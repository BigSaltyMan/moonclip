// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn sw_budget(nodes? : Int = 500000, work? : Int = 5000000) -> CallBudget {
  new_call_budget({
    input: Default::default(),
    max_nodes: nodes,
    max_work: work,
  })
}

///|
fn sw_run(budget : CallBudget) -> Result[SimplifyResult, ClipError] {
  simplify_execute(
    [pt_rect()],
    SimplifyOptions::new(epsilon=0.25),
    budget.limits,
    budget~,
  )
}

///|
test "simplify budget numeric finite huge epsilon square" {
  assert_true(
    simplify_paths([], options=SimplifyOptions::new(epsilon=1.0e308))
    is Err(NumericFailure({ stage: SimplifyParameters, .. }, _)),
  )
  assert_true(
    decimal_simplify_execute(
      [],
      dw_precision(6),
      SimplifyOptions::new(epsilon=1.0e150),
      sw_budget().limits,
    )
    is Err(NumericFailure(_, _)),
  )
}

///|
test "simplify budget numeric legal boundary distance" {
  let b = sw_budget()
  let x = 1000000000L
  let d = simplify_distance(
    Point64::new(0L, x),
    Point64::new(-x, -x),
    Point64::new(x, -x),
    b,
    0,
    1,
  )
  assert_eq(d, 4000000000000000000.0)
  assert_eq(b.stats.work, 1)
}

///|
test "simplify budget numeric repeated neighbors distance zero" {
  let b = sw_budget()
  let p = Point64::new(10L, 20L)
  assert_eq(simplify_distance(Point64::new(99L, -10L), p, p, b, 0, 0), 0.0)
}

///|
test "simplify budget numeric distance to infinite line" {
  let b = sw_budget()
  assert_eq(
    simplify_distance(
      Point64::new(20L, 1L),
      Point64::new(0L, 0L),
      Point64::new(10L, 0L),
      b,
      0,
      0,
    ),
    1.0,
  )
}

///|
test "simplify budget numeric workspace exact allocation" {
  let b = sw_budget(nodes=10)
  let error = wb_error(fn() raise ScanAbort {
    ignore(simplify_local(pt_rect(), 0.0625, Closed, b, 0))
  })
  assert_eq(b.stats.nodes, 10)
  assert_true(
    error
    is ResourceLimitExceeded({ stage: SimplifyOutput, .. }, InternalNodes, 10),
  )
  assert_true(b.stats.work > 4)
}

///|
test "simplify budget numeric workspace one short atomic" {
  let b = sw_budget(nodes=9)
  let error = wb_error(fn() raise ScanAbort {
    ignore(simplify_local(pt_rect(), 0.0625, Closed, b, 0))
  })
  assert_eq(b.stats.nodes, 0)
  assert_eq(b.stats.work, 0)
  assert_true(
    error
    is ResourceLimitExceeded({ stage: SimplifyEvaluate, .. }, InternalNodes, 9),
  )
}

///|
test "simplify budget numeric deleted marker scans exact" {
  let b = sw_budget(work=3)
  assert_eq(
    simplify_neighbor([true, true, false, true, true, false], 2, true, b, 4),
    5,
  )
  assert_eq(b.stats.work, 3)
  assert_eq(b.stats.nodes, 0)
}

///|
test "simplify budget numeric deleted marker scan exhausts" {
  let b = sw_budget(work=2)
  let error = wb_error(fn() raise ScanAbort {
    ignore(
      simplify_neighbor([true, true, false, true, true, false], 2, true, b, 4),
    )
  })
  assert_true(
    error
    is ResourceLimitExceeded(
      { stage: SimplifyEvaluate, path_index: Some(4), vertex_index: Some(5), },
      ScanWork,
      2
    ),
  )
  assert_eq(b.stats.work, 2)
}

