// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "line clip: ordered hole fragments and independent storage" {
  let paths = [st_path([(-2L, 5L), (2L, 5L), (5L, 5L), (12L, 5L)])]
  // Clockwise hole, so the same hand-written region works with both rules.
  let clip = [
    bb_rect(0L, 0L, 10L, 10L),
    st_path([(3L, 3L), (3L, 7L), (7L, 7L), (7L, 3L)]),
  ]
  let saved_paths = @moonclip.copy_paths(paths)
  let saved_clip = @moonclip.copy_paths(clip)
  let expected = [
    st_path([(0L, 5L), (2L, 5L), (3L, 5L)]),
    st_path([(7L, 5L), (10L, 5L)]),
  ]
  for rule in [@moonclip.EvenOdd, @moonclip.NonZero] {
    let result = @moonclip.intersect_polylines(paths, clip, fill_rule=rule).unwrap()
    assert_eq(result, expected)
    result[0][0] = @moonclip.Point64::new(99L, 99L)
    result.push([])
    assert_eq(paths, saved_paths)
    assert_eq(clip, saved_clip)
  }
}

///|
test "line clip: included boundary cancelled region and rational crossings" {
  let rect = bb_rect(0L, 0L, 10L, 10L)
  assert_eq(
    @moonclip.intersect_polylines([st_path([(-2L, 0L), (5L, 0L), (12L, 0L)])], [
      rect,
    ]),
    Ok([st_path([(0L, 0L), (5L, 0L), (10L, 0L)])]),
  )
  assert_eq(
    @moonclip.intersect_polylines([st_path([(-1L, 1L), (1L, -1L)])], [rect]),
    Ok([]),
  )
  assert_eq(
    @moonclip.intersect_polylines([st_path([(-1L, 0L), (11L, 0L)])], [
      rect, rect,
    ]),
    Ok([]),
  )
  assert_eq(
    @moonclip.intersect_polylines([st_path([(-1L, 1L), (4L, 3L)])], [
      st_path([(0L, 0L), (5L, 0L), (0L, 5L)]),
    ]),
    Ok([st_path([(0L, 1L), (3L, 2L)])]),
  )
}
