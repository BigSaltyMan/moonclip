// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal closed stroke: full miter frame default precision and isolation" {
  let path = dd_box(0.0, 0.0, 1.0, 1.0)
  let expected = [
    dd_box(-0.1, -0.1, 1.1, 1.1),
    [
      @moonclip.PointD::new(0.1, 0.1),
      @moonclip.PointD::new(0.1, 0.9),
      @moonclip.PointD::new(0.9, 0.9),
      @moonclip.PointD::new(0.9, 0.1),
    ],
  ]
  let result = @moonclip.stroke_closed_polyline_d(
    path,
    0.2,
    precision=dd_precision(2),
  ).unwrap()
  assert_eq(dd_canonical(result), dd_canonical(expected))
  assert_eq(
    @moonclip.stroke_closed_polyline_d(path, 0.2).map(dd_canonical),
    Ok(dd_canonical(expected)),
  )
  path[0] = @moonclip.PointD::new(9.0, 9.0)
  path.push(@moonclip.PointD::new(8.0, 8.0))
  assert_eq(dd_canonical(result), dd_canonical(expected))
  let saved = path.copy()
  result[0][0] = @moonclip.PointD::new(7.0, 7.0)
  result.push([])
  assert_eq(path, saved)
}

///|
test "decimal closed stroke: bevel seam repeated start collision and collinear acceptance" {
  let path = dd_box(0.0, 0.0, 1.0, 1.0)
  let options = @moonclip.OffsetOptions::new(join=@moonclip.Bevel)
  let expected = [
    [
      @moonclip.PointD::new(0.0, -0.1),
      @moonclip.PointD::new(1.0, -0.1),
      @moonclip.PointD::new(1.1, 0.0),
      @moonclip.PointD::new(1.1, 1.0),
      @moonclip.PointD::new(1.0, 1.1),
      @moonclip.PointD::new(0.0, 1.1),
      @moonclip.PointD::new(-0.1, 1.0),
      @moonclip.PointD::new(-0.1, 0.0),
    ],
    [
      @moonclip.PointD::new(0.1, 0.1),
      @moonclip.PointD::new(0.1, 0.9),
      @moonclip.PointD::new(0.9, 0.9),
      @moonclip.PointD::new(0.9, 0.1),
    ],
  ]
  assert_eq(
    @moonclip.stroke_closed_polyline_d(
      path,
      0.2,
      precision=dd_precision(2),
      options~,
    ).map(dd_canonical),
    Ok(dd_canonical(expected)),
  )
  path.push(path[0])
  assert_eq(
    @moonclip.stroke_closed_polyline_d(
      path,
      0.2,
      precision=dd_precision(2),
      options~,
    ).map(dd_canonical),
    Ok(dd_canonical(expected)),
  )
  assert_true(
    @moonclip.stroke_closed_polyline_d(
      [
        @moonclip.PointD::new(0.001, 0.0),
        @moonclip.PointD::new(0.002, 0.0),
        @moonclip.PointD::new(1.0, 1.0),
      ],
      0.2,
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
  // Acceptance only: this does not establish the complete shape of a retraced stroke.
  assert_true(
    @moonclip.stroke_closed_polyline_d(
      [
        @moonclip.PointD::new(0.0, 0.0),
        @moonclip.PointD::new(1.0, 0.0),
        @moonclip.PointD::new(2.0, 0.0),
      ],
      0.2,
      precision=dd_precision(2),
    )
    is Ok(_),
  )
}
