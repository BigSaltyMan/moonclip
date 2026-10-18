// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn st_path(points : Array[(Int64, Int64)]) -> @moonclip.Path64 {
  points.map(fn(p) { @moonclip.Point64::new(p.0, p.1) })
}

///|
fn st_line() -> @moonclip.Path64 {
  st_path([(0L, 0L), (20L, 0L)])
}

///|
fn st_route() -> @moonclip.Path64 {
  st_path([(0L, 0L), (20L, 0L), (20L, 20L)])
}

///|
fn st_round_line() -> @moonclip.Paths64 {
  [
    st_path([
      (0L, 2L),
      (-2L, 1L),
      (-2L, -1L),
      (0L, -2L),
      (20L, -2L),
      (22L, -1L),
      (22L, 1L),
      (20L, 2L),
    ]),
  ]
}

///|
fn st_expect(
  path : @moonclip.Path64,
  width : Double,
  expected : @moonclip.Paths64,
  cap? : @moonclip.CapType = Butt,
  options? : @moonclip.OffsetOptions = Default::default(),
) -> Unit raise {
  assert_eq(
    @moonclip.stroke_polyline(path, width, cap~, options~).map(bb_canonical),
    Ok(bb_canonical(expected)),
  )
}

///|
fn st_right_expected(
  join : @moonclip.JoinType,
  cap : @moonclip.CapType,
) -> @moonclip.Paths64 {
  let points : Array[(Int64, Int64)] = match cap {
    Butt => [(0L, 2L), (0L, -2L)]
    Square => [(-2L, 2L), (-2L, -2L)]
    Round => [(0L, 2L), (-2L, 1L), (-2L, -1L), (0L, -2L)]
  }
  match join {
    Miter => points.push((22L, -2L))
    Bevel => {
      points.push((20L, -2L))
      points.push((22L, 0L))
    }
    Square => {
      points.push((21L, -2L))
      points.push((22L, -1L))
    }
    Round => {
      points.push((20L, -2L))
      points.push((22L, -1L))
    }
  }
  match cap {
    Butt => {
      points.push((22L, 20L))
      points.push((18L, 20L))
    }
    Square => {
      points.push((22L, 22L))
      points.push((18L, 22L))
    }
    Round => {
      points.push((22L, 20L))
      points.push((21L, 22L))
      points.push((19L, 22L))
      points.push((18L, 20L))
    }
  }
  points.push((18L, 2L))
  [st_path(points)]
}

///|
test "stroke parameters 1 invalid widths" {
  for
    width in [
      -1.0, @double.not_a_number, @double.infinity, @double.neg_infinity,
    ] {
    assert_true(
      @moonclip.stroke_polyline([], width)
      is Err(InvalidInput({ stage: StrokeParameters, .. }, _)),
    )
  }
}

///|
test "stroke parameters 2 invalid options for every cap" {
  for
    cap in [
      @moonclip.CapType::Butt,
      @moonclip.CapType::Square,
      @moonclip.CapType::Round,
    ] {
    for
      options in [
        @moonclip.OffsetOptions::new(miter_limit=1.99),
        @moonclip.OffsetOptions::new(miter_limit=@double.infinity),
        @moonclip.OffsetOptions::new(arc_tolerance=-0.1),
        @moonclip.OffsetOptions::new(arc_tolerance=@double.not_a_number),
        @moonclip.OffsetOptions::new(arc_tolerance=@double.infinity),
      ] {
      assert_true(
        @moonclip.stroke_polyline([], 0.0, cap~, options~)
        is Err(InvalidInput({ stage: StrokeParameters, .. }, _)),
      )
    }
  }
}

///|
test "stroke parameters 3 zero negative zero and subgrid width are empty" {
  for
    cap in [
      @moonclip.CapType::Butt,
      @moonclip.CapType::Square,
      @moonclip.CapType::Round,
    ] {
    for width in [0.0, -0.0, 0.99] {
      st_expect(st_line(), width, [], cap~)
    }
  }
}

