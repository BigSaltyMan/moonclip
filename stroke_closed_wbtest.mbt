// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "closed stroke: raw preflight degenerate output and consumed budget retry" {
  let options : OffsetOptions = Default::default()
  let limits = st_limits()
  let short = [
    Point64::new(0L, 0L),
    Point64::new(10L, 0L),
    Point64::new(0L, 0L),
  ]
  let empty_budget = st_budget()
  assert_eq(
    stroke_closed_execute(short, 2.0, options, limits, budget=empty_budget),
    Ok([]),
  )
  // Preparation: array + three retained slots; empty result: one array.
  assert_eq(empty_budget.stats.nodes, 5)
  assert_eq(stroke_closed_polyline([], 2.0), Ok([]))
  assert_true(
    stroke_closed_polyline([], 2.0, limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    })
    is Err(
      ResourceLimitExceeded(
        { stage: StrokeGenerate, path_index: Some(0), .. },
        InputPaths,
        0
      )
    ),
  )
  assert_true(
    stroke_closed_polyline([Point64::new(1000000001L, 0L)], 0.0)
    is Err(
      CoordinateOutOfRange(
        { stage: StrokeGenerate, path_index: Some(0), vertex_index: Some(0), },
        X,
        _
      )
    ),
  )
  assert_true(
    stroke_closed_polyline(short, 2.0, limits={
      max_input_paths: 1,
      max_input_vertices: 2,
    })
    is Err(
      ResourceLimitExceeded(
        { stage: StrokeGenerate, path_index: Some(0), vertex_index: Some(2), },
        InputVertices,
        2
      )
    ),
  )
  let path = pt_rect(w=10L, h=10L)
  let saved = path.copy()
  let bounded = st_budget(limits={ ..limits, max_nodes: 20, })
  bounded.stats.nodes = 1
  bounded.stats.work = 3
  assert_true(
    stroke_closed_execute(path, 2.0, options, limits, budget=bounded)
    is Err(
      ResourceLimitExceeded({ stage: StrokeGenerate, .. }, InternalNodes, 20)
    ),
  )
  assert_eq(bounded.limits.max_nodes, 20)
  assert_true(bounded.stats.nodes > 1)
  assert_true(bounded.stats.work > 3)
  assert_eq(path, saved)
  let expected = [
    pt_rect(x=-1L, y=-1L, w=12L, h=12L),
    [
      Point64::new(1L, 1L),
      Point64::new(1L, 9L),
      Point64::new(9L, 9L),
      Point64::new(9L, 1L),
    ],
  ]
  assert_eq(
    stroke_closed_polyline(path, 2.0).map(internal_canonical),
    Ok(internal_canonical(expected)),
  )
}
