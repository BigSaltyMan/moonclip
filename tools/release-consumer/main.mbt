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
  let window : @moonclip.Bounds64 = {
    min_x: 0L,
    min_y: 0L,
    max_x: 10L,
    max_y: 10L,
  }
  let point = fn(x, y) { @moonclip.Point64::new(x, y) }
  assert_eq(
    @moonclip.rect_clip_lines(window, [
      [point(-10L, 5L), point(5L, 5L), point(20L, 5L)],
    ]),
    Ok([[point(0L, 5L), point(5L, 5L), point(10L, 5L)]]),
  )
  println("RECTCLIP_API_OK rect_clip_lines")
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
  check_rect([child.contour()], Array::makei(4, fn(i) { hole[3 - i] }))
  println("TREE_API_OK boolean_tree")
  check_decimal_boolean_tree()

  guard @moonclip.offset_polygons([outer], 2.0) is Ok(expanded) else {
    fail("Offset failed")
  }
  check_rect(expanded, rect(-2L, -2L, 24L, 24L))
  // Both new Unreleased entries must be present in the audited ZIP itself.
  let reverse_hole = Array::makei(hole.length(), fn(i) {
    hole[hole.length() - 1 - i]
  })
  guard @moonclip.offset_tree([outer, reverse_hole], 2.0) is Ok(offset_tree) else {
    fail("Offset tree failed")
  }
  assert_eq(offset_tree.roots().length(), 1)
  let offset_root = offset_tree.roots()[0]
  check_rect([offset_root.contour()], rect(-2L, -2L, 24L, 24L))
  assert_eq(offset_root.depth(), 1)
  assert_true(!offset_root.is_hole())
  assert_eq(offset_root.children().length(), 1)
  let offset_hole = offset_root.children()[0]
  let inset_hole = rect(7L, 7L, 6L, 6L)
  check_rect(
    [offset_hole.contour()],
    Array::makei(4, fn(i) { inset_hole[3 - i] }),
  )
  assert_eq(offset_hole.depth(), 2)
  assert_true(offset_hole.is_hole())
  assert_eq(offset_hole.children().length(), 0)
  println("TREE_API_OK offset_tree")
  let decimal_input = [outer, reverse_hole].map(fn(path) {
    path.map(fn(p) {
      @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
    })
  })
  guard @moonclip.offset_tree_d(decimal_input, 0.2) is Ok(decimal_tree) else {
    fail("Decimal offset tree failed")
  }
  assert_eq(decimal_tree.roots().length(), 1)
  let decimal_root = decimal_tree.roots()[0]
  assert_eq(decimal_root.depth(), 1)
  assert_true(!decimal_root.is_hole())
  assert_eq(decimal_root.children().length(), 1)
  let decimal_hole = decimal_root.children()[0]
  assert_eq(decimal_hole.depth(), 2)
  assert_true(decimal_hole.is_hole())
  assert_eq(decimal_hole.children().length(), 0)
  for
    (actual, grid) in [
      (decimal_root.contour(), offset_root.contour()),
      (decimal_hole.contour(), offset_hole.contour()),
    ] {
    let expected = grid.map(fn(p) {
      @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
    })
    assert_eq(actual.length(), expected.length())
    let mut found = false
    for shift = 0; shift < expected.length(); shift = shift + 1 {
      if Array::makei(actual.length(), fn(i) {
          actual[(i + shift) % actual.length()]
        }) ==
        expected {
        found = true
      }
    }
    assert_true(found)
  }
  println("TREE_API_OK offset_tree_d")
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
  check_stroke_trees()
  check_incremental_rectclip()
  check_incremental_batch_stroke_query(tree)
  check_incremental_minkowski_tree()
  println(
    "MoonClip candidate consumer OK: Boolean PolyTree Offset Stroke Decimal Simplify Minkowski errors",
  )
}

