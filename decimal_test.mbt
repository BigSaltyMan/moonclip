// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn dd_precision(digits : Int) -> @moonclip.Precision {
  @moonclip.Precision::new(digits).unwrap()
}

///|
fn dd_box(
  x1 : Double,
  y1 : Double,
  x2 : Double,
  y2 : Double,
) -> @moonclip.PathD {
  [
    @moonclip.PointD::new(x1, y1),
    @moonclip.PointD::new(x2, y1),
    @moonclip.PointD::new(x2, y2),
    @moonclip.PointD::new(x1, y2),
  ]
}

///|
fn dd_compare(a : @moonclip.PathD, b : @moonclip.PathD) -> Int {
  for i = 0; i < a.length() && i < b.length(); i = i + 1 {
    if a[i].x != b[i].x {
      return if a[i].x < b[i].x { -1 } else { 1 }
    }
    if a[i].y != b[i].y {
      return if a[i].y < b[i].y { -1 } else { 1 }
    }
  }
  a.length() - b.length()
}

///|
fn dd_canonical(paths : @moonclip.PathsD) -> @moonclip.PathsD {
  let result = paths.map(fn(path) {
    let mut best = path.copy()
    for start = 1; start < path.length(); start = start + 1 {
      let candidate = Array::makei(path.length(), fn(i) {
        path[(start + i) % path.length()]
      })
      if dd_compare(candidate, best) < 0 {
        best = candidate
      }
    }
    best
  })
  for i = 1; i < result.length(); i = i + 1 {
    let mut j = i
    while j > 0 && dd_compare(result[j], result[j - 1]) < 0 {
      let temp = result[j]
      result[j] = result[j - 1]
      result[j - 1] = temp
      j -= 1
    }
  }
  result
}

///|
fn dd_equal(
  actual : @moonclip.PathsD,
  expected : @moonclip.PathsD,
) -> Unit raise {
  assert_eq(dd_canonical(actual), dd_canonical(expected))
}