///|
test "stroke parameters 4 empty path does not produce a cap region" {
  for
    cap in [
      @moonclip.CapType::Butt,
      @moonclip.CapType::Square,
      @moonclip.CapType::Round,
    ] {
    st_expect([], 4.0, [], cap~)
  }
}

///|
test "stroke parameters 5 singleton is empty under the MoonClip contract" {
  for
    cap in [
      @moonclip.CapType::Butt,
      @moonclip.CapType::Square,
      @moonclip.CapType::Round,
    ] {
    st_expect(st_path([(0L, 0L)]), 4.0, [], cap~)
  }
}

///|
test "stroke parameters 6 all duplicate points remain a degenerate route" {
  for
    cap in [
      @moonclip.CapType::Butt,
      @moonclip.CapType::Square,
      @moonclip.CapType::Round,
    ] {
    st_expect(st_path([(3L, 4L), (3L, 4L), (3L, 4L)]), 10.0, [], cap~)
  }
}

///|
test "stroke parameters 7 zero width cannot bypass raw limits" {
  assert_true(
    @moonclip.stroke_polyline(st_line(), 0.0, limits={
      max_input_paths: 0,
      max_input_vertices: 2,
    })
    is Err(ResourceLimitExceeded(_, InputPaths, 0)),
  )
  assert_true(
    @moonclip.stroke_polyline(st_line(), 0.0, limits={
      max_input_paths: 1,
      max_input_vertices: 1,
    })
    is Err(ResourceLimitExceeded(_, InputVertices, 1)),
  )
  assert_true(
    @moonclip.stroke_polyline([], 0.0, limits={
      max_input_paths: 1,
      max_input_vertices: -1,
    })
    is Err(InvalidInput(_, _)),
  )
}

///|
test "stroke parameters 8 threshold and fractional full widths use half before rounding" {
  for width in [1.0, 1.01, 1.99, 2.0] {
    st_expect(st_line(), width, [bb_rect(0L, -1L, 20L, 2L)])
  }
  st_expect(st_line(), 3.0, [bb_rect(0L, -2L, 20L, 4L)])
  st_expect(st_line(), 0.99, [])
}

///|
test "stroke combination Miter Butt full corner and caps" {
  let join = @moonclip.JoinType::Miter
  let cap = @moonclip.CapType::Butt
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Miter Square full corner and caps" {
  let join = @moonclip.JoinType::Miter
  let cap = @moonclip.CapType::Square
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Miter Round full corner and caps" {
  let join = @moonclip.JoinType::Miter
  let cap = @moonclip.CapType::Round
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Bevel Butt full corner and caps" {
  let join = @moonclip.JoinType::Bevel
  let cap = @moonclip.CapType::Butt
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Bevel Square full corner and caps" {
  let join = @moonclip.JoinType::Bevel
  let cap = @moonclip.CapType::Square
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Bevel Round full corner and caps" {
  let join = @moonclip.JoinType::Bevel
  let cap = @moonclip.CapType::Round
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Square Butt full corner and caps" {
  let join = @moonclip.JoinType::Square
  let cap = @moonclip.CapType::Butt
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Square Square full corner and caps" {
  let join = @moonclip.JoinType::Square
  let cap = @moonclip.CapType::Square
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Square Round full corner and caps" {
  let join = @moonclip.JoinType::Square
  let cap = @moonclip.CapType::Round
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Round Butt full corner and caps" {
  let join = @moonclip.JoinType::Round
  let cap = @moonclip.CapType::Butt
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Round Square full corner and caps" {
  let join = @moonclip.JoinType::Round
  let cap = @moonclip.CapType::Square
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke combination Round Round full corner and caps" {
  let join = @moonclip.JoinType::Round
  let cap = @moonclip.CapType::Round
  st_expect(
    st_route(),
    4.0,
    st_right_expected(join, cap),
    cap~,
    options=@moonclip.OffsetOptions::new(join~),
  )
}

