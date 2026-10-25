// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "line difference: preflight fees and retry" {
  let routes = [[Point64::new(-2L, 5L), Point64::new(12L, 5L)]]
  let clip = [
    [
      Point64::new(0L, 0L),
      Point64::new(10L, 0L),
      Point64::new(10L, 10L),
      Point64::new(0L, 10L),
    ],
  ]
  let limits : ScanLimits = Default::default()
  let budget = new_call_budget(
    limits,
    generate_stage=LineClipEvaluate,
    cleanup_stage=LineClipEvaluate,
  )
  assert_eq(
    line_clip_execute(routes, clip, EvenOdd, limits, budget~),
    Ok([[Point64::new(0L, 5L), Point64::new(10L, 5L)]]),
  )
  // Measured on the unchanged baseline executor before adding the mode.
  assert_eq(budget.stats.nodes, 411)
  assert_eq(budget.stats.work, 650)
  assert_true(
    difference_polylines([[Point64::new(1000000001L, 0L)]], [])
    is Err(
      CoordinateOutOfRange(
        {
          stage: LineClipParameters,
          path_index: Some(0),
          vertex_index: Some(0),
        },
        X,
        _
      )
    ),
  )
  assert_true(
    difference_polylines(routes, clip, limits={
      max_input_paths: 1,
      max_input_vertices: 6,
    })
    is Err(
      ResourceLimitExceeded(
        { stage: LineClipParameters, path_index: Some(1), .. },
        InputPaths,
        1
      )
    ),
  )
  assert_true(
    difference_polylines(routes, clip, limits={
      max_input_paths: 2,
      max_input_vertices: 5,
    })
    is Err(
      ResourceLimitExceeded(
        {
          stage: LineClipParameters,
          path_index: Some(1),
          vertex_index: Some(3),
        },
        InputVertices,
        5
      )
    ),
  )
  assert_true(
    difference_polylines(routes, [[Point64::new(0L, -1000000001L)]])
    is Err(
      CoordinateOutOfRange(
        {
          stage: LineClipParameters,
          path_index: Some(1),
          vertex_index: Some(0),
        },
        Y,
        _
      )
    ),
  )
  let saved_routes = copy_paths(routes)
  let saved_clip = copy_paths(clip)
  let bounded = new_call_budget({ ..limits, max_nodes: 300, })
  bounded.stats.nodes = 1
  bounded.stats.work = 3
  assert_true(
    line_clip_execute(
      routes,
      clip,
      EvenOdd,
      limits,
      budget=bounded,
      mode=KeepOutside,
    )
    is Err(ResourceLimitExceeded(_, InternalNodes, 300)),
  )
  assert_true(bounded.stats.nodes > 1)
  assert_true(bounded.stats.work > 3)
  assert_eq(bounded.limits.max_nodes, 300)
  assert_eq(routes, saved_routes)
  assert_eq(clip, saved_clip)
  assert_eq(
    difference_polylines(routes, clip),
    Ok([
      [Point64::new(-2L, 5L), Point64::new(0L, 5L)],
      [Point64::new(10L, 5L), Point64::new(12L, 5L)],
    ]),
  )
}
