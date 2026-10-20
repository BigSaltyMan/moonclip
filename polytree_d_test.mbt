// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn dt_get(
  subject : @moonclip.PathsD,
  clip? : @moonclip.PathsD = [],
  operation? : @moonclip.ClipType = Union,
  precision? : @moonclip.Precision = Default::default(),
  fill_rule? : @moonclip.FillRule = EvenOdd,
) -> @moonclip.PolyTreeD raise {
  match
    @moonclip.boolean_tree_d(subject, clip, operation, precision~, fill_rule~) {
    Ok(tree) => tree
    Err(error) => fail(error.message())
  }
}

///|
fn dt_reverse(path : @moonclip.PathD) -> @moonclip.PathD {
  Array::makei(path.length(), fn(i) { path[path.length() - 1 - i] })
}

///|
// Locked integer fixture hole_difference_evenodd, input SHA f0ea16637f0cd318...
// Decode its complete expected contours on the 10^2 grid, not via another API.
test "decimal tree: locked hole difference decoded on precision two grid" {
  let outer = dd_box(-0.2, -0.2, 0.2, 0.2)
  let hole = dd_box(-0.1, -0.1, 0.1, 0.1)
  dt_chain(
    dt_get(
      [outer],
      clip=[hole],
      operation=Difference,
      precision=dd_precision(2),
    ),
    [outer, dt_reverse(hole)],
  )
}

///|
// Locked fixture touch_edge_union_nonzero, input SHA f4ddcc11ec06f722...
test "decimal tree: locked touching edge union decoded on precision two grid" {
  dt_chain(
    dt_get(
      [dd_box(0.0, 0.0, 0.1, 0.1)],
      clip=[dd_box(0.1, 0.0, 0.2, 0.1)],
      precision=dd_precision(2),
      fill_rule=NonZero,
    ),
    [dd_box(0.0, 0.0, 0.2, 0.1)],
  )
}

///|
fn dt_chain(tree : @moonclip.PolyTreeD, paths : @moonclip.PathsD) -> Unit raise {
  let mut views = tree.roots()
  for i = 0; i < paths.length(); i = i + 1 {
    assert_eq(views.length(), 1)
    let node = views[0]
    assert_eq(node.depth(), i + 1)
    assert_eq(node.is_hole(), i % 2 == 1)
    // dd_equal rotates and sorts rings only: no reversal or vertex deletion.
    dd_equal([node.contour()], [paths[i]])
    views = node.children()
  }
  assert_eq(views.length(), 0)
  dd_equal(tree.to_paths(), paths)
}

///|
test "decimal tree: empty tree and zero input allowances" {
  guard @moonclip.boolean_tree_d([], [], Union, limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    })
    is Ok(tree) else {
    fail("Expected empty tree")
  }
  assert_eq(tree.roots().length(), 0)
  assert_eq(tree.to_paths(), [])
  assert_eq(dt_get([[], []]).to_paths(), [])
}

///|
test "decimal tree: single fractional root and default precision" {
  let box = dd_box(-2.125, -1.25, 4.375, 3.5)
  dt_chain(dt_get([box]), [box])
}

///|
test "decimal tree: distinct roots and sibling views" {
  let a = dd_box(-4.5, -2.5, -2.5, 1.5)
  let b = dd_box(1.25, -1.75, 3.75, 2.25)
  let tree = dt_get([a, b])
  assert_eq(tree.roots().length(), 2)
  dd_equal(tree.to_paths(), [a, b])
  let first = tree.roots()[0].contour()
  first[0] = @moonclip.PointD::new(99.0, 99.0)
  for node in tree.roots() {
    assert_eq(node.depth(), 1)
    assert_true(!node.is_hole())
    assert_eq(node.children().length(), 0)
  }
  dd_equal(tree.roots().map(fn(n) { n.contour() }), [a, b])
}

///|
test "decimal tree: EvenOdd outer hole island complete contours" {
  let a = dd_box(-5.25, -5.25, 5.25, 5.25)
  let b = dd_box(-3.25, -3.25, 3.25, 3.25)
  let c = dd_box(-1.25, -1.25, 1.25, 1.25)
  dt_chain(dt_get([a, b, c]), [a, dt_reverse(b), c])
}

