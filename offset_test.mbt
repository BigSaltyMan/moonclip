// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn of_result(
  paths : @moonclip.Paths64,
  delta : Double,
  expected : @moonclip.Paths64,
  options? : @moonclip.OffsetOptions = Default::default(),
) -> Unit raise {
  assert_eq(
    @moonclip.offset_polygons(paths, delta, options~).map(bb_canonical),
    Ok(bb_canonical(expected)),
  )
}

///|
fn of_acute() -> @moonclip.Path64 {
  [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(60L, 0L),
    @moonclip.Point64::new(2L, 10L),
  ]
}

///|
test "offset rectangle expands and contracts with complete rings" {
  let input = [bb_rect(0L, 0L, 10L, 10L)]
  of_result(input, 2.0, [bb_rect(-2L, -2L, 14L, 14L)])
  of_result(input, -2.0, [bb_rect(2L, 2L, 6L, 6L)])
}

///|
test "offset exact and excessive collapse are legal empty regions" {
  for delta in [-5.0, -6.0, -100.0] {
    of_result([bb_rect(0L, 0L, 10L, 10L)], delta, [])
  }
}

///|
test "offset zero negative zero and small values normalize instead of copying raw" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let b = bb_rect(5L, 0L, 10L, 10L)
  for delta in [0.0, -0.0, 0.49, -0.49, 0.499999999, -0.499999999] {
    of_result([a, b], delta, [bb_rect(0L, 0L, 15L, 10L)])
  }
}

///|
test "offset half grid distances use actual generation" {
  for delta in [0.5, 0.500000001] {
    of_result([bb_rect(0L, 0L, 10L, 10L)], delta, [bb_rect(-1L, -1L, 12L, 12L)])
  }
  of_result([bb_rect(0L, 0L, 10L, 10L)], -0.5, [bb_rect(1L, 1L, 9L, 9L)])
  for delta in [-0.500000001] {
    of_result([bb_rect(0L, 0L, 10L, 10L)], delta, [bb_rect(1L, 1L, 8L, 8L)])
  }
}

///|
test "offset negative coordinates and grid boundary are exact" {
  of_result([bb_rect(-10L, -10L, 10L, 10L)], 2.0, [
    bb_rect(-12L, -12L, 14L, 14L),
  ])
  of_result([bb_rect(999999988L, 999999988L, 10L, 10L)], 2.0, [
    bb_rect(999999986L, 999999986L, 14L, 14L),
  ])
}

///|
test "offset generated coordinate overflow is reported without source indices" {
  assert_true(
    @moonclip.offset_polygons([bb_rect(999999990L, 0L, 10L, 10L)], 1.0)
    is Err(
      CoordinateOutOfRange(
        { stage: OffsetGenerate, path_index: None, vertex_index: None, },
        X,
        1000000001L
      )
    ),
  )
  assert_true(
    @moonclip.offset_polygons([bb_rect(-1000000000L, 0L, 10L, 10L)], 1.0)
    is Err(
      CoordinateOutOfRange(
        { stage: OffsetGenerate, path_index: None, vertex_index: None, },
        X,
        -1000000001L
      )
    ),
  )
}

///|
test "offset holes shrink expand and disappear with the same group delta" {
  let source = [
    bb_rect(-30L, -30L, 60L, 60L),
    bb_reverse(bb_rect(-10L, -10L, 20L, 20L)),
  ]
  of_result(source, 2.0, [
    bb_rect(-32L, -32L, 64L, 64L),
    bb_reverse(bb_rect(-8L, -8L, 16L, 16L)),
  ])
  of_result(source, -2.0, [
    bb_rect(-28L, -28L, 56L, 56L),
    bb_reverse(bb_rect(-12L, -12L, 24L, 24L)),
  ])
  of_result(source, 12.0, [bb_rect(-42L, -42L, 84L, 84L)])
}

///|
test "offset island retains three-level topology in independent tree composition" {
  let source = [
    bb_rect(-40L, -40L, 80L, 80L),
    bb_reverse(bb_rect(-25L, -25L, 50L, 50L)),
    bb_rect(-10L, -10L, 20L, 20L),
  ]
  guard @moonclip.offset_polygons(source, 4.0) is Ok(result) else {
    fail("Expected offset")
  }
  assert_eq(
    bb_canonical(result),
    bb_canonical([
      bb_rect(-44L, -44L, 88L, 88L),
      bb_reverse(bb_rect(-21L, -21L, 42L, 42L)),
      bb_rect(-14L, -14L, 28L, 28L),
    ]),
  )
  guard @moonclip.boolean_tree(result, [], Union, fill_rule=NonZero) is Ok(tree) else {
    fail("Expected independent tree")
  }
  assert_eq(tree.roots()[0].children()[0].children()[0].depth(), 3)
}

