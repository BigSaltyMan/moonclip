// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "closed stroke tree: flat fees empty tree shared conversion failure cleanup and retry" {
  let limits : ScanLimits = Default::default()
  let options : OffsetOptions = Default::default()
  let short = [
    Point64::new(0L, 0L),
    Point64::new(10L, 0L),
    Point64::new(0L, 0L),
  ]
  let flat = st_budget()
  assert_eq(
    stroke_closed_execute(short, 2.0, options, limits, budget=flat),
    Ok([]),
  )
  // Raw work 5, prepare visits/slots 6, closing comparisons 2. One empty array.
  assert_eq(flat.stats.nodes, 5)
  assert_eq(flat.stats.work, 13)
  let empty_budget = st_budget()
  let empty = stroke_closed_tree_execute(
    short,
    2.0,
    options,
    limits,
    budget=empty_budget,
  ).unwrap()
  assert_eq(empty.roots().length(), 0)
  assert_eq(empty_budget.stats.nodes, 8) // Prepared 4 + tree_empty 4, no flat array.
  assert_eq(empty_budget.stats.work, 14)
  let precision = Precision::new(2).unwrap()
  let empty_d = decimal_tree_output(empty, precision, empty_budget)
  assert_eq(empty_d.roots().length(), 0)
  assert_eq(empty_budget.stats.nodes, 12) // Existing empty conversion: 4 nodes / 1 work.
  assert_eq(empty_budget.stats.work, 15)

  let path = [
    PointD::new(0.0, 0.0),
    PointD::new(1.0, 0.0),
    PointD::new(1.0, 1.0),
    PointD::new(0.0, 1.0),
  ]
  let saved = path.copy()
  let measured = st_budget()
  measured.stats.nodes = 1
  measured.stats.work = 3
  decimal_spend(measured, 3, 1, location(DecimalQuantize, None, None))
  let paths = [path]
  let unused : PathsD = []
  decimal_precheck(paths, unused, precision, measured)
  let (grid, _) = decimal_quantize(paths, unused, precision, false, measured)
  let width = decimal_parameter(0.2, precision)
  let scaled = decimal_scaled_options(options, precision)
  assert_true(
    stroke_closed_tree_execute(grid[0], width, scaled, limits, budget=measured)
    is Ok(_),
  )
  // Fixed integer-phase allowance from one execution, never a threshold search.
  let bounded = new_call_budget(
    { ..limits, max_nodes: measured.stats.nodes, },
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  bounded.stats.nodes = 1
  bounded.stats.work = 3
  decimal_spend(bounded, 3, 1, location(DecimalQuantize, None, None))
  decimal_precheck(paths, unused, precision, bounded)
  let (grid, _) = decimal_quantize(paths, unused, precision, false, bounded)
  let observed : Array[ScanState] = []
  let result = stroke_closed_compute(
    grid[0],
    width,
    scaled,
    limits,
    fn(state) raise ScanAbort {
      observed.push(state)
      decimal_tree_output(tree_build(state), precision, bounded)
    },
    fn(budget) raise ScanAbort {
      decimal_tree_output(tree_empty(budget), precision, budget)
    },
    budget=bounded,
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
  let limited = new_call_budget(
    bounded.limits,
    generate_stage=StrokeGenerate,
    cleanup_stage=StrokeCleanup,
  )
  limited.stats.nodes = 1
  limited.stats.work = 3
  assert_true(
    decimal_stroke_closed_tree_execute(
      path,
      0.2,
      precision,
      options,
      limits,
      budget=limited,
    )
    is Err(
      ResourceLimitExceeded({ stage: DecimalOutput, .. }, InternalNodes, _)
    ),
  )
  assert_eq(limited.stats.nodes, measured.stats.nodes)
  assert_eq(limited.stats.work, measured.stats.work)
  assert_eq(limited.limits.max_nodes, measured.stats.nodes)
  assert_eq(path, saved)
  assert_true(stroke_closed_tree_d(path, 0.2, precision~) is Ok(_))
}
