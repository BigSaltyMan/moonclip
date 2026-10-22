// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal stroke batch: complete merged rectangle and isolated storage" {
  let first = [
    @moonclip.PointD::new(-1.0, 0.0),
    @moonclip.PointD::new(1.0, 0.0),
  ]
  let second = [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(2.0, 0.0),
  ]
  // Aliased input routes are legal and must not alias the output.
  let paths = [first, second, first]
  let result = @moonclip.stroke_polylines_d(
    paths,
    0.5,
    precision=dd_precision(2),
  ).unwrap()
  assert_eq(dd_canonical(result), [dd_box(-1.0, -0.25, 2.0, 0.25)])
  first[0] = @moonclip.PointD::new(9.0, 9.0)
  paths.push([])
  assert_eq(dd_canonical(result), [dd_box(-1.0, -0.25, 2.0, 0.25)])
  result[0][0] = @moonclip.PointD::new(8.0, 8.0)
  result.push([])
  assert_eq(second, [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(2.0, 0.0),
  ])
  assert_eq(paths[2][0], @moonclip.PointD::new(9.0, 9.0))
  assert_eq(first.length(), 2)
}

///|
test "decimal stroke batch: aggregate limits and zero-width collision location" {
  let paths = [
    [@moonclip.PointD::new(-1.0, 0.0), @moonclip.PointD::new(1.0, 0.0)],
    [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(2.0, 0.0)],
  ]
  assert_true(
    @moonclip.stroke_polylines_d(paths, 0.5, limits={
      max_input_paths: 2,
      max_input_vertices: 3,
    })
    is Err(ResourceLimitExceeded(_, InputVertices, 3)),
  )
  // Distinct positions across routes collide in the shared grid, even at width zero.
  paths[0][0] = @moonclip.PointD::new(0.001, 0.0)
  paths[1][0] = @moonclip.PointD::new(0.002, 0.0)
  assert_true(
    @moonclip.stroke_polylines_d(paths, 0.0, precision=dd_precision(2))
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
}
