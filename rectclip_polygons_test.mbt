// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "rect clip polygons: complete region distinguishes parity and nonzero" {
  let paths = [bb_rect(-2L, -2L, 14L, 14L), bb_rect(3L, 3L, 4L, 4L)]
  let saved = @moonclip.copy_paths(paths)
  let result = @moonclip.rect_clip_polygons(rc_window(), paths).unwrap()
  assert_eq(
    bb_canonical(result),
    bb_canonical([
      bb_rect(0L, 0L, 10L, 10L),
      bb_reverse(bb_rect(3L, 3L, 4L, 4L)),
    ]),
  )
  assert_eq(
    bb_canonical(
      @moonclip.rect_clip_polygons(rc_window(), paths, fill_rule=NonZero).unwrap(),
    ),
    bb_canonical([bb_rect(0L, 0L, 10L, 10L)]),
  )
  result[0][0] = @moonclip.Point64::new(99L, 99L)
  result.push([])
  assert_eq(paths, saved)
}

///|
test "rect clip polygons: internal window is excluded from raw limits" {
  assert_eq(
    bb_canonical(
      @moonclip.rect_clip_polygons(rc_window(), [bb_rect(-2L, -2L, 14L, 14L)], limits={
        max_input_paths: 1,
        max_input_vertices: 4,
      }).unwrap(),
    ),
    bb_canonical([bb_rect(0L, 0L, 10L, 10L)]),
  )
  let zero : @moonclip.Bounds64 = { ..rc_window(), max_x: 0L, }
  assert_true(
    @moonclip.rect_clip_polygons(zero, [
      [@moonclip.Point64::new(1000000001L, 0L)],
    ])
    is Err(
      CoordinateOutOfRange(
        {
          stage: RectClipParameters,
          path_index: Some(0),
          vertex_index: Some(0),
        },
        X,
        1000000001L
      )
    ),
  )
  assert_true(
    @moonclip.rect_clip_polygons({ ..rc_window(), min_x: 11L, }, [])
    is Err(
      InvalidInput(
        { stage: RectClipParameters, path_index: None, vertex_index: None, },
        "Rectangle minimum exceeds maximum"
      )
    ),
  )
}
