// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn mk_path(points : Array[(Int, Int)]) -> @moonclip.Path64 {
  points.map(fn(p) { @moonclip.Point64::new(p.0.to_int64(), p.1.to_int64()) })
}

///|
fn mk_run(
  pattern : @moonclip.Path64,
  path : @moonclip.Path64,
  closed? : Bool = false,
) -> @moonclip.Paths64 {
  @moonclip.minkowski_sum(pattern, path, closed).unwrap()
}

///|
fn mk_square() -> @moonclip.Path64 {
  cp_rect(-1L, -1L, 2L, 2L)
}

///|
fn mk_line() -> @moonclip.Path64 {
  mk_path([(0, 0), (10, 0)])
}

///|
test "minkowski API empty pattern" {
  assert_eq(mk_run([], mk_line()), [])
}

///|
test "minkowski API empty route" {
  assert_eq(mk_run(mk_square(), []), [])
}

///|
test "minkowski API empty both validate two paths" {
  assert_eq(
    @moonclip.minkowski_sum([], [], false, limits={
      max_input_paths: 2,
      max_input_vertices: 0,
    }),
    Ok([]),
  )
  assert_true(
    @moonclip.minkowski_sum([], [], false, limits={
      max_input_paths: 1,
      max_input_vertices: 0,
    })
    is Err(@moonclip.ResourceLimitExceeded(_, @moonclip.InputPaths, 1)),
  )
}

///|
test "minkowski API empty validates other coordinates" {
  assert_true(
    @moonclip.minkowski_sum(
      [],
      [@moonclip.Point64::new(1000000001L, 0L)],
      false,
    )
    is Err(
      @moonclip.CoordinateOutOfRange(
        { path_index: Some(1), vertex_index: Some(0), .. },
        @moonclip.X,
        1000000001L
      )
    ),
  )
}

///|
test "minkowski API single route open no face" {
  assert_eq(mk_run(mk_square(), mk_path([(2, 3)])), [])
}

///|
test "minkowski API single route closed no face" {
  assert_eq(mk_run(mk_square(), mk_path([(2, 3)]), closed=true), [])
}

///|
test "minkowski API single point pattern no face" {
  assert_eq(mk_run(mk_path([(2, 3)]), mk_line()), [])
}

///|
test "minkowski API two point nonparallel pattern" {
  cp_equal(mk_run(mk_path([(0, -1), (0, 1)]), mk_line()), [
    cp_rect(0L, -1L, 10L, 2L),
  ])
}

///|
test "minkowski API two point parallel pattern" {
  assert_eq(mk_run(mk_path([(-1, 0), (1, 0)]), mk_line()), [])
}

///|
test "minkowski API shared original vertices limit" {
  assert_true(
    @moonclip.minkowski_sum(mk_square(), mk_line(), false, limits={
      max_input_paths: 2,
      max_input_vertices: 5,
    })
    is Err(
      @moonclip.ResourceLimitExceeded(
        { path_index: Some(1), vertex_index: Some(1), .. },
        @moonclip.InputVertices,
        5
      )
    ),
  )
  assert_true(
    @moonclip.minkowski_sum(mk_square(), mk_line(), false, limits={
      max_input_paths: 2,
      max_input_vertices: 6,
    })
    is Ok(_),
  )
}

///|
test "minkowski API negative and zero limits" {
  assert_true(
    @moonclip.minkowski_sum([], [], false, limits={
      max_input_paths: -1,
      max_input_vertices: 0,
    })
    is Err(@moonclip.InvalidInput(_, _)),
  )
  assert_true(
    @moonclip.minkowski_sum([], [], false, limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    })
    is Err(@moonclip.ResourceLimitExceeded(_, @moonclip.InputPaths, 0)),
  )
}

