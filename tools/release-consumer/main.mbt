// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE in MoonClip.

///|
fn rect(x : Int64, y : Int64, w : Int64, h : Int64) -> @moonclip.Path64 {
  [
    @moonclip.Point64::new(x, y),
    @moonclip.Point64::new(x + w, y),
    @moonclip.Point64::new(x + w, y + h),
    @moonclip.Point64::new(x, y + h),
  ]
}

///|
fn check_rect(
  paths : @moonclip.Paths64,
  expected : @moonclip.Path64,
) -> Unit raise {
  assert_eq(paths.length(), 1)
  assert_eq(paths[0].length(), 4)
  let actual = paths[0]
  for start = 0; start < 4; start = start + 1 {
    if actual[start] == expected[0] {
      for i = 0; i < 4; i = i + 1 {
        assert_eq(actual[(start + i) % 4], expected[i])
      }
      return
    }
  }
  fail("Expected complete rectangle")
}

///|
fn main raise {
  let outer = rect(0L, 0L, 20L, 20L)
  let hole = rect(5L, 5L, 10L, 10L)
  guard @moonclip.boolean_op(
      [outer],
      [rect(10L, -5L, 20L, 20L)],
      Intersection,
      fill_rule=NonZero,
    )
    is Ok(intersection) else {
    fail("Boolean failed")
  }
  check_rect(intersection, rect(10L, 0L, 10L, 15L))
  guard @moonclip.boolean_tree([outer], [hole], Difference, fill_rule=NonZero)
    is Ok(tree) else {
    fail("PolyTree failed")
  }
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  check_rect([root.contour()], outer)
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  assert_eq(root.children().length(), 1)
  let child = root.children()[0]
  assert_eq(child.depth(), 2)
  assert_true(child.is_hole())
  assert_eq(child.children().length(), 0)
  assert_eq(@moonclip.area2(child.contour()), Ok(-200N))

  guard @moonclip.offset_polygons([outer], 2.0) is Ok(expanded) else {
    fail("Offset failed")
  }
  check_rect(expanded, rect(-2L, -2L, 24L, 24L))
  let route = [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)]
  guard @moonclip.stroke_polyline(route, 4.0, cap=Butt) is Ok(stroke) else {
    fail("Stroke failed")
  }
  check_rect(stroke, rect(0L, -2L, 20L, 4L))

  let decimal = [
    [
      @moonclip.PointD::new(-1.25, -0.25),
      @moonclip.PointD::new(1.25, -0.25),
      @moonclip.PointD::new(1.25, 1.25),
      @moonclip.PointD::new(-1.25, 1.25),
    ],
  ]
  guard @moonclip.Precision::new(2) is Ok(precision) else {
    fail("Precision failed")
  }
  guard @moonclip.boolean_op_d(
      decimal,
      [],
      Union,
      fill_rule=NonZero,
      precision~,
    )
    is Ok(decoded) else {
    fail("Decimal Boolean failed")
  }
  assert_eq(decoded.length(), 1)
  assert_eq(decoded[0].length(), 4)
  for p in decimal[0] {
    assert_true(decoded[0].contains(p))
  }

  let redundant = [
    outer[0],
    @moonclip.Point64::new(10L, 0L),
    outer[1],
    outer[2],
    outer[3],
  ]
  guard @moonclip.simplify_paths(
      [redundant],
      options=@moonclip.SimplifyOptions::new(epsilon=0.25),
    )
    is Ok(simple) else {
    fail("Simplify failed")
  }
  check_rect(simple.paths(), outer)
  assert_eq(simple.removed_vertices(), 1)
  assert_eq(simple.degenerate_indices(), [])
  guard @moonclip.minkowski_sum(rect(-1L, -1L, 2L, 2L), route, false)
    is Ok(sweep) else {
    fail("Minkowski failed")
  }
  assert_eq(sweep.length(), 1)
  assert_eq(@moonclip.area2(sweep[0]), Ok(88N))
  assert_eq(
    @moonclip.bounds(sweep[0]),
    Ok(Some({ min_x: -1L, min_y: -1L, max_x: 21L, max_y: 1L, })),
  )

  assert_true(
    @moonclip.stroke_polyline(route, -1.0)
    is Err(InvalidInput({ stage: StrokeParameters, .. }, _)),
  )
  assert_true(
    @moonclip.bounds([@moonclip.Point64::new(1000000001L, 0L)])
    is Err(CoordinateOutOfRange({ vertex_index: Some(0), .. }, X, 1000000001L)),
  )
  println(
    "MoonClip candidate consumer OK: Boolean PolyTree Offset Stroke Decimal Simplify Minkowski errors",
  )
}
