// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn st_limits() -> ScanLimits {
  { input: Default::default(), max_nodes: 500000, max_work: 5000000, }
}

///|
fn st_budget(limits? : ScanLimits = st_limits()) -> CallBudget {
  new_call_budget(
    limits,
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
}

///|
fn st_internal_line() -> Path64 {
  [Point64::new(0L, 0L), Point64::new(20L, 0L)]
}

///|
test "stroke topology 3 Open preparation retains nonconsecutive points and closing endpoint" {
  let path = [
    Point64::new(0L, 0L),
    Point64::new(0L, 0L),
    Point64::new(20L, 0L),
    Point64::new(0L, 0L),
  ]
  let result = stroke_prepare(path, st_budget())
  assert_eq(result, [
    Point64::new(0L, 0L),
    Point64::new(20L, 0L),
    Point64::new(0L, 0L),
  ])
}

///|
test "stroke numeric 1 full width divides before any grid conversion" {
  assert_eq(
    stroke_polyline(st_internal_line(), 2.5),
    stroke_polyline(st_internal_line(), 2.0),
  )
  assert_true(
    stroke_polyline(st_internal_line(), 3.0) !=
    stroke_polyline(st_internal_line(), 2.5),
  )
}

///|
test "stroke numeric 2 signed half grid uses the common converter" {
  assert_eq(offset_coordinate(-1.5, X, stage=StrokeGenerate), -2L)
  assert_eq(offset_coordinate(1.5, X, stage=StrokeGenerate), 2L)
  assert_eq(
    stroke_polyline([Point64::new(-20L, 0L), Point64::new(0L, 0L)], 3.0).map(
      internal_canonical,
    ),
    Ok(internal_canonical([pt_rect(x=-20L, y=-2L, w=20L, h=4L)])),
  )
}

///|
test "stroke numeric 3 generated exact coordinate boundary is accepted" {
  assert_eq(
    stroke_polyline(
      [Point64::new(0L, 999999998L), Point64::new(20L, 999999998L)],
      4.0,
    ).map(internal_canonical),
    Ok(internal_canonical([pt_rect(y=999999996L, w=20L, h=4L)])),
  )
}

///|
test "stroke numeric 4 generated cap overflow reports no raw vertex" {
  assert_true(
    stroke_polyline(
      [Point64::new(999999990L, 0L), Point64::new(1000000000L, 0L)],
      4.0,
      cap=Square,
    )
    is Err(
      CoordinateOutOfRange(
        { stage: StrokeGenerate, path_index: None, vertex_index: None, },
        X,
        1000000002L
      )
    ),
  )
}

///|
test "stroke numeric 5 extreme finite widths fail safely in generation" {
  assert_true(
    stroke_polyline(st_internal_line(), 4000000000.0)
    is Err(CoordinateOutOfRange({ stage: StrokeGenerate, .. }, _, _)),
  )
  assert_true(
    stroke_polyline(st_internal_line(), 1.0e300)
    is Err(NumericFailure({ stage: StrokeGenerate, .. }, _)),
  )
}

///|
test "stroke numeric 6 round cap preflights its complete semicircle" {
  let budget = st_budget(limits={
    input: Default::default(),
    max_nodes: 1,
    max_work: 100,
  })
  let path : Path64 = []
  let result = try {
    stroke_cap(
      path,
      Point64::new(0L, 0L),
      { x: 0.0, y: -1.0, },
      10.0,
      Round,
      Some(offset_arc_parameters(10.0, 0.25, stage=StrokeGenerate)),
      budget,
    )
    Ok(())
  } catch {
    ScanAbort(e) => Err(e)
  }
  assert_true(
    result
    is Err(
      ResourceLimitExceeded({ stage: StrokeGenerate, .. }, InternalNodes, 1)
    ),
  )
  assert_eq(path, [])
  assert_eq(budget.stats.nodes, 0)
}

///|
test "stroke numeric 7 both caps and both sides share generated node allowance" {
  let reference = st_budget()
  ignore(
    stroke_generate(
      st_internal_line(),
      2.0,
      Round,
      OffsetOptions::new(),
      reference,
    ),
  )
  let budget = st_budget(limits={
    input: Default::default(),
    max_nodes: reference.stats.nodes - 1,
    max_work: 5000000,
  })
  let result = Ok(
    stroke_generate(
      st_internal_line(),
      2.0,
      Round,
      OffsetOptions::new(),
      budget,
    ),
  ) catch {
    ScanAbort(e) => Err(e)
  }
  assert_true(
    result
    is Err(
      ResourceLimitExceeded({ stage: StrokeGenerate, .. }, InternalNodes, _)
    ),
  )
  assert_true(budget.stats.nodes > 0)
}

///|
test "stroke numeric 8 cleanup cannot renew generation allowance" {
  let reference = st_budget()
  let path = stroke_prepare(st_internal_line(), reference)
  ignore(stroke_generate(path, 2.0, Round, OffsetOptions::new(), reference))
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 500000,
    max_work: reference.stats.work,
  }
  assert_true(
    stroke_execute(st_internal_line(), 4.0, Round, OffsetOptions::new(), limits)
    is Err(
      ResourceLimitExceeded(
        { stage: StrokeCleanup, path_index: None, vertex_index: None, },
        ScanWork,
        _
      )
    ),
  )
  assert_true(stroke_polyline(st_internal_line(), 4.0, cap=Round) is Ok(_))
}

///|
test "stroke numeric 9 cap sampling work exhaustion preserves StrokeGenerate" {
  let budget = st_budget(limits={
    input: Default::default(),
    max_nodes: 100,
    max_work: 1,
  })
  let path : Path64 = []
  let result = try {
    stroke_cap(
      path,
      Point64::new(0L, 0L),
      { x: 0.0, y: -1.0, },
      10.0,
      Round,
      Some(offset_arc_parameters(10.0, 0.25, stage=StrokeGenerate)),
      budget,
    )
    Ok(())
  } catch {
    ScanAbort(e) => Err(e)
  }
  assert_true(
    result
    is Err(ResourceLimitExceeded({ stage: StrokeGenerate, .. }, ScanWork, 1)),
  )
  assert_eq(path, [])
}

///|
test "stroke numeric 10 raw two vertex allowance permits generated round caps" {
  guard stroke_polyline(st_internal_line(), 4.0, cap=Round, limits={
      max_input_paths: 1,
      max_input_vertices: 2,
    })
    is Ok(result) else {
    fail("Generated samples must not renew raw input checks")
  }
  assert_eq(result[0].length(), 8)
  assert_true(
    stroke_polyline(
      [Point64::new(0L, 0L), Point64::new(0L, 0L), Point64::new(20L, 0L)],
      4.0,
      limits={ max_input_paths: 1, max_input_vertices: 2, },
    )
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
}
