// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal stroke batch: integer success leaves insufficient decoding budget" {
  let paths = [
    [PointD::new(-1.0, 0.0), PointD::new(1.0, 0.0)],
    [PointD::new(0.0, 0.0), PointD::new(2.0, 0.0)],
  ]
  let precision = Precision::new(2).unwrap()
  let limits : ScanLimits = Default::default()
  let measured = new_call_budget(
    limits,
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  // Begin with historical consumption, retained through integer execution and decoding.
  measured.stats.nodes = 1
  measured.stats.work = 1
  decimal_precheck(paths, [], precision, measured)
  let (grid, _) = decimal_quantize(paths, [], precision, false, measured)
  let width = decimal_parameter(0.5, precision)
  let options = decimal_scaled_options(Default::default(), precision)
  assert_true(
    stroke_batch_execute(grid, width, Butt, options, limits, budget=measured)
    is Ok(_),
  )
  let limited = new_call_budget(
    {
      input: limits.input,
      max_nodes: measured.stats.nodes,
      max_work: limits.max_work,
    },
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  limited.stats.nodes = 1
  limited.stats.work = 1
  assert_true(
    decimal_stroke_batch_execute(
      paths,
      0.5,
      precision,
      Butt,
      Default::default(),
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
  assert_true(stroke_polylines_d(paths, 0.5, precision~) is Ok(_))
}
