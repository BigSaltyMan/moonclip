// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "stroke batch: overlapping routes merge with independent storage" {
  let paths = [st_path([(0L, 0L), (10L, 0L)]), st_path([(5L, 0L), (15L, 0L)])]
  let result = @moonclip.stroke_polylines(paths, 2.0).unwrap()
  assert_eq(bb_canonical(result), bb_canonical([bb_rect(0L, -1L, 15L, 2L)]))
  paths[0][0] = @moonclip.Point64::new(99L, 99L)
  paths.push([])
  assert_eq(bb_canonical(result), bb_canonical([bb_rect(0L, -1L, 15L, 2L)]))
  result[0][0] = @moonclip.Point64::new(88L, 88L)
  result.push([])
  assert_eq(paths[1], st_path([(5L, 0L), (15L, 0L)]))
  assert_eq(paths[0].length(), 2)
}

///|
test "stroke batch: raw batch rejection includes sub-grid calls" {
  let invalid = [st_line(), st_path([(0L, 0L), (1000000001L, 0L)])]
  for width in [2.0, 0.5] {
    assert_true(
      @moonclip.stroke_polylines(invalid, width)
      is Err(
        CoordinateOutOfRange(
          { stage: StrokeGenerate, path_index: Some(1), vertex_index: Some(1), },
          X,
          1000000001L
        )
      ),
    )
  }
  assert_true(
    @moonclip.stroke_polylines([st_line(), st_line()], 2.0, limits={
      max_input_paths: 2,
      max_input_vertices: 3,
    })
    is Err(ResourceLimitExceeded(_, InputVertices, 3)),
  )
}
