// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn rc_path(points : Array[(Int64, Int64)]) -> @moonclip.Path64 {
  points.map(fn(p) { @moonclip.Point64::new(p.0, p.1) })
}

///|
fn rc_window() -> @moonclip.Bounds64 {
  { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, }
}

///|
test "rect clip lines: independent horizontal direction and collinear vertices" {
  let p = rc_path([(-10L, 5L), (5L, 5L), (20L, 5L)])
  assert_eq(
    @moonclip.rect_clip_lines(rc_window(), [p]),
    Ok([rc_path([(0L, 5L), (5L, 5L), (10L, 5L)])]),
  )
  let reversed = rc_path([(20L, 5L), (5L, 5L), (-10L, 5L)])
  assert_eq(
    @moonclip.rect_clip_lines(rc_window(), [reversed]),
    Ok([rc_path([(10L, 5L), (5L, 5L), (0L, 5L)])]),
  )
}

///|
test "rect clip lines: fragments never join across routes or outside excursions" {
  let p = rc_path([
    (-5L, 2L),
    (5L, 2L),
    (15L, 2L),
    (15L, 8L),
    (5L, 8L),
    (-5L, 8L),
  ])
  let q = rc_path([(-5L, 2L), (5L, 2L)])
  assert_eq(
    @moonclip.rect_clip_lines(rc_window(), [p, q]),
    Ok([
      rc_path([(0L, 2L), (5L, 2L), (10L, 2L)]),
      rc_path([(10L, 8L), (5L, 8L), (0L, 8L)]),
      rc_path([(0L, 2L), (5L, 2L)]),
    ]),
  )
}

///|
test "rect clip lines: open route is not implicitly closed" {
  let p = rc_path([(2L, 2L), (8L, 2L), (8L, 8L)])
  assert_eq(@moonclip.rect_clip_lines(rc_window(), [p]), Ok([p]))
  p.push(@moonclip.Point64::new(2L, 2L))
  assert_eq(@moonclip.rect_clip_lines(rc_window(), [p]), Ok([p]))
}

///|
test "rect clip lines: empty single repeated and zero area have no isolated outputs" {
  assert_eq(
    @moonclip.rect_clip_lines(rc_window(), [
      [],
      rc_path([(5L, 5L)]),
      rc_path([(5L, 5L), (5L, 5L)]),
    ]),
    Ok([]),
  )
  let windows : Array[@moonclip.Bounds64] = [
    { min_x: 0L, min_y: 0L, max_x: 0L, max_y: 10L, },
    { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 0L, },
  ]
  for r in windows {
    assert_eq(
      @moonclip.rect_clip_lines(r, [rc_path([(-5L, 5L), (15L, 5L)])]),
      Ok([]),
    )
  }
}

///|
test "rect clip lines: window rejects reversed bounds and Int64 extremes safely" {
  assert_true(
    @moonclip.rect_clip_lines(
      { min_x: 1L, min_y: 0L, max_x: 0L, max_y: 10L, },
      [],
    )
    is Err(InvalidInput({ stage: RectClipParameters, .. }, _)),
  )
  for
    x in [
      -9223372036854775808L, 9223372036854775807L, -1000000001L, 1000000001L,
    ] {
    assert_true(
      @moonclip.rect_clip_lines(
        { min_x: x, min_y: 0L, max_x: 10L, max_y: 10L, },
        [],
      )
      is Err(
        CoordinateOutOfRange(
          { stage: RectClipParameters, path_index: None, vertex_index: None, },
          X,
          _
        )
      ),
    )
  }
}

///|
test "rect clip lines: zero area still validates raw coordinates and original index" {
  let r : @moonclip.Bounds64 = { min_x: 0L, min_y: 0L, max_x: 0L, max_y: 10L, }
  assert_true(
    @moonclip.rect_clip_lines(r, [[], rc_path([(0L, 0L), (1000000001L, 0L)])])
    is Err(
      CoordinateOutOfRange(
        {
          stage: RectClipParameters,
          path_index: Some(1),
          vertex_index: Some(1),
        },
        X,
        _
      )
    ),
  )
}

///|
test "rect clip lines: raw paths and duplicate vertices consume input allowance" {
  assert_true(
    @moonclip.rect_clip_lines(rc_window(), [[], []], limits={
      max_input_paths: 1,
      max_input_vertices: 10,
    })
    is Err(
      ResourceLimitExceeded(
        { stage: RectClipParameters, path_index: Some(1), .. },
        InputPaths,
        1
      )
    ),
  )
  assert_true(
    @moonclip.rect_clip_lines(
      rc_window(),
      [rc_path([(1L, 1L), (1L, 1L), (1L, 1L)])],
      limits={ max_input_paths: 1, max_input_vertices: 2, },
    )
    is Err(
      ResourceLimitExceeded(
        {
          stage: RectClipParameters,
          path_index: Some(0),
          vertex_index: Some(2),
        },
        InputVertices,
        2
      )
    ),
  )
  assert_true(
    @moonclip.rect_clip_lines(rc_window(), [], limits={
      max_input_paths: -1,
      max_input_vertices: 0,
    })
    is Err(InvalidInput(_, _)),
  )
}

///|
test "rect clip lines: input output arrays are isolated and repeated calls deterministic" {
  let path = rc_path([(1L, 1L), (5L, 5L), (9L, 9L)])
  let input = [path]
  let original = @moonclip.copy_paths(input)
  let result = @moonclip.rect_clip_lines(rc_window(), input)
  assert_eq(result, Ok(original))
  guard result is Ok(output) else { fail("clip failed") }
  output[0][0] = @moonclip.Point64::new(7L, 7L)
  output.push([])
  assert_eq(input, original)
  assert_eq(@moonclip.rect_clip_lines(rc_window(), input), Ok(original))
  path[0] = @moonclip.Point64::new(2L, 2L)
  assert_eq(output[0][0], @moonclip.Point64::new(7L, 7L))
}

///|
test "rect clip lines: fractional intersections truncate toward zero including negatives" {
  assert_eq(
    @moonclip.rect_clip_lines(rc_window(), [rc_path([(-2L, 0L), (2L, 1L)])]),
    Ok([rc_path([(0L, 0L), (2L, 1L)])]),
  )
  let r : @moonclip.Bounds64 = { min_x: -1L, min_y: -2L, max_x: 1L, max_y: 1L, }
  assert_eq(
    @moonclip.rect_clip_lines(r, [rc_path([(-2L, -1L), (2L, 0L)])]),
    Ok([rc_path([(-1L, 0L), (1L, 0L)])]),
  )
}