///|
fn check_stroke_trees() -> Unit raise {
  let route = rect(0L, 0L, 30L, 30L)
  route.push(route[0])
  guard @moonclip.stroke_tree(route, 4.0, cap=Square) is Ok(tree) else {
    fail("Stroke tree failed")
  }
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  assert_eq(root.children().length(), 1)
  let hole = root.children()[0]
  assert_eq(hole.depth(), 2)
  assert_true(hole.is_hole())
  assert_eq(hole.children().length(), 0)
  let outer = rect(-2L, -2L, 34L, 34L)
  let inner = rect(2L, 2L, 26L, 26L)
  let reversed = Array::makei(4, fn(i) { inner[3 - i] })
  check_rect([root.contour()], outer)
  check_rect([hole.contour()], reversed)
  println("TREE_API_OK stroke_tree")
  let decimal = route.map(fn(p) {
    @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
  })
  guard @moonclip.stroke_tree_d(decimal, 0.4, cap=Square) is Ok(decoded) else {
    fail("Decimal stroke tree failed")
  }
  assert_eq(decoded.roots().length(), 1)
  let droot = decoded.roots()[0]
  assert_eq(droot.depth(), 1)
  assert_true(!droot.is_hole())
  assert_eq(droot.children().length(), 1)
  let dhole = droot.children()[0]
  assert_eq(dhole.depth(), 2)
  assert_true(dhole.is_hole())
  assert_eq(dhole.children().length(), 0)
  for (actual, grid) in [(droot.contour(), outer), (dhole.contour(), reversed)] {
    let expected = grid.map(fn(p) {
      @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
    })
    assert_eq(actual.length(), expected.length())
    let mut found = false
    for shift = 0; shift < expected.length(); shift = shift + 1 {
      if Array::makei(actual.length(), fn(i) {
          actual[(i + shift) % actual.length()]
        }) ==
        expected {
        found = true
      }
    }
    assert_true(found)
  }
  println("TREE_API_OK stroke_tree_d")
}

///|
fn check_rect_d(
  actual : @moonclip.PathD,
  expected : @moonclip.PathD,
) -> Unit raise {
  assert_eq(actual.length(), 4)
  assert_eq(expected.length(), 4)
  for start = 0; start < 4; start = start + 1 {
    if actual[start] == expected[0] {
      for i = 0; i < 4; i = i + 1 {
        assert_eq(actual[(start + i) % 4], expected[i])
      }
      return
    }
  }
  fail("Expected complete decimal rectangle with original winding")
}

///|
fn decimal_rect(min : Double, max : Double) -> @moonclip.PathD {
  [
    @moonclip.PointD::new(min, min),
    @moonclip.PointD::new(max, min),
    @moonclip.PointD::new(max, max),
    @moonclip.PointD::new(min, max),
  ]
}

///|
fn check_decimal_boolean_tree() -> Unit raise {
  let outer = decimal_rect(-5.25, 5.25)
  let inner = decimal_rect(-3.25, 3.25)
  let hole = Array::makei(4, fn(i) { inner[3 - i] })
  let island = decimal_rect(-1.25, 1.25)
  let subject = [outer, hole, island]
  let clip : @moonclip.PathsD = []
  let original = @moonclip.copy_paths_d(subject)
  guard @moonclip.boolean_tree_d(subject, clip, Union, fill_rule=NonZero)
    is Ok(tree) else {
    fail("Decimal Boolean tree failed")
  }
  assert_eq(subject, original)
  assert_eq(clip, [])
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  check_rect_d(root.contour(), outer)
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  assert_eq(root.children().length(), 1)
  let child = root.children()[0]
  check_rect_d(child.contour(), hole)
  assert_eq(child.depth(), 2)
  assert_true(child.is_hole())
  assert_eq(child.children().length(), 1)
  let deepest = child.children()[0]
  check_rect_d(deepest.contour(), island)
  assert_eq(deepest.depth(), 3)
  assert_true(!deepest.is_hole())
  assert_eq(deepest.children().length(), 0)
  println("TREE_API_OK boolean_tree_d")
}

///|
fn decimal_path(points : Array[(Double, Double)]) -> @moonclip.PathD {
  points.map(fn(pair) { @moonclip.PointD::new(pair.0, pair.1) })
}

///|
fn check_contour_d(
  actual : @moonclip.PathD,
  expected : @moonclip.PathD,
) -> Unit raise {
  assert_eq(actual.length(), expected.length())
  for start = 0; start < actual.length(); start = start + 1 {
    if actual[start] == expected[0] {
      for i = 0; i < expected.length(); i = i + 1 {
        assert_eq(actual[(start + i) % actual.length()], expected[i])
      }
      return
    }
  }
  fail("Expected complete decimal contour with original winding and vertices")
}