///|
test "offset merging adjacent expanded regions is one cleanup" {
  of_result([bb_rect(0L, 0L, 10L, 10L), bb_rect(14L, 0L, 10L, 10L)], 3.0, [
    bb_rect(-3L, -3L, 30L, 16L),
  ])
}

///|
test "offset fill normalization distinguishes parity nonzero and cancellation" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  assert_eq(@moonclip.offset_polygons([a, a], 2.0, fill_rule=EvenOdd), Ok([]))
  of_result([a, a], 2.0, [bb_rect(-2L, -2L, 14L, 14L)])
  of_result([a, bb_reverse(a)], 2.0, [])
}

///|
test "offset degenerates never become point or line strokes" {
  of_result(
    [
      [],
      [@moonclip.Point64::new(0L, 0L)],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 10L)],
    ],
    4.0,
    [],
  )
}

///|
test "offset empty inputs remain empty for finite distances" {
  for delta in [0.0, 0.49, 0.5, -2.0, 1.0e300] {
    of_result([], delta, [])
  }
}

///|
test "offset Miter and Bevel have distinct complete corners" {
  of_result(
    [bb_rect(0L, 0L, 10L, 10L)],
    2.0,
    [
      [
        @moonclip.Point64::new(-2L, 0L),
        @moonclip.Point64::new(0L, -2L),
        @moonclip.Point64::new(10L, -2L),
        @moonclip.Point64::new(12L, 0L),
        @moonclip.Point64::new(12L, 10L),
        @moonclip.Point64::new(10L, 12L),
        @moonclip.Point64::new(0L, 12L),
        @moonclip.Point64::new(-2L, 10L),
      ],
    ],
    options=@moonclip.OffsetOptions::new(join=Bevel),
  )
}

///|
test "offset sharp Miter uses Square fallback and limit changes it" {
  let p = of_acute()
  of_result([p], 3.0, [
    [
      @moonclip.Point64::new(-4L, -3L),
      @moonclip.Point64::new(63L, -3L),
      @moonclip.Point64::new(63L, 2L),
      @moonclip.Point64::new(0L, 13L),
    ],
  ])
  // Independently executed fixed C++ adapter, MiterLimit=20: the acute tip survives.
  of_result(
    [p],
    3.0,
    [
      [
        @moonclip.Point64::new(-4L, -3L),
        @moonclip.Point64::new(95L, -3L),
        @moonclip.Point64::new(0L, 13L),
      ],
    ],
    options=@moonclip.OffsetOptions::new(miter_limit=20.0),
  )
  let m = @moonclip.offset_polygons([p], 3.0)
  assert_true(
    m !=
    @moonclip.offset_polygons(
      [p],
      3.0,
      options=@moonclip.OffsetOptions::new(join=Bevel),
    ),
  )
  assert_true(
    m !=
    @moonclip.offset_polygons(
      [p],
      3.0,
      options=@moonclip.OffsetOptions::new(miter_limit=20.0),
    ),
  )
}

///|
test "offset Bevel ignores every legal Miter limit" {
  let a = @moonclip.offset_polygons(
    [of_acute()],
    3.0,
    options=@moonclip.OffsetOptions::new(join=Bevel),
  )
  for limit in [2.0, 4.0, 10.0, 1.0e300] {
    assert_eq(
      a.map(bb_canonical),
      @moonclip.offset_polygons(
        [of_acute()],
        3.0,
        options=@moonclip.OffsetOptions::new(join=Bevel, miter_limit=limit),
      ).map(bb_canonical),
    )
  }
}

///|
test "offset nonfinite distances rejected even with no region" {
  for delta in [@double.not_a_number, @double.infinity, @double.neg_infinity] {
    assert_true(
      @moonclip.offset_polygons([], delta)
      is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
    )
    assert_true(
      @moonclip.offset_polygons([bb_rect(0L, 0L, 10L, 10L)], delta)
      is Err(InvalidInput(_, _)),
    )
  }
}

