///|
fn run_foundation_example() -> Unit raise {
  run_rectclip_example()
  run_decimal_rectclip_lines_example()
  run_rectclip_polygons_example()
  run_rectclip_tree_example()
  run_decimal_rectclip_polygons_example()
  run_stroke_batch_example()
  run_stroke_batch_tree_example()
  run_decimal_stroke_batch_example()
  run_decimal_minkowski_example()
  run_tree_locate_example()
  run_decimal_tree_locate_example()
  let path : @moonclip.Path64 = [
    @moonclip.Point64::new(-10L, 0L),
    @moonclip.Point64::new(10L, 0L),
    @moonclip.Point64::new(0L, 10L),
  ]
  let paths : @moonclip.Paths64 = [path, []]
  let copied = @moonclip.copy_paths(paths)
  assert_true(paths == copied)
  path[0] = @moonclip.Point64::new(-99L, 5L)
  assert_eq(copied[0][0].x, -10L)
  assert_eq(copied[0][0].y, 0L)
  assert_true(paths != copied)

  let contour : @moonclip.Path64 = [
    @moonclip.Point64::new(-4L, -3L),
    @moonclip.Point64::new(4L, -3L),
    @moonclip.Point64::new(4L, 3L),
    @moonclip.Point64::new(-4L, 3L),
  ]
  assert_eq(
    @moonclip.orientation(contour[0], contour[1], contour[2]),
    Ok(@moonclip.CounterClockwise),
  )
  match @moonclip.bounds(contour) {
    Ok(Some(box)) => {
      assert_eq(box.min_x, -4L)
      assert_eq(box.min_y, -3L)
      assert_eq(box.max_x, 4L)
      assert_eq(box.max_y, 3L)
    }
    _ => fail("Expected bounds for the rectangle")
  }
  assert_eq(@moonclip.area2(contour), Ok(96N))
  assert_eq(
    @moonclip.point_in_polygon(@moonclip.Point64::new(0L, 0L), contour),
    Ok(@moonclip.Inside),
  )
  assert_eq(
    @moonclip.point_in_polygon(@moonclip.Point64::new(4L, 0L), contour),
    Ok(@moonclip.OnBoundary),
  )
  assert_eq(
    @moonclip.point_in_polygon(@moonclip.Point64::new(5L, 0L), contour),
    Ok(@moonclip.Outside),
  )

  let raw = [
    contour[0],
    contour[0],
    contour[1],
    contour[2],
    contour[3],
    contour[0],
  ]
  let saved = @moonclip.copy_path(raw)
  match @moonclip.normalize_path(raw, @moonclip.Closed) {
    Ok(cleaned) => {
      assert_eq(cleaned, contour)
      assert_eq(raw, saved)
      cleaned[0] = @moonclip.Point64::new(0L, 0L)
      assert_eq(raw, saved)
    }
    Err(error) => fail(error.message())
  }
  let invalid = @moonclip.Point64::new(1000000001L, 0L)
  match @moonclip.bounds([invalid]) {
    Err(CoordinateOutOfRange(loc, X, value)) => {
      assert_true(loc.stage is Bounds)
      assert_eq(loc.vertex_index, Some(0))
      assert_eq(value, 1000000001L)
    }
    _ => fail("Expected coordinate range error")
  }
  let limits : @moonclip.Limits = {
    max_input_paths: 1,
    max_input_vertices: 100,
  }
  assert_true(
    @moonclip.normalize_paths([contour, []], @moonclip.Closed, limits~)
    is Err(ResourceLimitExceeded(_, InputPaths, 1)),
  )
}

///|
fn run_stroke_batch_example() -> Unit raise {
  let paths = [
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
    [@moonclip.Point64::new(5L, 0L), @moonclip.Point64::new(15L, 0L)],
  ]
  let region = @moonclip.stroke_polylines(paths, 2.0).unwrap()
  example_result(region, [example_rect(0L, -1L, 15L, 2L)])
}

///|
fn run_decimal_stroke_batch_example() -> Unit raise {
  let paths = [
    [@moonclip.PointD::new(-1.0, 0.0), @moonclip.PointD::new(1.0, 0.0)],
    [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(2.0, 0.0)],
  ]
  let result = @moonclip.stroke_polylines_d(
    paths,
    0.5,
    precision=@moonclip.Precision::new(2).unwrap(),
  ).unwrap()
  example_decimal_rectangle(result, -1.0, -0.25, 2.0, 0.25)
}

///|
fn run_decimal_minkowski_example() -> Unit raise {
  let pattern = [
    @moonclip.PointD::new(0.0, -0.25),
    @moonclip.PointD::new(0.0, 0.25),
  ]
  let path = [@moonclip.PointD::new(-1.0, 0.0), @moonclip.PointD::new(1.0, 0.0)]
  let result = @moonclip.minkowski_sum_d(pattern, path, false).unwrap()
  example_decimal_rectangle(result, -1.0, -0.25, 1.0, 0.25)
}

