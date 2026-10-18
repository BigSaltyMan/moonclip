// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn cp_rect(x : Int64, y : Int64, w : Int64, h : Int64) -> @moonclip.Path64 {
  [
    @moonclip.Point64::new(x, y),
    @moonclip.Point64::new(x + w, y),
    @moonclip.Point64::new(x + w, y + h),
    @moonclip.Point64::new(x, y + h),
  ]
}

///|
fn cp_union(
  a : @moonclip.Paths64,
  b : @moonclip.Paths64,
  operation? : @moonclip.ClipType = @moonclip.Union,
) -> @moonclip.Paths64 raise {
  guard @moonclip.boolean_op(a, b, operation, fill_rule=@moonclip.NonZero)
    is Ok(value) else {
    fail("Boolean stage failed")
  }
  value
}

///|
fn cp_offset(a : @moonclip.Paths64, delta : Double) -> @moonclip.Paths64 raise {
  guard @moonclip.offset_polygons(a, delta, fill_rule=@moonclip.NonZero)
    is Ok(value) else {
    fail("Offset stage failed")
  }
  value
}

///|
fn cp_tree(a : @moonclip.Paths64) -> @moonclip.PolyTree64 raise {
  guard @moonclip.boolean_tree(
      a,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(value) else {
    fail("Tree stage failed")
  }
  value
}

///|
fn cp_stroke(
  a : @moonclip.Path64,
  cap? : @moonclip.CapType = @moonclip.Butt,
) -> @moonclip.Paths64 raise {
  guard @moonclip.stroke_polyline(a, 4.0, cap~) is Ok(value) else {
    fail("Stroke stage failed")
  }
  value
}

///|
fn cp_equal(a : @moonclip.Paths64, b : @moonclip.Paths64) -> Unit raise {
  assert_eq(bb_canonical(a), bb_canonical(b))
}

///|
test "composition A1 Union then expansion has independent rectangle expectation" {
  let middle = cp_union([cp_rect(0L, 0L, 10L, 10L)], [cp_rect(5L, 0L, 10L, 10L)])
  cp_equal(middle, [cp_rect(0L, 0L, 15L, 10L)])
  cp_equal(cp_offset(middle, 2.0), [cp_rect(-2L, -2L, 19L, 14L)])
}

///|
test "composition A2 Difference notch then Miter expansion" {
  let middle = cp_union(
    [cp_rect(0L, 0L, 10L, 10L)],
    [cp_rect(5L, -5L, 10L, 20L)],
    operation=@moonclip.Difference,
  )
  cp_equal(middle, [cp_rect(0L, 0L, 5L, 10L)])
  cp_equal(cp_offset(middle, 1.0), [cp_rect(-1L, -1L, 7L, 12L)])
}

///|
test "composition A3 Difference hole then expansion" {
  let middle = cp_union(
    [cp_rect(0L, 0L, 40L, 40L)],
    [cp_rect(10L, 10L, 20L, 20L)],
    operation=@moonclip.Difference,
  )
  cp_equal(cp_offset(middle, 2.0), [
    cp_rect(-2L, -2L, 44L, 44L),
    bb_reverse(cp_rect(12L, 12L, 16L, 16L)),
  ])
}

///|
test "composition A4 multipart inset removes only small component" {
  let middle = cp_union([cp_rect(0L, 0L, 3L, 3L)], [cp_rect(20L, 0L, 10L, 10L)])
  cp_equal(cp_offset(middle, -2.0), [cp_rect(22L, 2L, 6L, 6L)])
}

///|
test "composition A5 explicit EvenOdd cancellation remains empty on Offset" {
  let p = cp_rect(0L, 0L, 10L, 10L)
  guard @moonclip.boolean_op(
      [p, p],
      [],
      @moonclip.Union,
      fill_rule=@moonclip.EvenOdd,
    )
    is Ok(middle) else {
    fail("Boolean failed")
  }
  assert_eq(middle, [])
  assert_eq(cp_offset(middle, 2.0), [])
}

///|
test "composition A6 explicit NonZero retains duplicate winding then shrink" {
  let p = cp_rect(0L, 0L, 10L, 10L)
  let middle = cp_union([p, p], [])
  cp_equal(cp_offset(middle, -2.0), [cp_rect(2L, 2L, 6L, 6L)])
}

///|
test "composition B1 inset preserves complete outer hole contours and ownership" {
  let middle = cp_offset(
    [cp_rect(0L, 0L, 40L, 40L), bb_reverse(cp_rect(10L, 10L, 20L, 20L))],
    -2.0,
  )
  cp_equal(middle, [
    cp_rect(2L, 2L, 36L, 36L),
    bb_reverse(cp_rect(8L, 8L, 24L, 24L)),
  ])
  let t = cp_tree(middle)
  assert_eq(t.roots().length(), 1)
  let root = t.roots()[0]
  assert_eq(root.depth(), 1)
  assert_eq(root.children().length(), 1)
  assert_true(root.children()[0].is_hole())
  cp_equal([root.contour()], [cp_rect(2L, 2L, 36L, 36L)])
  cp_equal([root.children()[0].contour()], [
    bb_reverse(cp_rect(8L, 8L, 24L, 24L)),
  ])
}

///|
test "composition B2 narrow bridge breaks into separate roots" {
  let p = [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(10L, 0L),
    @moonclip.Point64::new(10L, 4L),
    @moonclip.Point64::new(20L, 4L),
    @moonclip.Point64::new(20L, 0L),
    @moonclip.Point64::new(30L, 0L),
    @moonclip.Point64::new(30L, 10L),
    @moonclip.Point64::new(20L, 10L),
    @moonclip.Point64::new(20L, 6L),
    @moonclip.Point64::new(10L, 6L),
    @moonclip.Point64::new(10L, 10L),
    @moonclip.Point64::new(0L, 10L),
  ]
  let middle = cp_offset([p], -2.0)
  cp_equal(middle, [cp_rect(2L, 2L, 6L, 6L), cp_rect(22L, 2L, 6L, 6L)])
  let t = cp_tree(middle)
  assert_eq(t.roots().length(), 2)
  assert_true(t.roots().all(fn(n) { !n.is_hole() && n.children().is_empty() }))
}

///|
test "composition B3 expanding hole reaches exterior and removes hole parentage" {
  let middle = cp_offset(
    [cp_rect(0L, 0L, 40L, 40L), bb_reverse(cp_rect(4L, 4L, 32L, 32L))],
    -2.0,
  )
  assert_eq(middle, [])
  assert_eq(cp_tree(middle).roots().length(), 0)
}

///|
test "composition B4 vanished component continues into empty tree" {
  let middle = cp_offset([cp_rect(0L, 0L, 3L, 3L)], -2.0)
  assert_eq(middle, [])
  assert_eq(cp_tree(middle).to_paths(), [])
}

///|
test "composition B5 nested island keeps all four depths and winding" {
  let middle = cp_offset(
    [
      cp_rect(0L, 0L, 100L, 100L),
      bb_reverse(cp_rect(10L, 10L, 80L, 80L)),
      cp_rect(30L, 30L, 40L, 40L),
      bb_reverse(cp_rect(40L, 40L, 20L, 20L)),
    ],
    -2.0,
  )
  let expected = [
    cp_rect(2L, 2L, 96L, 96L),
    bb_reverse(cp_rect(8L, 8L, 84L, 84L)),
    cp_rect(32L, 32L, 36L, 36L),
    bb_reverse(cp_rect(38L, 38L, 24L, 24L)),
  ]
  cp_equal(middle, expected)
  let t = cp_tree(middle)
  cp_equal(t.to_paths(), expected)
  let mut node = t.roots()[0]
  for d = 1; d <= 4; d = d + 1 {
    assert_eq(node.depth(), d)
    assert_eq(node.is_hole(), d % 2 == 0)
    if d < 4 {
      assert_eq(node.children().length(), 1)
      node = node.children()[0]
    } else {
      assert_eq(node.children().length(), 0)
    }
  }
}

///|
test "composition B6 reversed input winding still normalizes before hierarchy" {
  let middle = cp_offset(
    [bb_reverse(cp_rect(0L, 0L, 40L, 40L)), cp_rect(10L, 10L, 20L, 20L)],
    -2.0,
  )
  let t = cp_tree(middle)
  cp_equal(t.to_paths(), [
    cp_rect(2L, 2L, 36L, 36L),
    bb_reverse(cp_rect(8L, 8L, 24L, 24L)),
  ])
  assert_eq(t.roots()[0].children().length(), 1)
}

///|
test "composition C1 straight Butt route clipped to rectangle" {
  let middle = cp_stroke([
    @moonclip.Point64::new(-10L, 10L),
    @moonclip.Point64::new(30L, 10L),
  ])
  cp_equal(middle, [cp_rect(-10L, 8L, 40L, 4L)])
  cp_equal(
    cp_union(
      middle,
      [cp_rect(0L, 0L, 20L, 20L)],
      operation=@moonclip.Intersection,
    ),
    [cp_rect(0L, 8L, 20L, 4L)],
  )
}

///|
test "composition C2 Round caps clipped away by mask" {
  let middle = cp_stroke(
    [@moonclip.Point64::new(-1L, 10L), @moonclip.Point64::new(21L, 10L)],
    cap=@moonclip.CapType::Round,
  )
  cp_equal(
    cp_union(
      middle,
      [cp_rect(0L, 0L, 20L, 20L)],
      operation=@moonclip.Intersection,
    ),
    [cp_rect(0L, 8L, 20L, 4L)],
  )
}

///|
test "composition C3 corner route intersects concave mask" {
  let middle = cp_stroke([
    @moonclip.Point64::new(-10L, 0L),
    @moonclip.Point64::new(20L, 0L),
    @moonclip.Point64::new(20L, 20L),
  ])
  let mask = [
    @moonclip.Point64::new(0L, -4L),
    @moonclip.Point64::new(10L, -4L),
    @moonclip.Point64::new(10L, 4L),
    @moonclip.Point64::new(4L, 4L),
    @moonclip.Point64::new(4L, 10L),
    @moonclip.Point64::new(0L, 10L),
  ]
  cp_equal(cp_union(middle, [mask], operation=@moonclip.Intersection), [
    cp_rect(0L, -2L, 10L, 4L),
  ])
}

///|
test "composition C4 self crossing route covers central mask" {
  let middle = cp_stroke([
    @moonclip.Point64::new(-20L, -20L),
    @moonclip.Point64::new(20L, 20L),
    @moonclip.Point64::new(-20L, 20L),
    @moonclip.Point64::new(20L, -20L),
  ])
  cp_equal(
    cp_union(
      middle,
      [cp_rect(-1L, -1L, 2L, 2L)],
      operation=@moonclip.Intersection,
    ),
    [cp_rect(-1L, -1L, 2L, 2L)],
  )
}

///|
test "composition C5 hole mask cuts route into two contours" {
  let middle = cp_stroke([
    @moonclip.Point64::new(-10L, 20L),
    @moonclip.Point64::new(50L, 20L),
  ])
  let mask = [
    cp_rect(0L, 0L, 40L, 40L),
    bb_reverse(cp_rect(10L, 10L, 20L, 20L)),
  ]
  cp_equal(cp_union(middle, mask, operation=@moonclip.Intersection), [
    cp_rect(0L, 18L, 10L, 4L),
    cp_rect(30L, 18L, 10L, 4L),
  ])
}

///|
test "composition C6 disjoint mask produces legitimate empty" {
  let middle = cp_stroke([
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(10L, 0L),
  ])
  assert_eq(
    cp_union(
      middle,
      [cp_rect(0L, 20L, 10L, 10L)],
      operation=@moonclip.Intersection,
    ),
    [],
  )
}

///|
test "composition isolation 1 inputs remain unchanged across all three flows" {
  let a = [cp_rect(0L, 0L, 10L, 10L)]
  let b = [cp_rect(5L, 0L, 10L, 10L)]
  let saved_a = @moonclip.copy_paths(a)
  let saved_b = @moonclip.copy_paths(b)
  let middle = cp_union(a, b)
  ignore(cp_tree(cp_offset(middle, 2.0)))
  let route = [@moonclip.Point64::new(-5L, 5L), @moonclip.Point64::new(20L, 5L)]
  let saved = route.copy()
  ignore(cp_union(cp_stroke(route), a, operation=@moonclip.Intersection))
  assert_eq(a, saved_a)
  assert_eq(b, saved_b)
  assert_eq(route, saved)
}

///|
test "composition isolation 2 alias inputs and independently mutable output" {
  let path = cp_rect(0L, 0L, 10L, 10L)
  let inputs = [path, path]
  let middle = cp_union(inputs, [])
  cp_equal(middle, [cp_rect(0L, 0L, 10L, 10L)])
  middle[0][0] = @moonclip.Point64::new(-20L, -20L)
  assert_eq(inputs, [cp_rect(0L, 0L, 10L, 10L), cp_rect(0L, 0L, 10L, 10L)])
}

///|
test "composition isolation 3 modifying intermediate leaves source and other result intact" {
  let input = [cp_rect(0L, 0L, 10L, 10L)]
  let middle = cp_union(input, [])
  let other = cp_offset(middle, 2.0)
  middle[0].clear()
  middle.clear()
  cp_equal(input, [cp_rect(0L, 0L, 10L, 10L)])
  cp_equal(other, [cp_rect(-2L, -2L, 14L, 14L)])
}

///|
test "composition isolation 4 modified intermediate coordinates are new raw inputs" {
  let middle = cp_union([cp_rect(0L, 0L, 10L, 10L)], [])
  middle[0][2] = @moonclip.Point64::new(1000000001L, 0L)
  assert_true(
    @moonclip.offset_polygons(middle, 2.0)
    is Err(
      @moonclip.CoordinateOutOfRange(
        {
          stage: @moonclip.EnginePrepare,
          path_index: Some(0),
          vertex_index: Some(2),
        },
        @moonclip.X,
        1000000001L
      )
    ),
  )
}

///|
test "composition isolation 5 intermediate must obey next calls raw vertex limit" {
  let middle = cp_union([cp_rect(0L, 0L, 10L, 10L)], [])
  assert_true(
    @moonclip.boolean_tree(middle, [], @moonclip.Union, limits={
      max_input_paths: 10000,
      max_input_vertices: 3,
    })
    is Err(
      @moonclip.ResourceLimitExceeded(
        { stage: @moonclip.EnginePrepare, .. },
        @moonclip.InputVertices,
        3
      )
    ),
  )
  cp_equal(middle, [cp_rect(0L, 0L, 10L, 10L)])
}

///|
test "composition isolation 6 tree flatten copies isolate outer and inner arrays" {
  let t = cp_tree(
    cp_offset(
      [cp_rect(0L, 0L, 40L, 40L), bb_reverse(cp_rect(10L, 10L, 20L, 20L))],
      -2.0,
    ),
  )
  let saved = t.to_paths()
  let changed = t.to_paths()
  changed[0].clear()
  changed.clear()
  assert_eq(t.to_paths(), saved)
}

///|
test "composition isolation 7 node and child accessor arrays are independent" {
  let t = cp_tree([
    cp_rect(0L, 0L, 40L, 40L),
    bb_reverse(cp_rect(10L, 10L, 20L, 20L)),
  ])
  let root = t.roots()[0]
  let saved = root.contour()
  let changed = root.contour()
  changed.clear()
  let children = root.children()
  children.clear()
  assert_eq(root.contour(), saved)
  assert_eq(root.children().length(), 1)
}

///|
test "composition isolation 8 success failure success creates fresh public budgets" {
  let input = [cp_rect(0L, 0L, 10L, 10L)]
  let good = cp_offset(cp_union(input, []), 2.0)
  assert_true(
    @moonclip.offset_polygons(input, 2.0, limits={
      max_input_paths: 10000,
      max_input_vertices: 0,
    })
    is Err(@moonclip.ResourceLimitExceeded(_, @moonclip.InputVertices, 0)),
  )
  cp_equal(cp_offset(cp_union(input, []), 2.0), good)
}