///|
test "decimal tree: NonZero outer hole island complete contours" {
  let paths = [
    dd_box(-5.5, -5.5, 5.5, 5.5),
    dt_reverse(dd_box(-3.5, -3.5, 3.5, 3.5)),
    dd_box(-1.5, -1.5, 1.5, 1.5),
  ]
  dt_chain(dt_get(paths, fill_rule=NonZero), paths)
}

///|
test "decimal tree: fill rules distinguish equal winding nested inputs" {
  let a = dd_box(0.0, 0.0, 10.0, 10.0)
  let b = dd_box(2.0, 2.0, 8.0, 8.0)
  dt_chain(dt_get([a, b], fill_rule=EvenOdd), [a, dt_reverse(b)])
  dt_chain(dt_get([a, b], fill_rule=NonZero), [a])
}

///|
test "decimal tree: four operations under both public fill rules" {
  for fill in [@moonclip.EvenOdd, @moonclip.NonZero] {
    let a = dd_box(0.0, 0.0, 2.0, 2.0)
    let b = dd_box(1.0, 0.0, 3.0, 2.0)
    for
      (operation, expected) in [
        (@moonclip.Union, [dd_box(0.0, 0.0, 3.0, 2.0)]),
        (@moonclip.Intersection, [dd_box(1.0, 0.0, 2.0, 2.0)]),
        (@moonclip.Difference, [dd_box(0.0, 0.0, 1.0, 2.0)]),
        (
          @moonclip.Xor,
          [dd_box(0.0, 0.0, 1.0, 2.0), dd_box(2.0, 0.0, 3.0, 2.0)],
        ),
      ] {
      let tree = dt_get([a], clip=[b], operation~, fill_rule=fill)
      dd_equal(tree.to_paths(), expected)
      assert_eq(tree.roots().length(), expected.length())
      for root in tree.roots() {
        assert_eq(root.depth(), 1)
        assert_eq(root.children().length(), 0)
      }
    }
  }
}

///|
test "decimal tree: precision zero rounds signed ties away from zero" {
  dt_chain(dt_get([dd_box(-2.5, -1.5, 3.5, 4.5)], precision=dd_precision(0)), [
    dd_box(-3.0, -2.0, 4.0, 5.0),
  ])
}

///|
test "decimal tree: precision six and coordinate boundaries" {
  let a = dd_box(-1000.0, -1000.0, 1000.0, 1000.0)
  dt_chain(dt_get([a], precision=dd_precision(6)), [a])
  let b = dd_box(-0.000003, -0.000002, 0.000004, 0.000005)
  dt_chain(dt_get([b], precision=dd_precision(6)), [b])
}

///|
test "decimal tree: zero decoding is positive without changing source" {
  let a = dd_box(-0.0, -0.0, 1.0, 1.0)
  let tree = dt_get([a])
  for path in tree.to_paths() {
    for p in path {
      if p.x == 0.0 {
        assert_true(1.0 / p.x > 0.0)
      }
      if p.y == 0.0 {
        assert_true(1.0 / p.y > 0.0)
      }
    }
  }
  assert_true(1.0 / a[0].x < 0.0)
}

///|
test "decimal tree: source and separate calls cannot mutate trees" {
  let a = dd_box(-1.25, -1.25, 1.25, 1.25)
  let expected = @moonclip.copy_path_d(a)
  let source = [a]
  let first = dt_get(source)
  let second = dt_get(source)
  a[0] = @moonclip.PointD::new(100.0, 100.0)
  source.clear()
  let copy = first.to_paths()
  copy[0][0] = a[0]
  copy.push([])
  dt_chain(first, [expected])
  dt_chain(second, [expected])
}

///|
test "decimal tree: roots children contours and flattened arrays isolate" {
  let a = dd_box(-5.0, -5.0, 5.0, 5.0)
  let b = dt_reverse(dd_box(-3.0, -3.0, 3.0, 3.0))
  let tree = dt_get([a, b])
  let roots = tree.roots()
  let root = roots[0]
  let children = root.children()
  let child = children[0]
  roots.clear()
  children[0] = root
  children.clear()
  root.contour().clear()
  child.contour().clear()
  let paths = tree.to_paths()
  paths[0].clear()
  paths[1] = []
  paths.clear()
  dt_chain(tree, [a, b])
  assert_eq(child.depth(), 2)
}

///|
test "decimal tree: repeated aliased input arrays remain unchanged" {
  let a = dd_box(0.0, 0.0, 2.0, 2.0)
  let expected = @moonclip.copy_path_d(a)
  let tree = dt_get([a, a], fill_rule=NonZero)
  tree.to_paths()[0].clear()
  assert_eq(a, expected)
  dt_chain(tree, [expected])
}

