// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
// Locked case minkowski_rectangle_rectangle_closed_forward, input SHA 3e6a5cfdaf7bcb97...
// Complete reference coordinates embedded here; no runtime file IO or API-generated expectation.
fn mkt_expected() -> @moonclip.Paths64 {
  [
    mk_path([
      (2, -1),
      (28, -1),
      (32, -1),
      (32, 1),
      (32, 21),
      (28, 21),
      (2, 21),
      (-2, 21),
      (-2, 19),
      (-2, 1),
      (-2, -1),
    ]),
    mk_path([(2, 19), (28, 19), (28, 1), (2, 1)]),
  ]
}

///|
fn mkt_quarter(path : @moonclip.Path64) -> @moonclip.PathD {
  path.map(fn(p) {
    @moonclip.PointD::new(p.x.to_double() / 4.0, p.y.to_double() / 4.0)
  })
}

///|
test "minkowski tree: locked complete collinear contours and decimal hierarchy with old entry regressions" {
  let pattern = bb_rect(-2L, -1L, 4L, 2L)
  let path = bb_rect(0L, 0L, 30L, 20L)
  let expected = mkt_expected()
  let tree = @moonclip.minkowski_sum_tree(pattern, path, true).unwrap()
  pt_chain(tree, expected)
  assert_eq(tree.roots()[0].contour().length(), 11)
  assert_eq(tree.roots()[0].children()[0].contour().length(), 4)
  let decimal = @moonclip.minkowski_sum_tree_d(
    mkt_quarter(pattern),
    mkt_quarter(path),
    true,
    precision=dd_precision(2),
  ).unwrap()
  dt_chain(decimal, expected.map(mkt_quarter))
  assert_eq(
    bb_canonical(@moonclip.minkowski_sum(pattern, path, true).unwrap()),
    bb_canonical(expected),
  )
  // Ordinary Boolean trees still remove the middle collinear point.
  pt_chain(
    @moonclip.boolean_tree(
      [mk_path([(0, 0), (5, 0), (10, 0), (10, 10), (0, 10)])],
      [],
      Union,
    ).unwrap(),
    [bb_rect(0L, 0L, 10L, 10L)],
  )
}

///|
test "minkowski tree: empty results validate inputs and snapshots stay isolated" {
  let empty = @moonclip.minkowski_sum_tree([], [], false).unwrap()
  assert_eq(empty.roots().length(), 0)
  assert_eq(empty.to_paths(), [])
  let empty_d = @moonclip.minkowski_sum_tree_d([], [], false).unwrap()
  assert_eq(empty_d.roots().length(), 0)
  assert_eq(empty_d.to_paths(), [])
  let tree = @moonclip.minkowski_sum_tree(
    bb_rect(-2L, -1L, 4L, 2L),
    bb_rect(0L, 0L, 30L, 20L),
    true,
  ).unwrap()
  let copied = tree.roots()[0].contour()
  copied[0] = @moonclip.Point64::new(99L, 99L)
  pt_chain(tree, mkt_expected())
  assert_true(
    @moonclip.minkowski_sum_tree(
      [],
      [@moonclip.Point64::new(1000000001L, 0L)],
      false,
    )
    is Err(
      CoordinateOutOfRange(
        { path_index: Some(1), vertex_index: Some(0), .. },
        X,
        1000000001L
      )
    ),
  )
  // Empty pattern would produce no region, but route collisions must still fail.
  assert_true(
    @moonclip.minkowski_sum_tree_d(
      [],
      [@moonclip.PointD::new(0.001, 0.0), @moonclip.PointD::new(0.002, 0.0)],
      false,
      precision=dd_precision(2),
    )
    is Err(
      QuantizationFailure(
        { stage: DecimalQuantize, path_index: Some(1), vertex_index: Some(1), },
        None,
        Some(
          {
            stage: DecimalQuantize,
            path_index: Some(1),
            vertex_index: Some(0),
          }
        ),
        _
      )
    ),
  )
}
