// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "closed stroke tree: integer hierarchy flat regression and isolated accessors" {
  let path = bb_rect(0L, 0L, 10L, 10L)
  let expected = [
    bb_rect(-1L, -1L, 12L, 12L),
    bb_reverse(bb_rect(1L, 1L, 8L, 8L)),
  ]
  let tree = @moonclip.stroke_closed_tree(path, 2.0).unwrap()
  pt_chain(tree, expected)
  assert_eq(bb_canonical(tree.to_paths()), bb_canonical(expected))
  assert_eq(
    bb_canonical(@moonclip.stroke_closed_polyline(path, 2.0).unwrap()),
    bb_canonical(expected),
  )
  let roots = tree.roots()
  let copy = roots[0].contour()
  copy[0] = @moonclip.Point64::new(99L, 99L)
  let children = roots[0].children()
  ignore(children.pop())
  ignore(roots.pop())
  pt_chain(tree, expected)
}

///|
test "closed stroke tree: decimal hierarchy isolation and subgrid empty tree" {
  let path = dd_box(0.0, 0.0, 1.0, 1.0)
  let saved = path.copy()
  let precision = dd_precision(2)
  let expected = [
    dd_box(-0.1, -0.1, 1.1, 1.1),
    dt_reverse(dd_box(0.1, 0.1, 0.9, 0.9)),
  ]
  let tree = @moonclip.stroke_closed_tree_d(path, 0.2, precision~).unwrap()
  dt_chain(tree, expected)
  assert_eq(path, saved)
  path[0] = @moonclip.PointD::new(99.0, 99.0)
  dt_chain(tree, expected)
  let copy = tree.roots()[0].contour()
  copy[0] = @moonclip.PointD::new(98.0, 98.0)
  assert_eq(path[0], @moonclip.PointD::new(99.0, 99.0))
  dt_chain(tree, expected)
  let empty = @moonclip.stroke_closed_tree_d(saved, 0.001, precision~).unwrap()
  assert_eq(empty.roots().length(), 0)
  assert_eq(empty.to_paths(), [])
}
