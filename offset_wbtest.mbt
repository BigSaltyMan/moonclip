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

///|
fn jo_arc(rate : Double) -> OffsetArc {
  { step_sin: 0.0, step_cos: 1.0, steps_per_rad: rate, }
}

///|
test "offset joins square 2 public Square and Miter fallback reuse one formula" {
  let p = Point64::new(0L, 0L)
  let previous = Point64::new(-10L, 0L)
  let a : OffsetVector = { x: 1.0, y: 0.0, }
  let b : OffsetVector = { x: -0.5, y: 0.75.sqrt(), }
  let square : Path64 = []
  let miter : Path64 = []
  offset_corner(
    square,
    p,
    previous,
    a,
    b,
    4.0,
    OffsetOptions::new(join=Square),
    0.5,
    new_call_budget(of_limits()),
  )
  offset_corner(
    miter,
    p,
    previous,
    a,
    b,
    4.0,
    OffsetOptions::new(join=Miter),
    0.5,
    new_call_budget(of_limits()),
  )
  assert_eq(square, miter)
}

///|
test "offset joins round 5 near collinear angle bypasses Miter shortcut" {
  let p = Point64::new(0L, 0L)
  let angle = 0.01
  let a : OffsetVector = { x: 0.0, y: -1.0, }
  let b : OffsetVector = { x: @math.sin(angle), y: -@math.cos(angle), }
  let path : Path64 = []
  offset_corner(
    path,
    p,
    Point64::new(-10L, 0L),
    a,
    b,
    100.0,
    OffsetOptions::new(join=Round, arc_tolerance=0.25),
    0.5,
    new_call_budget(of_limits()),
  )
  assert_eq(path, [Point64::new(0L, -100L), Point64::new(1L, -100L)])
}

///|
test "offset joins round 6 acute obtuse and near reversal retain direct endpoints" {
  for
    angle in [
      @math.PI / 6.0,
      @math.PI / 2.0,
      2.0 * @math.PI / 3.0,
      @math.PI - 1.0e-8,
    ] {
    let p = Point64::new(0L, 0L)
    let path : Path64 = []
    let b : OffsetVector = { x: @math.cos(angle), y: @math.sin(angle), }
    offset_corner(
      path,
      p,
      Point64::new(0L, -10L),
      { x: 1.0, y: 0.0, },
      b,
      100.0,
      OffsetOptions::new(join=Round, arc_tolerance=0.25),
      0.5,
      new_call_budget(of_limits()),
    )
    assert_eq(path[0], Point64::new(100L, 0L))
    assert_eq(
      path[path.length() - 1],
      Point64::new(
        offset_coordinate(b.x * 100.0, X),
        offset_coordinate(b.y * 100.0, Y),
      ),
    )
    for point in path {
      let radius = (point.x.to_double() * point.x.to_double() +
      point.y.to_double() * point.y.to_double()).sqrt()
      assert_true((radius - 100.0).abs() <= 0.71)
    }
  }
}

///|
test "offset joins round 7 analytic sagitta bound before grid and cleanup" {
  // Fixed before execution: r=100, tol=.25, absolute numeric bound 1e-11.
  let arc = offset_arc_parameters(100.0, 0.25)
  assert_true(arc.steps_per_rad * 2.0 * @math.PI < 100.0 * @math.PI)
  let step = 2.0 * @math.PI / (arc.steps_per_rad * 2.0 * @math.PI)
  let sagitta = 100.0 * (1.0 - @math.cos(step / 2.0))
  assert_true((sagitta - 0.25).abs() <= 1.0e-11)
  let mut x = 100.0
  let mut y = 0.0
  for i = 0; i < 40; i = i + 1 {
    let next = x * arc.step_cos - arc.step_sin * y
    y = x * arc.step_sin + y * arc.step_cos
    x = next
    assert_true(((x * x + y * y).sqrt() - 100.0).abs() <= 1.0e-10)
  }
}

///|
test "offset joins round 8 negative delta reverses rotation" {
  let path : Path64 = []
  offset_round(
    path,
    Point64::new(0L, 0L),
    { x: 1.0, y: 0.0, },
    { x: 0.0, y: -1.0, },
    -10.0,
    -@math.PI / 2.0,
    offset_arc_parameters(-10.0, 1.0),
    new_call_budget(of_limits()),
  )
  assert_eq(path, [
    Point64::new(-10L, 0L),
    Point64::new(-6L, 8L),
    Point64::new(0L, 10L),
  ])
}