///|
fn dd_boolean(
  a : @moonclip.PathsD,
  b : @moonclip.PathsD,
  operation? : @moonclip.ClipType = @moonclip.Union,
  precision? : @moonclip.Precision = Default::default(),
) -> @moonclip.PathsD raise {
  guard @moonclip.boolean_op_d(
      a,
      b,
      operation,
      precision~,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(value) else {
    fail("Expected decimal Boolean result")
  }
  value
}

///|
fn dd_offset(
  a : @moonclip.PathsD,
  delta : Double,
  precision? : @moonclip.Precision = Default::default(),
) -> @moonclip.PathsD raise {
  guard @moonclip.offset_polygons_d(a, delta, precision~) is Ok(value) else {
    fail("Expected decimal offset result")
  }
  value
}

///|
test "decimal type 01 raw immutable coordinates preserve Double values" {
  let p = @moonclip.PointD::new(-0.0, @double.not_a_number)
  assert_true(1.0 / p.x < 0.0)
  assert_true(p.y.is_nan())
  let q = @moonclip.PointD::new(@double.infinity, -2.25)
  assert_true(q.x.is_inf())
  assert_eq(q.y, -2.25)
}

///|
test "decimal type 02 field equality has no epsilon" {
  let p = @moonclip.PointD::new(1.0, 2.0)
  assert_eq(p, @moonclip.PointD::new(1.0, 2.0))
  assert_true(p != @moonclip.PointD::new(1.0000000000000002, 2.0))
  assert_true(p != @moonclip.PointD::new(1.0, 2.0000000000000004))
}

///|
test "decimal type 03 containers preserve order and degenerate raw input" {
  let a = @moonclip.PointD::new(0.1, -0.2)
  let b = @moonclip.PointD::new(2.0, 3.0)
  let paths : @moonclip.PathsD = [[], [a], [a, b], [a, a, b, a]]
  assert_eq(paths.length(), 4)
  assert_eq(paths[3], [a, a, b, a])
  assert_true(paths != [[], [a], [b, a], [a, a, b, a]])
}

///|
test "decimal type 04 path copy source mutation is isolated" {
  let path = dd_box(0.1, 0.2, 1.1, 1.2)
  let copy = @moonclip.copy_path_d(path)
  path[0] = @moonclip.PointD::new(99.0, 99.0)
  assert_eq(copy[0], @moonclip.PointD::new(0.1, 0.2))
}

///|
test "decimal type 05 path copy reverse mutation is isolated" {
  let path = dd_box(0.1, 0.2, 1.1, 1.2)
  let copy = @moonclip.copy_path_d(path)
  copy.clear()
  assert_eq(path.length(), 4)
}

///|
test "decimal type 06 paths copy owns outer array" {
  let paths = [dd_box(0.0, 0.0, 1.0, 1.0)]
  let copy = @moonclip.copy_paths_d(paths)
  paths.push([])
  copy[0] = []
  assert_eq(paths.length(), 2)
  assert_eq(paths[0].length(), 4)
  assert_eq(copy.length(), 1)
}

///|
test "decimal type 07 aliases receive independently owned inner copies" {
  let path = dd_box(0.0, 0.0, 1.0, 1.0)
  let copy = @moonclip.copy_paths_d([path, path])
  copy[0].clear()
  assert_eq(copy[1], path)
  assert_eq(path.length(), 4)
}

///|
test "decimal type 08 repeated and empty copies share no cache" {
  let a = @moonclip.copy_paths_d([])
  let b = @moonclip.copy_paths_d([])
  a.push([])
  assert_eq(b, [])
  let path = dd_box(0.0, 0.0, 1.0, 1.0)
  let first = @moonclip.copy_path_d(path)
  let second = @moonclip.copy_path_d(path)
  first.clear()
  assert_eq(second, path)
}

///|
test "decimal type 09 default precision is three" {
  let p : @moonclip.Precision = Default::default()
  assert_eq(p.digits(), 3)
  assert_eq(p, dd_precision(3))
}

///|
test "decimal type 10 all seven precision values are constructible" {
  for d = 0; d <= 6; d = d + 1 {
    assert_eq(dd_precision(d).digits(), d)
  }
}

///|
test "decimal type 11 invalid precisions return structured parameter error" {
  for d in [-2147483648, -1, 7, 2147483647] {
    assert_true(
      @moonclip.Precision::new(d)
      is Err(
        @moonclip.InvalidInput(
          {
            stage: @moonclip.DecimalParameters,
            path_index: None,
            vertex_index: None,
          },
          _
        )
      ),
    )
  }
}

///|
test "decimal type 12 one precision object holds no execution state" {
  let p = dd_precision(2)
  let input = [dd_box(-1.25, -0.25, 2.25, 1.25)]
  let first = dd_boolean(input, [], precision=p)
  assert_eq(p.digits(), 2)
  dd_equal(dd_boolean(input, [], precision=p), first)
}

///|
test "decimal quantize 01 both signed half ties use away from zero" {
  dd_equal(
    dd_boolean([dd_box(0.5, -1.5, 3.5, 2.5)], [], precision=dd_precision(0)),
    [dd_box(1.0, -2.0, 4.0, 3.0)],
  )
}

///|
test "decimal quantize 02 signed zero input repeats are one original position" {
  let path = dd_box(-0.0, -0.0, 1.0, 1.0)
  path.push(@moonclip.PointD::new(0.0, 0.0))
  let output = dd_boolean([path], [])
  for ring in output {
    for p in ring {
      if p.x == 0.0 {
        assert_true(1.0 / p.x > 0.0)
      }
      if p.y == 0.0 {
        assert_true(1.0 / p.y > 0.0)
      }
    }
  }
  assert_true(1.0 / path[0].x < 0.0)
}

///|
test "decimal quantize 03 NaN reports raw axis and vertex" {
  assert_true(
    @moonclip.boolean_op_d(
      [[@moonclip.PointD::new(@double.not_a_number, 0.0)]],
      [],
      @moonclip.Union,
    )
    is Err(
      @moonclip.QuantizationFailure(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(0),
          vertex_index: Some(0),
        },
        Some(@moonclip.X),
        None,
        _
      )
    ),
  )
}

///|
test "decimal quantize 04 Infinity checked even for a zero-width stroke" {
  assert_true(
    @moonclip.stroke_polyline_d(
      [@moonclip.PointD::new(0.0, @double.infinity)],
      0.0,
    )
    is Err(
      @moonclip.QuantizationFailure(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(0),
          vertex_index: Some(0),
        },
        Some(@moonclip.Y),
        None,
        _
      )
    ),
  )
}

