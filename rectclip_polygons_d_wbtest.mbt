// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal rect clip polygons: integer success leaves insufficient decoding budget" {
  let rect : BoundsD = { min_x: -1.25, min_y: -0.5, max_x: 2.75, max_y: 2.5, }
  let paths = [
    [
      PointD::new(-2.0, -1.0),
      PointD::new(4.0, -1.0),
      PointD::new(4.0, 4.0),
      PointD::new(-2.0, 4.0),
    ],
    [
      PointD::new(0.0, 0.0),
      PointD::new(1.0, 0.0),
      PointD::new(1.0, 1.0),
      PointD::new(0.0, 1.0),
    ],
  ]
  let precision = Precision::new(2).unwrap()
  let limits : ScanLimits = Default::default()
  let measured = new_call_budget(
    limits,
    generate_stage=RectClipEvaluate,
    cleanup_stage=RectClipEvaluate,
  )
  measured.stats.nodes = 1
  measured.stats.work = 1
  decimal_rect_parameters(rect, precision, measured)
  decimal_precheck(paths, [], precision, measured)
  let window = decimal_rect_quantize(rect, precision, measured)
  let (grid, _) = decimal_quantize(paths, [], precision, true, measured)
  assert_true(
    rect_clip_polygons_execute(window, grid, EvenOdd, limits, budget=measured)
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
    decimal_rect_clip_polygons_execute(
      rect,
      paths,
      precision,
      EvenOdd,
      limits,
      budget=limited,
    )
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalOutput, path_index: None, vertex_index: None, },
        InternalNodes,
        _
      )
    ),
  )
  assert_eq(limited.stats.nodes, measured.stats.nodes)
  assert_eq(limited.limits.max_nodes, measured.stats.nodes)
  assert_true(rect_clip_polygons_d(rect, paths, precision~) is Ok(_))
}