///|
test "offset joins round 9 concave corners retain source triples" {
  let path : Path64 = []
  offset_corner(
    path,
    Point64::new(10L, 10L),
    Point64::new(10L, 0L),
    { x: 1.0, y: 0.0, },
    { x: 0.0, y: 1.0, },
    -2.0,
    OffsetOptions::new(join=Round),
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
test "offset joins numeric 1 zero steps still allocate two endpoints" {
  let budget = new_call_budget(of_limits())
  let path : Path64 = []
  offset_round(
    path,
    Point64::new(0L, 0L),
    { x: 1.0, y: 0.0, },
    { x: 1.0, y: 0.0, },
    10.0,
    0.0,
    jo_arc(1.0),
    budget,
  )
  assert_eq(path, [Point64::new(10L, 0L), Point64::new(10L, 0L)])
  assert_eq((budget.stats.nodes, budget.stats.work), (2, 2))
}

///|
test "offset joins numeric 2 one step still allocates two endpoints" {
  let budget = new_call_budget(of_limits())
  let path : Path64 = []
  offset_round(
    path,
    Point64::new(0L, 0L),
    { x: 1.0, y: 0.0, },
    { x: 0.0, y: 1.0, },
    10.0,
    0.5,
    jo_arc(1.0),
    budget,
  )
  assert_eq(path.length(), 2)
  assert_eq((budget.stats.nodes, budget.stats.work), (2, 2))
}

///|
test "offset joins numeric 3 ordinary steps preflight does not double charge" {
  let budget = new_call_budget(of_limits())
  let path : Path64 = []
  assert_eq(offset_arc_steps(jo_arc(2.0), 1.0, budget), 2)
  assert_eq((budget.stats.nodes, budget.stats.work), (0, 0))
  offset_round(
    path,
    Point64::new(0L, 0L),
    { x: 1.0, y: 0.0, },
    { x: 0.0, y: 1.0, },
    10.0,
    1.0,
    jo_arc(2.0),
    budget,
  )
  assert_eq(path.length(), 3)
  assert_eq((budget.stats.nodes, budget.stats.work), (3, 3))
}

///|
test "offset joins numeric 4 insufficient arc nodes fail before mutation" {
  let budget = new_call_budget({
    input: Default::default(),
    max_nodes: 2,
    max_work: 100,
  })
  let path : Path64 = []
  let result = try {
    offset_round(
      path,
      Point64::new(0L, 0L),
      { x: 1.0, y: 0.0, },
      { x: 0.0, y: 1.0, },
      10.0,
      1.0,
      jo_arc(2.0),
      budget,
    )
    Ok(())
  } catch {
    ScanAbort(e) => Err(e)
  }
  assert_true(
    result
    is Err(
      ResourceLimitExceeded({ stage: OffsetGenerate, .. }, InternalNodes, 2)
    ),
  )
  assert_eq(path, [])
  assert_eq((budget.stats.nodes, budget.stats.work), (0, 0))
}

///|
test "offset joins numeric 5 insufficient arc work fails before mutation" {
  let budget = new_call_budget({
    input: Default::default(),
    max_nodes: 100,
    max_work: 2,
  })
  let path : Path64 = []
  let result = try {
    offset_round(
      path,
      Point64::new(0L, 0L),
      { x: 1.0, y: 0.0, },
      { x: 0.0, y: 1.0, },
      10.0,
      1.0,
      jo_arc(2.0),
      budget,
    )
    Ok(())
  } catch {
    ScanAbort(e) => Err(e)
  }
  assert_true(
    result
    is Err(ResourceLimitExceeded({ stage: OffsetGenerate, .. }, ScanWork, 2)),
  )
  assert_eq(path, [])
}

///|
test "offset joins numeric 6 equal rounded samples still consume every node" {
  let budget = new_call_budget(of_limits())
  let path : Path64 = []
  offset_round(
    path,
    Point64::new(0L, 0L),
    { x: 1.0, y: 0.0, },
    { x: 0.0, y: 1.0, },
    0.5,
    1.0,
    jo_arc(10.0),
    budget,
  )
  assert_eq(path.length(), 11)
  assert_eq(path[0], path[1])
  assert_eq((budget.stats.nodes, budget.stats.work), (11, 11))
}

///|
test "offset joins numeric 7 sub ULP tolerance selects fixed cap before budget rejection" {
  let arc = offset_arc_parameters(1000000000.0, 1.0e-11)
  assert_true((arc.steps_per_rad - 500000000.0).abs() < 1.0e-6)
  let result = Ok(
    offset_arc_steps(arc, @math.PI / 2.0, new_call_budget(of_limits())),
  ) catch {
    ScanAbort(e) => Err(e)
  }
  assert_true(
    result
    is Err(
      ResourceLimitExceeded({ stage: OffsetGenerate, .. }, InternalNodes, _)
    ),
  )
}

///|
test "offset joins numeric 8 nonfinite and excessive step counts cannot convert unchecked" {
  for rate in [@double.infinity, @double.not_a_number] {
    let result = Ok(
      offset_arc_steps(jo_arc(rate), 1.0, new_call_budget(of_limits())),
    ) catch {
      ScanAbort(e) => Err(e)
    }
    assert_true(result is Err(NumericFailure(_, _)))
  }
  let result = Ok(
    offset_arc_steps(jo_arc(1.0e20), 1.0, new_call_budget(of_limits())),
  ) catch {
    ScanAbort(e) => Err(e)
  }
  assert_true(result is Err(ResourceLimitExceeded(_, InternalNodes, _)))
}

///|
test "offset joins numeric 9 both new joins reject generated grid overflow" {
  for join in [Square, Round] {
    assert_true(
      offset_polygons(
        [pt_rect(x=999999990L)],
        10.0,
        options=OffsetOptions::new(join~),
      )
      is Err(
        CoordinateOutOfRange(
          { stage: OffsetGenerate, path_index: None, vertex_index: None, },
          _,
          _
        )
      ),
    )
  }
}

///|
test "offset joins numeric 10 Round generation and cleanup use cumulative budget" {
  let options = OffsetOptions::new(join=Round, arc_tolerance=0.25)
  let reference = new_call_budget(of_limits())
  let normal = of_budget_normal(reference)
  let normalized_nodes = reference.stats.nodes
  ignore(offset_generate(normal, 2.0, options, reference))
  let generated_nodes = reference.stats.nodes
  let generated_work = reference.stats.work
  assert_true(
    offset_execute([pt_rect()], 2.0, NonZero, options, {
      input: Default::default(),
      max_nodes: normalized_nodes,
      max_work: 5000000,
    })
    is Err(
      ResourceLimitExceeded({ stage: OffsetGenerate, .. }, InternalNodes, _)
    ),
  )
  assert_true(
    offset_execute([pt_rect()], 2.0, NonZero, options, {
      input: Default::default(),
      max_nodes: generated_nodes,
      max_work: 5000000,
    })
    is Err(
      ResourceLimitExceeded(
        { path_index: None, vertex_index: None, .. },
        InternalNodes,
        _
      )
    ),
  )
  assert_true(
    offset_execute([pt_rect()], 2.0, NonZero, options, {
      input: Default::default(),
      max_nodes: 500000,
      max_work: generated_work,
    })
    is Err(ResourceLimitExceeded({ stage: OffsetCleanup, .. }, ScanWork, _)),
  )
  assert_true(offset_polygons([pt_rect()], 2.0, options~) is Ok(_))
}

///|
test "offset joins isolation 6 multiple paths and corners cannot renew budgets" {
  let options = OffsetOptions::new(join=Round, arc_tolerance=0.25)
  let reference = new_call_budget(of_limits())
  ignore(offset_generate([pt_rect()], 2.0, options, reference))
  let limited = new_call_budget({
    input: Default::default(),
    max_nodes: reference.stats.nodes * 2 - 2,
    max_work: 5000000,
  })
  let result = Ok(
    offset_generate([pt_rect(), pt_rect(x=20L)], 2.0, options, limited),
  ) catch {
    ScanAbort(e) => Err(e)
  }
  assert_true(
    result
    is Err(
      ResourceLimitExceeded({ stage: OffsetGenerate, .. }, InternalNodes, _)
    ),
  )
  assert_true(limited.stats.nodes >= reference.stats.nodes)
}