///|
test "offset invalid options rejected for empty zero and Bevel" {
  for
    limit in [
      @double.not_a_number, @double.infinity, @double.neg_infinity, 1.999, -1.0,
    ] {
    for join in [@moonclip.Miter, @moonclip.Bevel] {
      let options = @moonclip.OffsetOptions::new(join~, miter_limit=limit)
      assert_true(
        @moonclip.offset_polygons([], 0.0, options~)
        is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
      )
      assert_true(
        @moonclip.offset_polygons([bb_rect(0L, 0L, 10L, 10L)], 0.0, options~)
        is Err(InvalidInput(_, _)),
      )
    }
  }
}

///|
test "offset huge finite intermediates fail before integer conversion" {
  assert_true(
    @moonclip.offset_polygons([bb_rect(0L, 0L, 10L, 10L)], 1.0e300)
    is Err(NumericFailure(_, _)),
  )
  assert_true(
    @moonclip.offset_polygons(
      [bb_rect(0L, 0L, 10L, 10L)],
      2.0,
      options=@moonclip.OffsetOptions::new(miter_limit=1.0e300),
    )
    is Err(NumericFailure(_, _)),
  )
}

///|
test "offset zero cannot bypass original coordinates and raw input budgets" {
  assert_true(
    @moonclip.offset_polygons([[@moonclip.Point64::new(1000000001L, 0L)]], 0.0)
    is Err(
      CoordinateOutOfRange(
        { path_index: Some(0), vertex_index: Some(0), .. },
        X,
        1000000001L
      )
    ),
  )
  assert_true(
    @moonclip.offset_polygons([[], []], 0.0, limits={
      max_input_paths: 1,
      max_input_vertices: 0,
    })
    is Err(ResourceLimitExceeded(_, InputPaths, 1)),
  )
  assert_true(
    @moonclip.offset_polygons([bb_rect(0L, 0L, 10L, 10L)], 0.0, limits={
      max_input_paths: 1,
      max_input_vertices: 3,
    })
    is Err(ResourceLimitExceeded(_, InputVertices, 3)),
  )
}

///|
test "offset raw four vertex allowance permits eight generated Bevel vertices" {
  guard @moonclip.offset_polygons(
      [bb_rect(0L, 0L, 10L, 10L)],
      2.0,
      options=@moonclip.OffsetOptions::new(join=Bevel),
      limits={ max_input_paths: 1, max_input_vertices: 4, },
    )
    is Ok(result) else {
    fail("Generated vertices must use internal budget")
  }
  assert_eq(result[0].length(), 8)
}

///|
test "offset raw repeated vertices still consume input allowance" {
  let p = bb_rect(0L, 0L, 10L, 10L)
  p.push(p[0])
  assert_true(
    @moonclip.offset_polygons([p], 0.49, limits={
      max_input_paths: 1,
      max_input_vertices: 4,
    })
    is Err(ResourceLimitExceeded(_, InputVertices, 4)),
  )
}

///|
test "offset results sources aliases and repeated calls remain independent" {
  let p = bb_rect(0L, 0L, 10L, 10L)
  let before = @moonclip.copy_path(p)
  guard @moonclip.offset_polygons([p, p], 2.0) is Ok(a) else {
    fail("Expected offset")
  }
  guard @moonclip.offset_polygons([p, p], 2.0) is Ok(b) else {
    fail("Expected offset")
  }
  assert_eq(p, before)
  let saved = @moonclip.copy_paths(b)
  p[0] = @moonclip.Point64::new(55L, 55L)
  assert_eq(b, saved)
  a[0][0] = @moonclip.Point64::new(99L, 99L)
  a.clear()
  assert_eq(b, saved)
}

///|
test "offset zero returns independent normalized arrays" {
  let p = bb_rect(0L, 0L, 10L, 10L)
  guard @moonclip.offset_polygons([p], -0.0) is Ok(result) else {
    fail("Expected offset")
  }
  result[0][0] = @moonclip.Point64::new(3L, 3L)
  assert_eq(p, bb_rect(0L, 0L, 10L, 10L))
}

///|
test "offset failure leaves original untouched and next call fresh" {
  let p = bb_rect(0L, 0L, 10L, 10L)
  let saved = p.copy()
  assert_true(@moonclip.offset_polygons([p], 1.0e300) is Err(_))
  assert_eq(p, saved)
  of_result([p], 2.0, [bb_rect(-2L, -2L, 14L, 14L)])
}

