// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn mw_pattern() -> Path64 {
  pt_rect(x=-1L, y=-1L, w=2L, h=2L)
}

///|
fn mw_path() -> Path64 {
  [Point64::new(0L, 0L), Point64::new(10L, 0L)]
}

///|
fn mw_budget(
  nodes? : Int = 500000,
  work? : Int = 5000000,
  input? : Limits = Default::default(),
) -> CallBudget {
  new_call_budget(
    { input, max_nodes: nodes, max_work: work, },
    generate_stage=MinkowskiGenerate,
    cleanup_stage=MinkowskiCleanup,
  )
}

///|
fn mw_run(b : CallBudget) -> Result[Paths64, ClipError] {
  minkowski_execute(mw_pattern(), mw_path(), false, b.limits, budget=b)
}

///|
fn mw_generated(b : CallBudget) -> Paths64 raise ScanAbort {
  // The fixed pair has two raw paths and six raw vertices, as public preflight.
  budget_spend(b, 0, 8, location(MinkowskiParameters, None, None))
  minkowski_generate(mw_pattern(), mw_path(), false, b)
}

///|
test "minkowski budget product Int overflow before multiplication" {
  let b = mw_budget()
  assert_true(
    wb_error(fn() raise ScanAbort {
      ignore(minkowski_product(2147483647, 2, b))
    })
    is ResourceLimitExceeded(
      { stage: MinkowskiGenerate, .. },
      InternalNodes,
      500000
    ),
  )
  assert_eq(b.stats.nodes, 0)
  assert_eq(b.stats.work, 0)
}

///|
test "minkowski budget zero dimensions without divide or underflow" {
  let b = mw_budget(nodes=0, work=0)
  assert_eq(minkowski_plan(0, 2147483647, true, b), (0, 0))
  assert_eq(minkowski_plan(2147483647, 0, false, b), (0, 0))
  assert_eq(b.stats.nodes, 0)
}

///|
test "minkowski budget quad slots Int overflow" {
  let b = mw_budget(nodes=2147483647, work=2147483647)
  assert_true(
    wb_error(fn() raise ScanAbort {
      ignore(minkowski_plan(1, 600000000, true, b))
    })
    is ResourceLimitExceeded(
      { stage: MinkowskiGenerate, .. },
      InternalNodes,
      2147483647
    ),
  )
  assert_eq(b.stats.nodes, 0)
}

///|
test "minkowski budget large representable matrix rejected before allocation" {
  let b = mw_budget()
  assert_true(
    wb_error(fn() raise ScanAbort {
      ignore(minkowski_plan(50000, 40000, false, b))
    })
    is ResourceLimitExceeded(_, InternalNodes, 500000),
  )
  assert_eq(b.stats.nodes, 0)
  assert_eq(b.stats.work, 0)
}

///|
test "minkowski budget exact generation allocation and work" {
  let b = mw_budget(nodes=46, work=18)
  assert_eq(minkowski_plan(4, 2, false, b), (8, 4))
  assert_eq(b.stats.nodes, 0)
  let faces = minkowski_generate(mw_pattern(), mw_path(), false, b)
  assert_eq(faces.length(), 4)
  for p in faces {
    assert_eq(p.length(), 4)
  }
  assert_eq(b.stats.nodes, 46)
  assert_eq(b.stats.work, 18)
}

///|
test "minkowski budget one fewer generation node preflight" {
  let b = mw_budget(nodes=45)
  assert_true(
    wb_error(fn() raise ScanAbort {
      ignore(minkowski_generate(mw_pattern(), mw_path(), false, b))
    })
    is ResourceLimitExceeded(_, InternalNodes, 45),
  )
  assert_eq(b.stats.nodes, 0)
  assert_eq(b.stats.work, 0)
}

///|
test "minkowski budget one fewer generation work preflight" {
  let b = mw_budget(work=17)
  assert_true(
    wb_error(fn() raise ScanAbort {
      ignore(minkowski_generate(mw_pattern(), mw_path(), false, b))
    })
    is ResourceLimitExceeded(_, ScanWork, 17),
  )
  assert_eq(b.stats.nodes, 0)
  assert_eq(b.stats.work, 0)
}

///|
test "minkowski budget preexisting charges reduce remaining allowance" {
  let b = mw_budget(nodes=46)
  budget_spend(b, 1, 1, location(MinkowskiParameters, None, None))
  assert_true(
    wb_error(fn() raise ScanAbort { ignore(minkowski_plan(4, 2, false, b)) })
    is ResourceLimitExceeded(_, InternalNodes, 46),
  )
  assert_eq(b.stats.nodes, 1)
  assert_eq(b.stats.work, 1)
}