///|
test "stroke topology 1 horizontal vertical diagonal full regions" {
  st_expect(st_line(), 4.0, [bb_rect(0L, -2L, 20L, 4L)])
  st_expect(st_path([(0L, 0L), (0L, 20L)]), 4.0, [bb_rect(-2L, 0L, 4L, 20L)])
  st_expect(st_path([(0L, 0L), (30L, 40L)]), 4.0, [
    st_path([(-2L, 1L), (2L, -1L), (32L, 39L), (28L, 41L)]),
  ])
}

///|
test "stroke topology 2 consecutive duplicates preserve the same route" {
  let raw = st_path([
    (0L, 0L),
    (0L, 0L),
    (20L, 0L),
    (20L, 0L),
    (20L, 20L),
    (20L, 20L),
  ])
  st_expect(raw, 4.0, st_right_expected(Miter, Butt))
}

///|
test "stroke topology 4 complete reversal is still a filled route" {
  st_expect(st_path([(0L, 0L), (20L, 0L), (0L, 0L)]), 4.0, [
    bb_rect(0L, -2L, 22L, 4L),
  ])
}

///|
test "stroke topology 5 zero area self crossing route remains strokable" {
  let route = st_path([(-20L, -20L), (20L, 20L), (-20L, 20L), (20L, -20L)])
  assert_eq(@moonclip.area2(route), Ok(0N))
  guard @moonclip.stroke_polyline(route, 4.0) is Ok(region) else {
    fail("Expected stroke")
  }
  assert_true(!region.is_empty())
  assert_true(
    region.any(fn(p) {
      @moonclip.point_in_polygon(@moonclip.Point64::new(0L, 0L), p) ==
      Ok(@moonclip.Inside)
    }),
  )
}

///|
test "stroke topology 6 coincident ends retain open cap geometry" {
  let route = st_path([(0L, 0L), (30L, 0L), (30L, 30L), (0L, 0L)])
  st_expect(route, 4.0, [
    st_path([(-1L, 1L), (0L, 0L), (0L, -2L), (32L, -2L), (32L, 31L), (30L, 32L)]),
    st_path([(4L, 2L), (28L, 26L), (28L, 2L)]),
  ])
}

///|
test "stroke topology 7 loop forms a genuine hole for independent tree composition" {
  let route = st_path([(0L, 0L), (30L, 0L), (30L, 30L), (0L, 30L), (0L, 0L)])
  let expected = [
    bb_rect(-2L, -2L, 34L, 34L),
    bb_reverse(bb_rect(2L, 2L, 26L, 26L)),
  ]
  st_expect(route, 4.0, expected, cap=@moonclip.CapType::Square)
  guard @moonclip.stroke_polyline(route, 4.0, cap=Square) is Ok(paths) else {
    fail("Expected ring")
  }
  guard @moonclip.boolean_tree(paths, [], Union, fill_rule=NonZero) is Ok(tree) else {
    fail("Expected independent tree")
  }
  assert_eq(tree.roots().length(), 1)
  assert_eq(tree.roots()[0].children().length(), 1)
  assert_true(tree.roots()[0].children()[0].is_hole())
}

///|
test "stroke topology 8 selected axis route reversal preserves region" {
  assert_eq(
    @moonclip.stroke_polyline(st_route(), 4.0).map(bb_canonical),
    @moonclip.stroke_polyline(bb_reverse(st_route()), 4.0).map(bb_canonical),
  )
}

///|
test "stroke topology 9 almost collinear route has finite valid connections" {
  guard @moonclip.stroke_polyline(
      st_path([(0L, 0L), (1000L, 0L), (2000L, 1L)]),
      4.0,
      options=@moonclip.OffsetOptions::new(join=Round),
    )
    is Ok(paths) else {
    fail("Expected near straight stroke")
  }
  assert_true(
    paths.any(fn(p) {
      @moonclip.point_in_polygon(@moonclip.Point64::new(1000L, 0L), p) ==
      Ok(@moonclip.Inside)
    }),
  )
}

