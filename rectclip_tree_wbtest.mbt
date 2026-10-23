// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "rect clip tree: decimal conversion exhausts shared budget cleans scan and retries" {
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
    rect_clip_polygons_tree_execute(
      window,
      grid,
      EvenOdd,
      limits,
      budget=measured,
    )
    is Ok(_),
  )
  let b = new_call_budget(
    { ..limits, max_nodes: measured.stats.nodes, },
    generate_stage=RectClipEvaluate,
    cleanup_stage=RectClipEvaluate,
  )
  b.stats.nodes = 1
  b.stats.work = 1
  decimal_rect_parameters(rect, precision, b)
  decimal_precheck(paths, [], precision, b)
  let window = decimal_rect_quantize(rect, precision, b)
  let (grid, _) = decimal_quantize(paths, [], precision, true, b)
  let observed : Array[ScanState] = []
  let result = rect_clip_polygons_compute(
    window,
    grid,
    EvenOdd,
    limits,
    fn(state) raise ScanAbort {
      observed.push(state)
      decimal_tree_output(tree_build(state), precision, b)
    },
    fn(b) raise ScanAbort { decimal_tree_output(tree_empty(b), precision, b) },
    budget=b,
  )
  assert_true(
    result
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalOutput, path_index: None, vertex_index: None, },
        InternalNodes,
        _
      )
    ),
  )
  assert_eq(observed.length(), 1)
  assert_true(observed[0].cleaned)
  assert_eq(observed[0].output.points.length(), 0)
  assert_eq(observed[0].output.records.length(), 0)
  // Exercise the actual decimal adapter with the same authoritative limit and history.
  let limited = new_call_budget(
    b.limits,
    generate_stage=RectClipEvaluate,
    cleanup_stage=RectClipEvaluate,
  )
  limited.stats.nodes = 1
  limited.stats.work = 1
  assert_true(
    decimal_rect_clip_polygons_tree_execute(
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
  assert_true(rect_clip_polygons_tree_d(rect, paths, precision~) is Ok(_))
}
