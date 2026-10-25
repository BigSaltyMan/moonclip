// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "closed stroke: miter frame seam and independent storage" {
  let path = bb_rect(0L, 0L, 10L, 10L)
  let expected = [
    bb_rect(-1L, -1L, 12L, 12L),
    bb_reverse(bb_rect(1L, 1L, 8L, 8L)),
  ]
  let result = @moonclip.stroke_closed_polyline(path, 2.0).unwrap()
  assert_eq(bb_canonical(result), bb_canonical(expected))
  let repeated = path.copy()
  repeated.push(path[0])
  repeated.push(path[0])
  assert_eq(
    @moonclip.stroke_closed_polyline(repeated, 2.0).map(bb_canonical),
    Ok(bb_canonical(expected)),
  )
  path[0] = @moonclip.Point64::new(99L, 99L)
  assert_eq(bb_canonical(result), bb_canonical(expected))
  let saved = path.copy()
  result[0][0] = @moonclip.Point64::new(98L, 98L)
  result.push([])
  assert_eq(path, saved)
}

///|
test "closed stroke: bevel seam and reversal keep complete coverage" {
  let path = bb_rect(0L, 0L, 10L, 10L)
  let expected = [
    st_path([
      (0L, -1L),
      (10L, -1L),
      (11L, 0L),
      (11L, 10L),
      (10L, 11L),
      (0L, 11L),
      (-1L, 10L),
      (-1L, 0L),
    ]),
    bb_reverse(bb_rect(1L, 1L, 8L, 8L)),
  ]
  let options = @moonclip.OffsetOptions::new(join=@moonclip.Bevel)
  assert_eq(
    @moonclip.stroke_closed_polyline(path, 2.0, options~).map(bb_canonical),
    Ok(bb_canonical(expected)),
  )
  assert_eq(
    @moonclip.stroke_closed_polyline(bb_reverse(path), 2.0, options~).map(
      bb_canonical,
    ),
    Ok(bb_canonical(expected)),
  )
}