///|
test "stroke topology 10 short near reversal does not damage output topology" {
  for
    join in [
      @moonclip.Miter,
      @moonclip.Bevel,
      @moonclip.JoinType::Square,
      @moonclip.JoinType::Round,
    ] {
    guard @moonclip.stroke_polyline(
        st_path([(0L, 0L), (20L, 0L), (1L, 1L)]),
        4.0,
        options=@moonclip.OffsetOptions::new(join~),
      )
      is Ok(paths) else {
      fail("Expected short turn")
    }
    assert_true(!paths.is_empty())
    assert_eq(
      @moonclip.boolean_op(paths, [], Union, fill_rule=NonZero).map(
        bb_canonical,
      ),
      Ok(bb_canonical(paths)),
    )
  }
}

///|
test "stroke isolation 1 inputs never change while generating both sides" {
  let path = st_path([(0L, 0L), (0L, 0L), (20L, 0L), (20L, 20L)])
  let saved = path.copy()
  for
    cap in [
      @moonclip.CapType::Butt,
      @moonclip.CapType::Square,
      @moonclip.CapType::Round,
    ] {
    assert_true(@moonclip.stroke_polyline(path, 4.0, cap~) is Ok(_))
    assert_eq(path, saved)
  }
}

///|
test "stroke isolation 2 changing source cannot affect returned arrays" {
  let path = st_line()
  guard @moonclip.stroke_polyline(path, 4.0, cap=Round) is Ok(region) else {
    fail("Expected stroke")
  }
  path[0] = @moonclip.Point64::new(99L, 99L)
  assert_eq(bb_canonical(region), bb_canonical(st_round_line()))
}

///|
test "stroke isolation 3 changing result cannot affect source" {
  let path = st_line()
  let saved = path.copy()
  guard @moonclip.stroke_polyline(path, 4.0) is Ok(region) else {
    fail("Expected stroke")
  }
  region[0][0] = @moonclip.Point64::new(99L, 99L)
  region.clear()
  assert_eq(path, saved)
}

///|
test "stroke isolation 4 repeated calls own all mutable arrays" {
  guard @moonclip.stroke_polyline(st_line(), 4.0) is Ok(a) else {
    fail("Expected stroke")
  }
  guard @moonclip.stroke_polyline(st_line(), 4.0) is Ok(b) else {
    fail("Expected stroke")
  }
  let saved = @moonclip.copy_paths(b)
  a[0].clear()
  assert_eq(b, saved)
}

///|
test "stroke isolation 5 coordinate failure leaves input and next call intact" {
  let path = st_path([(999999990L, 0L), (1000000000L, 0L)])
  let saved = path.copy()
  assert_true(@moonclip.stroke_polyline(path, 4.0, cap=Square) is Err(_))
  assert_eq(path, saved)
  st_expect(st_line(), 4.0, [bb_rect(0L, -2L, 20L, 4L)])
}

///|
test "stroke isolation 6 invalid parameters do not leak into subsequent calls" {
  assert_true(
    @moonclip.stroke_polyline(
      [],
      4.0,
      options=@moonclip.OffsetOptions::new(arc_tolerance=-1.0),
    )
    is Err(InvalidInput(_, _)),
  )
  st_expect(st_line(), 4.0, st_round_line(), cap=Round)
}

///|
test "stroke isolation 7 raw coordinate indices survive a zero width" {
  assert_true(
    @moonclip.stroke_polyline(st_path([(0L, 0L), (1000000001L, 0L)]), 0.0)
    is Err(
      CoordinateOutOfRange(
        { stage: StrokeGenerate, path_index: Some(0), vertex_index: Some(1), },
        X,
        1000000001L
      )
    ),
  )
}

///|
test "stroke isolation 8 options without a used join or arc do not change a line" {
  for limit in [2.0, 4.0, 10.0, 1.0e300] {
    st_expect(
      st_line(),
      4.0,
      [bb_rect(0L, -2L, 20L, 4L)],
      options=@moonclip.OffsetOptions::new(
        miter_limit=limit,
        arc_tolerance=1.0e300,
      ),
    )
  }
}
