// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn ot_get(
  paths : @moonclip.Paths64,
  delta : Double,
  fill_rule? : @moonclip.FillRule = NonZero,
  options? : @moonclip.OffsetOptions = Default::default(),
) -> @moonclip.PolyTree64 raise {
  match @moonclip.offset_tree(paths, delta, fill_rule~, options~) {
    Ok(tree) => tree
    Err(error) => fail(error.message())
  }
}

///|
fn ot_d(
  paths : @moonclip.PathsD,
  delta : Double,
  precision? : @moonclip.Precision = Default::default(),
) -> @moonclip.PolyTreeD raise {
  match @moonclip.offset_tree_d(paths, delta, precision~) {
    Ok(tree) => tree
    Err(error) => fail(error.message())
  }
}

///|
test "offset tree: integer rectangle expansion and contraction" {
  let paths = [bb_rect(0L, 0L, 40L, 40L)]
  pt_chain(ot_get(paths, 2.0), [bb_rect(-2L, -2L, 44L, 44L)])
  pt_chain(ot_get(paths, -2.0), [bb_rect(2L, 2L, 36L, 36L)])
}

///|
test "offset tree: complete holed expansion and contraction" {
  let paths = [
    bb_rect(0L, 0L, 40L, 40L),
    bb_reverse(bb_rect(10L, 10L, 20L, 20L)),
  ]
  for
    (delta, outer, hole) in [
      (
        2.0,
        bb_rect(-2L, -2L, 44L, 44L),
        bb_reverse(bb_rect(12L, 12L, 16L, 16L)),
      ),
      (-2.0, bb_rect(2L, 2L, 36L, 36L), bb_reverse(bb_rect(8L, 8L, 24L, 24L))),
    ] {
    let tree = ot_get(paths, delta)
    pt_chain(tree, [outer, hole])
    assert_eq(bb_canonical(tree.to_paths()), bb_canonical([outer, hole]))
  }
}

///|
test "offset tree: island remains a depth three region" {
  let tree = ot_get(
    [
      bb_rect(0L, 0L, 60L, 60L),
      bb_reverse(bb_rect(10L, 10L, 40L, 40L)),
      bb_rect(20L, 20L, 20L, 20L),
    ],
    1.0,
  )
  pt_chain(tree, [
    bb_rect(-1L, -1L, 62L, 62L),
    bb_reverse(bb_rect(11L, 11L, 38L, 38L)),
    bb_rect(19L, 19L, 22L, 22L),
  ])
}

///|
test "offset tree: independent roots and expanding merger" {
  let paths = [bb_rect(0L, 0L, 10L, 10L), bb_rect(12L, 0L, 10L, 10L)]
  let separate = ot_get(paths, 0.0)
  assert_eq(separate.roots().length(), 2)
  assert_eq(bb_canonical(separate.to_paths()), bb_canonical(paths))
  for root in separate.roots() {
    assert_eq(root.depth(), 1)
    assert_true(!root.is_hole())
    assert_eq(root.children().length(), 0)
  }
  pt_chain(ot_get(paths, 2.0), [bb_rect(-2L, -2L, 26L, 14L)])
}

///|
test "offset tree: contraction splits a narrow bridge" {
  let dumbbell = [
    (0L, 0L),
    (10L, 0L),
    (10L, 4L),
    (20L, 4L),
    (20L, 0L),
    (30L, 0L),
    (30L, 10L),
    (20L, 10L),
    (20L, 6L),
    (10L, 6L),
    (10L, 10L),
    (0L, 10L),
  ].map(fn(p) { @moonclip.Point64::new(p.0, p.1) })
  let tree = ot_get([dumbbell], -2.0)
  assert_eq(tree.roots().length(), 2)
  assert_eq(
    bb_canonical(tree.to_paths()),
    bb_canonical([bb_rect(2L, 2L, 6L, 6L), bb_rect(22L, 2L, 6L, 6L)]),
  )
  for root in tree.roots() {
    assert_eq(root.depth(), 1)
    assert_eq(root.children().length(), 0)
  }
}

///|
test "offset tree: growing region consumes the hole" {
  pt_chain(
    ot_get(
      [bb_rect(0L, 0L, 40L, 40L), bb_reverse(bb_rect(10L, 10L, 20L, 20L))],
      10.0,
    ),
    [bb_rect(-10L, -10L, 60L, 60L)],
  )
}

///|
test "offset tree: empty input normalization and full collapse" {
  for
    paths in [
      [],
      [[], []],
      [bb_rect(0L, 0L, 10L, 10L), bb_reverse(bb_rect(0L, 0L, 10L, 10L))],
    ] {
    for delta in [0.0, 2.0] {
      let tree = ot_get(paths, delta)
      assert_eq(tree.roots().length(), 0)
      assert_eq(tree.to_paths(), [])
    }
  }
  for delta in [-5.0, -6.0] {
    assert_eq(ot_get([bb_rect(0L, 0L, 10L, 10L)], delta).to_paths(), [])
  }
  assert_true(
    @moonclip.offset_tree([], 2.0, limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    })
    is Ok(_),
  )
}

