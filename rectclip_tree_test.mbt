// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "rect clip tree: complete integer and decimal holes with flat regression and isolation" {
  let paths = [bb_rect(-2L, -2L, 14L, 14L), bb_rect(3L, 3L, 4L, 4L)]
  let expected = [
    bb_rect(0L, 0L, 10L, 10L),
    bb_reverse(bb_rect(3L, 3L, 4L, 4L)),
  ]
  let tree = @moonclip.rect_clip_polygons_tree(rc_window(), paths).unwrap()
  pt_chain(tree, expected)
  assert_eq(
    bb_canonical(@moonclip.rect_clip_polygons(rc_window(), paths).unwrap()),
    bb_canonical(expected),
  )
  let rect : @moonclip.BoundsD = {
    min_x: -1.25,
    min_y: -0.5,
    max_x: 2.75,
    max_y: 2.5,
  }
  let decimal = @moonclip.rect_clip_polygons_tree_d(
    rect,
    [dd_box(-2.0, -1.0, 4.0, 4.0), dd_box(0.0, 0.0, 1.0, 1.0)],
    precision=dd_precision(2),
  ).unwrap()
  let hole = [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(0.0, 1.0),
    @moonclip.PointD::new(1.0, 1.0),
    @moonclip.PointD::new(1.0, 0.0),
  ]
  let expected_d = [dd_box(-1.25, -0.5, 2.75, 2.5), hole]
  dt_chain(decimal, expected_d)
  let copied = decimal.roots()[0].children()[0].contour()
  copied[0] = @moonclip.PointD::new(99.0, 99.0)
  dt_chain(decimal, expected_d)
}

///|
test "rect clip tree: cut-open hole becomes one notched outer contour and empty window succeeds" {
  let paths = [bb_rect(-2L, -2L, 14L, 14L), bb_rect(3L, 3L, 4L, 4L)]
  let tree = @moonclip.rect_clip_polygons_tree(
    { ..rc_window(), max_x: 5L, },
    paths,
  ).unwrap()
  pt_chain(tree, [
    st_path([
      (0L, 0L),
      (5L, 0L),
      (5L, 3L),
      (3L, 3L),
      (3L, 7L),
      (5L, 7L),
      (5L, 10L),
      (0L, 10L),
    ]),
  ])
  let empty = @moonclip.rect_clip_polygons_tree(
    { ..rc_window(), max_x: 0L, },
    paths,
  ).unwrap()
  assert_eq(empty.roots().length(), 0)
  assert_eq(empty.to_paths(), [])
}
