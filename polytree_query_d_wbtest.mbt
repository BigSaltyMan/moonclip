// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal tree locate: exact grid recovery conversion isolation and shared budget" {
  for digits in [0, 6] {
    let precision = Precision::new(digits).unwrap()
    for k in [0L, -1000000000L, 1000000000L, -123456789L, 123456789L] {
      assert_eq(
        decimal_tree_grid_value(decimal_value(k, precision), precision),
        k,
      )
    }
  }
  let precision = Precision::new(2).unwrap()
  assert_true(
    wb_error(fn() raise ScanAbort { decimal_tree_grid_value(0.123, precision) })
    is ExecutionFailure(
      { stage: PolyTreeQuery, path_index: None, vertex_index: None, },
      _
    ),
  )
  let source = boolean_tree(
    [
      pt_rect(w=20L, h=20L),
      pt_rect(x=4L, y=4L, w=12L, h=12L),
      pt_rect(x=8L, y=8L, w=4L, h=4L),
    ],
    [],
    Union,
  ).unwrap()
  let conversion = new_call_budget(Default::default())
  let tree = decimal_tree_output(source, precision, conversion)
  assert_eq(tree.data.precision, precision)
  assert_eq(conversion.stats.nodes, 43) // 4+5*3+2*12, no metadata container.
  assert_eq(conversion.stats.work, 19) // 1+2*3+12.
  source.data.roots.clear()
  source.data.nodes[0].children.clear()
  source.data.nodes[0].contour.clear()
  assert_eq(tree.data.roots, [0])
  assert_eq(tree.data.nodes[0].children, [1])
  assert_eq(tree.data.nodes[0].contour.length(), 4)
  let saved = tree.to_paths()
  let point = PointD::new(-1.0, 1.0)
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 500,
    max_work: 45,
  }
  let one = new_call_budget(limits)
  one.stats.work = 1
  assert_true(
    decimal_tree_locate_many_execute(
      tree,
      [point],
      Default::default(),
      budget=one,
    )
    is Ok(_),
  )
  // History 1 + point axes 2 + size 3 + grid 19 + integer query 15 + mapping 1 + append 1.
  assert_eq(one.stats.work, 42)
  assert_eq(one.stats.nodes, 52) // Quantized array/point/slot 3 + grid 43 + results 1 + query 3 + map 1 + slot 1.
  let batch = new_call_budget(limits)
  batch.stats.work = 1
  assert_true(
    decimal_tree_locate_many_execute(
      tree,
      [point, point],
      Default::default(),
      budget=batch,
    )
    is Err(
      ResourceLimitExceeded(
        { stage: PolyTreeQuery, path_index: None, vertex_index: Some(1), },
        ScanWork,
        45
      )
    ),
  )
  // Two points add two validation work: first result finishes at 44, next node at 45.
  assert_eq(batch.stats.work, 45)
  assert_eq(tree.to_paths(), saved)
  assert_eq(tree.locate_many([point, point]).unwrap().length(), 2)
  let empty_source : PolyTree64 = { data: { nodes: [], roots: [], }, }
  let empty_budget = new_call_budget(Default::default())
  let empty = decimal_tree_output(empty_source, precision, empty_budget)
  assert_eq(empty.data.precision, precision)
  assert_eq((empty_budget.stats.nodes, empty_budget.stats.work), (4, 1))
}
