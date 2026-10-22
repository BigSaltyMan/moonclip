// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn tq_node(
  node : @moonclip.PolyNode64,
  expected : @moonclip.Path64,
  depth : Int,
) -> Unit raise {
  assert_eq(bb_canonical([node.contour()]), bb_canonical([expected]))
  assert_eq(node.depth(), depth)
  assert_eq(node.is_hole(), depth % 2 == 0)
}

///|
test "tree locate: outer hole island and hole boundary" {
  let outer = bb_rect(0L, 0L, 20L, 20L)
  let hole = bb_reverse(bb_rect(4L, 4L, 12L, 12L))
  let island = bb_rect(8L, 8L, 4L, 4L)
  let tree = pt_get([outer, hole, island])
  assert_true(tree.locate(@moonclip.Point64::new(-1L, 1L)) is Ok(Outside))
  guard tree.locate(@moonclip.Point64::new(2L, 2L)) is Ok(Inside(node)) else {
    fail("Expected filled outer")
  }
  tq_node(node, outer, 1)
  guard tree.locate(@moonclip.Point64::new(6L, 6L)) is Ok(InHole(node)) else {
    fail("Expected hole")
  }
  tq_node(node, hole, 2)
  guard tree.locate(@moonclip.Point64::new(10L, 10L)) is Ok(Inside(node)) else {
    fail("Expected island")
  }
  tq_node(node, island, 3)
  guard tree.locate(@moonclip.Point64::new(4L, 6L)) is Ok(OnBoundary(nodes)) else {
    fail("Expected hole boundary")
  }
  assert_eq(nodes.length(), 1)
  tq_node(nodes[0], hole, 2)
}

///|
test "tree locate: touching contours isolated hits and empty validation" {
  let expected = [bb_rect(0L, 0L, 10L, 10L), bb_rect(10L, 10L, 10L, 10L)]
  let tree = pt_get(expected)
  let point = @moonclip.Point64::new(10L, 10L)
  guard tree.locate(point) is Ok(OnBoundary(nodes)) else {
    fail("Expected two boundaries")
  }
  assert_eq(nodes.length(), 2)
  assert_eq(
    bb_canonical(nodes.map(fn(node) { node.contour() })),
    bb_canonical(expected),
  )
  let contour = nodes[0].contour()
  contour[0] = @moonclip.Point64::new(99L, 99L)
  nodes.clear()
  guard tree.locate(point) is Ok(OnBoundary(again)) else {
    fail("Expected independent boundary array")
  }
  assert_eq(again.length(), 2)
  assert_eq(
    bb_canonical(again.map(fn(node) { node.contour() })),
    bb_canonical(expected),
  )
  let empty = pt_get([])
  assert_true(empty.locate(point) is Ok(Outside))
  assert_true(
    empty.locate(@moonclip.Point64::new(1000000001L, 0L))
    is Err(
      CoordinateOutOfRange(
        { stage: PolyTreeQuery, path_index: None, vertex_index: None, },
        X,
        1000000001L
      )
    ),
  )
}