///|
test "decimal quantize 05 distinct locations within a path report first origin" {
  let path = [
    @moonclip.PointD::new(0.0001, 0.0),
    @moonclip.PointD::new(0.0002, 0.0),
    @moonclip.PointD::new(1.0, 1.0),
  ]
  assert_true(
    @moonclip.boolean_op_d([path], [], @moonclip.Union)
    is Err(
      @moonclip.QuantizationFailure(
        { path_index: Some(0), vertex_index: Some(1), .. },
        None,
        Some({ path_index: Some(0), vertex_index: Some(0), .. }),
        _
      )
    ),
  )
}

///|
test "decimal quantize 06 conflict index spans different contours" {
  let paths = [dd_box(0.0, 0.0, 1.0, 1.0), dd_box(0.0001, 0.0, 1.0001, 1.0)]
  assert_true(
    @moonclip.offset_polygons_d(paths, 0.0)
    is Err(
      @moonclip.QuantizationFailure(
        { path_index: Some(1), vertex_index: Some(0), .. },
        None,
        Some({ path_index: Some(0), vertex_index: Some(0), .. }),
        _
      )
    ),
  )
}

///|
test "decimal quantize 07 Boolean operands share one stable conflict index" {
  assert_true(
    @moonclip.boolean_op_d(
      [dd_box(0.0, 0.0, 1.0, 1.0)],
      [dd_box(0.0001, 0.0, 1.0001, 1.0)],
      @moonclip.Intersection,
    )
    is Err(
      @moonclip.QuantizationFailure(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(1),
          vertex_index: Some(0),
        },
        None,
        Some({ path_index: Some(0), vertex_index: Some(0), .. }),
        _
      )
    ),
  )
}

///|
test "decimal quantize 08 exact repeated positions are legal and input is retained" {
  let p = dd_box(0.0, 0.0, 1.0, 1.0)
  p.insert(1, p[0])
  p.push(p[0])
  let saved = p.copy()
  dd_equal(dd_boolean([p], []), [dd_box(0.0, 0.0, 1.0, 1.0)])
  assert_eq(p, saved)
}

///|
test "decimal quantize 09 closed empty allowed but one and two point rejected" {
  assert_eq(@moonclip.boolean_op_d([[]], [], @moonclip.Union), Ok([]))
  for
    p in [
      [@moonclip.PointD::new(0.0, 0.0)],
      [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(1.0, 1.0)],
    ] {
    assert_true(
      @moonclip.offset_polygons_d([p], 0.0)
      is Err(
        @moonclip.QuantizationFailure(
          {
            stage: @moonclip.DecimalQuantize,
            path_index: Some(0),
            vertex_index: None,
          },
          None,
          None,
          _
        )
      ),
    )
  }
}

///|
test "decimal quantize 10 quantized collinearity cannot silently remove input" {
  let triangle = [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(1.0, 0.0001),
    @moonclip.PointD::new(2.0, 0.0),
  ]
  assert_true(
    @moonclip.offset_polygons_d([triangle], 0.0)
    is Err(
      @moonclip.QuantizationFailure(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(0),
          vertex_index: None,
        },
        None,
        None,
        _
      )
    ),
  )
}

///|
test "decimal units 01 physical Boolean output uses requested decimal grid" {
  dd_equal(
    dd_boolean([dd_box(-1.25, -0.25, 1.25, 1.25)], [
      dd_box(0.25, -0.25, 2.25, 1.25),
    ]),
    [dd_box(-1.25, -0.25, 2.25, 1.25)],
  )
}

///|
test "decimal units 02 delta point two means two hundred grid units" {
  dd_equal(dd_offset([dd_box(0.0, 0.0, 10.0, 10.0)], 0.2), [
    dd_box(-0.2, -0.2, 10.2, 10.2),
  ])
}

///|
test "decimal units 03 full width point four yields point two each side" {
  guard @moonclip.stroke_polyline_d(
      [@moonclip.PointD::new(-1.0, 0.0), @moonclip.PointD::new(1.0, 0.0)],
      0.4,
    )
    is Ok(value) else {
    fail("stroke")
  }
  dd_equal(value, [dd_box(-1.0, -0.2, 1.0, 0.2)])
}

