// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn sbt_edges() -> @moonclip.Paths64 {
  [
    st_path([(0L, 0L), (10L, 0L)]),
    st_path([(10L, 0L), (10L, 10L)]),
    st_path([(10L, 10L), (0L, 10L)]),
    st_path([(0L, 10L), (0L, 0L)]),
  ]
}

///|
fn sbt_edges_d() -> @moonclip.PathsD {
  sbt_edges().map(fn(path) {
    path.map(fn(p) {
      @moonclip.PointD::new(p.x.to_double() / 4.0, p.y.to_double() / 4.0)
    })
  })
}

///|
test "stroke batch tree: four independent routes form complete integer and decimal holes" {
  let expected = [
    bb_rect(-1L, -1L, 12L, 12L),
    bb_reverse(bb_rect(1L, 1L, 8L, 8L)),
  ]
  let tree = @moonclip.stroke_polylines_tree(sbt_edges(), 2.0, cap=Square).unwrap()
  pt_chain(tree, expected)
  // Affected flat wrapper keeps the same full contours and winding.
  assert_eq(
    bb_canonical(
      @moonclip.stroke_polylines(sbt_edges(), 2.0, cap=Square).unwrap(),
    ),
    bb_canonical(expected),
  )
  let decimal = @moonclip.stroke_polylines_tree_d(
    sbt_edges_d(),
    0.5,
    precision=dd_precision(2),
    cap=Square,
  ).unwrap()
  let hole = [
    @moonclip.PointD::new(0.25, 0.25),
    @moonclip.PointD::new(0.25, 2.25),
    @moonclip.PointD::new(2.25, 2.25),
    @moonclip.PointD::new(2.25, 0.25),
  ]
  dt_chain(decimal, [dd_box(-0.25, -0.25, 2.75, 2.75), hole])
}

///|
test "stroke batch tree: accessible empty trees isolation and zero-width validation" {
  let empty = @moonclip.stroke_polylines_tree([], 2.0).unwrap()
  assert_eq(empty.roots().length(), 0)
  assert_eq(empty.to_paths(), [])
  let empty_d = @moonclip.stroke_polylines_tree_d([], 0.5).unwrap()
  assert_eq(empty_d.roots().length(), 0)
  assert_eq(empty_d.to_paths(), [])
  let tree = @moonclip.stroke_polylines_tree(sbt_edges(), 2.0, cap=Square).unwrap()
  let contour = tree.roots()[0].contour()
  contour[0] = @moonclip.Point64::new(99L, 99L)
  pt_chain(tree, [
    bb_rect(-1L, -1L, 12L, 12L),
    bb_reverse(bb_rect(1L, 1L, 8L, 8L)),
  ])
  let decimal = @moonclip.stroke_polylines_tree_d(
    sbt_edges_d(),
    0.5,
    precision=dd_precision(2),
    cap=Square,
  ).unwrap()
  let saved = @moonclip.copy_paths_d(decimal.to_paths())
  let d_contour = decimal.roots()[0].contour()
  d_contour[0] = @moonclip.PointD::new(99.0, 99.0)
  assert_eq(decimal.to_paths(), saved)
  assert_true(
    @moonclip.stroke_polylines_tree_d(
      [[@moonclip.PointD::new(0.001, 0.0)], [@moonclip.PointD::new(0.002, 0.0)]],
      0.0,
      precision=dd_precision(2),
    )
    is Err(
      QuantizationFailure(
        { stage: DecimalQuantize, path_index: Some(1), vertex_index: Some(0), },
        None,
        Some(
          {
            stage: DecimalQuantize,
            path_index: Some(0),
            vertex_index: Some(0),
          }
        ),
        _
      )
    ),
  )
}