///|
fn jo_square() -> @moonclip.Paths64 {
  [
    [
      @moonclip.Point64::new(-2L, -1L),
      @moonclip.Point64::new(-1L, -2L),
      @moonclip.Point64::new(11L, -2L),
      @moonclip.Point64::new(12L, -1L),
      @moonclip.Point64::new(12L, 11L),
      @moonclip.Point64::new(11L, 12L),
      @moonclip.Point64::new(-1L, 12L),
      @moonclip.Point64::new(-2L, 11L),
    ],
  ]
}

///|
fn jo_round_options(tolerance? : Double = 0.0) -> @moonclip.OffsetOptions {
  @moonclip.OffsetOptions::new(join=Round, arc_tolerance=tolerance)
}

///|
fn jo_full_round() -> @moonclip.Paths64 {
  [
    [
      @moonclip.Point64::new(-10L, 0L),
      @moonclip.Point64::new(-6L, -8L),
      @moonclip.Point64::new(0L, -10L),
      @moonclip.Point64::new(100L, -10L),
      @moonclip.Point64::new(108L, -6L),
      @moonclip.Point64::new(110L, 0L),
      @moonclip.Point64::new(110L, 100L),
      @moonclip.Point64::new(106L, 108L),
      @moonclip.Point64::new(100L, 110L),
      @moonclip.Point64::new(0L, 110L),
      @moonclip.Point64::new(-8L, 106L),
      @moonclip.Point64::new(-10L, 100L),
    ],
  ]
}

///|
test "offset joins square 1 full Square differs from Bevel" {
  let paths = [bb_rect(0L, 0L, 10L, 10L)]
  of_result(
    paths,
    2.0,
    jo_square(),
    options=@moonclip.OffsetOptions::new(join=Square),
  )
  assert_true(
    @moonclip.offset_polygons(
      paths,
      2.0,
      options=@moonclip.OffsetOptions::new(join=Bevel),
    ).map(bb_canonical) !=
    Ok(bb_canonical(jo_square())),
  )
}

///|
test "offset joins square 3 default Miter behavior unchanged" {
  of_result(
    [bb_rect(0L, 0L, 10L, 10L)],
    2.0,
    [bb_rect(-2L, -2L, 14L, 14L)],
    options=@moonclip.OffsetOptions::new(),
  )
}

///|
test "offset joins square 4 legal miter limits cannot affect Square" {
  for limit in [2.0, 20.0, 1.0e300] {
    of_result(
      [bb_rect(0L, 0L, 10L, 10L)],
      2.0,
      jo_square(),
      options=@moonclip.OffsetOptions::new(join=Square, miter_limit=limit),
    )
  }
}

///|
test "offset joins square 5 irrelevant legal arc parameters preserve old joins" {
  for join in [@moonclip.Miter, @moonclip.Bevel, @moonclip.Square] {
    let expected = @moonclip.offset_polygons(
      [of_acute()],
      3.0,
      options=@moonclip.OffsetOptions::new(join~),
    ).map(bb_canonical)
    for tolerance in [0.0, 1.0e-12, 0.25, 1.0e300] {
      assert_eq(
        @moonclip.offset_polygons(
          [of_acute()],
          3.0,
          options=@moonclip.OffsetOptions::new(join~, arc_tolerance=tolerance),
        ).map(bb_canonical),
        expected,
      )
    }
  }
}

///|
test "offset joins square 6 orthogonal Square and Miter are different complete rings" {
  let input = [bb_rect(0L, 0L, 10L, 10L)]
  let square = @moonclip.offset_polygons(
    input,
    2.0,
    options=@moonclip.OffsetOptions::new(join=Square),
  ).map(bb_canonical)
  assert_eq(square, Ok(bb_canonical(jo_square())))
  assert_true(square != @moonclip.offset_polygons(input, 2.0).map(bb_canonical))
}

///|
test "offset joins round 1 fixed rotation full rectangle" {
  of_result(
    [bb_rect(0L, 0L, 100L, 100L)],
    10.0,
    jo_full_round(),
    options=jo_round_options(tolerance=1.0),
  )
}

///|
test "offset joins round 2 negative outer contraction keeps concave cleanup" {
  of_result(
    [bb_rect(0L, 0L, 100L, 100L)],
    -10.0,
    [bb_rect(10L, 10L, 80L, 80L)],
    options=jo_round_options(tolerance=0.25),
  )
}

