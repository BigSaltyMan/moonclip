// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal rect clip lines: ordered complete fragment retains collinear vertex" {
  let rect : @moonclip.BoundsD = {
    min_x: -1.25,
    min_y: -0.5,
    max_x: 2.75,
    max_y: 2.5,
  }
  let paths = [
    [
      @moonclip.PointD::new(-2.0, 0.25),
      @moonclip.PointD::new(0.5, 0.25),
      @moonclip.PointD::new(3.0, 0.25),
    ],
  ]
  let saved = @moonclip.copy_paths_d(paths)
  let result = @moonclip.rect_clip_lines_d(
    rect,
    paths,
    precision=dd_precision(2),
  ).unwrap()
  assert_eq(result, [
    [
      @moonclip.PointD::new(-1.25, 0.25),
      @moonclip.PointD::new(0.5, 0.25),
      @moonclip.PointD::new(2.75, 0.25),
    ],
  ])
  result[0][0] = @moonclip.PointD::new(99.0, 99.0)
  result.push([])
  assert_eq(paths, saved)
}

///|
test "decimal rect clip lines: collapsed window and empty-window collision diagnostics" {
  let rect : @moonclip.BoundsD = {
    min_x: 0.1,
    min_y: 0.0,
    max_x: 0.2,
    max_y: 1.0,
  }
  assert_true(
    @moonclip.rect_clip_lines_d(rect, [], precision=dd_precision(0))
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
  assert_true(
    @moonclip.rect_clip_lines_d(
      zero,
      [[@moonclip.PointD::new(0.001, 0.0), @moonclip.PointD::new(0.002, 0.0)]],
      precision=dd_precision(2),
    )
    is Err(
      QuantizationFailure(
        { stage: DecimalQuantize, path_index: Some(0), vertex_index: Some(1), },
        None,
        Some(
          {
            stage: DecimalQuantize,
            path_index: Some(0),
            vertex_index: Some(0),
          }
        ),
        _
      )
    ),
  )
}
