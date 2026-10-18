// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn dw_precision(digits : Int) -> Precision {
  Precision::new(digits).unwrap()
}

///|
fn dw_box() -> PathD {
  [
    PointD::new(0.0, 0.0),
    PointD::new(10.0, 0.0),
    PointD::new(10.0, 10.0),
    PointD::new(0.0, 10.0),
  ]
}

///|
fn dw_budget(
  kind? : Int = 0,
  nodes? : Int = 500000,
  work? : Int = 5000000,
  input? : Limits = Default::default(),
) -> CallBudget {
  new_call_budget(
    { input, max_nodes: nodes, max_work: work, },
    generate_stage=if kind == 2 { StrokeGenerate } else { OffsetGenerate },
    cleanup_stage=if kind == 2 { StrokeCleanup } else { OffsetCleanup },
  )
}

///|
fn dw_run(kind : Int, budget : CallBudget) -> Result[PathsD, ClipError] {
  let paths = if kind == 2 {
    [[PointD::new(0.0, 0.0), PointD::new(10.0, 0.0)]]
  } else {
    [dw_box()]
  }
  let operation = if kind == 0 {
    Boolean(Union, NonZero)
  } else if kind == 1 {
    Offset(0.2, NonZero, OffsetOptions::new())
  } else {
    Stroke(0.4, Butt, OffsetOptions::new())
  }
  decimal_execute(paths, [], operation, dw_precision(3), budget.limits, budget~)
}

///|
fn dw_quantize(budget : CallBudget) -> (Paths64, Paths64) raise ScanAbort {
  decimal_precheck([dw_box()], [], dw_precision(3), budget)
  decimal_quantize([dw_box()], [], dw_precision(3), true, budget)
}

///|
fn dw_output_measure(budget : CallBudget) -> Paths64 raise {
  let (left, right) = dw_quantize(budget)
  guard boolean_compute(
      left,
      right,
      Union,
      budget.limits,
      SignedNonZero,
      fn(state) raise ScanAbort {
        output_extract(state, preserve_collinear=false)
      },
      budget~,
    )
    is Ok(result) else {
    fail("Expected integer result")
  }
  result
}

///|
test "decimal quantize 11 adjacent Double values around signed one-half" {
  for
    (value, expected) in [
      (0.49999999999999994, 0L),
      (0.5, 1L),
      (0.5000000000000001, 1L),
      (-0.49999999999999994, 0L),
      (-0.5, -1L),
      (-0.5000000000000001, -1L),
    ] {
    assert_eq(
      decimal_coordinate(
        value,
        X,
        dw_precision(0),
        location(DecimalQuantize, Some(0), Some(0)),
      ),
      expected,
    )
  }
}

///|
test "decimal quantize 12 adjacent values around signed one-and-a-half" {
  for
    (value, expected) in [
      (1.4999999999999998, 1L),
      (1.5, 2L),
      (1.5000000000000002, 2L),
      (-1.4999999999999998, -1L),
      (-1.5, -2L),
      (-1.5000000000000002, -2L),
    ] {
    assert_eq(decimal_round(value), expected)
  }
}

///|
test "decimal quantize 13 tiny finite numbers and both zero signs" {
  for value in [0.0, -0.0, 1.0e-300, -1.0e-300] {
    assert_eq(
      decimal_coordinate(
        value,
        Y,
        dw_precision(6),
        location(DecimalQuantize, None, None),
      ),
      0L,
    )
  }
  assert_eq(decimal_value(0L, dw_precision(6)).reinterpret_as_int64(), 0L)
}

///|
test "decimal quantize 14 every precision rejects the adjacent exterior Double" {
  for d = 0; d <= 6; d = d + 1 {
    let p = dw_precision(d)
    let edge = 1000000000.0 / decimal_scale(p)
    let outside = (edge.reinterpret_as_int64() + 1L).reinterpret_as_double()
    for axis in [X, Y] {
      assert_eq(
        decimal_coordinate(
          edge,
          axis,
          p,
          location(DecimalQuantize, Some(2), Some(3)),
        ),
        1000000000L,
      )
      assert_eq(
        decimal_coordinate(
          -edge,
          axis,
          p,
          location(DecimalQuantize, Some(2), Some(3)),
        ),
        -1000000000L,
      )
      for v in [outside, -outside] {
        let e = wb_error(fn() raise ScanAbort {
          decimal_coordinate(
            v,
            axis,
            p,
            location(DecimalQuantize, Some(2), Some(3)),
          )
        })
        assert_true(
          e
          is DecimalCoordinateOutOfRange(
            {
              stage: DecimalQuantize,
              path_index: Some(2),
              vertex_index: Some(3),
            },
            actual_axis,
            actual_value,
            digits
          ) &&
          actual_axis == axis &&
          actual_value == v &&
          digits == d,
        )
      }
    }
  }
}

