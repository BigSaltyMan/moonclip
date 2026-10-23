// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "stroke batch tree: decimal output exhaustion cleans the shared scan and retry succeeds" {
  let paths = [
    [PointD::new(0.0, 0.0), PointD::new(2.5, 0.0)],
    [PointD::new(2.5, 0.0), PointD::new(2.5, 2.5)],
    [PointD::new(2.5, 2.5), PointD::new(0.0, 2.5)],
    [PointD::new(0.0, 2.5), PointD::new(0.0, 0.0)],
  ]
  let precision = Precision::new(2).unwrap()
  let limits : ScanLimits = Default::default()
  let measured = new_call_budget(
    limits,
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  measured.stats.nodes = 1
  measured.stats.work = 1
  decimal_precheck(paths, [], precision, measured)
  let (grid, _) = decimal_quantize(paths, [], precision, false, measured)
  let width = decimal_parameter(0.5, precision)
  let options = decimal_scaled_options(Default::default(), precision)
  assert_true(
    stroke_batch_tree_execute(
      grid,
      width,
      Square,
      options,
      limits,
      budget=measured,
    )
    is Ok(_),
  )
  let b = new_call_budget(
    { ..limits, max_nodes: measured.stats.nodes, },
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  b.stats.nodes = 1
  b.stats.work = 1
  decimal_precheck(paths, [], precision, b)
  let (grid, _) = decimal_quantize(paths, [], precision, false, b)
  let observed : Array[ScanState] = []
  let result = stroke_batch_compute(
    grid,
    width,
    Square,
    options,
    limits,
    fn(state) raise ScanAbort {
      observed.push(state)
      decimal_tree_output(tree_build(state), precision, b)
    },
    fn(_, b) raise ScanAbort {
      decimal_tree_output(tree_empty(b), precision, b)
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
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  limited.stats.nodes = 1
  limited.stats.work = 1
  assert_true(
    decimal_stroke_batch_tree_execute(
      paths,
      0.5,
      precision,
      Square,
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
  assert_true(
    stroke_polylines_tree_d(paths, 0.5, precision~, cap=Square) is Ok(_),
  )
}
