// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal line difference: shared decoding allowance and independent retry" {
  let routes = [[PointD::new(-0.1, 0.1), PointD::new(0.4, 0.3)]]
  let clip = [
    [PointD::new(0.0, 0.0), PointD::new(0.5, 0.0), PointD::new(0.0, 0.5)],
  ]
  let expected = [
    [PointD::new(-0.1, 0.1), PointD::new(0.0, 0.14)],
    [PointD::new(0.257, 0.243), PointD::new(0.4, 0.3)],
  ]
  let saved_routes = copy_paths_d(routes)
  let saved_clip = copy_paths_d(clip)
  let precision : Precision = Default::default()
  let limits : ScanLimits = {
    ..Default::default(),
    input: { max_input_paths: 2, max_input_vertices: 5, },
  }
  let measured = new_call_budget(
    limits,
    generate_stage=LineClipEvaluate,
    cleanup_stage=LineClipEvaluate,
  )
  measured.stats.nodes = 1
  measured.stats.work = 3
  decimal_precheck(routes, clip, precision, measured)
  assert_true(measured.stats.work > 3)
  let (grid, region) = decimal_quantize(
    routes, clip, precision, false, measured,
  )
  assert_true(measured.stats.nodes > 1)
  decimal_spend(measured, 0, 1, location(DecimalQuantize, Some(1), None))
  decimal_closed(region[0], 1, measured)
  let before_integer = measured.stats.work
  assert_true(
    line_clip_execute(
      grid,
      region,
      EvenOdd,
      limits,
      budget=measured,
      mode=KeepOutside,
    )
    is Ok(_),
  )
  assert_true(measured.stats.work > before_integer)
  // One deterministic phase execution fixes the allowance; no threshold search.
  // Replaying the same phases exhausts it before allocating the decode container.
  let limited = new_call_budget(
    { ..limits, max_nodes: measured.stats.nodes, },
    generate_stage=LineClipEvaluate,
    cleanup_stage=LineClipEvaluate,
  )
  limited.stats.nodes = 1
  limited.stats.work = 3
  assert_true(
    decimal_line_clip_execute(
      routes,
      clip,
      precision,
      EvenOdd,
      Default::default(),
      budget=limited,
      mode=KeepOutside,
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
  assert_eq(routes, saved_routes)
  assert_eq(clip, saved_clip)
  assert_eq(difference_polylines_d(routes, clip), Ok(expected))
}
