///|
fn main raise {
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
  run_boolean_example()
  run_winding_example()
  run_tree_example()
  println("MoonClip geometry, Boolean and PolyTree OK")
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
