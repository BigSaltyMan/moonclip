///|
fn pt_get(
  subject : @moonclip.Paths64,
  clip? : @moonclip.Paths64 = [],
  operation? : @moonclip.ClipType = Union,
  fill_rule? : @moonclip.FillRule = EvenOdd,
) -> @moonclip.PolyTree64 raise {
  match @moonclip.boolean_tree(subject, clip, operation, fill_rule~) {
    Ok(tree) => tree
    Err(error) => fail(error.message())
  }
}

///|
fn pt_chain(
  tree : @moonclip.PolyTree64,
  paths : @moonclip.Paths64,
) -> Unit raise {
  let mut children = tree.roots()
  for i = 0; i < paths.length(); i = i + 1 {
    assert_eq(children.length(), 1)
    let node = children[0]
    assert_eq(node.depth(), i + 1)
    assert_eq(node.is_hole(), i % 2 == 1)
    assert_eq(bb_canonical([node.contour()]), bb_canonical([paths[i]]))
    children = node.children()
  }
  assert_eq(children.length(), 0)
}

///|
test "tree empty result is successful with zero input allowances" {
  guard @moonclip.boolean_tree([], [], Union, limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    })
    is Ok(tree) else {
    fail("Expected empty tree")
  }
  assert_eq(tree.roots().length(), 0)
  assert_eq(tree.to_paths(), [])
}

///|
test "tree single outer contour has depth one and default EvenOdd" {
  let a = bb_rect(0L, 0L, 20L, 20L)
  pt_chain(pt_get([a]), [a])
  pt_chain(pt_get([a], fill_rule=EvenOdd), [a])
}

///|
test "tree independent outer contours remain separate roots" {
  let a = bb_rect(-30L, 0L, 10L, 10L)
  let b = bb_rect(20L, 0L, 10L, 10L)
  let tree = pt_get([a, b])
  assert_eq(tree.roots().length(), 2)
  assert_eq(bb_canonical(tree.to_paths()), bb_canonical([a, b]))
  for node in tree.roots() {
    assert_eq(node.depth(), 1)
    assert_true(!node.is_hole())
    assert_eq(node.children().length(), 0)
  }
}

///|
test "tree outer owns two complete distinct holes" {
  let a = bb_rect(-30L, -30L, 60L, 60L)
  let holes = [
    bb_reverse(bb_rect(-20L, -10L, 10L, 20L)),
    bb_reverse(bb_rect(10L, -10L, 10L, 20L)),
  ]
  let tree = pt_get([a, holes[0], holes[1]])
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  assert_eq(bb_canonical([root.contour()]), bb_canonical([a]))
  assert_eq(root.children().length(), 2)
  assert_eq(
    bb_canonical(root.children().map(fn(n) { n.contour() })),
    bb_canonical(holes),
  )
  for node in root.children() {
    assert_eq(node.depth(), 2)
    assert_true(node.is_hole())
    assert_eq(node.children().length(), 0)
  }
}

///|
test "tree NonZero outer hole and island are actual successive parents" {
  let a = bb_rect(-30L, -30L, 60L, 60L)
  let b = bb_reverse(bb_rect(-20L, -20L, 40L, 40L))
  let c = bb_rect(-10L, -10L, 20L, 20L)
  pt_chain(pt_get([a, b, c], fill_rule=NonZero), [a, b, c])
}

///|
test "tree five nested levels alternate holes and islands" {
  let paths = Array::makei(5, fn(i) {
    let n = (5 - i).to_int64() * 10L
    let p = bb_rect(-n, -n, 2L * n, 2L * n)
    if i % 2 == 0 {
      p
    } else {
      bb_reverse(p)
    }
  })
  pt_chain(pt_get(paths, fill_rule=NonZero), paths)
}

///|
test "tree multiple roots each retain their own hole and island" {
  let a = bb_rect(0L, 0L, 60L, 60L)
  let b = bb_reverse(bb_rect(10L, 10L, 40L, 40L))
  let c = bb_rect(20L, 20L, 20L, 20L)
  let other = [a, b, c].map(fn(p) {
    p.map(fn(v) { @moonclip.Point64::new(v.x + 100L, v.y) })
  })
  let tree = pt_get([a, b, c, other[0], other[1], other[2]], fill_rule=NonZero)
  assert_eq(tree.roots().length(), 2)
  for root in tree.roots() {
    assert_eq(root.children().length(), 1)
    let hole = root.children()[0]
    assert_eq(hole.depth(), 2)
    assert_eq(hole.children().length(), 1)
    let island = hole.children()[0]
    assert_eq(island.depth(), 3)
    assert_eq(island.children().length(), 0)
    let expected = if root.contour()[0].x < 100L { [a, b, c] } else { other }
    assert_eq(
      bb_canonical([root.contour(), hole.contour(), island.contour()]),
      bb_canonical(expected),
    )
  }
}