///|
fn check_incremental_rectclip() -> Unit raise {
  let precision = @moonclip.Precision::new(2).unwrap()
  let window : @moonclip.BoundsD = {
    min_x: -1.25,
    min_y: -0.5,
    max_x: 2.75,
    max_y: 2.5,
  }
  let route = decimal_path([(-2.0, 0.25), (0.5, 0.25), (3.0, 0.25)])
  let fragments = @moonclip.rect_clip_lines_d(window, [route], precision~).unwrap()
  assert_eq(fragments, [
    decimal_path([(-1.25, 0.25), (0.5, 0.25), (2.75, 0.25)]),
  ])
  let tree = @moonclip.rect_clip_polygons_tree_d(
    window,
    [
      decimal_path([(-2.0, -1.0), (4.0, -1.0), (4.0, 4.0), (-2.0, 4.0)]),
      decimal_path([(0.0, 0.0), (1.0, 0.0), (1.0, 1.0), (0.0, 1.0)]),
    ],
    precision~,
    fill_rule=EvenOdd,
  ).unwrap()
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  check_contour_d(
    root.contour(),
    decimal_path([(-1.25, -0.5), (2.75, -0.5), (2.75, 2.5), (-1.25, 2.5)]),
  )
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  assert_eq(root.children().length(), 1)
  let hole = root.children()[0]
  check_contour_d(
    hole.contour(),
    decimal_path([(0.0, 0.0), (0.0, 1.0), (1.0, 1.0), (1.0, 0.0)]),
  )
  assert_eq(hole.depth(), 2)
  assert_true(hole.is_hole())
  assert_eq(hole.children().length(), 0)
  println("INCREMENTAL_API_OK rectclip")
}

///|
fn check_incremental_batch_stroke_query(
  integer_tree : @moonclip.PolyTree64,
) -> Unit raise {
  let precision = @moonclip.Precision::new(2).unwrap()
  let tree = @moonclip.stroke_polylines_tree_d(
    [
      decimal_path([(-1.0, 0.0), (1.0, 0.0)]),
      decimal_path([(0.0, 0.0), (2.0, 0.0)]),
    ],
    0.5,
    precision~,
    cap=Butt,
  ).unwrap()
  let expected = decimal_path([
    (-1.0, -0.25),
    (2.0, -0.25),
    (2.0, 0.25),
    (-1.0, 0.25),
  ])
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  check_contour_d(root.contour(), expected)
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  assert_eq(root.children().length(), 0)
  // One call queries the same tree that supplied the complete merged contour.
  let locations : Array[@moonclip.TreePointLocationD] = tree
    .locate_many(decimal_path([(0.0, 0.0), (0.0, -0.25), (3.0, 0.0)]))
    .unwrap()
  assert_eq(locations.length(), 3)
  match locations[0] {
    Inside(node) => {
      check_contour_d(node.contour(), expected)
      assert_eq(node.depth(), 1)
      assert_true(!node.is_hole())
    }
    _ => fail("Expected decimal filled interior")
  }
  match locations[1] {
    OnBoundary(nodes) => {
      assert_eq(nodes.length(), 1)
      check_contour_d(nodes[0].contour(), expected)
      assert_eq(nodes[0].depth(), 1)
      assert_true(!nodes[0].is_hole())
    }
    _ => fail("Expected decimal boundary")
  }
  assert_true(locations[2] is Outside)
  let integer_location : @moonclip.TreePointLocation64 = integer_tree
    .locate(@moonclip.Point64::new(10L, 10L))
    .unwrap()
  match integer_location {
    InHole(node) => {
      let hole = rect(5L, 5L, 10L, 10L)
      check_rect([node.contour()], Array::makei(4, fn(i) { hole[3 - i] }))
      assert_eq(node.depth(), 2)
      assert_true(node.is_hole())
    }
    _ => fail("Expected integer Boolean hole")
  }
  println("INCREMENTAL_API_OK batch_stroke_query")
}

///|
fn check_incremental_minkowski_tree() -> Unit raise {
  let tree = @moonclip.minkowski_sum_tree_d(
    decimal_path([(-0.5, -0.25), (0.5, -0.25), (0.5, 0.25), (-0.5, 0.25)]),
    decimal_path([(0.0, 0.0), (7.5, 0.0), (7.5, 5.0), (0.0, 5.0)]),
    true,
    precision=@moonclip.Precision::new(2).unwrap(),
  ).unwrap()
  // Locked rectangle construction, scaled by 1/4. Keep all 11 outer vertices.
  let outer = decimal_path([
    (0.5, -0.25),
    (7.0, -0.25),
    (8.0, -0.25),
    (8.0, 0.25),
    (8.0, 5.25),
    (7.0, 5.25),
    (0.5, 5.25),
    (-0.5, 5.25),
    (-0.5, 4.75),
    (-0.5, 0.25),
    (-0.5, -0.25),
  ])
  let inner = decimal_path([(0.5, 4.75), (7.0, 4.75), (7.0, 0.25), (0.5, 0.25)])
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  check_contour_d(root.contour(), outer)
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  assert_eq(root.children().length(), 1)
  let hole = root.children()[0]
  check_contour_d(hole.contour(), inner)
  assert_eq(hole.depth(), 2)
  assert_true(hole.is_hole())
  assert_eq(hole.children().length(), 0)
  println("INCREMENTAL_API_OK minkowski_tree")
}