///|
test "decimal units 04 Round tolerance is scaled with distance" {
  let options = @moonclip.OffsetOptions::new(
    join=@moonclip.JoinType::Round,
    arc_tolerance=0.025,
  )
  guard @moonclip.offset_polygons_d(
      [dd_box(0.0, 0.0, 10.0, 10.0)],
      0.2,
      options~,
    )
    is Ok(actual) else {
    fail("decimal round")
  }
  guard @moonclip.offset_polygons(
      [cp_rect(0L, 0L, 10000L, 10000L)],
      200.0,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Round,
        arc_tolerance=25.0,
      ),
    )
    is Ok(grid) else {
    fail("integer round")
  }
  let expected = grid.map(fn(path) {
    path.map(fn(p) {
      @moonclip.PointD::new(p.x.to_double() / 1000.0, p.y.to_double() / 1000.0)
    })
  })
  dd_equal(actual, expected)
}

///|
test "decimal units 05 irrelevant valid options do not alter Miter geometry" {
  let input = [dd_box(0.0, 0.0, 1.0, 1.0)]
  assert_eq(
    @moonclip.offset_polygons_d(input, 0.2),
    @moonclip.offset_polygons_d(
      input,
      0.2,
      options=@moonclip.OffsetOptions::new(miter_limit=4.0, arc_tolerance=123.0),
    ),
  )
}

///|
test "decimal units 06 negative delta contracts in original units" {
  dd_equal(dd_offset([dd_box(0.0, 0.0, 1.0, 1.0)], -0.2), [
    dd_box(0.2, 0.2, 0.8, 0.8),
  ])
}

///|
test "decimal units 07 half-grid offset threshold remains fractional" {
  let input = [dd_box(0.0, 0.0, 1.0, 1.0)]
  dd_equal(dd_offset(input, 0.00049), input)
  dd_equal(dd_offset(input, 0.0005), [dd_box(-0.001, -0.001, 1.001, 1.001)])
}

///|
test "decimal units 08 subgrid width is empty only after validation" {
  let path = [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(1.0, 0.0)]
  assert_eq(@moonclip.stroke_polyline_d(path, 0.00099), Ok([]))
  guard @moonclip.stroke_polyline_d(path, 0.001) is Ok(value) else {
    fail("threshold")
  }
  dd_equal(value, [dd_box(0.0, -0.001, 1.0, 0.001)])
}

///|
test "decimal units 09 fractional scaled width is not truncated" {
  let path = [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(3.0, 4.0)]
  guard @moonclip.stroke_polyline_d(path, 0.00199) is Ok(value) else {
    fail("diagonal")
  }
  dd_equal(value, [
    [
      @moonclip.PointD::new(-0.001, 0.001),
      @moonclip.PointD::new(0.001, -0.001),
      @moonclip.PointD::new(3.001, 3.999),
      @moonclip.PointD::new(2.999, 4.001),
    ],
  ])
}

///|
test "decimal units 10 every precision accepts its inclusive coordinate boundary" {
  for
    (d, bound) in [
      (0, 1000000000.0),
      (1, 100000000.0),
      (2, 10000000.0),
      (3, 1000000.0),
      (4, 100000.0),
      (5, 10000.0),
      (6, 1000.0),
    ] {
    for sign in [-1.0, 1.0] {
      assert_eq(
        @moonclip.stroke_polyline_d(
          [@moonclip.PointD::new(sign * bound, sign * bound)],
          0.0,
          precision=dd_precision(d),
        ),
        Ok([]),
      )
    }
  }
}

///|
test "decimal units 11 generated Offset range error is back in original units" {
  assert_true(
    @moonclip.offset_polygons_d([dd_box(999999.99, 0.0, 1000000.0, 1.0)], 0.002)
    is Err(
      @moonclip.DecimalCoordinateOutOfRange(
        {
          stage: @moonclip.OffsetGenerate,
          path_index: None,
          vertex_index: None,
        },
        @moonclip.X,
        1000000.002,
        3
      )
    ),
  )
}

///|
test "decimal units 12 generated Stroke range retains Stroke context" {
  assert_true(
    @moonclip.stroke_polyline_d(
      [
        @moonclip.PointD::new(999.99999, 0.0),
        @moonclip.PointD::new(1000.0, 0.0),
      ],
      0.000004,
      precision=dd_precision(6),
      cap=@moonclip.CapType::Square,
    )
    is Err(
      @moonclip.DecimalCoordinateOutOfRange(
        {
          stage: @moonclip.StrokeGenerate,
          path_index: None,
          vertex_index: None,
        },
        @moonclip.X,
        1000.000002,
        6
      )
    ),
  )
}