///|
test "decimal quantize 15 finite huge coordinate rejects before unsafe multiplication" {
  assert_true(
    wb_error(fn() raise ScanAbort {
      decimal_coordinate(
        1.0e308,
        X,
        dw_precision(6),
        location(DecimalQuantize, Some(0), Some(1)),
      )
    })
    is DecimalCoordinateOutOfRange(
      { stage: DecimalQuantize, path_index: Some(0), vertex_index: Some(1), },
      X,
      1.0e308,
      6
    ),
  )
}

///|
test "decimal quantize 16 deterministic first conflict across repeated candidates" {
  let input = [
    [
      PointD::new(0.0001, 0.0),
      PointD::new(1.0, 0.0),
      PointD::new(0.0002, 0.0),
      PointD::new(0.0003, 0.0),
    ],
  ]
  for _run = 0; _run < 2; _run = _run + 1 {
    let b = dw_budget()
    let e = wb_error(fn() raise ScanAbort {
      decimal_quantize(input, [], dw_precision(3), false, b)
    })
    assert_true(
      e
      is QuantizationFailure(
        { path_index: Some(0), vertex_index: Some(2), .. },
        None,
        Some({ path_index: Some(0), vertex_index: Some(0), .. }),
        _
      ),
    )
  }
}

///|
test "decimal quantize 17 self intersection area zero is not degeneracy" {
  let path = [
    PointD::new(0.0, 0.0),
    PointD::new(4.0, 4.0),
    PointD::new(0.0, 4.0),
    PointD::new(4.0, 0.0),
  ]
  let b = dw_budget()
  let (quantized, _) = decimal_quantize([path], [], dw_precision(0), true, b)
  assert_eq(area2(quantized[0]), Ok(0N))
  guard boolean_op_d([path], [], Union, precision=dw_precision(0)) is Ok(output) else {
    fail("self intersection")
  }
  let grid = output.map(fn(p) {
    p.map(fn(v) { Point64::new(v.x.to_int64(), v.y.to_int64()) })
  })
  assert_eq(
    internal_canonical(grid),
    internal_canonical([
      [Point64::new(0L, 0L), Point64::new(4L, 0L), Point64::new(2L, 2L)],
      [Point64::new(0L, 4L), Point64::new(2L, 2L), Point64::new(4L, 4L)],
    ]),
  )
}

///|
test "decimal quantize 18 open degeneracy permitted but new merges checked first" {
  assert_eq(stroke_polyline_d([], 0.0), Ok([]))
  assert_eq(stroke_polyline_d([PointD::new(0.0, 0.0)], 2.0), Ok([]))
  assert_eq(
    stroke_polyline_d([PointD::new(0.0, 0.0), PointD::new(0.0, 0.0)], 2.0),
    Ok([]),
  )
  assert_true(
    stroke_polyline_d([PointD::new(0.0001, 0.0), PointD::new(0.0002, 0.0)], 0.0)
    is Err(
      QuantizationFailure(
        { vertex_index: Some(1), .. },
        None,
        Some({ vertex_index: Some(0), .. }),
        _
      )
    ),
  )
}

///|
test "decimal quantize 19 exact original positions may coincide across operands" {
  assert_true(
    boolean_op_d([dw_box()], [dw_box()], Intersection) is Ok(output) &&
    output.length() == 1,
  )
}

///|
test "decimal quantize 20 original identity never uses epsilon" {
  let path = [
    PointD::new(0.0001, 0.0),
    PointD::new(0.00010000000000000002, 0.0),
  ]
  assert_true(
    stroke_polyline_d(path, 0.0)
    is Err(
      QuantizationFailure(
        { vertex_index: Some(1), .. },
        None,
        Some({ vertex_index: Some(0), .. }),
        _
      )
    ),
  )
}