///|
test "minkowski budget translation succeeds quad storage fails" {
  let b = mw_budget(nodes=25)
  let translated = minkowski_matrix(mw_pattern(), mw_path(), b)
  assert_eq(translated.length(), 2)
  assert_eq(b.stats.nodes, 21)
  assert_true(
    wb_error(fn() raise ScanAbort {
      ignore(minkowski_quads(translated, 4, false, b))
    })
    is ResourceLimitExceeded(
      { stage: MinkowskiGenerate, path_index: None, .. },
      InternalNodes,
      25
    ),
  )
  assert_eq(b.stats.nodes, 22)
  assert_eq(b.stats.work, 10)
}

///|
test "minkowski budget generation succeeds cleanup precheck exhausts" {
  let b = mw_budget(work=26)
  assert_true(
    mw_run(b)
    is Err(
      ResourceLimitExceeded(
        { stage: MinkowskiCleanup, path_index: None, vertex_index: None, },
        ScanWork,
        26
      )
    ),
  )
  assert_eq(b.stats.nodes, 46)
  assert_eq(b.stats.work, 26)
}

///|
test "minkowski budget cleanup prepared scan exhausts" {
  let measured = mw_budget()
  let faces = mw_generated(measured)
  let state = prepare_scan(
    faces,
    [],
    limits=measured.limits,
    budget=measured,
    source_extrema=true,
    internal_input=true,
    preserve_collinear=true,
  ).unwrap()
  let consumed = measured.stats.work
  scan_cleanup(state)
  let b = mw_budget(work=consumed)
  assert_true(
    mw_run(b)
    is Err(ResourceLimitExceeded({ stage: ScanEvents, .. }, ScanWork, _)),
  )
  assert_eq(b.stats.work, consumed)
}

///|
test "minkowski budget scan succeeds output extraction exhausts" {
  let measured = mw_budget()
  let faces = mw_generated(measured)
  let mut before_output = 0
  assert_true(
    boolean_compute(
      faces,
      [],
      Union,
      measured.limits,
      SignedNonZero,
      fn(state) raise ScanAbort {
        before_output = state.stats.work
        output_extract(state, preserve_collinear=true)
      },
      budget=measured,
      internal_input=true,
      preserve_collinear=true,
    )
    is Ok(_),
  )
  let b = mw_budget(work=before_output)
  let faces = mw_generated(b)
  let mut reached = false
  let result = boolean_compute(
    faces,
    [],
    Union,
    b.limits,
    SignedNonZero,
    fn(state) raise ScanAbort {
      reached = true
      output_extract(state, preserve_collinear=true)
    },
    budget=b,
    internal_input=true,
    preserve_collinear=true,
  )
  assert_true(reached)
  assert_true(
    result
    is Err(ResourceLimitExceeded({ stage: OutputTopology, .. }, ScanWork, _)),
  )
}

///|
test "minkowski budget generated faces do not consume original quota" {
  let b = mw_budget(input={ max_input_paths: 2, max_input_vertices: 6, })
  assert_true(mw_run(b) is Ok(_))
  assert_true(b.stats.nodes > 46)
  assert_true(b.stats.work > 26)
}

///|
test "minkowski budget degenerate faces still spend actual work" {
  let b = mw_budget()
  assert_eq(
    minkowski_execute(
      mw_pattern(),
      [Point64::new(0L, 0L)],
      true,
      b.limits,
      budget=b,
    ),
    Ok([]),
  )
  assert_true(b.stats.nodes >= 36)
  assert_true(b.stats.work >= 20)
}

///|
test "minkowski budget failure counters persist fresh retry succeeds" {
  let b = mw_budget(work=26)
  assert_true(mw_run(b) is Err(_))
  assert_eq(b.stats.nodes, 46)
  assert_eq(b.stats.work, 26)
  let fresh = mw_budget()
  assert_true(mw_run(fresh) is Ok(_))
  assert_true(fresh.stats.nodes > 46)
  assert_eq(b.stats.nodes, 46)
}

///|
test "minkowski budget exact parallelogram sign and zero no reversal" {
  let b = mw_budget()
  let p = [Point64::new(0L, 0L), Point64::new(999999999L, 999999998L)]
  let r = [Point64::new(0L, 0L), Point64::new(1L, 1L)]
  let q = minkowski_generate(p, r, false, b)
  let expected = [
    Point64::new(999999999L, 999999998L),
    Point64::new(1000000000L, 999999999L),
    Point64::new(1L, 1L),
    Point64::new(0L, 0L),
  ]
  assert_eq(q, [expected, expected])
  assert_eq(cross_validated(q[0][0], q[0][1], q[0][2]), 1L)
  let z = minkowski_generate([Point64::new(0L, 0L)], r, false, mw_budget())
  assert_eq(z, [[r[0], r[1], r[1], r[0]]])
}