///|
test "offset joins round 3 holes change oppositely and preserve tree identity" {
  let input = [
    bb_rect(0L, 0L, 100L, 100L),
    bb_reverse(bb_rect(30L, 30L, 40L, 40L)),
  ]
  guard @moonclip.offset_polygons(
      input,
      10.0,
      options=jo_round_options(tolerance=1.0),
    )
    is Ok(expanded) else {
    fail("Expected Round region")
  }
  let expected = jo_full_round()
  expected.push(bb_reverse(bb_rect(40L, 40L, 20L, 20L)))
  assert_eq(bb_canonical(expanded), bb_canonical(expected))
  guard @moonclip.offset_polygons(
      input,
      -10.0,
      options=jo_round_options(tolerance=1.0),
    )
    is Ok(shrunk) else {
    fail("Expected Round region")
  }
  guard @moonclip.boolean_tree(shrunk, [], Union, fill_rule=NonZero) is Ok(tree) else {
    fail("Expected independent tree composition")
  }
  assert_eq(tree.roots().length(), 1)
  let hole = tree.roots()[0].children()[0]
  assert_true(hole.is_hole())
  assert_eq(
    @moonclip.point_in_polygon(@moonclip.Point64::new(25L, 50L), hole.contour()),
    Ok(Inside),
  )
}

///|
test "offset joins round 4 selected explicit tolerances change complete sampling" {
  let counts = [(0.05, 24), (0.25, 16), (1.0, 12)]
  for (tolerance, count) in counts {
    guard @moonclip.offset_polygons(
        [bb_rect(0L, 0L, 50L, 50L)],
        10.0,
        options=jo_round_options(tolerance~),
      )
      is Ok(result) else {
      fail("Expected Round")
    }
    assert_eq(result.length(), 1)
    assert_eq(result[0].length(), count)
  }
}

///|
test "offset joins round 10 half grid threshold uses Round generation" {
  let input = [bb_rect(0L, 0L, 10L, 10L)]
  of_result(
    input,
    0.5,
    [
      [
        @moonclip.Point64::new(-1L, 0L),
        @moonclip.Point64::new(0L, -1L),
        @moonclip.Point64::new(10L, -1L),
        @moonclip.Point64::new(11L, 0L),
        @moonclip.Point64::new(11L, 10L),
        @moonclip.Point64::new(10L, 11L),
        @moonclip.Point64::new(0L, 11L),
        @moonclip.Point64::new(-1L, 10L),
      ],
    ],
    options=jo_round_options(),
  )
  of_result(input, -0.5, [bb_rect(1L, 1L, 9L, 9L)], options=jo_round_options())
}

///|
test "offset joins parameters 1 optional arc defaults preserve existing construction" {
  let options : @moonclip.OffsetOptions = Default::default()
  assert_eq(
    options,
    @moonclip.OffsetOptions::new(join=Miter, miter_limit=2.0, arc_tolerance=0.0),
  )
}

///|
test "offset joins parameters 2 negative tolerance is rejected for every join" {
  for
    join in [
      @moonclip.Miter,
      @moonclip.Bevel,
      @moonclip.Square,
      @moonclip.Round,
    ] {
    assert_true(
      @moonclip.offset_polygons(
        [bb_rect(0L, 0L, 10L, 10L)],
        2.0,
        options=@moonclip.OffsetOptions::new(join~, arc_tolerance=-0.001),
      )
      is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
    )
  }
}

///|
test "offset joins parameters 3 NaN tolerance is rejected" {
  assert_true(
    @moonclip.offset_polygons(
      [],
      1.0,
      options=jo_round_options(tolerance=@double.not_a_number),
    )
    is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
  )
}

///|
test "offset joins parameters 4 infinite tolerances are rejected" {
  for tolerance in [@double.infinity, @double.neg_infinity] {
    assert_true(
      @moonclip.offset_polygons([], 2.0, options=jo_round_options(tolerance~))
      is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
    )
  }
}

///|
test "offset joins parameters 5 empty input still checks both options" {
  assert_true(
    @moonclip.offset_polygons(
      [],
      1.0,
      options=@moonclip.OffsetOptions::new(join=Square, arc_tolerance=-1.0),
    )
    is Err(InvalidInput(_, _)),
  )
  assert_true(
    @moonclip.offset_polygons(
      [],
      1.0,
      options=@moonclip.OffsetOptions::new(join=Round, miter_limit=1.0),
    )
    is Err(InvalidInput(_, _)),
  )
}