///|
test "decimal units 17 distance and full width scale exactly once" {
  let p = dw_precision(3)
  assert_eq(decimal_parameter(0.2, p), 200.0)
  assert_eq(decimal_parameter(0.4, p), 400.0)
  assert_eq(decimal_parameter(0.4, p) / 2.0, 200.0)
}

///|
test "decimal units 18 scaled distances remain fractional Double" {
  let p = dw_precision(3)
  assert_eq(decimal_parameter(0.0005, p), 0.5)
  assert_eq(decimal_parameter(0.00199, p), 1.99)
  assert_true(
    decimal_parameter(0.00049, p) > 0.0 && decimal_parameter(0.00049, p) < 0.5,
  )
}

///|
test "decimal units 19 zero tolerance sentinel and scaled tiny positive tolerance" {
  let p = dw_precision(3)
  let automatic = decimal_scaled_options(OffsetOptions::new(join=Round), p)
  assert_eq(automatic.arc_tolerance, 0.0)
  let tiny = decimal_scaled_options(
    OffsetOptions::new(join=Round, arc_tolerance=1.0e-14),
    p,
  )
  assert_eq(tiny.arc_tolerance, 1.0e-14 * 1000.0)
  assert_true(tiny.arc_tolerance > 1.0e-12)
}

///|
test "decimal units 20 MiterLimit unchanged and scaled options independent" {
  let options = OffsetOptions::new(
    join=Miter,
    miter_limit=4.0,
    arc_tolerance=0.025,
  )
  let scaled = decimal_scaled_options(options, dw_precision(3))
  assert_eq(scaled.miter_limit, 4.0)
  assert_eq(scaled.join, Miter)
  assert_eq(scaled.arc_tolerance, 25.0)
  assert_eq(
    options,
    OffsetOptions::new(join=Miter, miter_limit=4.0, arc_tolerance=0.025),
  )
}

///|
test "decimal budget 01 raw precheck succeeds before quantized storage rejection" {
  let b = dw_budget(nodes=0)
  decimal_precheck([dw_box()], [], dw_precision(3), b)
  let before = b.stats.work
  assert_true(
    wb_error(fn() raise ScanAbort {
      decimal_quantize([dw_box()], [], dw_precision(3), true, b)
    })
    is ResourceLimitExceeded(
      { stage: DecimalQuantize, path_index: None, vertex_index: None, },
      InternalNodes,
      0
    ),
  )
  assert_eq(b.stats.nodes, 0)
  assert_eq(b.stats.work, before)
}

///|
test "decimal budget 02 merge index allocation has its own bounded storage" {
  let b = dw_budget(nodes=6)
  assert_true(
    wb_error(fn() raise ScanAbort { dw_quantize(b) })
    is ResourceLimitExceeded(
      { stage: DecimalQuantize, path_index: Some(0), vertex_index: Some(0), },
      InternalNodes,
      6
    ),
  )
  assert_eq(b.stats.nodes, 6)
  assert_true(b.stats.work > 0)
}

///|
test "decimal budget 03 quantization succeeds before integer preparation exhausts" {
  let measured = dw_budget()
  ignore(dw_quantize(measured))
  let b = dw_budget(nodes=measured.stats.nodes)
  assert_true(
    dw_run(0, b)
    is Err(
      ResourceLimitExceeded({ stage: EnginePrepare, .. }, InternalNodes, _)
    ),
  )
  assert_eq(b.stats.nodes, measured.stats.nodes)
}

///|
test "decimal budget 04 three entries exact nodes and one less target DecimalOutput" {
  for kind in [0, 1, 2] {
    let measured = dw_budget(kind~)
    assert_true(dw_run(kind, measured) is Ok(_))
    let exact = dw_budget(
      kind~,
      nodes=measured.stats.nodes,
      work=measured.stats.work,
    )
    assert_true(dw_run(kind, exact) is Ok(_))
    assert_eq(
      (exact.stats.nodes, exact.stats.work),
      (measured.stats.nodes, measured.stats.work),
    )
    let short = dw_budget(
      kind~,
      nodes=measured.stats.nodes - 1,
      work=measured.stats.work,
    )
    assert_true(
      dw_run(kind, short)
      is Err(
        ResourceLimitExceeded(
          { stage: DecimalOutput, path_index: None, vertex_index: None, },
          InternalNodes,
          _
        )
      ),
    )
  }
}

