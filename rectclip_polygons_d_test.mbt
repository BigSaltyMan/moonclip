// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal rect clip polygons: complete clipped rectangle and hole with isolated output" {
  let rect : @moonclip.BoundsD = {
    min_x: -1.25,
    min_y: -0.5,
    max_x: 2.75,
    max_y: 2.5,
  }
  let paths = [dd_box(-2.0, -1.0, 4.0, 4.0), dd_box(0.0, 0.0, 1.0, 1.0)]
  let saved = @moonclip.copy_paths_d(paths)
  let result = @moonclip.rect_clip_polygons_d(
    rect,
    paths,
    precision=dd_precision(2),
  ).unwrap()
  let hole = [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(0.0, 1.0),
    @moonclip.PointD::new(1.0, 1.0),
    @moonclip.PointD::new(1.0, 0.0),
  ]
  assert_eq(
    dd_canonical(result),
    dd_canonical([dd_box(-1.25, -0.5, 2.75, 2.5), hole]),
  )
  result[0][0] = @moonclip.PointD::new(99.0, 99.0)
  result.push([])
  assert_eq(paths, saved)
}

///|
test "decimal rect clip polygons: collapsed grid window differs from raw empty window" {
  let rect : @moonclip.BoundsD = {
    min_x: 0.1,
    min_y: 0.0,
    max_x: 0.2,
    max_y: 1.0,
  }
  assert_true(
    @moonclip.rect_clip_polygons_d(rect, [], precision=dd_precision(0))
    is Err(
      QuantizationFailure(
        { stage: DecimalQuantize, path_index: None, vertex_index: None, },
        None,
        None,
        _
      )
    ),
  )
  let zero : @moonclip.BoundsD = { ..rect, max_x: 0.1, }
  // Closed-grid validity remains mandatory even when the original window is empty.
  assert_true(
    @moonclip.rect_clip_polygons_d(zero, [[@moonclip.PointD::new(0.0, 0.0)]])
    is Err(
      QuantizationFailure(
        { stage: DecimalQuantize, path_index: Some(0), vertex_index: None, },
        None,
        None,
        _
      )
    ),
  )
}