///|
test "decimal tree: raw combined path quota counts empty paths" {
  assert_true(
    @moonclip.boolean_tree_d([[]], [[]], Union, limits={
      max_input_paths: 1,
      max_input_vertices: 0,
    })
    is Err(
      @moonclip.ResourceLimitExceeded(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(1),
          vertex_index: None,
        },
        @moonclip.InputPaths,
        1
      )
    ),
  )
}

///|
test "decimal tree: raw duplicate vertices consume combined quota" {
  let a = dd_box(0.0, 0.0, 2.0, 2.0)
  a.push(a[0])
  let saved = @moonclip.copy_path_d(a)
  assert_true(
    @moonclip.boolean_tree_d([], [a], Union, limits={
      max_input_paths: 1,
      max_input_vertices: 4,
    })
    is Err(
      @moonclip.ResourceLimitExceeded(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(0),
          vertex_index: Some(4),
        },
        @moonclip.InputVertices,
        4
      )
    ),
  )
  assert_eq(a, saved)
  dt_chain(dt_get([a]), [dd_box(0.0, 0.0, 2.0, 2.0)])
}

///|
test "decimal tree: negative input allowances are parameter errors" {
  let invalid : Array[@moonclip.Limits] = [
    { max_input_paths: -1, max_input_vertices: 0, },
    { max_input_paths: 0, max_input_vertices: -1, },
  ]
  for limits in invalid {
    assert_true(
      @moonclip.boolean_tree_d([], [], Union, limits~)
      is Err(
        @moonclip.InvalidInput({ stage: @moonclip.DecimalParameters, .. }, _)
      ),
    )
  }
}

///|
test "decimal tree: nonfinite coordinates locate original axes" {
  for
    (x, y, axis) in [
      (@double.not_a_number, 0.0, @moonclip.X),
      (0.0, @double.infinity, @moonclip.Y),
    ] {
    match @moonclip.boolean_tree_d([], [[@moonclip.PointD::new(x, y)]], Union) {
      Err(@moonclip.QuantizationFailure(loc, Some(actual), None, _)) => {
        assert_eq(loc.path_index, Some(0))
        assert_eq(loc.vertex_index, Some(0))
        assert_eq(actual, axis)
      }
      _ => fail("Expected nonfinite coordinate failure")
    }
  }
}

///|
test "decimal tree: out of range preserves decimal value and precision" {
  assert_true(
    @moonclip.boolean_tree_d(
      [[@moonclip.PointD::new(1000.000001, 0.0)]],
      [],
      Union,
      precision=dd_precision(6),
    )
    is Err(
      @moonclip.DecimalCoordinateOutOfRange(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(0),
          vertex_index: Some(0),
        },
        @moonclip.X,
        1000.000001,
        6
      )
    ),
  )
}

///|
test "decimal tree: quantization collision reports both original locations" {
  assert_true(
    @moonclip.boolean_tree_d(
      [[@moonclip.PointD::new(0.0001, 0.0), @moonclip.PointD::new(0.0002, 0.0)]],
      [],
      Union,
    )
    is Err(
      @moonclip.QuantizationFailure(
        { path_index: Some(0), vertex_index: Some(1), .. },
        None,
        Some({ path_index: Some(0), vertex_index: Some(0), .. }),
        _
      )
    ),
  )
}

///|
test "decimal tree: nonempty degenerate contours fail without changing inputs" {
  for
    path in [
      [@moonclip.PointD::new(0.0, 0.0)],
      [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(1.0, 1.0)],
      [
        @moonclip.PointD::new(0.0, 0.0),
        @moonclip.PointD::new(1.0, 1.0),
        @moonclip.PointD::new(2.0, 2.0),
      ],
    ] {
    let saved = @moonclip.copy_path_d(path)
    assert_true(
      @moonclip.boolean_tree_d([path], [], Union)
      is Err(
        @moonclip.QuantizationFailure(
          {
            stage: @moonclip.DecimalQuantize,
            path_index: Some(0),
            vertex_index: None,
          },
          None,
          None,
          _
        )
      ),
    )
    assert_eq(path, saved)
  }
  dt_chain(dt_get([dd_box(0.0, 0.0, 1.0, 1.0)]), [dd_box(0.0, 0.0, 1.0, 1.0)])
}