///|
test "decimal budget 05 three entries exact work and one less target DecimalOutput" {
  for kind in [0, 1, 2] {
    let measured = dw_budget(kind~)
    assert_true(dw_run(kind, measured) is Ok(_))
    let exact = dw_budget(
      kind~,
      nodes=measured.stats.nodes,
      work=measured.stats.work,
    )
    assert_true(dw_run(kind, exact) is Ok(_))
    let short = dw_budget(
      kind~,
      nodes=measured.stats.nodes,
      work=measured.stats.work - 1,
    )
    assert_true(
      dw_run(kind, short)
      is Err(
        ResourceLimitExceeded(
          { stage: DecimalOutput, path_index: None, vertex_index: None, },
          ScanWork,
          _
        )
      ),
    )
  }
}

///|
test "decimal budget 06 real integer result still needs output storage" {
  let measured = dw_budget()
  let result = dw_output_measure(measured)
  let nodes = measured.stats.nodes
  let b = dw_budget(nodes~)
  let actual = dw_output_measure(b)
  assert_eq(actual, result)
  assert_true(
    wb_error(fn() raise ScanAbort { decimal_output(actual, dw_precision(3), b) })
    is ResourceLimitExceeded({ stage: DecimalOutput, .. }, InternalNodes, _),
  )
  assert_eq(b.stats.nodes, nodes)
}

///|
test "decimal budget 07 real integer result still needs output work" {
  let measured = dw_budget()
  let result = dw_output_measure(measured)
  let work = measured.stats.work
  let b = dw_budget(work~)
  let actual = dw_output_measure(b)
  assert_eq(actual, result)
  assert_true(
    wb_error(fn() raise ScanAbort { decimal_output(actual, dw_precision(3), b) })
    is ResourceLimitExceeded({ stage: DecimalOutput, .. }, ScanWork, _),
  )
  assert_eq(b.stats.work, work)
}

///|
test "decimal budget 08 repeated raw points consume vertex quota before copy" {
  let path = dw_box()
  path.push(path[0])
  let b = dw_budget(input={ max_input_paths: 1, max_input_vertices: 4, })
  assert_true(
    decimal_execute(
      [path],
      [],
      Boolean(Union, NonZero),
      dw_precision(3),
      b.limits,
      budget=b,
    )
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalQuantize, path_index: Some(0), vertex_index: Some(4), },
        InputVertices,
        4
      )
    ),
  )
  assert_eq(b.stats.nodes, 0)
  assert_eq(path.length(), 5)
}

///|
test "decimal budget 09 empty contours and both operands share raw quotas" {
  let b = dw_budget(input={ max_input_paths: 1, max_input_vertices: 100, })
  assert_true(
    decimal_execute(
      [[]],
      [[]],
      Boolean(Union, NonZero),
      dw_precision(3),
      b.limits,
      budget=b,
    )
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalQuantize, path_index: Some(1), .. },
        InputPaths,
        1
      )
    ),
  )
  let c = dw_budget(input={ max_input_paths: 2, max_input_vertices: 7, })
  assert_true(
    decimal_execute(
      [dw_box()],
      [dw_box()],
      Boolean(Union, NonZero),
      dw_precision(3),
      c.limits,
      budget=c,
    )
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalQuantize, path_index: Some(1), vertex_index: Some(3), },
        InputVertices,
        7
      )
    ),
  )
}

///|
test "decimal budget 10 negative limits rejected and zero quotas precise" {
  for
    limits in [
      {
        input: { max_input_paths: -1, max_input_vertices: 10, },
        max_nodes: 100,
        max_work: 100,
      },
      { input: Default::default(), max_nodes: -1, max_work: 100, },
      { input: Default::default(), max_nodes: 100, max_work: -1, },
    ] {
    assert_true(
      decimal_execute([], [], Boolean(Union, NonZero), dw_precision(3), limits)
      is Err(InvalidInput({ stage: DecimalParameters, .. }, _)),
    )
  }
  assert_eq(
    boolean_op_d([], [], Union, limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    }),
    Ok([]),
  )
  assert_true(
    stroke_polyline_d([], 0.0, limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    })
    is Err(ResourceLimitExceeded({ stage: DecimalQuantize, .. }, InputPaths, 0)),
  )
}