///|
test "minkowski API repeated originals cannot bypass limit" {
  let p = mk_path([(-1, -1), (-1, -1), (1, -1), (1, 1), (-1, 1), (-1, -1)])
  assert_true(
    @moonclip.minkowski_sum(p, mk_line(), false, limits={
      max_input_paths: 2,
      max_input_vertices: 7,
    })
    is Err(@moonclip.ResourceLimitExceeded(_, @moonclip.InputVertices, 7)),
  )
  assert_eq(p.length(), 6)
}

///|
test "minkowski geometry long rectangle" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(9L, -1L),
      @moonclip.Point64::new(11L, -1L),
      @moonclip.Point64::new(11L, 1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
  ])
  cp_equal(
    @moonclip.boolean_op(
      outcome,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ).unwrap(),
    [cp_rect(-1L, -1L, 12L, 2L)],
  )
}

///|
test "minkowski geometry short rectangle gap" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(0L, 1L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(0L, -1L),
    ],
    [
      @moonclip.Point64::new(2L, 1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(2L, -1L),
    ],
  ])
  assert_eq(outcome.length(), 2)
}

///|
test "minkowski geometry fixed integer circle" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(3L, 0L),
      @moonclip.Point64::new(2L, 2L),
      @moonclip.Point64::new(0L, 3L),
      @moonclip.Point64::new(-2L, 2L),
      @moonclip.Point64::new(-3L, 0L),
      @moonclip.Point64::new(-2L, -2L),
      @moonclip.Point64::new(0L, -3L),
      @moonclip.Point64::new(2L, -2L),
    ],
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(20L, 3L),
      @moonclip.Point64::new(0L, 3L),
      @moonclip.Point64::new(-2L, 2L),
      @moonclip.Point64::new(-3L, 0L),
      @moonclip.Point64::new(-2L, -2L),
      @moonclip.Point64::new(0L, -3L),
      @moonclip.Point64::new(20L, -3L),
      @moonclip.Point64::new(22L, -2L),
      @moonclip.Point64::new(23L, 0L),
      @moonclip.Point64::new(22L, 2L),
    ],
  ])
}

///|
test "minkowski geometry concave right turn" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(4L, 0L),
      @moonclip.Point64::new(4L, 1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(1L, 4L),
      @moonclip.Point64::new(0L, 4L),
    ],
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(10L, 10L),
    ],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(14L, 0L),
      @moonclip.Point64::new(14L, 1L),
      @moonclip.Point64::new(14L, 11L),
      @moonclip.Point64::new(11L, 11L),
      @moonclip.Point64::new(11L, 14L),
      @moonclip.Point64::new(10L, 14L),
      @moonclip.Point64::new(10L, 10L),
      @moonclip.Point64::new(10L, 4L),
      @moonclip.Point64::new(1L, 4L),
      @moonclip.Point64::new(0L, 4L),
      @moonclip.Point64::new(0L, 0L),
    ],
  ])
}

///|
test "minkowski geometry offcenter anchor" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(2L, 1L),
      @moonclip.Point64::new(6L, 1L),
      @moonclip.Point64::new(5L, 4L),
      @moonclip.Point64::new(2L, 3L),
    ],
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(12L, 1L),
      @moonclip.Point64::new(16L, 1L),
      @moonclip.Point64::new(15L, 4L),
      @moonclip.Point64::new(5L, 4L),
      @moonclip.Point64::new(2L, 3L),
      @moonclip.Point64::new(2L, 1L),
    ],
  ])
}

///|
test "minkowski geometry route translation" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [@moonclip.Point64::new(5L, -7L), @moonclip.Point64::new(15L, -7L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(14L, -8L),
      @moonclip.Point64::new(16L, -8L),
      @moonclip.Point64::new(16L, -6L),
      @moonclip.Point64::new(6L, -6L),
      @moonclip.Point64::new(4L, -6L),
      @moonclip.Point64::new(4L, -8L),
    ],
  ])
}

