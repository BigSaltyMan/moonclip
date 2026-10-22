// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "rect clip polygons: consumed ledger covers window and scan with independent retry" {
  let rect : Bounds64 = { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, }
  let paths = [
    [
      Point64::new(-2L, -2L),
      Point64::new(12L, -2L),
      Point64::new(12L, 12L),
      Point64::new(-2L, 12L),
    ],
  ]
  let limits : ScanLimits = Default::default()
  let measured = new_call_budget(
    limits,
    generate_stage=RectClipEvaluate,
    cleanup_stage=RectClipEvaluate,
  )
  assert_true(
    rect_clip_polygons_execute(rect, paths, EvenOdd, limits, budget=measured)
    is Ok(_),
  )
  let limited = new_call_budget(
    { ..limits, max_nodes: measured.stats.nodes, },
    generate_stage=RectClipEvaluate,
    cleanup_stage=RectClipEvaluate,
  )
  limited.stats.nodes = 1
  limited.stats.work = 1
  assert_true(
    rect_clip_polygons_execute(rect, paths, EvenOdd, limits, budget=limited)
    is Err(ResourceLimitExceeded(_, InternalNodes, _)),
  )
  // The window's 11 nodes / 6 work and later scan consumption all remain charged.
  assert_true(limited.stats.nodes > 12)
  assert_true(limited.stats.work > 7)
  assert_eq(limited.limits.max_nodes, measured.stats.nodes)
  assert_eq(paths[0][0], Point64::new(-2L, -2L))
  assert_true(rect_clip_polygons(rect, paths) is Ok(_))
}