///|
test "simplify budget numeric computed distances but final point storage fails" {
  let b = sw_budget(nodes=14)
  let error = wb_error(fn() raise ScanAbort {
    ignore(simplify_local(pt_rect(), 0.0625, Closed, b, 0))
  })
  assert_true(
    error
    is ResourceLimitExceeded(
      { stage: SimplifyOutput, vertex_index: Some(3), .. },
      InternalNodes,
      14
    ),
  )
  assert_eq(b.stats.nodes, 14)
  assert_true(b.stats.work > 4)
}

///|
test "simplify budget numeric complete path but report fails" {
  let b = sw_budget(nodes=33)
  assert_true(
    sw_run(b)
    is Err(
      ResourceLimitExceeded(
        { stage: SimplifyReport, path_index: None, .. },
        InternalNodes,
        33
      )
    ),
  )
  assert_eq(b.stats.nodes, 32)
}

///|
test "simplify budget numeric exact whole call node allowance" {
  let b = sw_budget(nodes=34)
  let value = sw_run(b).unwrap()
  assert_eq(value.paths(), [pt_rect()])
  assert_eq(value.removed_per_path(), [0])
  assert_eq(b.stats.nodes, 34)
  assert_eq(b.stats.work, 40)
}

///|
test "simplify budget numeric whole call work exact and one less" {
  let b = sw_budget(work=40)
  assert_true(sw_run(b) is Ok(_))
  let short = sw_budget(work=39)
  assert_true(
    sw_run(short)
    is Err(ResourceLimitExceeded({ stage: SimplifyReport, .. }, ScanWork, 39)),
  )
  assert_eq(short.stats.work, 39)
}

///|
test "simplify budget numeric decimal quantize and algorithm share ledger" {
  let p = [dw_box()]
  let b = sw_budget()
  let v = decimal_simplify_execute(
    p,
    dw_precision(3),
    SimplifyOptions::new(epsilon=0.25),
    b.limits,
    budget=b,
  ).unwrap()
  assert_eq(v.paths(), p)
  let required = b.stats.nodes
  assert_true(required > 34)
  let short = sw_budget(nodes=required - 1)
  assert_true(
    decimal_simplify_execute(
      p,
      dw_precision(3),
      SimplifyOptions::new(epsilon=0.25),
      short.limits,
      budget=short,
    )
    is Err(
      ResourceLimitExceeded({ stage: SimplifyReport, .. }, InternalNodes, _)
    ),
  )
  let exact = sw_budget(nodes=required)
  assert_true(
    decimal_simplify_execute(
      p,
      dw_precision(3),
      SimplifyOptions::new(epsilon=0.25),
      exact.limits,
      budget=exact,
    )
    is Ok(_),
  )
}

///|
test "simplify budget numeric failure isolation and retry" {
  let p = [pt_rect()]
  let saved = copy_paths(p)
  let b = sw_budget(work=1)
  assert_true(
    simplify_execute(p, SimplifyOptions::new(epsilon=0.25), b.limits, budget=b)
    is Err(_),
  )
  assert_eq(p, saved)
  assert_eq(
    simplify_paths(p, options=SimplifyOptions::new(epsilon=0.25))
    .unwrap()
    .paths(),
    saved,
  )
}

///|
test "simplify budget numeric combined input budgets before arrays" {
  let paths = [pt_rect(), pt_rect()]
  let b = new_call_budget({
    input: { max_input_paths: 2, max_input_vertices: 7, },
    max_nodes: 500000,
    max_work: 5000000,
  })
  assert_true(
    simplify_execute(paths, SimplifyOptions::new(), b.limits, budget=b)
    is Err(
      ResourceLimitExceeded(
        { path_index: Some(1), vertex_index: Some(3), .. },
        InputVertices,
        7
      )
    ),
  )
  assert_eq(b.stats.nodes, 0)
  assert_eq(b.stats.work, 0)
}

///|
test "simplify budget numeric invalid internal limits" {
  for
    limits in [
      { input: Default::default(), max_nodes: -1, max_work: 1, },
      { input: Default::default(), max_nodes: 1, max_work: -1, },
    ] {
    assert_true(
      simplify_execute([], SimplifyOptions::new(), limits)
      is Err(InvalidInput({ stage: SimplifyParameters, .. }, _)),
    )
  }
}