///|
test "offset tree: zero negative zero and subgrid distances normalize overlapping inputs" {
  for delta in [0.0, -0.0, 0.49, -0.49] {
    pt_chain(
      ot_get([bb_rect(0L, 0L, 10L, 10L), bb_rect(5L, 0L, 10L, 10L)], delta),
      [bb_rect(0L, 0L, 15L, 10L)],
    )
  }
  pt_chain(ot_get([bb_rect(0L, 0L, 10L, 10L)], 0.5), [
    bb_rect(-1L, -1L, 12L, 12L),
  ])
}

///|
test "offset tree: input filling is independent of final Positive cleanup" {
  let decimal = [dd_box(0.0, 0.0, 40.0, 40.0), dd_box(10.0, 10.0, 30.0, 30.0)]
  guard @moonclip.offset_tree_d(decimal, 2.0, fill_rule=EvenOdd) is Ok(tree) else {
    fail("Expected EvenOdd decimal tree")
  }
  dt_chain(tree, [
    dd_box(-2.0, -2.0, 42.0, 42.0),
    dt_reverse(dd_box(12.0, 12.0, 28.0, 28.0)),
  ])
  let paths = [bb_rect(0L, 0L, 40L, 40L), bb_rect(10L, 10L, 20L, 20L)]
  pt_chain(ot_get(paths, 2.0, fill_rule=NonZero), [bb_rect(-2L, -2L, 44L, 44L)])
  pt_chain(ot_get(paths, 2.0, fill_rule=EvenOdd), [
    bb_rect(-2L, -2L, 44L, 44L),
    bb_reverse(bb_rect(12L, 12L, 16L, 16L)),
  ])
}

///|
test "offset tree: four join modes agree with flat geometry and preserve simple topology" {
  for
    join in [
      @moonclip.Miter,
      @moonclip.Bevel,
      @moonclip.Square,
      @moonclip.Round,
    ] {
    let options = @moonclip.OffsetOptions::new(join~, arc_tolerance=0.25)
    let decimal = [dd_box(0.0, 0.0, 40.0, 40.0)]
    guard @moonclip.offset_tree_d(decimal, 2.0, options~) is Ok(decoded) else {
      fail("Expected decimal join tree")
    }
    assert_eq(decoded.roots().length(), 1)
    assert_eq(decoded.roots()[0].depth(), 1)
    assert_eq(decoded.roots()[0].children().length(), 0)
    guard @moonclip.offset_polygons_d(decimal, 2.0, options~) is Ok(flat) else {
      fail("Expected decimal join paths")
    }
    dd_equal(decoded.to_paths(), flat)
  }
  for
    join in [
      @moonclip.Miter,
      @moonclip.Bevel,
      @moonclip.Square,
      @moonclip.Round,
    ] {
    let options = @moonclip.OffsetOptions::new(join~, arc_tolerance=0.25)
    let paths = [bb_rect(0L, 0L, 40L, 40L)]
    let tree = ot_get(paths, 2.0, options~)
    let root = tree.roots()[0]
    assert_eq(tree.roots().length(), 1)
    assert_eq(root.depth(), 1)
    assert_true(!root.is_hole())
    assert_eq(root.children().length(), 0)
    assert_eq(
      @moonclip.bounds(root.contour()),
      Ok(Some({ min_x: -2L, min_y: -2L, max_x: 42L, max_y: 42L, })),
    )
    assert_eq(
      @moonclip.offset_polygons(paths, 2.0, options~).map(bb_canonical),
      Ok(bb_canonical(tree.to_paths())),
    )
  }
}

///|
test "offset tree: result accessors and source arrays remain isolated" {
  let input = [
    bb_rect(0L, 0L, 40L, 40L),
    bb_reverse(bb_rect(10L, 10L, 20L, 20L)),
  ]
  let saved = @moonclip.copy_paths(input)
  let tree = ot_get(input, 2.0)
  assert_eq(input, saved)
  let roots = tree.roots()
  let node = roots[0]
  let children = node.children()
  children[0].contour().clear()
  children.clear()
  roots.clear()
  node.contour().clear()
  let flat = tree.to_paths()
  flat[0].clear()
  flat.clear()
  input[0].clear()
  input.clear()
  pt_chain(tree, [
    bb_rect(-2L, -2L, 44L, 44L),
    bb_reverse(bb_rect(12L, 12L, 16L, 16L)),
  ])
  pt_chain(ot_get(saved, 2.0), [
    bb_rect(-2L, -2L, 44L, 44L),
    bb_reverse(bb_rect(12L, 12L, 16L, 16L)),
  ])
}