///|
fn run_tree_locate_example() -> Unit raise {
  let tree = @moonclip.boolean_tree(
    [
      example_rect(0L, 0L, 20L, 20L),
      example_rect(4L, 4L, 12L, 12L),
      example_rect(8L, 8L, 4L, 4L),
    ],
    [],
    Union,
  ).unwrap()
  guard tree.locate(@moonclip.Point64::new(6L, 6L)) is Ok(InHole(hole)) else {
    fail("Expected hole query")
  }
  assert_eq(hole.depth(), 2)
  assert_true(hole.is_hole())
  guard tree.locate(@moonclip.Point64::new(10L, 10L)) is Ok(Inside(island)) else {
    fail("Expected island query")
  }
  assert_eq(island.depth(), 3)
  assert_true(!island.is_hole())
  guard tree.locate(@moonclip.Point64::new(4L, 6L)) is Ok(OnBoundary(nodes)) else {
    fail("Boundary is a separate query result")
  }
  assert_eq(nodes.length(), 1)
  assert_eq(nodes[0].depth(), 2)
  assert_true(nodes[0].is_hole())
  // Batch results preserve the input order: outside, hole, island, boundary.
  let results = tree
    .locate_many([
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(6L, 6L),
      @moonclip.Point64::new(10L, 10L),
      @moonclip.Point64::new(4L, 6L),
    ])
    .unwrap()
  assert_eq(results.length(), 4)
  assert_true(results[0] is Outside)
  guard results[1] is InHole(node) else { fail("Batch hole order") }
  assert_eq(node.depth(), 2)
  guard results[2] is Inside(node) else { fail("Batch island order") }
  assert_eq(node.depth(), 3)
  guard results[3] is OnBoundary(nodes) else { fail("Batch boundary order") }
  assert_eq(nodes.length(), 1)
  assert_eq(nodes[0].depth(), 2)
}

///|
fn run_rectclip_example() -> Unit raise {
  let r : @moonclip.Bounds64 = { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, }
  let point = fn(x, y) { @moonclip.Point64::new(x, y) }
  assert_eq(
    @moonclip.rect_clip_lines(r, [
      [point(-10L, 5L), point(5L, 5L), point(20L, 5L)],
    ]),
    Ok([[point(0L, 5L), point(5L, 5L), point(10L, 5L)]]),
  )
  assert_eq(
    @moonclip.rect_clip_lines(r, [
      [point(-5L, 2L), point(15L, 2L), point(15L, 8L), point(-5L, 8L)],
    ]),
    Ok([[point(0L, 2L), point(10L, 2L)], [point(10L, 8L), point(0L, 8L)]]),
  )
  println("Rect clip lines: ordered open fragments OK")
}

///|
// Standalone public-library examples, grouped like the browser demo.
fn main raise {
  run_foundation_example()
  // Region operations and holed offsets.
  run_boolean_example()
  run_winding_example()
  run_tree_example()
  run_offset_example()
  run_offset_tree_example()
  run_join_example()
  // Open-route widening.
  run_stroke_example()
  run_stroke_tree_example()
  run_composition_example()
  // Decimal units, explicit simplification and integer pattern sweeps.
  run_decimal_example()
  run_decimal_tree_example()
  run_simplify_example()
  run_minkowski_example()
  run_minkowski_tree_example()
  println(
    "MoonClip geometry, Boolean, PolyTree, offset, stroke, composition, decimal, simplify and Minkowski OK",
  )
}

///|
// Unreleased: one cumulative open-route stroke produces its filled hierarchy.
fn run_stroke_tree_example() -> Unit raise {
  let line = [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)]
  guard @moonclip.stroke_tree(line, 4.0) is Ok(straight) else {
    fail("Expected straight stroke tree")
  }
  assert_eq(straight.roots().length(), 1)
  assert_eq(straight.roots()[0].depth(), 1)
  assert_true(!straight.roots()[0].is_hole())
  assert_eq(straight.roots()[0].children().length(), 0)
  example_result(straight.to_paths(), [example_rect(0L, -2L, 20L, 4L)])
  let route = example_rect(0L, 0L, 30L, 30L)
  route.push(route[0]) // Still an open route with two Square caps.
  guard @moonclip.stroke_tree(route, 4.0, cap=Square) is Ok(tree) else {
    fail("Expected holed stroke tree")
  }
  let expected = [
    example_rect(-2L, -2L, 34L, 34L),
    example_reverse(example_rect(2L, 2L, 26L, 26L)),
  ]
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  assert_eq(root.children().length(), 1)
  let hole = root.children()[0]
  assert_eq(hole.depth(), 2)
  assert_true(hole.is_hole())
  assert_eq(hole.children().length(), 0)
  example_result([root.contour()], [expected[0]])
  example_result([hole.contour()], [expected[1]])
  let decimal = route.map(fn(p) {
    @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
  })
  guard @moonclip.stroke_tree_d(decimal, 0.4, cap=Square) is Ok(decoded) else {
    fail("Expected decimal stroke tree")
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
  for
    (actual, grid) in [
      (droot.contour(), expected[0]),
      (dhole.contour(), expected[1]),
    ] {
    let ring = grid.map(fn(p) {
      @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
    })
    assert_eq(actual.length(), ring.length())
    let mut found = false
    for shift = 0; shift < ring.length(); shift = shift + 1 {
      if Array::makei(actual.length(), fn(i) {
          actual[(i + shift) % actual.length()]
        }) ==
        ring {
        found = true
      }
    }
    assert_true(found)
  }
}

