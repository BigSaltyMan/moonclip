// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal line clip: ordered hole fragments and two-way isolation" {
  let paths = [
    [
      @moonclip.PointD::new(-0.2, 0.5),
      @moonclip.PointD::new(0.2, 0.5),
      @moonclip.PointD::new(0.5, 0.5),
      @moonclip.PointD::new(1.2, 0.5),
    ],
  ]
  let clip = [dd_box(0.0, 0.0, 1.0, 1.0), dd_box(0.3, 0.3, 0.7, 0.7)]
  let expected = [
    [
      @moonclip.PointD::new(0.0, 0.5),
      @moonclip.PointD::new(0.2, 0.5),
      @moonclip.PointD::new(0.3, 0.5),
    ],
    [@moonclip.PointD::new(0.7, 0.5), @moonclip.PointD::new(1.0, 0.5)],
  ]
  let result = @moonclip.intersect_polylines_d(
    paths,
    clip,
    precision=dd_precision(2),
  ).unwrap()
  assert_eq(result, expected)
  paths[0][0] = @moonclip.PointD::new(9.0, 9.0)
  paths.push([])
  clip[0][0] = @moonclip.PointD::new(8.0, 8.0)
  clip.push([])
  assert_eq(result, expected)
  let saved_paths = @moonclip.copy_paths_d(paths)
  let saved_clip = @moonclip.copy_paths_d(clip)
  result[0][0] = @moonclip.PointD::new(7.0, 7.0)
  result.push([])
  assert_eq(paths, saved_paths)
  assert_eq(clip, saved_clip)
}

///|
test "decimal line clip: mixed quantization and combined error locations" {
  let routes = [
    [@moonclip.PointD::new(-0.2, 0.5), @moonclip.PointD::new(1.2, 0.5)],
  ]
  let box = dd_box(0.0, 0.0, 1.0, 1.0)
  assert_eq(
    @moonclip.intersect_polylines_d(routes, [box]),
    Ok([[@moonclip.PointD::new(0.0, 0.5), @moonclip.PointD::new(1.0, 0.5)]]),
  )
  assert_true(
    @moonclip.intersect_polylines_d(
      [[@moonclip.PointD::new(0.001, 0.0), @moonclip.PointD::new(0.5, 0.5)]],
      [dd_box(0.002, 0.0, 1.0, 1.0)],
      precision=dd_precision(2),
    )
    is Err(
      QuantizationFailure(
        { stage: DecimalQuantize, path_index: Some(1), vertex_index: Some(0), },
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
  assert_true(
    // Three distinct real positions become collinear, without a collision.
    @moonclip.intersect_polylines_d(
      routes,
      [
        [
          @moonclip.PointD::new(0.0, 0.0),
          @moonclip.PointD::new(0.5, 0.0),
          @moonclip.PointD::new(1.0, 0.001),
        ],
      ],
      precision=dd_precision(2),
    )
    is Err(
      QuantizationFailure(
        { stage: DecimalQuantize, path_index: Some(1), vertex_index: None, },
        None,
        None,
        _
      )
    ),
  )
  assert_true(
    @moonclip.intersect_polylines_d([[@moonclip.PointD::new(1000001.0, 0.0)]], [])
    is Err(
      DecimalCoordinateOutOfRange(
        { stage: DecimalQuantize, path_index: Some(0), vertex_index: Some(0), },
        X,
        1000001.0,
        3
      )
    ),
  )
}