///|
test "minkowski geometry pattern translation" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(4L, -8L),
      @moonclip.Point64::new(6L, -8L),
      @moonclip.Point64::new(6L, -6L),
      @moonclip.Point64::new(4L, -6L),
    ],
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(14L, -8L),
      @moonclip.Point64::new(16L, -8L),
      @moonclip.Point64::new(16L, -6L),
      @moonclip.Point64::new(6L, -6L),
      @moonclip.Point64::new(4L, -6L),
      @moonclip.Point64::new(4L, -8L),
    ],
  ])
}

///|
test "minkowski geometry reverse route" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [@moonclip.Point64::new(10L, 0L), @moonclip.Point64::new(0L, 0L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(9L, -1L),
      @moonclip.Point64::new(11L, -1L),
      @moonclip.Point64::new(11L, 1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
  ])
}

///|
test "minkowski geometry reverse pattern" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(9L, -1L),
      @moonclip.Point64::new(11L, -1L),
      @moonclip.Point64::new(11L, 1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
  ])
}

///|
test "minkowski geometry retrace extension" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(3L, 0L),
      @moonclip.Point64::new(3L, 10L),
    ],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(9L, -1L),
      @moonclip.Point64::new(11L, -1L),
      @moonclip.Point64::new(11L, 1L),
      @moonclip.Point64::new(4L, 1L),
      @moonclip.Point64::new(4L, 11L),
      @moonclip.Point64::new(2L, 11L),
      @moonclip.Point64::new(2L, 9L),
      @moonclip.Point64::new(2L, 1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
  ])
}

///|
test "minkowski geometry self crossing" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 10L),
      @moonclip.Point64::new(0L, 10L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(15L, 5L),
    ],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(5L, 3L),
      @moonclip.Point64::new(9L, -1L),
      @moonclip.Point64::new(11L, -1L),
      @moonclip.Point64::new(16L, 4L),
      @moonclip.Point64::new(16L, 6L),
      @moonclip.Point64::new(14L, 6L),
      @moonclip.Point64::new(10L, 2L),
      @moonclip.Point64::new(7L, 5L),
      @moonclip.Point64::new(11L, 9L),
      @moonclip.Point64::new(11L, 11L),
      @moonclip.Point64::new(9L, 11L),
      @moonclip.Point64::new(1L, 11L),
      @moonclip.Point64::new(-1L, 11L),
      @moonclip.Point64::new(-1L, 9L),
      @moonclip.Point64::new(3L, 5L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
    [
      @moonclip.Point64::new(3L, 9L),
      @moonclip.Point64::new(7L, 9L),
      @moonclip.Point64::new(5L, 7L),
    ],
  ])
}

///|
test "minkowski geometry repeat endpoint open" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(10L, 10L),
      @moonclip.Point64::new(0L, 0L),
    ],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(9L, -1L),
      @moonclip.Point64::new(11L, -1L),
      @moonclip.Point64::new(11L, 1L),
      @moonclip.Point64::new(11L, 9L),
      @moonclip.Point64::new(11L, 11L),
      @moonclip.Point64::new(9L, 11L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
    [
      @moonclip.Point64::new(3L, 1L),
      @moonclip.Point64::new(9L, 7L),
      @moonclip.Point64::new(9L, 1L),
    ],
  ])
}

///|
test "minkowski geometry repeat endpoint closed" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(10L, 10L),
      @moonclip.Point64::new(0L, 0L),
    ],
    closed=true,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(9L, -1L),
      @moonclip.Point64::new(11L, -1L),
      @moonclip.Point64::new(11L, 1L),
      @moonclip.Point64::new(11L, 9L),
      @moonclip.Point64::new(11L, 11L),
      @moonclip.Point64::new(9L, 11L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
    [
      @moonclip.Point64::new(3L, 1L),
      @moonclip.Point64::new(9L, 7L),
      @moonclip.Point64::new(9L, 1L),
    ],
  ])
}

