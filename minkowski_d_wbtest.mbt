// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal minkowski: integer success leaves insufficient shared decoding budget" {
  let pattern = [PointD::new(0.0, -0.25), PointD::new(0.0, 0.25)]
  let path = [PointD::new(-1.0, 0.0), PointD::new(1.0, 0.0)]
  let limits : ScanLimits = Default::default()
  let measured = new_call_budget(
    limits,
    generate_stage=MinkowskiGenerate,
    cleanup_stage=MinkowskiCleanup,
  )
  decimal_precheck([pattern], [path], Default::default(), measured)
  let (left, right) = decimal_quantize(
    [pattern],
    [path],
    Default::default(),
    false,
    measured,
  )
  assert_true(
    minkowski_execute(left[0], right[0], false, limits, budget=measured)
    is Ok(_),
  )
  // Exactly the measured integer-stage allowance: no room for the decoding container.
  let limited = new_call_budget(
    {
      input: limits.input,
      max_nodes: measured.stats.nodes,
      max_work: limits.max_work,
    },
    generate_stage=MinkowskiGenerate,
    cleanup_stage=MinkowskiCleanup,
  )
  assert_true(
    decimal_minkowski_execute(
      pattern,
      path,
      false,
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
  assert_true(minkowski_sum_d(pattern, path, false) is Ok(_))
}