///|
test "offset tree: invalid options coordinates and limits cannot hide behind shortcuts" {
  for delta in [0.0, 2.0] {
    assert_true(
      @moonclip.offset_tree(
        [],
        delta,
        options=@moonclip.OffsetOptions::new(miter_limit=1.0),
      )
      is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
    )
    assert_true(
      @moonclip.offset_tree(
        [],
        delta,
        options=@moonclip.OffsetOptions::new(arc_tolerance=-1.0),
      )
      is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
    )
    assert_true(
      @moonclip.offset_tree([[@moonclip.Point64::new(1000000001L, 0L)]], delta)
      is Err(
        CoordinateOutOfRange(
          { path_index: Some(0), vertex_index: Some(0), .. },
          X,
          _
        )
      ),
    )
    assert_true(
      @moonclip.offset_tree([[]], delta, limits={
        max_input_paths: 0,
        max_input_vertices: 0,
      })
      is Err(ResourceLimitExceeded(_, InputPaths, 0)),
    )
  }
  assert_true(
    @moonclip.offset_tree([], @double.not_a_number)
    is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
  )
  assert_true(
    @moonclip.offset_tree([bb_rect(999999990L, 0L, 10L, 10L)], 1.0)
    is Err(
      CoordinateOutOfRange(
        { stage: OffsetGenerate, path_index: None, vertex_index: None, },
        X,
        1000000001L
      )
    ),
  )
}

///|
test "offset tree: fractional hole and island decode with default precision" {
  let paths = [
    dd_box(-5.25, -5.25, 5.25, 5.25),
    dt_reverse(dd_box(-3.25, -3.25, 3.25, 3.25)),
    dd_box(-1.25, -1.25, 1.25, 1.25),
  ]
  dt_chain(ot_d(paths, 0.25), [
    dd_box(-5.5, -5.5, 5.5, 5.5),
    dt_reverse(dd_box(-3.0, -3.0, 3.0, 3.0)),
    dd_box(-1.5, -1.5, 1.5, 1.5),
  ])
}

///|
test "offset tree: decimal distance threshold is tested after scaling" {
  let paths = [dd_box(0.0, 0.0, 1.0, 1.0)]
  dt_chain(ot_d(paths, 0.001), [dd_box(-0.001, -0.001, 1.001, 1.001)])
  for delta in [0.0, -0.0, 0.00049] {
    dt_chain(ot_d(paths, delta), paths)
  }
}

///|
test "offset tree: precision zero and six keep full coordinates and positive zero" {
  dt_chain(
    ot_d([dd_box(-10.5, -10.5, 10.5, 10.5)], 2.0, precision=dd_precision(0)),
    [dd_box(-13.0, -13.0, 13.0, 13.0)],
  )
  let tree = ot_d(
    [dd_box(0.000001, 0.000001, 0.000011, 0.000011)],
    0.000001,
    precision=dd_precision(6),
  )
  dt_chain(tree, [dd_box(0.0, 0.0, 0.000012, 0.000012)])
  for p in tree.to_paths()[0] {
    if p.x == 0.0 {
      assert_true(1.0 / p.x > 0.0)
    }
    if p.y == 0.0 {
      assert_true(1.0 / p.y > 0.0)
    }
  }
}

///|
test "offset tree: decimal empty collapsed and malformed inputs" {
  for delta in [0.0, 2.0] {
    assert_eq(ot_d([], delta).to_paths(), [])
    assert_true(
      @moonclip.offset_tree_d(
        [],
        delta,
        options=@moonclip.OffsetOptions::new(miter_limit=1.0),
      )
      is Err(InvalidInput({ stage: DecimalParameters, .. }, _)),
    )
  }
  assert_eq(ot_d([dd_box(0.0, 0.0, 1.0, 1.0)], -1.0).to_paths(), [])
  assert_true(
    @moonclip.offset_tree_d([], @double.infinity)
    is Err(InvalidInput({ stage: DecimalParameters, .. }, _)),
  )
  assert_true(
    @moonclip.offset_tree_d(
      [[@moonclip.PointD::new(@double.not_a_number, 0.0)]],
      0.0,
    )
    is Err(QuantizationFailure(_, _, _, _)),
  )
  assert_true(
    @moonclip.offset_tree_d([dd_box(0.0, 0.0, 0.0001, 0.0001)], 0.0)
    is Err(QuantizationFailure(_, _, _, _)),
  )
  assert_true(
    @moonclip.offset_tree_d([dd_box(1000000.0, 0.0, 1000000.001, 1.0)], 1.0)
    is Err(DecimalCoordinateOutOfRange(_, X, _, 3)),
  )
}

///|
test "offset tree: decimal views stay isolated across mutation and retries" {
  let input = [
    dd_box(0.0, 0.0, 4.0, 4.0),
    dt_reverse(dd_box(1.0, 1.0, 3.0, 3.0)),
  ]
  let saved = @moonclip.copy_paths_d(input)
  let tree = ot_d(input, 0.25)
  assert_eq(input, saved)
  let roots = tree.roots()
  let root = roots[0]
  root.children()[0].contour().clear()
  root.children().clear()
  root.contour().clear()
  roots.clear()
  let flat = tree.to_paths()
  flat[0].clear()
  flat.clear()
  input[0].clear()
  input.clear()
  let expected = [
    dd_box(-0.25, -0.25, 4.25, 4.25),
    dt_reverse(dd_box(1.25, 1.25, 2.75, 2.75)),
  ]
  dt_chain(tree, expected)
  dt_chain(ot_d(saved, 0.25), expected)
}