///|
test "minkowski geometry closed rectangle actual hole" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(20L, 0L),
      @moonclip.Point64::new(20L, 20L),
      @moonclip.Point64::new(0L, 20L),
    ],
    closed=true,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(19L, -1L),
      @moonclip.Point64::new(21L, -1L),
      @moonclip.Point64::new(21L, 1L),
      @moonclip.Point64::new(21L, 21L),
      @moonclip.Point64::new(19L, 21L),
      @moonclip.Point64::new(1L, 21L),
      @moonclip.Point64::new(-1L, 21L),
      @moonclip.Point64::new(-1L, 19L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
    [
      @moonclip.Point64::new(1L, 19L),
      @moonclip.Point64::new(19L, 19L),
      @moonclip.Point64::new(19L, 1L),
      @moonclip.Point64::new(1L, 1L),
    ],
  ])
  let tree = @moonclip.boolean_tree(
    outcome,
    [],
    @moonclip.Union,
    fill_rule=@moonclip.NonZero,
  ).unwrap()
  assert_eq(tree.roots().length(), 1)
  assert_eq(tree.roots()[0].children().length(), 1)
  assert_eq(tree.roots()[0].children()[0].is_hole(), true)
  cp_equal([tree.roots()[0].contour()], [cp_rect(-1L, -1L, 22L, 22L)])
  cp_equal([tree.roots()[0].children()[0].contour()], [
    bb_reverse(cp_rect(1L, 1L, 18L, 18L)),
  ])
}

///|
test "minkowski geometry zero area bowtie pattern" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(4L, 4L),
      @moonclip.Point64::new(0L, 4L),
      @moonclip.Point64::new(4L, 0L),
    ],
    [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(14L, 0L),
      @moonclip.Point64::new(12L, 2L),
      @moonclip.Point64::new(14L, 4L),
      @moonclip.Point64::new(4L, 4L),
      @moonclip.Point64::new(0L, 4L),
      @moonclip.Point64::new(2L, 2L),
      @moonclip.Point64::new(0L, 0L),
    ],
  ])
}