///|
test "tree all operations preserve empty single and multiple root distinctions" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let b = bb_rect(5L, 0L, 10L, 10L)
  for
    (op, expected) in [
      (@moonclip.Intersection, [bb_rect(5L, 0L, 5L, 10L)]),
      (Union, [bb_rect(0L, 0L, 15L, 10L)]),
      (Difference, [bb_rect(0L, 0L, 5L, 10L)]),
      (Xor, [bb_rect(0L, 0L, 5L, 10L), bb_rect(10L, 0L, 5L, 10L)]),
    ] {
    let tree = pt_get([a], clip=[b], operation=op)
    assert_eq(tree.roots().length(), expected.length())
    assert_eq(bb_canonical(tree.to_paths()), bb_canonical(expected))
  }
  assert_eq(pt_get([a], clip=[a], operation=Difference).roots().length(), 0)
}

///|
test "tree same direction nesting distinguishes EvenOdd and NonZero" {
  let a = bb_rect(0L, 0L, 30L, 30L)
  let b = bb_rect(10L, 10L, 10L, 10L)
  pt_chain(pt_get([a, b]), [a, bb_reverse(b)])
  pt_chain(pt_get([a, b], fill_rule=NonZero), [a])
}

///|
test "tree opposite contour cancellation leaves no empty node" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let tree = pt_get([a, bb_reverse(a)], fill_rule=NonZero)
  assert_eq(tree.roots().length(), 0)
  assert_eq(tree.to_paths(), [])
}

///|
test "tree vertex touching regions remain two explicit outer roots" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let b = bb_rect(10L, 10L, 10L, 10L)
  let tree = pt_get([a, b])
  assert_eq(tree.roots().length(), 2)
  assert_eq(bb_canonical(tree.to_paths()), bb_canonical([a, b]))
  for node in tree.roots() {
    assert_eq(node.children().length(), 0)
  }
}

///|
test "tree concave bounding box does not own a contour in its empty notch" {
  let l = [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(20L, 0L),
    @moonclip.Point64::new(20L, 5L),
    @moonclip.Point64::new(5L, 5L),
    @moonclip.Point64::new(5L, 20L),
    @moonclip.Point64::new(0L, 20L),
  ]
  let b = bb_rect(10L, 10L, 5L, 5L)
  let tree = pt_get([l, b])
  assert_eq(tree.roots().length(), 2)
  assert_eq(bb_canonical(tree.to_paths()), bb_canonical([l, b]))
}

///|
test "tree accessors and flattening never expose mutable hierarchy or points" {
  let a = bb_rect(0L, 0L, 30L, 30L)
  let b = bb_reverse(bb_rect(10L, 10L, 10L, 10L))
  let tree = pt_get([a, b], fill_rule=NonZero)
  let roots = tree.roots()
  let children = roots[0].children()
  let contour = children[0].contour()
  contour[0] = @moonclip.Point64::new(999L, 999L)
  children.clear()
  roots.clear()
  let flat = tree.to_paths()
  flat[0].clear()
  flat.clear()
  pt_chain(tree, [a, b])
}

///|
test "tree snapshot survives input mutation a later call and later input failure" {
  let a = bb_rect(0L, 0L, 20L, 20L)
  let saved = @moonclip.copy_path(a)
  let tree = pt_get([a])
  a[0] = @moonclip.Point64::new(1000000001L, 0L)
  assert_true(
    @moonclip.boolean_tree([a], [], Union)
    is Err(CoordinateOutOfRange(_, X, 1000000001L)),
  )
  let other = pt_get([saved, saved], fill_rule=NonZero)
  other.to_paths()[0].clear()
  pt_chain(tree, [saved])
  pt_chain(pt_get([saved]), [saved])
}

///|
test "tree independent flat and tree entrypoints agree for both rules and all operations" {
  let a = bb_rect(-20L, -20L, 40L, 40L)
  let b = bb_rect(-10L, -10L, 20L, 20L)
  let clip = [bb_rect(-15L, -5L, 30L, 10L)]
  for rule in [@moonclip.EvenOdd, NonZero] {
    for op in [@moonclip.Intersection, Union, Difference, Xor] {
      let tree = pt_get([a, b], clip~, operation=op, fill_rule=rule)
      assert_eq(
        @moonclip.boolean_op([a, b], clip, op, fill_rule=rule).map(bb_canonical),
        Ok(bb_canonical(tree.to_paths())),
      )
    }
  }
}

///|
test "tree depth beyond protocol sixty four uses iterative library traversal" {
  let paths = Array::makei(72, fn(i) {
    let n = (72 - i).to_int64() * 4L
    let p = bb_rect(-n, -n, 2L * n, 2L * n)
    if i % 2 == 0 {
      p
    } else {
      bb_reverse(p)
    }
  })
  let tree = pt_get(paths, fill_rule=NonZero)
  pt_chain(tree, paths)
  assert_eq(bb_canonical(tree.to_paths()), bb_canonical(paths))
}
