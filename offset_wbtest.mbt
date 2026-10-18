// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn of_limits() -> ScanLimits {
  { input: Default::default(), max_nodes: 500000, max_work: 5000000, }
}

///|
fn of_budget_normal(budget : CallBudget) -> Paths64 raise {
  guard boolean_compute(
      [pt_rect()],
      [],
      Union,
      budget.limits,
      SignedNonZero,
      fn(state) raise ScanAbort {
        output_extract(state, preserve_collinear=false)
      },
      budget~,
    )
    is Ok(paths) else {
    fail("Expected normalization")
  }
  paths
}

///|
test "offset grid conversion rounds both signed halves away from zero" {
  for
    (value, expected) in [
      (0.5, 1L),
      (-0.5, -1L),
      (1.5, 2L),
      (-1.5, -2L),
      (0.499999999, 0L),
      (-0.499999999, 0L),
      (999999999.5, 1000000000L),
      (-999999999.5, -1000000000L),
    ] {
    assert_eq(offset_coordinate(value, X), expected)
  }
}

///|
test "offset checked conversion rejects nonfinite huge and grid overflow" {
  for
    value in [
      @double.infinity, @double.neg_infinity, @double.not_a_number, 1.0e300,
    ] {
    let actual = Ok(offset_coordinate(value, Y)) catch {
      ScanAbort(e) => Err(e)
    }
    assert_true(
      actual
      is Err(
        NumericFailure(
          { stage: OffsetGenerate, path_index: None, vertex_index: None, },
          _
        )
      ),
    )
  }
  for value in [1000000000.5, -1000000000.5] {
    let actual = Ok(offset_coordinate(value, Y)) catch {
      ScanAbort(e) => Err(e)
    }
    assert_true(actual is Err(CoordinateOutOfRange(_, Y, _)))
  }
}

///|
test "offset unit normals include horizontal vertical diagonal and duplicate edge" {
  let a = Point64::new(0L, 0L)
  let right = offset_unit(a, Point64::new(10L, 0L))
  assert_eq((right.x, right.y), (0.0, -1.0))
  let up = offset_unit(a, Point64::new(0L, 10L))
  assert_eq((up.x, up.y), (1.0, -0.0))
  let diagonal = offset_unit(a, Point64::new(3L, 4L))
  assert_true((diagonal.x - 0.8).abs() < 1.0e-15)
  assert_true((diagonal.y + 0.6).abs() < 1.0e-15)
  let zero = offset_unit(a, a)
  assert_eq((zero.x, zero.y), (0.0, 0.0))
}

///|
test "offset strict Miter threshold selects Square at equality" {
  let p = Point64::new(0L, 0L)
  let previous = Point64::new(-10L, 0L)
  let a : OffsetVector = { x: 1.0, y: 0.0, }
  let b : OffsetVector = { x: -0.5, y: 0.75.sqrt(), }
  let square : Path64 = []
  offset_square(square, p, previous, a, b, 4.0, new_call_budget(of_limits()))
  let bevel : Path64 = []
  offset_corner(
    bevel,
    p,
    previous,
    a,
    b,
    4.0,
    OffsetOptions::new(join=Bevel),
    0.5,
    new_call_budget(of_limits()),
  )
  assert_true(square != bevel)
  for threshold in [0.5, 0.500000001] {
    let actual : Path64 = []
    offset_corner(
      actual,
      p,
      previous,
      a,
      b,
      4.0,
      OffsetOptions::new(),
      threshold,
      new_call_budget(of_limits()),
    )
    assert_eq(actual, square)
  }
  let actual : Path64 = []
  let miter : Path64 = []
  offset_corner(
    actual,
    p,
    previous,
    a,
    b,
    4.0,
    OffsetOptions::new(),
    0.499999999,
    new_call_budget(of_limits()),
  )
  offset_miter(miter, p, a, b, 4.0, -0.5, new_call_budget(of_limits()))
  assert_eq(actual, miter)
  assert_true(actual != square)
}

///|
test "offset near straight and exact reversal use finite source branches" {
  for join in [Miter, Bevel] {
    let line : Path64 = []
    offset_corner(
      line,
      Point64::new(0L, 0L),
      Point64::new(-10L, 0L),
      { x: 0.0, y: -1.0, },
      { x: 0.0, y: -1.0, },
      2.0,
      OffsetOptions::new(join~),
      0.5,
      new_call_budget(of_limits()),
    )
    assert_eq(line, [Point64::new(0L, -2L)])
    let reversal : Path64 = []
    offset_corner(
      reversal,
      Point64::new(0L, 0L),
      Point64::new(-10L, 0L),
      { x: 0.0, y: -1.0, },
      { x: 0.0, y: 1.0, },
      2.0,
      OffsetOptions::new(join~),
      0.5,
      new_call_budget(of_limits()),
    )
    assert_eq(reversal.length(), 2)
  }
}