///|
test "minkowski geometry collinear vertices strictly retained" {
  // Independent fixed C++ MinkowskiSum complete-contour expectation.
  let outcome = mk_run(
    [
      @moonclip.Point64::new(-1L, -1L),
      @moonclip.Point64::new(1L, -1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
    ],
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(10L, 10L),
    ],
    closed=false,
  )
  cp_equal(outcome, [
    [
      @moonclip.Point64::new(9L, -1L),
      @moonclip.Point64::new(11L, -1L),
      @moonclip.Point64::new(11L, 1L),
      @moonclip.Point64::new(11L, 11L),
      @moonclip.Point64::new(9L, 11L),
      @moonclip.Point64::new(9L, 9L),
      @moonclip.Point64::new(9L, 1L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(-1L, 1L),
      @moonclip.Point64::new(-1L, -1L),
    ],
  ])
}

///|
test "minkowski boundary isolation positive exact bound" {
  let p = mk_square()
  let r = [
    @moonclip.Point64::new(999999990L, 0L),
    @moonclip.Point64::new(999999999L, 0L),
  ]
  let out = mk_run(p, r)
  cp_equal(@moonclip.boolean_op(out, [], @moonclip.Union).unwrap(), [
    cp_rect(999999989L, -1L, 11L, 2L),
  ])
}

///|
test "minkowski boundary isolation negative exact bound" {
  let r = [
    @moonclip.Point64::new(-999999999L, 0L),
    @moonclip.Point64::new(-999999990L, 0L),
  ]
  cp_equal(
    @moonclip.boolean_op(mk_run(mk_square(), r), [], @moonclip.Union).unwrap(),
    [cp_rect(-1000000000L, -1L, 11L, 2L)],
  )
}

///|
test "minkowski boundary isolation generated positive axis range" {
  assert_true(
    @moonclip.minkowski_sum(
      mk_square(),
      [@moonclip.Point64::new(1000000000L, 0L)],
      false,
    )
    is Err(
      @moonclip.CoordinateOutOfRange(
        {
          stage: @moonclip.MinkowskiGenerate,
          path_index: Some(1),
          vertex_index: Some(0),
        },
        @moonclip.X,
        1000000001L
      )
    ),
  )
}

///|
test "minkowski boundary isolation generated negative axis range" {
  assert_true(
    @moonclip.minkowski_sum(
      mk_square(),
      [@moonclip.Point64::new(0L, -1000000000L)],
      false,
    )
    is Err(
      @moonclip.CoordinateOutOfRange(
        {
          stage: @moonclip.MinkowskiGenerate,
          path_index: Some(1),
          vertex_index: Some(0),
        },
        @moonclip.Y,
        -1000000001L
      )
    ),
  )
}

///|
test "minkowski boundary isolation Int64 extrema rejected before add" {
  for x in [-9223372036854775808L, 9223372036854775807L] {
    assert_true(
      @moonclip.minkowski_sum([@moonclip.Point64::new(x, 0L)], mk_line(), false)
      is Err(
        @moonclip.CoordinateOutOfRange(
          {
            stage: @moonclip.MinkowskiParameters,
            path_index: Some(0),
            vertex_index: Some(0),
          },
          @moonclip.X,
          _
        )
      ),
    )
  }
}

///|
test "minkowski boundary isolation large near collinear exact winding" {
  let p = [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(999999999L, 999999998L),
  ]
  let r = mk_path([(0, 0), (1, 1)])
  assert_eq(
    @moonclip.cross(p[0], r[1], @moonclip.Point64::new(1000000000L, 999999999L)),
    Ok(-1L),
  )
  assert_true(@moonclip.minkowski_sum(p, r, false) is Ok(_))
}

///|
test "minkowski boundary isolation source arrays unchanged" {
  let p = mk_square()
  let r = mk_line()
  let saved_p = p.copy()
  let saved_r = r.copy()
  ignore(mk_run(p, r))
  assert_eq(p, saved_p)
  assert_eq(r, saved_r)
}

///|
test "minkowski boundary isolation output changes isolate inputs" {
  let p = mk_square()
  let r = mk_line()
  let saved_p = p.copy()
  let saved_r = r.copy()
  let out = mk_run(p, r)
  out[0].clear()
  out.clear()
  assert_eq(p, saved_p)
  assert_eq(r, saved_r)
}

///|
test "minkowski boundary isolation input changes isolate output" {
  let p = mk_square()
  let r = mk_line()
  let out = mk_run(p, r)
  let saved = @moonclip.copy_paths(out)
  p.clear()
  r.clear()
  assert_eq(out, saved)
}

///|
test "minkowski boundary isolation shared pattern route input" {
  let p = cp_rect(0L, 0L, 10L, 10L)
  let saved = p.copy()
  let a = mk_run(p, p, closed=true)
  let b = mk_run(saved, saved, closed=true)
  cp_equal(a, b)
  assert_eq(p, saved)
  a[0].clear()
  cp_equal(b, mk_run(saved, saved, closed=true))
}

///|
test "minkowski boundary isolation independent calls own arrays" {
  let a = mk_run(mk_square(), mk_line())
  let b = mk_run(mk_square(), mk_line())
  let saved = @moonclip.copy_paths(b)
  a[0].clear()
  a.clear()
  assert_eq(b, saved)
}

///|
test "minkowski boundary isolation failure retry owns fresh budget" {
  let p = mk_square()
  let r = mk_line()
  let expected = mk_run(p, r)
  assert_true(
    @moonclip.minkowski_sum(p, r, false, limits={
      max_input_paths: 2,
      max_input_vertices: 1,
    })
    is Err(_),
  )
  cp_equal(mk_run(p, r), expected)
}