///|
test "offset joins parameters 6 zero and tiny distance do not bypass validation" {
  for delta in [0.0, -0.0, 0.49, -0.49] {
    assert_true(
      @moonclip.offset_polygons(
        [bb_rect(0L, 0L, 10L, 10L)],
        delta,
        options=jo_round_options(tolerance=-1.0),
      )
      is Err(InvalidInput({ stage: OffsetParameters, .. }, _)),
    )
  }
}

///|
test "offset joins parameters 7 tiny positive tolerance uses automatic branch" {
  let input = [bb_rect(0L, 0L, 100L, 100L)]
  let automatic = @moonclip.offset_polygons(
    input,
    10.0,
    options=jo_round_options(),
  ).map(bb_canonical)
  for tolerance in [0.0, -0.0, 1.0e-20, 1.0e-12] {
    assert_eq(
      @moonclip.offset_polygons(
        input,
        10.0,
        options=jo_round_options(tolerance~),
      ).map(bb_canonical),
      automatic,
    )
  }
}

///|
test "offset joins parameters 8 tolerance larger than radius is capped" {
  let input = [bb_rect(0L, 0L, 100L, 100L)]
  let capped = @moonclip.offset_polygons(
    input,
    10.0,
    options=jo_round_options(tolerance=10.0),
  ).map(bb_canonical)
  for tolerance in [10.0, 100.0, 1.0e300] {
    assert_eq(
      @moonclip.offset_polygons(
        input,
        10.0,
        options=jo_round_options(tolerance~),
      ).map(bb_canonical),
      capped,
    )
  }
}

///|
test "offset joins isolation 1 both new joins preserve input and winding" {
  let p = bb_rect(0L, 0L, 100L, 100L)
  let input = [p, bb_reverse(bb_rect(30L, 30L, 40L, 40L))]
  let saved = @moonclip.copy_paths(input)
  for join in [@moonclip.JoinType::Square, @moonclip.JoinType::Round] {
    assert_true(
      @moonclip.offset_polygons(
        input,
        3.0,
        options=@moonclip.OffsetOptions::new(join~),
      )
      is Ok(_),
    )
    assert_eq(input, saved)
  }
}

///|
test "offset joins isolation 2 result mutation cannot reach source" {
  let input = [bb_rect(0L, 0L, 100L, 100L)]
  let saved = @moonclip.copy_paths(input)
  guard @moonclip.offset_polygons(input, 10.0, options=jo_round_options())
    is Ok(result) else {
    fail("Expected Round")
  }
  result[0][0] = @moonclip.Point64::new(999L, 999L)
  result.clear()
  assert_eq(input, saved)
}

///|
test "offset joins isolation 3 repeated calls own their arrays" {
  let input = [bb_rect(0L, 0L, 100L, 100L)]
  guard @moonclip.offset_polygons(input, 10.0, options=jo_round_options())
    is Ok(a) else {
    fail("Expected Round")
  }
  guard @moonclip.offset_polygons(input, 10.0, options=jo_round_options())
    is Ok(b) else {
    fail("Expected Round")
  }
  let saved = @moonclip.copy_paths(b)
  a[0].clear()
  input[0][0] = @moonclip.Point64::new(1L, 1L)
  assert_eq(b, saved)
}

///|
test "offset joins isolation 4 failed generation leaves next call fresh" {
  let p = bb_rect(999999990L, 0L, 10L, 10L)
  let saved = p.copy()
  assert_true(
    @moonclip.offset_polygons([p], 10.0, options=jo_round_options()) is Err(_),
  )
  assert_eq(p, saved)
  of_result(
    [bb_rect(0L, 0L, 100L, 100L)],
    10.0,
    jo_full_round(),
    options=jo_round_options(tolerance=1.0),
  )
}

///|
test "offset joins isolation 5 tiny distances still normalize shared raw inputs" {
  let p = bb_rect(0L, 0L, 10L, 10L)
  for delta in [0.0, -0.0, 0.49, -0.49] {
    for join in [@moonclip.JoinType::Square, @moonclip.JoinType::Round] {
      assert_eq(
        @moonclip.offset_polygons(
          [p, p],
          delta,
          fill_rule=EvenOdd,
          options=@moonclip.OffsetOptions::new(join~),
        ),
        Ok([]),
      )
      of_result([p, p], delta, [p], options=@moonclip.OffsetOptions::new(join~))
    }
  }
}
