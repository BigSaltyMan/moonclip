// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn stt_get(
  path : @moonclip.Path64,
  width : Double,
  cap? : @moonclip.CapType = Butt,
  options? : @moonclip.OffsetOptions = Default::default(),
) -> @moonclip.PolyTree64 raise {
  match @moonclip.stroke_tree(path, width, cap~, options~) {
    Ok(tree) => tree
    Err(error) => fail(error.message())
  }
}

///|
fn stt_d(
  path : @moonclip.PathD,
  width : Double,
  precision? : @moonclip.Precision = Default::default(),
  cap? : @moonclip.CapType = Butt,
  options? : @moonclip.OffsetOptions = Default::default(),
) -> @moonclip.PolyTreeD raise {
  match @moonclip.stroke_tree_d(path, width, precision~, cap~, options~) {
    Ok(tree) => tree
    Err(error) => fail(error.message())
  }
}

///|
fn stt_loop() -> @moonclip.Path64 {
  st_path([(0L, 0L), (30L, 0L), (30L, 30L), (0L, 30L), (0L, 0L)])
}

///|
test "stroke tree: horizontal and vertical full-width rectangles" {
  pt_chain(stt_get(st_line(), 4.0), [bb_rect(0L, -2L, 20L, 4L)])
  pt_chain(stt_get(st_path([(-10L, -10L), (-10L, 10L)]), 4.0), [
    bb_rect(-12L, -10L, 4L, 20L),
  ])
}

///|
test "stroke tree: diagonal has independently specified complete contour" {
  pt_chain(stt_get(st_path([(0L, 0L), (20L, 20L)]), 4.0), [
    st_path([(-1L, 1L), (1L, -1L), (21L, 19L), (19L, 21L)]),
  ])
}

///|
test "stroke tree: all caps on a single segment" {
  for
    (cap, expected) in [
      (@moonclip.Butt, [bb_rect(0L, -2L, 20L, 4L)]),
      (@moonclip.Square, [bb_rect(-2L, -2L, 24L, 4L)]),
      (@moonclip.Round, st_round_line()),
    ] {
    let tree = stt_get(st_line(), 4.0, cap~)
    pt_chain(tree, expected)
    assert_eq(bb_canonical(tree.to_paths()), bb_canonical(expected))
  }
}

///|
test "stroke tree: four joins reuse fixed corner expectations" {
  for
    join in [
      @moonclip.Miter,
      @moonclip.Bevel,
      @moonclip.Square,
      @moonclip.Round,
    ] {
    let expected = st_right_expected(join, @moonclip.Butt)
    let tree = stt_get(
      st_route(),
      4.0,
      options=@moonclip.OffsetOptions::new(join~),
    )
    pt_chain(tree, expected)
    assert_eq(bb_canonical(tree.to_paths()), bb_canonical(expected))
  }
}

///|
test "stroke tree: returned endpoint remains open with its Butt cap geometry" {
  let route = st_path([(0L, 0L), (30L, 0L), (30L, 30L), (0L, 0L)])
  let expected = [
    st_path([(-1L, 1L), (0L, 0L), (0L, -2L), (32L, -2L), (32L, 31L), (30L, 32L)]),
    st_path([(4L, 2L), (28L, 26L), (28L, 2L)]),
  ]
  let tree = stt_get(route, 4.0)
  pt_chain(tree, expected)
  assert_eq(bb_canonical(tree.to_paths()), bb_canonical(expected))
}

///|
test "stroke tree: returning route forms the complete outer and real hole" {
  let expected = [
    bb_rect(-2L, -2L, 34L, 34L),
    bb_reverse(bb_rect(2L, 2L, 26L, 26L)),
  ]
  let tree = stt_get(stt_loop(), 4.0, cap=Square)
  pt_chain(tree, expected)
  assert_eq(bb_canonical(tree.to_paths()), bb_canonical(expected))
}

///|
test "stroke tree: greater width shrinks and finally consumes the hole" {
  pt_chain(stt_get(stt_loop(), 20.0, cap=Square), [
    bb_rect(-10L, -10L, 50L, 50L),
    bb_reverse(bb_rect(10L, 10L, 10L, 10L)),
  ])
  pt_chain(stt_get(stt_loop(), 30.0, cap=Square), [
    bb_rect(-15L, -15L, 60L, 60L),
  ])
}

///|
test "stroke tree: consecutive duplicates and backtracking do not close a route" {
  pt_chain(stt_get(st_path([(0L, 0L), (0L, 0L), (20L, 0L), (20L, 0L)]), 4.0), [
    bb_rect(0L, -2L, 20L, 4L),
  ])
  let route = st_path([(0L, 0L), (20L, 0L), (0L, 0L)])
  let tree = stt_get(route, 4.0)
  assert_eq(
    @moonclip.stroke_polyline(route, 4.0).map(bb_canonical),
    Ok(bb_canonical(tree.to_paths())),
  )
  assert_eq(tree.roots().length(), 1)
  assert_true(!tree.roots()[0].is_hole())
}

