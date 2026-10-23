// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "tree locate batch: ordered states and independent boundary results" {
  let outer = bb_rect(0L, 0L, 20L, 20L)
  let hole = bb_reverse(bb_rect(4L, 4L, 12L, 12L))
  let island = bb_rect(8L, 8L, 4L, 4L)
  let tree = pt_get([outer, hole, island])
  let points = [
    @moonclip.Point64::new(-1L, 1L),
    @moonclip.Point64::new(2L, 2L),
    @moonclip.Point64::new(6L, 6L),
    @moonclip.Point64::new(10L, 10L),
    @moonclip.Point64::new(4L, 6L),
    @moonclip.Point64::new(4L, 6L),
  ]
  let saved = points.copy()
  let results = tree.locate_many(points).unwrap()
  assert_eq(results.length(), 6)
  assert_true(results[0] is Outside)
  guard results[1] is Inside(node) else { fail("Expected outer") }
  tq_node(node, outer, 1)
  guard results[2] is InHole(node) else { fail("Expected hole") }
  tq_node(node, hole, 2)
  guard results[3] is Inside(node) else { fail("Expected island") }
  tq_node(node, island, 3)
  guard results[4] is OnBoundary(first) else { fail("Expected first boundary") }
  guard results[5] is OnBoundary(second) else {
    fail("Expected second boundary")
  }
  assert_eq(first.length(), 1)
  assert_eq(second.length(), 1)
  tq_node(first[0], hole, 2)
  tq_node(second[0], hole, 2)
  let copy = first[0].contour()
  copy[0] = @moonclip.Point64::new(99L, 99L)
  first.clear()
  assert_eq(second.length(), 1)
  tq_node(second[0], hole, 2)
  guard tree.locate(points[2]) is Ok(InHole(node)) else {
    fail("Single query regression")
  }
  tq_node(node, hole, 2)
  assert_eq(points, saved)
  assert_eq(bb_canonical(tree.to_paths()), bb_canonical([outer, hole, island]))
}

///|
test "tree locate batch: later invalid point and empty input validation" {
  let tree = pt_get([bb_rect(0L, 0L, 20L, 20L)])
  let point = @moonclip.Point64::new(2L, 2L)
  assert_true(
    tree.locate_many([point, @moonclip.Point64::new(-9223372036854775808L, 0L)])
    is Err(
      CoordinateOutOfRange(
        { stage: PolyTreeQuery, path_index: None, vertex_index: Some(1), },
        X,
        -9223372036854775808L
      )
    ),
  )
  assert_eq(tree.locate_many([]).unwrap().length(), 0)
  assert_true(
    tree.locate_many([], limits={ max_input_paths: -1, max_input_vertices: 0, })
    is Err(InvalidInput(_, _)),
  )
  let empty = pt_get([])
  let results = empty.locate_many([point]).unwrap()
  assert_eq(results.length(), 1)
  assert_true(results[0] is Outside)
  assert_true(
    empty.locate_many([@moonclip.Point64::new(1000000001L, 0L)])
    is Err(
      CoordinateOutOfRange(
        { stage: PolyTreeQuery, path_index: None, vertex_index: Some(0), },
        X,
        1000000001L
      )
    ),
  )
}
