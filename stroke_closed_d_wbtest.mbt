// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal closed stroke: subgrid validation shared decoding budget and retry" {
  let path = [
    PointD::new(0.0, 0.0),
    PointD::new(1.0, 0.0),
    PointD::new(1.0, 1.0),
    PointD::new(0.0, 1.0),
  ]
  let saved = path.copy()
  let precision = Precision::new(2).unwrap()
  let options : OffsetOptions = Default::default()
  assert_eq(stroke_closed_polyline_d(path, 0.001, precision~), Ok([]))
  assert_true(
    stroke_closed_polyline_d([PointD::new(10000001.0, 0.0)], 0.0, precision~)
    is Err(
      DecimalCoordinateOutOfRange(
        { stage: DecimalQuantize, path_index: Some(0), vertex_index: Some(0), },
        X,
        10000001.0,
        2
      )
    ),
  )
  let limits : ScanLimits = {
    ..Default::default(),
    input: { max_input_paths: 1, max_input_vertices: 4, },
  }
  let measured = new_call_budget(
    limits,
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  measured.stats.nodes = 1
  measured.stats.work = 3
  decimal_spend(measured, 3, 1, location(DecimalQuantize, None, None))
  let paths = [path]
  let empty : PathsD = []
  decimal_precheck(paths, empty, precision, measured)
  let (grid, _) = decimal_quantize(paths, empty, precision, false, measured)
  let width = decimal_parameter(0.2, precision)
  let scaled_options = decimal_scaled_options(options, precision)
  assert_true(
    stroke_closed_execute(
      grid[0],
      width,
      scaled_options,
      limits,
      budget=measured,
    )
    is Ok(_),
  )
  // One deterministic phase execution fixes the decode allowance; no threshold search.
  let limited = new_call_budget(
    { ..limits, max_nodes: measured.stats.nodes, },
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  limited.stats.nodes = 1
  limited.stats.work = 3
  assert_true(
    decimal_stroke_closed_execute(
      path,
      0.2,
      precision,
      options,
      Default::default(),
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
  assert_eq(limited.stats.work, measured.stats.work)
  assert_eq(limited.limits.max_nodes, measured.stats.nodes)
  assert_eq(limited.limits.input, limits.input)
  assert_eq(path, saved)
  assert_true(stroke_closed_polyline_d(path, 0.2, precision~) is Ok(_))
}