///|
test "stroke tree: self-crossing route preserves filled-region hierarchy" {
  let route = st_path([(0L, 0L), (20L, 20L), (0L, 20L), (20L, 0L)])
  let tree = stt_get(route, 4.0)
  assert_eq(tree.roots().length(), 1)
  let root = tree.roots()[0]
  assert_eq(root.depth(), 1)
  assert_true(!root.is_hole())
  assert_eq(
    @moonclip.stroke_polyline(route, 4.0).map(bb_canonical),
    Ok(bb_canonical(tree.to_paths())),
  )
  for child in root.children() {
    assert_eq(child.depth(), 2)
    assert_true(child.is_hole())
  }
}

///|
test "stroke tree: shortcut widths empty singleton and duplicate-only routes" {
  for cap in [@moonclip.Butt, @moonclip.Square, @moonclip.Round] {
    for width in [0.0, -0.0, 0.99, 4.0] {
      for
        path in [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          st_path([(1L, 1L), (1L, 1L), (1L, 1L)]),
        ] {
        let tree = stt_get(path, width, cap~)
        assert_eq(tree.roots().length(), 0)
        assert_eq(tree.to_paths(), [])
      }
    }
    for width in [0.0, -0.0, 0.99] {
      assert_eq(stt_get(st_line(), width, cap~).to_paths(), [])
    }
  }
  pt_chain(stt_get(st_line(), 1.0), [bb_rect(0L, -1L, 20L, 2L)])
}

///|
test "stroke tree: shortcuts cannot hide invalid width options coordinates or raw limits" {
  for width in [-1.0, @double.not_a_number, @double.infinity] {
    assert_true(
      @moonclip.stroke_tree([], width)
      is Err(InvalidInput({ stage: StrokeParameters, .. }, _)),
    )
  }
  for width in [0.0, 4.0] {
    assert_true(
      @moonclip.stroke_tree(
        [],
        width,
        options=@moonclip.OffsetOptions::new(miter_limit=1.0),
      )
      is Err(InvalidInput({ stage: StrokeParameters, .. }, _)),
    )
    assert_true(
      @moonclip.stroke_tree(
        [],
        width,
        options=@moonclip.OffsetOptions::new(arc_tolerance=-1.0),
      )
      is Err(InvalidInput({ stage: StrokeParameters, .. }, _)),
    )
    assert_true(
      @moonclip.stroke_tree([@moonclip.Point64::new(1000000001L, 0L)], width)
      is Err(
        CoordinateOutOfRange(
          { path_index: Some(0), vertex_index: Some(0), .. },
          X,
          _
        )
      ),
    )
    assert_true(
      @moonclip.stroke_tree([], width, limits={
        max_input_paths: 0,
        max_input_vertices: 0,
      })
      is Err(ResourceLimitExceeded(_, InputPaths, 0)),
    )
    assert_true(
      @moonclip.stroke_tree(st_path([(0L, 0L), (0L, 0L), (0L, 0L)]), width, limits={
        max_input_paths: 1,
        max_input_vertices: 2,
      })
      is Err(ResourceLimitExceeded(_, InputVertices, 2)),
    )
  }
}

///|
test "stroke tree: generated overflow retains stroke stage and independent retry" {
  assert_true(
    @moonclip.stroke_tree(
      st_path([(999999990L, 0L), (1000000000L, 0L)]),
      4.0,
      cap=Square,
    )
    is Err(
      CoordinateOutOfRange(
        { stage: StrokeGenerate, path_index: None, vertex_index: None, },
        X,
        _
      )
    ),
  )
  pt_chain(stt_get(st_line(), 4.0), [bb_rect(0L, -2L, 20L, 4L)])
}

///|
test "stroke tree: integer inputs nodes and all accessor arrays remain isolated" {
  let path = stt_loop()
  let saved = @moonclip.copy_path(path)
  let tree = stt_get(path, 4.0, cap=Square)
  assert_eq(path, saved)
  let roots = tree.roots()
  let root = roots[0]
  let children = root.children()
  children[0].contour().clear()
  children.clear()
  root.contour().clear()
  roots.clear()
  let paths = tree.to_paths()
  paths[0].clear()
  paths.clear()
  path.clear()
  let expected = [
    bb_rect(-2L, -2L, 34L, 34L),
    bb_reverse(bb_rect(2L, 2L, 26L, 26L)),
  ]
  pt_chain(tree, expected)
  pt_chain(stt_get(saved, 4.0, cap=Square), expected)
}

///|
test "stroke tree: decimal returning route retains real fractional hole" {
  let path = stt_loop().map(fn(p) {
    @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
  })
  dt_chain(stt_d(path, 0.4, cap=Square), [
    dd_box(-0.2, -0.2, 3.2, 3.2),
    dt_reverse(dd_box(0.2, 0.2, 2.8, 2.8)),
  ])
}

///|
test "stroke tree: decimal width threshold uses the scaled full width" {
  let path = [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(0.02, 0.0)]
  dt_chain(stt_d(path, 0.001), [dd_box(0.0, -0.001, 0.02, 0.001)])
  for width in [0.0, -0.0, 0.00099] {
    assert_eq(stt_d(path, width).to_paths(), [])
  }
}