///|
test "decimal units 13 slight raw overflow cannot round back inside" {
  let outside = 1000000.0000000001
  assert_true(
    @moonclip.stroke_polyline_d([@moonclip.PointD::new(outside, 0.0)], 0.0)
    is Err(
      @moonclip.DecimalCoordinateOutOfRange(
        {
          stage: @moonclip.DecimalQuantize,
          path_index: Some(0),
          vertex_index: Some(0),
        },
        @moonclip.X,
        v,
        3
      )
    ) &&
    v == outside,
  )
}

///|
test "decimal units 14 invalid widths rejected even on empty route" {
  for width in [-1.0, @double.not_a_number, @double.infinity] {
    assert_true(
      @moonclip.stroke_polyline_d([], width)
      is Err(
        @moonclip.InvalidInput({ stage: @moonclip.DecimalParameters, .. }, _)
      ),
    )
  }
}

///|
test "decimal units 15 parameter and options scaling must remain finite" {
  assert_true(
    @moonclip.offset_polygons_d([], 1.0e308, precision=dd_precision(6))
    is Err(
      @moonclip.NumericFailure({ stage: @moonclip.DecimalParameters, .. }, _)
    ),
  )
  assert_true(
    @moonclip.stroke_polyline_d(
      [],
      1.0,
      precision=dd_precision(6),
      options=@moonclip.OffsetOptions::new(arc_tolerance=1.0e308),
    )
    is Err(
      @moonclip.NumericFailure({ stage: @moonclip.DecimalParameters, .. }, _)
    ),
  )
  assert_true(
    @moonclip.offset_polygons_d(
      [],
      0.0,
      options=@moonclip.OffsetOptions::new(miter_limit=1.0),
    )
    is Err(
      @moonclip.InvalidInput({ stage: @moonclip.DecimalParameters, .. }, _)
    ),
  )
}

///|
test "decimal units 16 defaults preserve respective integer fill and cap rules" {
  let p = dd_box(0.0, 0.0, 1.0, 1.0)
  assert_eq(@moonclip.boolean_op_d([p, p], [], @moonclip.Union), Ok([]))
  dd_equal(dd_offset([p, p], 0.0), [p])
  let line = [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(1.0, 0.0)]
  assert_eq(
    @moonclip.stroke_polyline_d(line, 0.4),
    @moonclip.stroke_polyline_d(line, 0.4, cap=@moonclip.CapType::Butt),
  )
}

///|
test "decimal isolation 01 BooleanD then OffsetD uses real intermediate" {
  let p = dd_precision(3)
  let middle = dd_boolean(
    [dd_box(-1.0, -1.0, 1.0, 1.0)],
    [dd_box(0.0, -1.0, 2.0, 1.0)],
    precision=p,
  )
  dd_equal(middle, [dd_box(-1.0, -1.0, 2.0, 1.0)])
  dd_equal(dd_offset(middle, 0.2, precision=p), [dd_box(-1.2, -1.2, 2.2, 1.2)])
}

///|
test "decimal isolation 02 StrokeD then IntersectionD uses real coverage" {
  guard @moonclip.stroke_polyline_d(
      [@moonclip.PointD::new(-1.0, 0.0), @moonclip.PointD::new(3.0, 0.0)],
      0.4,
    )
    is Ok(coverage) else {
    fail("stroke")
  }
  dd_equal(
    dd_boolean(
      coverage,
      [dd_box(0.0, -1.0, 2.0, 1.0)],
      operation=@moonclip.Intersection,
    ),
    [dd_box(0.0, -0.2, 2.0, 0.2)],
  )
}

///|
test "decimal isolation 03 source mutation cannot change earlier result" {
  let input = [dd_box(0.0, 0.0, 1.0, 1.0)]
  let result = dd_offset(input, 0.2)
  input[0].clear()
  input.clear()
  dd_equal(result, [dd_box(-0.2, -0.2, 1.2, 1.2)])
}

///|
test "decimal isolation 04 result mutation cannot change source or other call" {
  let input = [dd_box(0.0, 0.0, 1.0, 1.0)]
  let saved = @moonclip.copy_paths_d(input)
  let first = dd_boolean(input, [])
  let second = dd_boolean(input, [])
  first[0].clear()
  first.clear()
  assert_eq(input, saved)
  dd_equal(second, saved)
}

///|
test "decimal isolation 05 aliased paths retain raw input ownership" {
  let p = dd_box(0.0, 0.0, 1.0, 1.0)
  let input = [p, p]
  let saved = @moonclip.copy_paths_d(input)
  let output = dd_offset(input, 0.2)
  output[0][0] = @moonclip.PointD::new(-99.0, -99.0)
  assert_eq(input, saved)
}

