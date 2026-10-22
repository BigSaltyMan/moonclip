// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "decimal minkowski: two-point pattern gives complete rectangle and isolated output" {
  let pattern = [
    @moonclip.PointD::new(0.0, -0.25),
    @moonclip.PointD::new(0.0, 0.25),
  ]
  let path = [@moonclip.PointD::new(-1.0, 0.0), @moonclip.PointD::new(1.0, 0.0)]
  let result = @moonclip.minkowski_sum_d(pattern, path, false).unwrap()
  assert_eq(dd_canonical(result), [dd_box(-1.0, -0.25, 1.0, 0.25)])
  pattern[0] = @moonclip.PointD::new(9.0, 9.0)
  path[0] = @moonclip.PointD::new(8.0, 8.0)
  assert_eq(dd_canonical(result), [dd_box(-1.0, -0.25, 1.0, 0.25)])
  result[0][0] = @moonclip.PointD::new(7.0, 7.0)
  result.push([])
  assert_eq(pattern[0], @moonclip.PointD::new(9.0, 9.0))
  assert_eq(path[0], @moonclip.PointD::new(8.0, 8.0))
  assert_eq((pattern.length(), path.length()), (2, 2))
}

///|
test "decimal minkowski: shared quantization collision and translated coordinate overflow" {
  assert_true(
    @moonclip.minkowski_sum_d(
      [@moonclip.PointD::new(0.0001, 0.0)],
      [@moonclip.PointD::new(0.0002, 0.0)],
      false,
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
    @moonclip.minkowski_sum_d(
      [
        @moonclip.PointD::new(600000.0, -0.25),
        @moonclip.PointD::new(600000.0, 0.25),
      ],
      [
        @moonclip.PointD::new(600000.0, 0.0),
        @moonclip.PointD::new(600001.0, 0.0),
      ],
      false,
    )
    is Err(
      DecimalCoordinateOutOfRange(
        {
          stage: MinkowskiGenerate,
          path_index: Some(1),
          vertex_index: Some(0),
        },
        X,
        1200000.0,
        3
      )
    ),
  )
}