///|
test "stroke tree: decimal precision endpoints and zero decode" {
  dt_chain(
    stt_d(
      [@moonclip.PointD::new(-10.5, 0.0), @moonclip.PointD::new(10.5, 0.0)],
      4.0,
      precision=dd_precision(0),
    ),
    [dd_box(-11.0, -2.0, 11.0, 2.0)],
  )
  let tree = stt_d(
    [
      @moonclip.PointD::new(0.0, 0.000001),
      @moonclip.PointD::new(0.000010, 0.000001),
    ],
    0.000002,
    precision=dd_precision(6),
  )
  dt_chain(tree, [dd_box(0.0, 0.0, 0.000010, 0.000002)])
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
test "stroke tree: decimal caps joins and arc tolerance follow existing scaling" {
  let route = [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(2.0, 0.0),
    @moonclip.PointD::new(2.0, 2.0),
  ]
  for
    (join, cap) in [
      (@moonclip.Miter, @moonclip.Butt),
      (@moonclip.Bevel, @moonclip.Square),
      (@moonclip.Square, @moonclip.Butt),
      (@moonclip.Round, @moonclip.Round),
    ] {
    let options = @moonclip.OffsetOptions::new(join~, arc_tolerance=0.01)
    let tree = stt_d(route, 0.4, cap~, options~)
    assert_eq(tree.roots().length(), 1)
    assert_eq(tree.roots()[0].depth(), 1)
    guard @moonclip.stroke_polyline_d(route, 0.4, cap~, options~) is Ok(flat) else {
      fail("Expected decimal stroke")
    }
    dd_equal(tree.to_paths(), flat)
  }
}

///|
test "stroke tree: decimal shortcuts still reject invalid raw and quantized inputs" {
  for width in [-1.0, @double.not_a_number, @double.infinity] {
    assert_true(
      @moonclip.stroke_tree_d([], width)
      is Err(InvalidInput({ stage: DecimalParameters, .. }, _)),
    )
  }
  for width in [0.0, 0.4] {
    assert_true(
      @moonclip.stroke_tree_d(
        [],
        width,
        options=@moonclip.OffsetOptions::new(miter_limit=1.0),
      )
      is Err(InvalidInput({ stage: DecimalParameters, .. }, _)),
    )
    assert_true(
      @moonclip.stroke_tree_d([], width, limits={
        max_input_paths: 0,
        max_input_vertices: 0,
      })
      is Err(ResourceLimitExceeded(_, InputPaths, 0)),
    )
    assert_true(
      @moonclip.stroke_tree_d(
        [@moonclip.PointD::new(@double.not_a_number, 0.0)],
        width,
      )
      is Err(QuantizationFailure(_, _, _, _)),
    )
    assert_true(
      @moonclip.stroke_tree_d(
        [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(0.0001, 0.0)],
        width,
      )
      is Err(QuantizationFailure(_, _, _, _)),
    )
    assert_true(
      @moonclip.stroke_tree_d([@moonclip.PointD::new(1000000.001, 0.0)], width)
      is Err(DecimalCoordinateOutOfRange(_, X, _, 3)),
    )
  }
  for cap in [@moonclip.Butt, @moonclip.Square, @moonclip.Round] {
    for
      path in [
        [],
        [@moonclip.PointD::new(0.25, 0.25)],
        [@moonclip.PointD::new(0.25, 0.25), @moonclip.PointD::new(0.25, 0.25)],
      ] {
      assert_eq(stt_d(path, 0.4, cap~).to_paths(), [])
    }
  }
  assert_true(
    @moonclip.stroke_tree_d(
      [
        @moonclip.PointD::new(999999.99, 0.0),
        @moonclip.PointD::new(1000000.0, 0.0),
      ],
      0.004,
      cap=Square,
    )
    is Err(
      DecimalCoordinateOutOfRange(
        { stage: StrokeGenerate, path_index: None, vertex_index: None, },
        X,
        _,
        3
      )
    ),
  )
}

///|
test "stroke tree: decimal input and mutable accessor results remain isolated" {
  let path = stt_loop().map(fn(p) {
    @moonclip.PointD::new(p.x.to_double() / 10.0, p.y.to_double() / 10.0)
  })
  let saved = @moonclip.copy_path_d(path)
  let tree = stt_d(path, 0.4, cap=Square)
  assert_eq(path, saved)
  let roots = tree.roots()
  let root = roots[0]
  let children = root.children()
  children[0].contour().clear()
  children.clear()
  root.contour().clear()
  roots.clear()
  let paths = tree.to_paths()
  paths[0].clear()
  paths.clear()
  path.clear()
  let expected = [
    dd_box(-0.2, -0.2, 3.2, 3.2),
    dt_reverse(dd_box(0.2, 0.2, 2.8, 2.8)),
  ]
  dt_chain(tree, expected)
  dt_chain(stt_d(saved, 0.4, cap=Square), expected)
}