///|
fn run_offset_tree_example() -> Unit raise {
  let input = [
    example_rect(0L, 0L, 40L, 40L),
    example_reverse(example_rect(10L, 10L, 20L, 20L)),
  ]
  guard @moonclip.offset_tree(input, 2.0) is Ok(tree) else {
    fail("Expected holed offset tree")
  }
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  example_result([root.contour()], [example_rect(-2L, -2L, 44L, 44L)])
  assert_eq(root.children().length(), 1)
  let hole = root.children()[0]
  assert_eq(hole.depth(), 2)
  assert_true(hole.is_hole())
  assert_eq(hole.children().length(), 0)
  example_result([hole.contour()], [
    example_reverse(example_rect(12L, 12L, 16L, 16L)),
  ])

  let decimal = input.map(fn(path) {
    path.map(fn(p) {
      @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
    })
  })
  guard @moonclip.offset_tree_d(decimal, 0.2) is Ok(decoded) else {
    fail("Expected decimal holed offset tree")
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
  for
    (actual, grid) in [
      (droot.contour(), root.contour()),
      (dhole.contour(), hole.contour()),
    ] {
    let expected = grid.map(fn(p) {
      @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
    })
    assert_eq(actual.length(), expected.length())
    // Ring start is unspecified; preserve every point and its winding.
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
}

///|
fn example_rect(x : Int64, y : Int64, w : Int64, h : Int64) -> @moonclip.Path64 {
  [
    @moonclip.Point64::new(x, y),
    @moonclip.Point64::new(x + w, y),
    @moonclip.Point64::new(x + w, y + h),
    @moonclip.Point64::new(x, y + h),
  ]
}

///|
fn example_same_ring(a : @moonclip.Path64, b : @moonclip.Path64) -> Bool {
  if a.length() != b.length() {
    return false
  }
  for shift = 0; shift < b.length(); shift = shift + 1 {
    let mut same = true
    for i = 0; i < a.length(); i = i + 1 {
      if a[i] != b[(shift + i) % b.length()] {
        same = false
        break
      }
    }
    if same {
      return true
    }
  }
  a.is_empty()
}

///|
fn example_result(
  actual : @moonclip.Paths64,
  expected : @moonclip.Paths64,
) -> Unit raise {
  assert_eq(actual.length(), expected.length())
  let matched = Array::make(expected.length(), false)
  for path in actual {
    let mut found = false
    for i = 0; i < expected.length(); i = i + 1 {
      if !matched[i] && example_same_ring(path, expected[i]) {
        matched[i] = true
        found = true
        break
      }
    }
    assert_true(found)
  }
}

///|
fn run_boolean_example() -> Unit raise {
  let a = example_rect(0L, 0L, 10L, 10L)
  let b = example_rect(5L, 0L, 10L, 10L)
  for
    (operation, expected, twice_area) in [
      (@moonclip.Intersection, [example_rect(5L, 0L, 5L, 10L)], 100N),
      (@moonclip.Union, [example_rect(0L, 0L, 15L, 10L)], 300N),
      (@moonclip.Difference, [example_rect(0L, 0L, 5L, 10L)], 100N),
      (
        @moonclip.Xor,
        [example_rect(0L, 0L, 5L, 10L), example_rect(10L, 0L, 5L, 10L)],
        200N,
      ),
    ] {
    guard @moonclip.boolean_op([a], [b], operation) is Ok(actual) else {
      fail("Boolean operation failed")
    }
    example_result(actual, expected)
    let mut total = 0N
    for path in actual {
      guard @moonclip.area2(path) is Ok(value) else {
        fail("Expected exact area")
      }
      total += value
    }
    assert_eq(total, twice_area)
  }
  let concave = [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(12L, 0L),
    @moonclip.Point64::new(12L, 4L),
    @moonclip.Point64::new(4L, 4L),
    @moonclip.Point64::new(4L, 12L),
    @moonclip.Point64::new(0L, 12L),
  ]
  guard @moonclip.boolean_op([concave], [], Union) is Ok(actual) else {
    fail("Concave union failed")
  }
  example_result(actual, [concave])
}

///|
fn example_reverse(path : @moonclip.Path64) -> @moonclip.Path64 {
  Array::makei(path.length(), fn(i) { path[path.length() - 1 - i] })
}

///|
fn run_winding_example() -> Unit raise {
  let a = example_rect(0L, 0L, 10L, 10L)
  let b = example_rect(5L, 0L, 10L, 10L)
  let strips = [example_rect(0L, 0L, 5L, 10L), example_rect(10L, 0L, 5L, 10L)]
  for
    (subject, nz_expected, nz_area2) in [
      ([a, b], [example_rect(0L, 0L, 15L, 10L)], 300N),
      ([a, example_reverse(b)], strips, 200N),
      (
        [example_reverse(a), example_reverse(b)],
        [example_rect(0L, 0L, 15L, 10L)],
        300N,
      ),
    ] {
    for
      (rule, expected, expected_area2) in [
        (@moonclip.EvenOdd, strips, 200N),
        (@moonclip.NonZero, nz_expected, nz_area2),
      ] {
      guard @moonclip.boolean_op(subject, [], Union, fill_rule=rule)
        is Ok(actual) else {
        fail("Expected winding result")
      }
      example_result(actual, expected)
      let mut total = 0N
      for path in actual {
        guard @moonclip.area2(path) is Ok(value) else {
          fail("Expected exact area")
        }
        total += value
      }
      assert_eq(total, expected_area2)
    }
  }
}

///|
fn run_tree_example() -> Unit raise {
  let outer = example_rect(-30L, -30L, 60L, 60L)
  let hole = example_reverse(example_rect(-20L, -20L, 40L, 40L))
  let island = example_rect(-10L, -10L, 20L, 20L)
  let subject = [outer, hole, island]
  guard @moonclip.boolean_tree(subject, [], Union, fill_rule=NonZero)
    is Ok(tree) else {
    fail("Expected PolyTree")
  }
  let roots = tree.roots()
  assert_eq(roots.length(), 1)
  let root = roots[0]
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  example_result([root.contour()], [outer])
  let children = root.children()
  assert_eq(children.length(), 1)
  let h = children[0]
  assert_eq(h.depth(), 2)
  assert_true(h.is_hole())
  example_result([h.contour()], [hole])
  let islands = h.children()
  assert_eq(islands.length(), 1)
  assert_eq(islands[0].depth(), 3)
  assert_true(!islands[0].is_hole())
  assert_eq(islands[0].children().length(), 0)
  example_result([islands[0].contour()], [island])
  guard @moonclip.boolean_op(subject, [], Union, fill_rule=NonZero) is Ok(flat) else {
    fail("Expected independent flat result")
  }
  example_result(tree.to_paths(), flat)
  roots.clear()
  children.clear()
  let exposed = h.contour()
  exposed[0] = @moonclip.Point64::new(999L, 999L)
  assert_eq(tree.roots().length(), 1)
  assert_eq(tree.roots()[0].children().length(), 1)
  example_result([tree.roots()[0].children()[0].contour()], [hole])
}

///|
fn run_offset_example() -> Unit raise {
  let rectangle = [example_rect(0L, 0L, 10L, 10L)]
  for
    (delta, expected) in [
      (2.0, [example_rect(-2L, -2L, 14L, 14L)]),
      (-2.0, [example_rect(2L, 2L, 6L, 6L)]),
      (-6.0, []),
    ] {
    guard @moonclip.offset_polygons(rectangle, delta) is Ok(result) else {
      fail("Expected rectangle offset")
    }
    example_result(result, expected)
  }
  let triangle = [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(60L, 0L),
    @moonclip.Point64::new(2L, 10L),
  ]
  guard @moonclip.offset_polygons([triangle], 3.0) is Ok(miter) else {
    fail("Expected Miter")
  }
  example_result(miter, [
    [
      @moonclip.Point64::new(-4L, -3L),
      @moonclip.Point64::new(63L, -3L),
      @moonclip.Point64::new(63L, 2L),
      @moonclip.Point64::new(0L, 13L),
    ],
  ])
  guard @moonclip.offset_polygons(
      [triangle],
      3.0,
      options=@moonclip.OffsetOptions::new(join=Bevel),
    )
    is Ok(bevel) else {
    fail("Expected Bevel")
  }
  example_result(bevel, [
    [
      @moonclip.Point64::new(-3L, 1L),
      @moonclip.Point64::new(0L, -3L),
      @moonclip.Point64::new(60L, -3L),
      @moonclip.Point64::new(61L, 3L),
      @moonclip.Point64::new(3L, 13L),
      @moonclip.Point64::new(-1L, 11L),
    ],
  ])
  let region = [
    example_rect(-30L, -30L, 60L, 60L),
    example_reverse(example_rect(-10L, -10L, 20L, 20L)),
  ]
  for
    (delta, expected) in [
      (
        2.0,
        [
          example_rect(-32L, -32L, 64L, 64L),
          example_reverse(example_rect(-8L, -8L, 16L, 16L)),
        ],
      ),
      (
        -2.0,
        [
          example_rect(-28L, -28L, 56L, 56L),
          example_reverse(example_rect(-12L, -12L, 24L, 24L)),
        ],
      ),
    ] {
    guard @moonclip.offset_polygons(region, delta) is Ok(result) else {
      fail("Expected region offset")
    }
    example_result(result, expected)
  }
  assert_true(
    @moonclip.offset_polygons(
      [],
      0.0,
      options=@moonclip.OffsetOptions::new(miter_limit=1.0),
    )
    is Err(InvalidInput(_, _)),
  )
}

///|
fn run_join_example() -> Unit raise {
  let region = [example_rect(0L, 0L, 100L, 100L)]
  guard @moonclip.offset_polygons(
      region,
      10.0,
      options=@moonclip.OffsetOptions::new(join=Square),
    )
    is Ok(square) else {
    fail("Expected Square offset")
  }
  example_result(square, [
    [
      @moonclip.Point64::new(-10L, -4L),
      @moonclip.Point64::new(-4L, -10L),
      @moonclip.Point64::new(104L, -10L),
      @moonclip.Point64::new(110L, -4L),
      @moonclip.Point64::new(110L, 104L),
      @moonclip.Point64::new(104L, 110L),
      @moonclip.Point64::new(-4L, 110L),
      @moonclip.Point64::new(-10L, 104L),
    ],
  ])
  guard @moonclip.offset_polygons(
      region,
      10.0,
      options=@moonclip.OffsetOptions::new(join=Round, arc_tolerance=0.25),
    )
    is Ok(round) else {
    fail("Expected Round offset")
  }
  example_result(round, [
    [
      @moonclip.Point64::new(104L, -9L),
      @moonclip.Point64::new(108L, -6L),
      @moonclip.Point64::new(110L, -2L),
      @moonclip.Point64::new(110L, 100L),
      @moonclip.Point64::new(109L, 104L),
      @moonclip.Point64::new(106L, 108L),
      @moonclip.Point64::new(102L, 110L),
      @moonclip.Point64::new(0L, 110L),
      @moonclip.Point64::new(-4L, 109L),
      @moonclip.Point64::new(-8L, 106L),
      @moonclip.Point64::new(-10L, 102L),
      @moonclip.Point64::new(-10L, 0L),
      @moonclip.Point64::new(-9L, -4L),
      @moonclip.Point64::new(-6L, -8L),
      @moonclip.Point64::new(-2L, -10L),
      @moonclip.Point64::new(100L, -10L),
    ],
  ])
  assert_true(square != round)
}

///|
fn run_stroke_example() -> Unit raise {
  let line = [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)]
  for
    (cap, expected) in [
      (@moonclip.CapType::Butt, [example_rect(0L, -2L, 20L, 4L)]),
      (@moonclip.CapType::Square, [example_rect(-2L, -2L, 24L, 4L)]),
    ] {
    guard @moonclip.stroke_polyline(line, 4.0, cap~) is Ok(result) else {
      fail("Expected line stroke")
    }
    example_result(result, expected)
  }
  guard @moonclip.stroke_polyline(line, 4.0, cap=Round) is Ok(round) else {
    fail("Expected round caps")
  }
  example_result(round, [
    [
      @moonclip.Point64::new(0L, 2L),
      @moonclip.Point64::new(-2L, 1L),
      @moonclip.Point64::new(-2L, -1L),
      @moonclip.Point64::new(0L, -2L),
      @moonclip.Point64::new(20L, -2L),
      @moonclip.Point64::new(22L, -1L),
      @moonclip.Point64::new(22L, 1L),
      @moonclip.Point64::new(20L, 2L),
    ],
  ])
  let route = [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(20L, 0L),
    @moonclip.Point64::new(20L, 20L),
  ]
  guard @moonclip.stroke_polyline(
      route,
      4.0,
      cap=Round,
      options=@moonclip.OffsetOptions::new(join=Round, arc_tolerance=0.25),
    )
    is Ok(region) else {
    fail("Expected route stroke")
  }
  example_result(region, [
    [
      @moonclip.Point64::new(0L, 2L),
      @moonclip.Point64::new(-2L, 1L),
      @moonclip.Point64::new(-2L, -1L),
      @moonclip.Point64::new(0L, -2L),
      @moonclip.Point64::new(20L, -2L),
      @moonclip.Point64::new(22L, -1L),
      @moonclip.Point64::new(22L, 20L),
      @moonclip.Point64::new(21L, 22L),
      @moonclip.Point64::new(19L, 22L),
      @moonclip.Point64::new(18L, 20L),
      @moonclip.Point64::new(18L, 2L),
    ],
  ])
  assert_eq(@moonclip.stroke_polyline(line, 0.99), Ok([]))
  assert_true(@moonclip.stroke_polyline(line, -1.0) is Err(InvalidInput(_, _)))
}

///|
fn run_composition_example() -> Unit raise {
  guard @moonclip.boolean_op(
      [example_rect(0L, 0L, 10L, 10L)],
      [example_rect(5L, 0L, 10L, 10L)],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(united) else {
    fail("Composition Union failed")
  }
  example_result(united, [example_rect(0L, 0L, 15L, 10L)])
  guard @moonclip.offset_polygons(united, 2.0, fill_rule=@moonclip.NonZero)
    is Ok(expanded) else {
    fail("Composition expansion failed")
  }
  example_result(expanded, [example_rect(-2L, -2L, 19L, 14L)])

  let region = [
    example_rect(0L, 0L, 40L, 40L),
    example_reverse(example_rect(10L, 10L, 20L, 20L)),
  ]
  guard @moonclip.offset_polygons(region, -2.0, fill_rule=@moonclip.NonZero)
    is Ok(inset) else {
    fail("Composition inset failed")
  }
  guard @moonclip.boolean_tree(
      inset,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(tree) else {
    fail("Composition hierarchy failed")
  }
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  assert_eq(root.depth(), 1)
  assert_eq(root.children().length(), 1)
  assert_true(root.children()[0].is_hole())
  example_result([root.contour()], [example_rect(2L, 2L, 36L, 36L)])
  example_result([root.children()[0].contour()], [
    example_reverse(example_rect(8L, 8L, 24L, 24L)),
  ])

  let route = [
    @moonclip.Point64::new(-10L, 10L),
    @moonclip.Point64::new(30L, 10L),
  ]
  guard @moonclip.stroke_polyline(route, 4.0, cap=@moonclip.CapType::Butt)
    is Ok(coverage) else {
    fail("Composition stroke failed")
  }
  guard @moonclip.boolean_op(
      coverage,
      [example_rect(0L, 0L, 20L, 20L)],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(clipped) else {
    fail("Composition intersection failed")
  }
  example_result(clipped, [example_rect(0L, 8L, 20L, 4L)])
}

///|
fn example_box_d(
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
) -> @moonclip.PathD {
  [
    @moonclip.PointD::new(x1, y1),
    @moonclip.PointD::new(x2, y1),
    @moonclip.PointD::new(x2, y2),
    @moonclip.PointD::new(x1, y2),
  ]
}

///|
fn example_decimal_rectangle(
  value : @moonclip.PathsD,
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
) -> Unit raise {
  assert_eq(value.length(), 1)
  let expected = example_box_d(x1, y1, x2, y2)
  let path = value[0]
  assert_eq(path.length(), 4)
  for start = 0; start < 4; start = start + 1 {
    if path[start] == expected[0] {
      for i = 0; i < 4; i = i + 1 {
        assert_eq(path[(start + i) % 4], expected[i])
      }
      return
    }
  }
  fail("Decimal contour differs from the complete expected rectangle")
}

///|
fn run_decimal_example() -> Unit raise {
  guard @moonclip.Precision::new(3) is Ok(precision) else {
    fail("Expected supported precision")
  }
  let subject = [example_box_d(-1.25, -0.25, 1.25, 1.25)]
  let clip = [example_box_d(0.25, -0.25, 2.25, 1.25)]
  let saved = @moonclip.copy_paths_d(subject)
  guard @moonclip.boolean_op_d(
      subject,
      clip,
      @moonclip.Union,
      precision~,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(united) else {
    fail("Decimal Union failed")
  }
  example_decimal_rectangle(united, -1.25, -0.25, 2.25, 1.25)
  guard @moonclip.offset_polygons_d(
      united,
      0.2,
      precision~,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(expanded) else {
    fail("Decimal offset failed")
  }
  example_decimal_rectangle(expanded, -1.45, -0.45, 2.45, 1.45)
  let route = [
    @moonclip.PointD::new(-1.0, 0.0),
    @moonclip.PointD::new(3.0, 0.0),
  ]
  guard @moonclip.stroke_polyline_d(
      route,
      0.4,
      precision~,
      cap=@moonclip.CapType::Butt,
    )
    is Ok(coverage) else {
    fail("Decimal stroke failed")
  }
  example_decimal_rectangle(coverage, -1.0, -0.2, 3.0, 0.2)
  guard @moonclip.boolean_op_d(
      coverage,
      [example_box_d(0.0, -1.0, 2.0, 1.0)],
      @moonclip.Intersection,
      precision~,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(clipped) else {
    fail("Decimal intersection failed")
  }
  example_decimal_rectangle(clipped, 0.0, -0.2, 2.0, 0.2)
  assert_eq(subject, saved)
  assert_true(
    @moonclip.stroke_polyline_d(
      [@moonclip.PointD::new(0.0001, 0.0), @moonclip.PointD::new(0.0002, 0.0)],
      0.0,
      precision~,
    )
    is Err(
      @moonclip.QuantizationFailure(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(0),
          vertex_index: Some(1),
        },
        None,
        Some({ path_index: Some(0), vertex_index: Some(0), .. }),
        _
      )
    ),
  )
}

///|
fn example_decimal_ring(
  path : @moonclip.PathD,
  expected : @moonclip.PathD,
) -> Unit raise {
  assert_eq(path.length(), expected.length())
  for start = 0; start < path.length(); start = start + 1 {
    if path[start] == expected[0] {
      for i = 0; i < path.length(); i = i + 1 {
        assert_eq(path[(start + i) % path.length()], expected[i])
      }
      return
    }
  }
  fail("Decimal tree contour differs from expected ring")
}

///|
fn run_decimal_tree_example() -> Unit raise {
  let outer = example_box_d(-5.25, -5.25, 5.25, 5.25)
  let hole = example_box_d(-3.25, -3.25, 3.25, 3.25)
  let island = example_box_d(-1.25, -1.25, 1.25, 1.25)
  // EvenOdd accepts equal input winding; the returned hole is negative.
  let expected = [
    outer,
    Array::makei(hole.length(), fn(i) { hole[hole.length() - 1 - i] }),
    island,
  ]
  guard @moonclip.boolean_tree_d([outer, hole, island], [], @moonclip.Union)
    is Ok(tree) else {
    fail("Decimal tree failed")
  }
  let mut views = tree.roots()
  for i = 0; i < 3; i = i + 1 {
    assert_eq(views.length(), 1)
    let node = views[0]
    assert_eq(node.depth(), i + 1)
    assert_eq(node.is_hole(), i == 1)
    example_decimal_ring(node.contour(), expected[i])
    views = node.children()
  }
  assert_eq(views.length(), 0)
  assert_eq(tree.to_paths().length(), 3)
  println("Decimal tree: outer/hole/island OK")
}

///|
fn run_simplify_example() -> Unit raise {
  let outer = [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(20L, 0L),
    @moonclip.Point64::new(40L, 0L),
    @moonclip.Point64::new(40L, 40L),
    @moonclip.Point64::new(0L, 40L),
  ]
  let hole = example_reverse(example_rect(10L, 10L, 20L, 20L))
  let input = [outer, hole, []]
  let saved = @moonclip.copy_paths(input)
  guard @moonclip.simplify_paths(
      input,
      options=@moonclip.SimplifyOptions::new(epsilon=0.25),
    )
    is Ok(value) else {
    fail("Simplification failed")
  }
  assert_eq(value.removed_vertices(), 1)
  assert_eq(value.removed_per_path(), [1, 0, 0])
  assert_eq(value.input_degenerate_indices(), [2])
  assert_eq(value.degenerate_indices(), [2])
  assert_eq(value.collapsed_indices(), [])
  assert_eq(input, saved)
  let paths = value.paths()
  assert_eq(paths[0], example_rect(0L, 0L, 40L, 40L))
  let selected : @moonclip.Paths64 = []
  let excluded = value.degenerate_indices()
  for i = 0; i < paths.length(); i = i + 1 {
    if !excluded.contains(i) {
      selected.push(paths[i])
    }
  }
  guard @moonclip.offset_polygons(selected, 2.0) is Ok(expanded) else {
    fail("Post-simplification offset failed")
  }
  let expected_hole = example_reverse(example_rect(12L, 12L, 16L, 16L))
  example_result(expanded, [example_rect(-2L, -2L, 44L, 44L), expected_hole])
  guard @moonclip.boolean_tree(
      expanded,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(tree) else {
    fail("Post-simplification tree failed")
  }
  assert_eq(tree.roots().length(), 1)
  assert_eq(tree.roots()[0].children().length(), 1)
  assert_eq(tree.roots()[0].children()[0].is_hole(), true)
  println(
    "Simplify vertices: 9 -> 8; input_degenerate=[2]; degenerate=[2]; collapsed=[]; offset/tree OK",
  )
}

///|
fn run_minkowski_example() -> Unit raise {
  guard @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      false,
    )
    is Ok(sweep0) else {
    fail("Minkowski sweep failed")
  }
  example_result(sweep0, [
    [
      @moonclip.Point64::new(18L, -1L),
      @moonclip.Point64::new(22L, -1L),
      @moonclip.Point64::new(22L, 1L),
      @moonclip.Point64::new(22L, 21L),
      @moonclip.Point64::new(18L, 21L),
      @moonclip.Point64::new(18L, 19L),
      @moonclip.Point64::new(18L, 1L),
      @moonclip.Point64::new(2L, 1L),
      @moonclip.Point64::new(-2L, 1L),
      @moonclip.Point64::new(-2L, -1L),
    ],
  ])
  guard @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      false,
    )
    is Ok(sweep1) else {
    fail("Minkowski sweep failed")
  }
  example_result(sweep1, [
    [
      @moonclip.Point64::new(-4L, -4L),
      @moonclip.Point64::new(26L, 16L),
      @moonclip.Point64::new(25L, 19L),
      @moonclip.Point64::new(22L, 18L),
      @moonclip.Point64::new(-8L, -2L),
      @moonclip.Point64::new(-8L, -4L),
    ],
  ])
  guard @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      true,
    )
    is Ok(sweep2) else {
    fail("Minkowski sweep failed")
  }
  example_result(sweep2, [
    [
      @moonclip.Point64::new(2L, -1L),
      @moonclip.Point64::new(28L, -1L),
      @moonclip.Point64::new(32L, -1L),
      @moonclip.Point64::new(32L, 1L),
      @moonclip.Point64::new(32L, 21L),
      @moonclip.Point64::new(28L, 21L),
      @moonclip.Point64::new(2L, 21L),
      @moonclip.Point64::new(-2L, 21L),
      @moonclip.Point64::new(-2L, 19L),
      @moonclip.Point64::new(-2L, 1L),
      @moonclip.Point64::new(-2L, -1L),
    ],
    [
      @moonclip.Point64::new(2L, 19L),
      @moonclip.Point64::new(28L, 19L),
      @moonclip.Point64::new(28L, 1L),
      @moonclip.Point64::new(2L, 1L),
    ],
  ])
  guard @moonclip.boolean_tree(
      sweep2,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(tree) else {
    fail("Minkowski tree failed")
  }
  assert_eq(tree.roots().length(), 1)
  assert_eq(tree.roots()[0].children().length(), 1)
  assert_true(tree.roots()[0].children()[0].is_hole())
  println(
    "Minkowski: rectangle/polyline, offcenter/diagonal and closed route/hole OK",
  )
}

///|
fn run_rectclip_polygons_example() -> Unit raise {
  let rect : @moonclip.Bounds64 = {
    min_x: 0L,
    min_y: 0L,
    max_x: 10L,
    max_y: 10L,
  }
  let result = @moonclip.rect_clip_polygons(rect, [
    example_rect(-2L, -2L, 14L, 14L),
    example_rect(3L, 3L, 4L, 4L),
  ]).unwrap()
  example_result(result, [
    example_rect(0L, 0L, 10L, 10L),
    example_reverse(example_rect(3L, 3L, 4L, 4L)),
  ])
}

///|
fn run_decimal_rectclip_polygons_example() -> Unit raise {
  let rect : @moonclip.BoundsD = {
    min_x: -1.25,
    min_y: -0.5,
    max_x: 2.75,
    max_y: 2.5,
  }
  let result = @moonclip.rect_clip_polygons_d(
    rect,
    [example_box_d(-2.0, -1.0, 4.0, 4.0), example_box_d(0.0, 0.0, 1.0, 1.0)],
    precision=@moonclip.Precision::new(2).unwrap(),
  ).unwrap()
  assert_eq(result.length(), 2)
  let outer = example_box_d(-1.25, -0.5, 2.75, 2.5)
  let hole = [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(0.0, 1.0),
    @moonclip.PointD::new(1.0, 1.0),
    @moonclip.PointD::new(1.0, 0.0),
  ]
  let mut outer_count = 0
  for ring in result {
    if ring.contains(outer[0]) {
      example_decimal_ring(ring, outer)
      outer_count += 1
    } else {
      example_decimal_ring(ring, hole)
    }
  }
  assert_eq(outer_count, 1)
}

///|
fn run_decimal_rectclip_lines_example() -> Unit raise {
  let rect : @moonclip.BoundsD = {
    min_x: -1.25,
    min_y: -0.5,
    max_x: 2.75,
    max_y: 2.5,
  }
  let result = @moonclip.rect_clip_lines_d(
    rect,
    [
      [
        @moonclip.PointD::new(-2.0, 0.25),
        @moonclip.PointD::new(0.5, 0.25),
        @moonclip.PointD::new(3.0, 0.25),
      ],
    ],
    precision=@moonclip.Precision::new(2).unwrap(),
  ).unwrap()
  // Direct ordered comparison: the middle collinear point remains present.
  assert_eq(result, [
    [
      @moonclip.PointD::new(-1.25, 0.25),
      @moonclip.PointD::new(0.5, 0.25),
      @moonclip.PointD::new(2.75, 0.25),
    ],
  ])
}

///|
fn run_stroke_batch_tree_example() -> Unit raise {
  let paths = [
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
    [@moonclip.Point64::new(10L, 0L), @moonclip.Point64::new(10L, 10L)],
    [@moonclip.Point64::new(10L, 10L), @moonclip.Point64::new(0L, 10L)],
    [@moonclip.Point64::new(0L, 10L), @moonclip.Point64::new(0L, 0L)],
  ]
  let tree = @moonclip.stroke_polylines_tree(paths, 2.0, cap=Square).unwrap()
  let roots = tree.roots()
  assert_eq(roots.length(), 1)
  assert_eq(roots[0].depth(), 1)
  assert_eq(roots[0].is_hole(), false)
  example_result([roots[0].contour()], [example_rect(-1L, -1L, 12L, 12L)])
  let children = roots[0].children()
  assert_eq(children.length(), 1)
  assert_eq(children[0].depth(), 2)
  assert_eq(children[0].is_hole(), true)
  example_result([children[0].contour()], [
    example_reverse(example_rect(1L, 1L, 8L, 8L)),
  ])
  assert_eq(children[0].children().length(), 0)
}

///|
fn run_rectclip_tree_example() -> Unit raise {
  let rect : @moonclip.Bounds64 = {
    min_x: 0L,
    min_y: 0L,
    max_x: 5L,
    max_y: 10L,
  }
  let tree = @moonclip.rect_clip_polygons_tree(rect, [
    example_rect(-2L, -2L, 14L, 14L),
    example_rect(3L, 3L, 4L, 4L),
  ]).unwrap()
  let roots = tree.roots()
  assert_eq(roots.length(), 1)
  assert_eq(roots[0].depth(), 1)
  assert_eq(roots[0].is_hole(), false)
  assert_eq(roots[0].children().length(), 0)
  // The window cuts the hole open: it is now a notch, not a separate child.
  example_result([roots[0].contour()], [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(5L, 0L),
      @moonclip.Point64::new(5L, 3L),
      @moonclip.Point64::new(3L, 3L),
      @moonclip.Point64::new(3L, 7L),
      @moonclip.Point64::new(5L, 7L),
      @moonclip.Point64::new(5L, 10L),
      @moonclip.Point64::new(0L, 10L),
    ],
  ])
}

///|
fn run_minkowski_tree_example() -> Unit raise {
  let tree = @moonclip.minkowski_sum_tree(
    example_rect(-2L, -1L, 4L, 2L),
    example_rect(0L, 0L, 30L, 20L),
    true,
  ).unwrap()
  let expected = [
    [
      @moonclip.Point64::new(2L, -1L),
      @moonclip.Point64::new(28L, -1L),
      @moonclip.Point64::new(32L, -1L),
      @moonclip.Point64::new(32L, 1L),
      @moonclip.Point64::new(32L, 21L),
      @moonclip.Point64::new(28L, 21L),
      @moonclip.Point64::new(2L, 21L),
      @moonclip.Point64::new(-2L, 21L),
      @moonclip.Point64::new(-2L, 19L),
      @moonclip.Point64::new(-2L, 1L),
      @moonclip.Point64::new(-2L, -1L),
    ],
    [
      @moonclip.Point64::new(2L, 19L),
      @moonclip.Point64::new(28L, 19L),
      @moonclip.Point64::new(28L, 1L),
      @moonclip.Point64::new(2L, 1L),
    ],
  ]
  let roots = tree.roots()
  assert_eq(roots.length(), 1)
  assert_eq(roots[0].depth(), 1)
  assert_eq(roots[0].is_hole(), false)
  assert_eq(roots[0].contour().length(), 11)
  example_result([roots[0].contour()], [expected[0]])
  let children = roots[0].children()
  assert_eq(children.length(), 1)
  assert_eq(children[0].depth(), 2)
  assert_eq(children[0].is_hole(), true)
  assert_eq(children[0].children().length(), 0)
  example_result([children[0].contour()], [expected[1]])
}

///|
fn run_decimal_tree_locate_example() -> Unit raise {
  let tree = @moonclip.boolean_tree_d(
    [
      example_box_d(0.0, 0.0, 2.0, 2.0),
      example_box_d(0.4, 0.4, 1.6, 1.6),
      example_box_d(0.8, 0.8, 1.2, 1.2),
    ],
    [],
    Union,
    precision=@moonclip.Precision::new(2).unwrap(),
  ).unwrap()
  guard tree.locate(@moonclip.PointD::new(0.6, 0.6)) is Ok(InHole(hole)) else {
    fail("Expected decimal hole query")
  }
  assert_eq(hole.depth(), 2)
  let hole_expected = example_box_d(0.4, 0.4, 1.6, 1.6)
  example_decimal_ring(
    hole.contour(),
    Array::makei(4, fn(i) { hole_expected[3 - i] }),
  )
  let results = tree
    .locate_many([
      @moonclip.PointD::new(0.2, 0.2),
      @moonclip.PointD::new(-0.004, 1.0),
      @moonclip.PointD::new(-0.1, 1.0),
    ])
    .unwrap()
  assert_eq(results.length(), 3)
  guard results[0] is Inside(node) else { fail("Expected decimal inside") }
  assert_eq(node.depth(), 1)
  guard results[1] is OnBoundary(nodes) else {
    fail("Expected quantized boundary")
  }
  assert_eq(nodes.length(), 1)
  assert_eq(nodes[0].depth(), 1)
  assert_true(results[2] is Outside)
}
