// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "line clip: combined preflight and cumulative failure with retry" {
  let route = [[Point64::new(-2L, 5L), Point64::new(12L, 5L)]]
  let rect = [
    [
      Point64::new(0L, 0L),
      Point64::new(10L, 0L),
      Point64::new(10L, 10L),
      Point64::new(0L, 10L),
    ],
  ]
  assert_true(
    intersect_polylines([[Point64::new(1000000001L, 0L)]], [])
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
    intersect_polylines(route, rect, limits={
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
    intersect_polylines(route, rect, limits={
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
    intersect_polylines(route, [[Point64::new(0L, -1000000001L)]])
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
  let limits : ScanLimits = Default::default()
  // Raw validation for 2 paths / 6 vertices is 2*2 + 6 = 10 work.
  // Only 9 remain: a consumed ledger rejects before allocating any geometry.
  let consumed = new_call_budget({ ..limits, max_work: 14, })
  consumed.stats.work = 5
  assert_true(
    line_clip_execute(route, rect, EvenOdd, limits, budget=consumed)
    is Err(
      ResourceLimitExceeded({ stage: LineClipParameters, .. }, ScanWork, 14)
    ),
  )
  assert_eq(consumed.stats.nodes, 0)
  assert_eq(consumed.stats.work, 5)
  // BigInt/event storage has its own preallocation charges: each endpoint
  // costs ratio+two BigInts+slot = 4 nodes. Historical consumption stays spent.
  let event_budget = new_call_budget({ ..limits, max_nodes: 7, })
  event_budget.stats.nodes = 3
  let loc = location(LineClipEvaluate, Some(0), Some(1))
  let events : Array[LineRatio] = [] // Test-owned container, not API storage.
  line_event(events, 0L, 1L, event_budget, loc)
  assert_eq(event_budget.stats.nodes, 7)
  let failure = try {
    line_event(events, 1L, 1L, event_budget, loc)
    None
  } catch {
    ScanAbort(error) => Some(error)
  }
  assert_true(
    failure
    is Some(
      ResourceLimitExceeded({ stage: LineClipEvaluate, .. }, InternalNodes, 7)
    ),
  )
  let bounded = new_call_budget({ ..limits, max_nodes: 300, })
  bounded.stats.nodes = 1
  assert_true(
    line_clip_execute(route, rect, EvenOdd, limits, budget=bounded)
    is Err(ResourceLimitExceeded(_, InternalNodes, 300)),
  )
  assert_true(bounded.stats.nodes > 1)
  assert_eq(route[0], [Point64::new(-2L, 5L), Point64::new(12L, 5L)])
  assert_eq(rect[0], [
    Point64::new(0L, 0L),
    Point64::new(10L, 0L),
    Point64::new(10L, 10L),
    Point64::new(0L, 10L),
  ])
  assert_eq(
    intersect_polylines(route, rect),
    Ok([[Point64::new(0L, 5L), Point64::new(10L, 5L)]]),
  )
}