///|
test "decimal budget 11 passed ledger remains authoritative over child limits" {
  let measured = dw_budget()
  assert_true(dw_run(0, measured) is Ok(_))
  let b = dw_budget(
    nodes=measured.stats.nodes + 7,
    work=measured.stats.work + 11,
  )
  decimal_spend(b, 7, 11, location(DecimalQuantize, None, None))
  assert_true(
    decimal_execute(
      [dw_box()],
      [],
      Boolean(Union, NonZero),
      dw_precision(3),
      { input: Default::default(), max_nodes: 0, max_work: 0, },
      budget=b,
    )
    is Ok(_),
  )
  assert_eq(
    (b.stats.nodes, b.stats.work),
    (measured.stats.nodes + 7, measured.stats.work + 11),
  )
}

///|
test "decimal budget 12 decimal debit keeps both counters atomic" {
  let b = dw_budget(nodes=10, work=2)
  decimal_spend(b, 2, 1, location(DecimalQuantize, None, None))
  assert_true(
    wb_error(fn() raise ScanAbort {
      decimal_spend(b, 3, 2, location(DecimalQuantize, None, None))
    })
    is ResourceLimitExceeded({ stage: DecimalQuantize, .. }, ScanWork, 2),
  )
  assert_eq((b.stats.nodes, b.stats.work), (2, 1))
  assert_true(
    wb_error(fn() raise ScanAbort {
      decimal_spend(b, -1, 0, location(DecimalOutput, None, None))
    })
    is InvalidInput({ stage: DecimalOutput, .. }, _),
  )
  assert_eq((b.stats.nodes, b.stats.work), (2, 1))
}

///|
test "decimal budget 13 dropping converted arrays never refunds cumulative usage" {
  let b = dw_budget()
  guard dw_run(0, b) is Ok(result) else { fail("result") }
  let used = (b.stats.nodes, b.stats.work)
  result[0].clear()
  result.clear()
  assert_eq((b.stats.nodes, b.stats.work), used)
  assert_true(b.stats.nodes > 0 && b.stats.work > 0)
}

///|
test "decimal budget 14 non-coordinate error kinds and specific stages unchanged" {
  let p = dw_precision(3)
  for
    e in [
      NumericFailure(location(OffsetGenerate, None, None), "numeric"),
      ResourceLimitExceeded(
        location(Intersections, Some(1), Some(2)),
        ScanWork,
        5,
      ),
      ExecutionFailure(location(OutputTopology, None, None), "topology"),
    ] {
    assert_eq(decimal_error(e, p), e)
  }
  assert_eq(
    decimal_error(
      CoordinateOutOfRange(location(StrokeGenerate, None, None), Y, 1000000002L),
      p,
    ),
    DecimalCoordinateOutOfRange(
      location(StrokeGenerate, None, None),
      Y,
      1000000.002,
      3,
    ),
  )
}

///|
test "decimal budget 15 failed output has no partial public success and fresh retry works" {
  let measured = dw_budget()
  assert_true(dw_run(1, measured) is Ok(_))
  let b = dw_budget(nodes=measured.stats.nodes - 1)
  assert_true(
    dw_run(1, b)
    is Err(
      ResourceLimitExceeded({ stage: DecimalOutput, .. }, InternalNodes, _)
    ),
  )
  assert_true(b.stats.nodes > 0 && b.stats.work > 0)
  assert_true(
    offset_polygons_d([dw_box()], 0.2) is Ok(paths) && paths.length() == 1,
  )
}

///|
test "decimal budget 16 Stroke generation context survives decimal wrapping" {
  let b = dw_budget(kind=2)
  assert_true(
    decimal_execute(
      [[PointD::new(999.99999, 0.0), PointD::new(1000.0, 0.0)]],
      [],
      Stroke(0.000004, Square, OffsetOptions::new()),
      dw_precision(6),
      b.limits,
      budget=b,
    )
    is Err(
      DecimalCoordinateOutOfRange(
        { stage: StrokeGenerate, path_index: None, vertex_index: None, },
        X,
        1000.000002,
        6
      )
    ),
  )
  assert_true(b.stats.nodes > 0 && b.stats.work > 0)
  assert_true(
    stroke_polyline_d(
      [PointD::new(0.0, 0.0), PointD::new(1.0, 0.0)],
      0.4,
      precision=dw_precision(3),
    )
    is Ok(_),
  )
}
