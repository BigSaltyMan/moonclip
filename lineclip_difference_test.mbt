// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "line difference: ordered hole fragments and independent storage" {
  let paths = [st_path([(-2L, 5L), (2L, 5L), (5L, 5L), (12L, 5L)])]
  let clip = [
    bb_rect(0L, 0L, 10L, 10L),
    st_path([(3L, 3L), (3L, 7L), (7L, 7L), (7L, 3L)]),
  ]
  let expected = [
    st_path([(-2L, 5L), (0L, 5L)]),
    st_path([(3L, 5L), (5L, 5L), (7L, 5L)]),
    st_path([(10L, 5L), (12L, 5L)]),
  ]
  let result = @moonclip.difference_polylines(paths, clip).unwrap()
  assert_eq(result, expected)
  assert_eq(
    @moonclip.intersect_polylines(paths, clip),
    Ok([st_path([(0L, 5L), (2L, 5L), (3L, 5L)]), st_path([(7L, 5L), (10L, 5L)])]),
  )
  paths[0][0] = @moonclip.Point64::new(-99L, 0L)
  clip[0][0] = @moonclip.Point64::new(-98L, 0L)
  assert_eq(result, expected)
  let saved_paths = @moonclip.copy_paths(paths)
  let saved_clip = @moonclip.copy_paths(clip)
  result[0][0] = @moonclip.Point64::new(99L, 99L)
  result.push([])
  assert_eq(paths, saved_paths)
  assert_eq(clip, saved_clip)
}

///|
test "line difference: erased boundary isolated tangent and rational cuts" {
  let rect = bb_rect(0L, 0L, 10L, 10L)
  assert_eq(
    @moonclip.difference_polylines([st_path([(0L, 0L), (10L, 0L)])], [rect]),
    Ok([]),
  )
  // Both adjacent intervals are exterior: touching a single point does not split.
  let tangent = st_path([(-1L, 1L), (0L, 0L), (1L, -1L)])
  assert_eq(@moonclip.difference_polylines([tangent], [rect]), Ok([tangent]))
  assert_eq(
    @moonclip.difference_polylines([st_path([(-1L, 1L), (4L, 3L)])], [
      st_path([(0L, 0L), (5L, 0L), (0L, 5L)]),
    ]),
    Ok([st_path([(-1L, 1L), (0L, 1L)]), st_path([(3L, 2L), (4L, 3L)])]),
  )
}
