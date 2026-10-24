// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn dql_node(
  node : @moonclip.PolyNodeD,
  contour : @moonclip.PathD,
  depth : Int,
) -> Unit raise {
  dd_equal([node.contour()], [contour])
  assert_eq(node.depth(), depth)
  assert_eq(node.is_hole(), depth % 2 == 0)
}

///|
test "decimal tree locate: ordered states and independent quantized boundary hits" {
  let outer = dd_box(0.0, 0.0, 2.0, 2.0)
  let hole = dt_reverse(dd_box(0.4, 0.4, 1.6, 1.6))
  let island = dd_box(0.8, 0.8, 1.2, 1.2)
  let tree = dt_get([outer, hole, island], precision=dd_precision(2))
  guard tree.locate(@moonclip.PointD::new(0.6, 0.6)) is Ok(InHole(node)) else {
    fail("Expected decimal hole")
  }
  dql_node(node, hole, 2)
  let points = [
    @moonclip.PointD::new(-0.1, 0.1),
    @moonclip.PointD::new(0.2, 0.2),
    @moonclip.PointD::new(0.6, 0.6),
    @moonclip.PointD::new(1.0, 1.0),
    @moonclip.PointD::new(0.399, 0.6),
    @moonclip.PointD::new(0.401, 0.6),
  ]
  let saved = points.copy()
  let results = tree.locate_many(points).unwrap()
  assert_eq(results.length(), 6)
  assert_true(results[0] is Outside)
  guard results[1] is Inside(node) else { fail("Expected decimal outer") }
  dql_node(node, outer, 1)
  guard results[2] is InHole(node) else { fail("Expected batch hole") }
  dql_node(node, hole, 2)
  guard results[3] is Inside(node) else { fail("Expected decimal island") }
  dql_node(node, island, 3)
  guard results[4] is OnBoundary(first) else {
    fail("Expected rounded boundary")
  }
  guard results[5] is OnBoundary(second) else {
    fail("Coincident grid queries are allowed")
  }
  assert_eq(first.length(), 1)
  assert_eq(second.length(), 1)
  dql_node(first[0], hole, 2)
  dql_node(second[0], hole, 2)
  let contour = first[0].contour()
  contour.clear()
  first.clear()
  assert_eq(second.length(), 1)
  dql_node(second[0], hole, 2)
  dd_equal(tree.to_paths(), [outer, hole, island])
  assert_eq(points, saved)
}

///|
test "decimal tree locate: original precision and indexed input errors" {
  let input = [dd_box(0.0, 0.0, 2.0, 2.0)]
  let coarse = dt_get(input, precision=dd_precision(2))
  let fine = dt_get(input, precision=dd_precision(3))
  let point = @moonclip.PointD::new(-0.004, 1.0)
  guard coarse.locate(point) is Ok(OnBoundary(nodes)) else {
    fail("Precision two rounds onto boundary")
  }
  assert_eq(nodes.length(), 1)
  dql_node(nodes[0], input[0], 1)
  assert_true(fine.locate(point) is Ok(Outside))
  assert_true(
    fine.locate_many([point, @moonclip.PointD::new(@double.infinity, 0.0)])
    is Err(
      QuantizationFailure(
        { stage: PolyTreeQuery, path_index: None, vertex_index: Some(1), },
        Some(X),
        None,
        _
      )
    ),
  )
  let empty = dt_get([], precision=dd_precision(6))
  assert_true(empty.locate(@moonclip.PointD::new(1000.0, 0.0)) is Ok(Outside))
  assert_true(
    empty.locate(@moonclip.PointD::new(1000.001, 0.0))
    is Err(
      DecimalCoordinateOutOfRange(
        { stage: PolyTreeQuery, path_index: None, vertex_index: None, },
        X,
        1000.001,
        6
      )
    ),
  )
  assert_eq(empty.locate_many([]).unwrap().length(), 0)
}