///|
test "offset concave generation preserves all three cleanup vertices" {
  let path : Path64 = []
  offset_corner(
    path,
    Point64::new(10L, 10L),
    Point64::new(10L, 0L),
    { x: 1.0, y: 0.0, },
    { x: 0.0, y: 1.0, },
    -2.0,
    OffsetOptions::new(),
    0.5,
    new_call_budget(of_limits()),
  )
  assert_eq(path, [
    Point64::new(8L, 10L),
    Point64::new(10L, 10L),
    Point64::new(10L, 8L),
  ])
}

///|
test "offset normalization and generation actually share work and nodes" {
  let budget = new_call_budget(of_limits())
  let normalized = of_budget_normal(budget)
  let nodes = budget.stats.nodes
  let work = budget.stats.work
  assert_true(nodes > 0 && work > 0)
  ignore(offset_generate(normalized, 2.0, OffsetOptions::new(), budget))
  assert_true(budget.stats.nodes > nodes && budget.stats.work > work)
}

///|
test "offset generation exhausts remaining normalization nodes and work" {
  let reference = new_call_budget(of_limits())
  ignore(of_budget_normal(reference))
  for
    limits in [
      {
        input: Default::default(),
        max_nodes: reference.stats.nodes,
        max_work: 5000000,
      },
      {
        input: Default::default(),
        max_nodes: 500000,
        max_work: reference.stats.work,
      },
    ] {
    let result = offset_execute(
      [pt_rect()],
      2.0,
      NonZero,
      OffsetOptions::new(),
      limits,
    )
    assert_true(
      result
      is Err(
        ResourceLimitExceeded(
          { stage: OffsetGenerate, path_index: None, vertex_index: None, },
          _,
          _
        )
      ),
    )
  }
  assert_true(offset_polygons([pt_rect()], 2.0) is Ok(_))
}

///|
test "offset cleanup cannot renew allowances consumed by earlier stages" {
  let reference = new_call_budget(of_limits())
  let normalized = of_budget_normal(reference)
  ignore(offset_generate(normalized, 2.0, OffsetOptions::new(), reference))
  let limits : ScanLimits = {
    input: { max_input_paths: 1, max_input_vertices: 4, },
    max_nodes: reference.stats.nodes,
    max_work: 5000000,
  }
  let result = offset_execute(
    [pt_rect()],
    2.0,
    NonZero,
    OffsetOptions::new(),
    limits,
  )
  assert_true(
    result
    is Err(
      ResourceLimitExceeded(
        { path_index: None, vertex_index: None, .. },
        InternalNodes,
        _
      )
    ),
  )
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 500000,
    max_work: reference.stats.work,
  }
  assert_true(
    offset_execute([pt_rect()], 2.0, NonZero, OffsetOptions::new(), limits)
    is Err(
      ResourceLimitExceeded(
        { stage: OffsetCleanup, path_index: None, vertex_index: None, },
        ScanWork,
        _
      )
    ),
  )
}

///|
test "offset exact cumulative allowances succeed and one less fails" {
  let budget = new_call_budget(of_limits())
  assert_true(
    offset_execute(
      [pt_rect()],
      2.0,
      NonZero,
      OffsetOptions::new(),
      budget.limits,
      budget~,
    )
    is Ok(_),
  )
  let nodes = budget.stats.nodes
  let work = budget.stats.work
  assert_true(
    offset_execute([pt_rect()], 2.0, NonZero, OffsetOptions::new(), {
      input: Default::default(),
      max_nodes: nodes,
      max_work: work,
    })
    is Ok(_),
  )
  for
    limits in [
      { input: Default::default(), max_nodes: nodes - 1, max_work: work, },
      { input: Default::default(), max_nodes: nodes, max_work: work - 1, },
    ] {
    assert_true(
      offset_execute([pt_rect()], 2.0, NonZero, OffsetOptions::new(), limits)
      is Err(ResourceLimitExceeded(_, _, _)),
    )
  }
}

///|
test "offset internal cleanup still validates generated coordinates without original indices" {
  let result = boolean_compute(
    [[Point64::new(1000000001L, 0L)]],
    [],
    Union,
    of_limits(),
    Positive,
    fn(state) raise ScanAbort {
      output_extract(state, preserve_collinear=false)
    },
    internal_input=true,
  )
  assert_true(
    result
    is Err(
      CoordinateOutOfRange(
        { stage: OffsetCleanup, path_index: None, vertex_index: None, },
        X,
        1000000001L
      )
    ),
  )
}
