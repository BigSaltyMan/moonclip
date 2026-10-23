// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "minkowski tree: decimal conversion exhausts shared budget cleans scan and retries" {
  let pattern = [
    PointD::new(-0.5, -0.25),
    PointD::new(0.5, -0.25),
    PointD::new(0.5, 0.25),
    PointD::new(-0.5, 0.25),
  ]
  let path = [
    PointD::new(0.0, 0.0),
    PointD::new(7.5, 0.0),
    PointD::new(7.5, 5.0),
    PointD::new(0.0, 5.0),
  ]
  let precision = Precision::new(2).unwrap()
  let limits : ScanLimits = Default::default()
  let measured = new_call_budget(
    limits,
    generate_stage=MinkowskiGenerate,
    cleanup_stage=MinkowskiCleanup,
  )
  measured.stats.nodes = 1
  measured.stats.work = 1
  decimal_precheck([pattern], [path], precision, measured)
  let (left, right) = decimal_quantize(
    [pattern],
    [path],
    precision,
    false,
    measured,
  )
  assert_true(
    minkowski_tree_execute(left[0], right[0], true, limits, budget=measured)
    is Ok(_),
  )
  let b = new_call_budget(
    { ..limits, max_nodes: measured.stats.nodes, },
    generate_stage=MinkowskiGenerate,
    cleanup_stage=MinkowskiCleanup,
  )
  b.stats.nodes = 1
  b.stats.work = 1
  decimal_precheck([pattern], [path], precision, b)
  let (left, right) = decimal_quantize([pattern], [path], precision, false, b)
  let observed : Array[ScanState] = []
  let result = minkowski_compute(
    left[0],
    right[0],
    true,
    limits,
    fn(state) raise ScanAbort {
      observed.push(state)
      decimal_tree_output(tree_build_with_collinear(state, true), precision, b)
    },
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
    generate_stage=MinkowskiGenerate,
    cleanup_stage=MinkowskiCleanup,
  )
  limited.stats.nodes = 1
  limited.stats.work = 1
  assert_true(
    decimal_minkowski_tree_execute(
      pattern,
      path,
      true,
      precision,
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
  assert_true(minkowski_sum_tree_d(pattern, path, true, precision~) is Ok(_))
}