///|
test "decimal isolation 06 switching precision never mutates old output" {
  let input = [dd_box(0.25, 0.25, 1.25, 1.25)]
  let fine = dd_boolean(input, [], precision=dd_precision(3))
  let coarse = dd_boolean(input, [], precision=dd_precision(0))
  dd_equal(fine, input)
  dd_equal(coarse, [dd_box(0.0, 0.0, 1.0, 1.0)])
  dd_equal(dd_boolean(input, [], precision=dd_precision(3)), fine)
}

///|
test "decimal isolation 07 merge failure leaves shared precision usable" {
  let p = dd_precision(3)
  let input = [dd_box(0.0, 0.0, 1.0, 1.0)]
  let first = dd_boolean(input, [], precision=p)
  assert_true(
    @moonclip.boolean_op_d(
      input,
      [dd_box(0.0001, 0.0, 1.0001, 1.0)],
      @moonclip.Union,
      precision=p,
    )
    is Err(@moonclip.QuantizationFailure(_, _, _, _)),
  )
  dd_equal(dd_boolean(input, [], precision=p), first)
}

///|
test "decimal isolation 08 resource rejection leaves next public call fresh" {
  let input = [dd_box(0.0, 0.0, 1.0, 1.0)]
  assert_true(
    @moonclip.offset_polygons_d(input, 0.2, limits={
      max_input_paths: 1,
      max_input_vertices: 3,
    })
    is Err(
      @moonclip.ResourceLimitExceeded(
        { stage: @moonclip.DecimalQuantize, .. },
        @moonclip.InputVertices,
        3
      )
    ),
  )
  dd_equal(dd_offset(input, 0.2), [dd_box(-0.2, -0.2, 1.2, 1.2)])
}

///|
test "decimal isolation 09 options shared by OffsetD and StrokeD remain original" {
  let options = @moonclip.OffsetOptions::new(
    join=@moonclip.JoinType::Round,
    miter_limit=4.0,
    arc_tolerance=0.025,
  )
  let saved = options
  assert_true(
    @moonclip.offset_polygons_d([dd_box(0.0, 0.0, 1.0, 1.0)], 0.2, options~)
    is Ok(_),
  )
  assert_true(
    @moonclip.stroke_polyline_d(
      [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(1.0, 0.0)],
      0.4,
      options~,
    )
    is Ok(_),
  )
  assert_eq(options, saved)
  assert_eq(
    options,
    @moonclip.OffsetOptions::new(
      join=@moonclip.JoinType::Round,
      miter_limit=4.0,
      arc_tolerance=0.025,
    ),
  )
}

///|
test "decimal isolation 10 independent empty results have no mutable cache" {
  let a = dd_boolean([], [])
  let b = dd_boolean([], [])
  a.push([])
  assert_eq(b, [])
  assert_eq(dd_offset([], 0.2), [])
}

///|
test "decimal isolation 11 equal precision instances do not share mutable execution" {
  let a = dd_precision(3)
  let b = dd_precision(3)
  assert_eq(a, b)
  let first = dd_offset([dd_box(0.0, 0.0, 1.0, 1.0)], 0.2, precision=a)
  let second = dd_offset([dd_box(0.0, 0.0, 1.0, 1.0)], 0.2, precision=b)
  first[0].clear()
  dd_equal(second, [dd_box(-0.2, -0.2, 1.2, 1.2)])
}

///|
test "decimal isolation 12 modified intermediate is revalidated with fresh raw indices" {
  let source = [dd_box(0.0, 0.0, 1.0, 1.0)]
  let middle = dd_boolean(source, [])
  let a = middle[0][0]
  let changed = @moonclip.PointD::new(a.x + 0.0001, a.y)
  middle.push([
    changed,
    @moonclip.PointD::new(2.0, 0.0),
    @moonclip.PointD::new(2.0, 2.0),
  ])
  assert_true(
    @moonclip.offset_polygons_d(middle, 0.0)
    is Err(
      @moonclip.QuantizationFailure(
        { path_index: Some(1), vertex_index: Some(0), .. },
        None,
        Some({ path_index: Some(0), vertex_index: Some(0), .. }),
        _
      )
    ),
  )
  ignore(middle.pop())
  dd_equal(dd_offset(middle, 0.0), source)
  assert_eq(source, [dd_box(0.0, 0.0, 1.0, 1.0)])
}
