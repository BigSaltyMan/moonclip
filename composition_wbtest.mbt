// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn cm_limits(nodes? : Int = 500000, work? : Int = 5000000) -> ScanLimits {
  { input: Default::default(), max_nodes: nodes, max_work: work, }
}

///|
fn cm_run(kind : Int, budget : CallBudget) -> Result[Unit, ClipError] {
  if kind == 1 {
    return offset_execute(
      [pt_rect()],
      2.0,
      NonZero,
      OffsetOptions::new(),
      budget.limits,
      budget~,
    ).map(fn(_) { () })
  }
  if kind == 2 {
    return stroke_execute(
      st_internal_line(),
      4.0,
      Butt,
      OffsetOptions::new(),
      budget.limits,
      budget~,
    ).map(fn(_) { () })
  }
  boolean_compute(
    [pt_rect()],
    [],
    Union,
    budget.limits,
    SignedNonZero,
    fn(state) raise ScanAbort {
      if kind == 3 {
        ignore(tree_build(state))
      } else {
        ignore(output_extract(state, preserve_collinear=false))
      }
    },
    budget~,
  )
}

///|
fn cm_budget(
  kind : Int,
  nodes? : Int = 500000,
  work? : Int = 5000000,
) -> CallBudget {
  new_call_budget(
    cm_limits(nodes~, work~),
    generate_stage=if kind == 2 { StrokeGenerate } else { OffsetGenerate },
    cleanup_stage=if kind == 2 { StrokeCleanup } else { OffsetCleanup },
  )
}

///|
fn cm_boundary(kind : Int, node_limit : Bool) -> Unit raise {
  let baseline = cm_budget(kind)
  assert_eq(cm_run(kind, baseline), Ok(()))
  let exact = cm_budget(
    kind,
    nodes=baseline.stats.nodes,
    work=baseline.stats.work,
  )
  assert_eq(cm_run(kind, exact), Ok(()))
  assert_eq(
    (exact.stats.nodes, exact.stats.work),
    (baseline.stats.nodes, baseline.stats.work),
  )
  let short = cm_budget(
    kind,
    nodes=baseline.stats.nodes - (if node_limit { 1 } else { 0 }),
    work=baseline.stats.work - (if node_limit { 0 } else { 1 }),
  )
  let error = cm_run(kind, short)
  assert_true(
    error
    is Err(
      ResourceLimitExceeded(
        { stage: OutputTopology, path_index: None, vertex_index: None, },
        resource,
        _
      )
    ) &&
    resource == (if node_limit { InternalNodes } else { ScanWork }),
  )
}

///|
fn cm_cleanup(
  generated : Paths64,
  budget : CallBudget,
) -> Result[Paths64, ClipError] {
  boolean_compute(
    generated,
    [],
    Union,
    budget.limits,
    Positive,
    fn(state) raise ScanAbort {
      output_extract(state, preserve_collinear=false)
    },
    budget~,
    internal_input=true,
  )
}

///|
test "composition budget 01 preflight consumes no credit" {
  let b = cm_budget(0, nodes=5, work=7)
  assert_eq(budget_error(b, 5, 7, location(OffsetGenerate, None, None)), None)
  assert_eq((b.stats.nodes, b.stats.work), (0, 0))
  offset_spend(b, 5, 7)
  assert_eq((b.stats.nodes, b.stats.work), (5, 7))
}

///|
test "composition budget 02 exact Boolean nodes and one less at snapshot" {
  cm_boundary(0, true)
}

///|
test "composition budget 03 exact Boolean work and one less at snapshot" {
  cm_boundary(0, false)
}

///|
test "composition budget 04 exact Offset nodes and one less at snapshot" {
  cm_boundary(1, true)
}

///|
test "composition budget 05 exact Offset work and one less at snapshot" {
  cm_boundary(1, false)
}

///|
test "composition budget 06 exact Stroke nodes and one less at snapshot" {
  cm_boundary(2, true)
}

///|
test "composition budget 07 exact Stroke work and one less at snapshot" {
  cm_boundary(2, false)
}

///|
test "composition budget 08 work rejection never partially charges nodes" {
  let b = cm_budget(0, nodes=10, work=4)
  offset_spend(b, 2, 3)
  assert_true(
    wb_error(fn() raise ScanAbort { offset_spend(b, 5, 2) })
    is ResourceLimitExceeded({ stage: OffsetGenerate, .. }, ScanWork, 4),
  )
  assert_eq((b.stats.nodes, b.stats.work), (2, 3))
}

///|
test "composition budget 09 negative nodes rejected atomically" {
  let b = cm_budget(1)
  offset_spend(b, 2, 3)
  assert_true(
    wb_error(fn() raise ScanAbort { offset_spend(b, -1, 1) })
    is InvalidInput({ stage: OffsetGenerate, .. }, _),
  )
  assert_eq((b.stats.nodes, b.stats.work), (2, 3))
}

///|
test "composition budget 10 negative work rejected atomically" {
  let b = cm_budget(2)
  offset_spend(b, 2, 3)
  assert_true(
    wb_error(fn() raise ScanAbort { offset_spend(b, 1, -1) })
    is InvalidInput({ stage: StrokeGenerate, .. }, _),
  )
  assert_eq((b.stats.nodes, b.stats.work), (2, 3))
}

///|
test "composition budget 11 scan and output retain atomic negative checks" {
  for output in [false, true] {
    let state = new_scan_state(cm_limits(nodes=10, work=4))
    let e = wb_error(fn() raise ScanAbort {
      if output {
        output_spend(state, 1, -1)
      } else {
        scan_spend(state, -1, 1, location(ScanEvents, None, None))
      }
    })
    assert_true(e is InvalidInput(_, _))
    assert_eq((state.stats.nodes, state.stats.work), (0, 0))
  }
}

///|
test "composition budget 12 child cannot replace authoritative limits" {
  let b = cm_budget(0, nodes=0)
  assert_true(
    boolean_compute(
      [pt_rect()],
      [],
      Union,
      cm_limits(),
      SignedNonZero,
      fn(state) raise ScanAbort { output_extract(state) },
      budget=b,
    )
    is Err(ResourceLimitExceeded(_, InternalNodes, 0)),
  )
  assert_eq(b.stats.nodes, 0)
}

///|
test "composition budget 13 child preserves earlier ledger usage" {
  let base = cm_budget(0)
  assert_eq(cm_run(0, base), Ok(()))
  let b = cm_budget(0, nodes=base.stats.nodes + 7, work=base.stats.work + 11)
  offset_spend(b, 7, 11)
  assert_eq(cm_run(0, b), Ok(()))
  assert_eq(
    (b.stats.nodes, b.stats.work),
    (base.stats.nodes + 7, base.stats.work + 11),
  )
}

///|
test "composition budget 14 normalization succeeds but generation has no nodes" {
  let measured = cm_budget(1)
  ignore(of_budget_normal(measured))
  let b = cm_budget(1, nodes=measured.stats.nodes)
  assert_true(
    offset_execute(
      [pt_rect()],
      2.0,
      NonZero,
      OffsetOptions::new(),
      b.limits,
      budget=b,
    )
    is Err(
      ResourceLimitExceeded(
        { stage: OffsetGenerate, path_index: None, vertex_index: None, },
        InternalNodes,
        _
      )
    ),
  )
}

///|
test "composition budget 15 whole arc preflight rejects before any sample" {
  let b = cm_budget(2, nodes=2)
  let output : Path64 = []
  let error = wb_error(fn() raise ScanAbort {
    offset_round(
      output,
      Point64::new(0L, 0L),
      { x: 0.0, y: -1.0, },
      { x: 0.0, y: 1.0, },
      10.0,
      @math.PI,
      jo_arc(10.0),
      b,
    )
  })
  assert_true(
    error
    is ResourceLimitExceeded({ stage: StrokeGenerate, .. }, InternalNodes, 2),
  )
  assert_eq(output, [])
  assert_eq((b.stats.nodes, b.stats.work), (0, 0))
}

///|
test "composition budget 16 generation succeeds but cleanup precheck exhausts work" {
  let measure = cm_budget(1)
  let normalized = of_budget_normal(measure)
  let generated = offset_generate(
    normalized,
    2.0,
    OffsetOptions::new(),
    measure,
  )
  let b = cm_budget(1, work=measure.stats.work)
  let normal = of_budget_normal(b)
  assert_eq(offset_generate(normal, 2.0, OffsetOptions::new(), b), generated)
  assert_true(
    cm_cleanup(generated, b)
    is Err(
      ResourceLimitExceeded(
        { stage: OffsetCleanup, path_index: None, vertex_index: None, },
        ScanWork,
        _
      )
    ),
  )
}

///|
test "composition budget 17 cleanup preparation succeeds before scan exhausts" {
  let measured = cm_budget(2)
  let prepared = stroke_prepare(st_internal_line(), measured)
  let generated = stroke_generate(
    prepared,
    2.0,
    Butt,
    OffsetOptions::new(),
    measured,
  )
  guard prepare_scan(
      generated,
      [],
      budget=measured,
      internal_input=true,
      source_extrema=true,
    )
    is Ok(preparation) else {
    fail("preparation")
  }
  let work = measured.stats.work
  scan_cleanup(preparation)
  let b = cm_budget(2, work~)
  let p = stroke_prepare(st_internal_line(), b)
  let g = stroke_generate(p, 2.0, Butt, OffsetOptions::new(), b)
  assert_true(
    cm_cleanup(g, b)
    is Err(
      ResourceLimitExceeded(
        { stage: ScanEvents, path_index: None, vertex_index: None, },
        ScanWork,
        _
      )
    ),
  )
}

///|
test "composition budget 18 completed scan does not grant free snapshot storage" {
  let measure = cm_scan(cm_limits())
  let ids = output_finalize(measure, false)
  let before = measure.stats.nodes
  ignore(output_snapshot(measure, ids))
  let total = measure.stats.nodes
  assert_true(total > before)
  let limited = cm_scan(cm_limits(nodes=total - 1))
  let limited_ids = output_finalize(limited, false)
  assert_true(
    wb_error(fn() raise ScanAbort { output_snapshot(limited, limited_ids) })
    is ResourceLimitExceeded({ stage: OutputTopology, .. }, InternalNodes, _),
  )
}

///|
test "composition budget 19 flat allowance cannot guarantee tree construction" {
  let flat = cm_budget(0)
  assert_eq(cm_run(0, flat), Ok(()))
  let tree = cm_budget(3, nodes=flat.stats.nodes, work=5000000)
  assert_true(
    cm_run(3, tree)
    is Err(ResourceLimitExceeded({ stage: PolyTree, .. }, InternalNodes, _)),
  )
}

///|
test "composition budget 20 cleanup releases storage without refund" {
  let state = engine_fixture([wb_rectangle()], simple_contour_decision)
  ignore(output_extract(state))
  let saved = (state.stats.nodes, state.stats.work)
  scan_cleanup(state)
  assert_eq((state.stats.nodes, state.stats.work), saved)
  assert_eq(state.output.points.length(), 0)
}

///|
test "composition budget 21 first scan failure stays sticky after cleanup" {
  let state = new_scan_state(cm_limits(nodes=0))
  let error = wb_error(fn() raise ScanAbort {
    scan_spend(state, 1, 0, location(ActiveEdges, None, None))
  })
  scan_cleanup(state)
  assert_eq(wb_error(fn() raise ScanAbort { output_spend(state, 0, 0) }), error)
  assert_eq(
    wb_error(fn() raise ScanAbort {
      scan_spend(state, -1, -1, location(ScanEvents, None, None))
    }),
    error,
  )
  assert_true(boolean_op([pt_rect()], [], Union) is Ok(_))
}

///|
test "composition budget 22 cleaned state rejects zero charge" {
  let state = new_scan_state(cm_limits())
  scan_cleanup(state)
  assert_true(
    wb_error(fn() raise ScanAbort { output_spend(state, 0, 0) })
    is InvalidInput({ stage: OutputTopology, .. }, _),
  )
  assert_eq((state.stats.nodes, state.stats.work), (0, 0))
  let diagnostic = new_scan_state(cm_limits())
  scan_cleanup(diagnostic)
  assert_true(engine_invariants(diagnostic, metered=true) is Err(_))
  assert_true(
    diagnostic.failure is Some(InvalidInput({ stage: OutputTopology, .. }, _)),
  )
  assert_eq((diagnostic.stats.nodes, diagnostic.stats.work), (0, 0))
}

///|
test "composition budget 23 production validation scratch is charged before allocation" {
  let state = new_scan_state(cm_limits(nodes=0))
  assert_true(engine_invariants(state, metered=true) is Err(_))
  assert_true(
    state.failure
    is Some(
      ResourceLimitExceeded({ stage: OutputTopology, .. }, InternalNodes, 0)
    ),
  )
  assert_eq(state.stats.nodes, 0)
  // Unmetered diagnostics remain available after failure.
  assert_eq(engine_invariants(state), Ok(()))
}

///|
test "composition budget 24 repeated internal empty stages do not reset usage" {
  let b = cm_budget(0)
  for _i = 0; _i < 2; _i = _i + 1 {
    let before = b.stats.nodes
    assert_true(
      boolean_compute(
        [],
        [],
        Union,
        b.limits,
        Positive,
        fn(state) raise ScanAbort { output_extract(state) },
        budget=b,
        internal_input=true,
      )
      is Ok([]),
    )
    assert_true(b.stats.nodes > before)
  }
}

///|
test "composition error 01 Offset parameter errors precede empty geometry" {
  assert_true(
    offset_polygons([], @double.not_a_number)
    is Err(
      InvalidInput(
        { stage: OffsetParameters, path_index: None, vertex_index: None, },
        _
      )
    ),
  )
}

///|
test "composition error 02 Stroke parameters keep their own stage" {
  assert_true(
    stroke_polyline([], -1.0)
    is Err(
      InvalidInput(
        { stage: StrokeParameters, path_index: None, vertex_index: None, },
        _
      )
    ),
  )
}

///|
test "composition error 03 generated Offset overflow has no fabricated input index" {
  assert_true(
    offset_polygons([pt_rect(x=999999990L, w=10L)], 2.0)
    is Err(
      CoordinateOutOfRange(
        { stage: OffsetGenerate, path_index: None, vertex_index: None, },
        X,
        _
      )
    ),
  )
}

///|
test "composition error 04 generated Stroke cap overflow keeps context" {
  assert_true(
    stroke_polyline(
      [Point64::new(999999990L, 0L), Point64::new(1000000000L, 0L)],
      4.0,
      cap=Square,
    )
    is Err(
      CoordinateOutOfRange(
        { stage: StrokeGenerate, path_index: None, vertex_index: None, },
        X,
        1000000002L
      )
    ),
  )
}

///|
test "composition error 05 next Boolean raw indices refer to intermediate arrays" {
  guard boolean_op([pt_rect()], [], Union) is Ok(middle) else { fail("first") }
  middle.push([Point64::new(0L, 0L), Point64::new(0L, -1000000001L)])
  assert_true(
    boolean_tree(middle, [], Union)
    is Err(
      CoordinateOutOfRange(
        { stage: EnginePrepare, path_index: Some(1), vertex_index: Some(1), },
        Y,
        -1000000001L
      )
    ),
  )
}

///|
test "composition error 06 internally generated validation has Stroke cleanup context" {
  let b = cm_budget(2)
  assert_true(
    cm_cleanup([[Point64::new(1000000001L, 0L)]], b)
    is Err(
      CoordinateOutOfRange(
        { stage: StrokeCleanup, path_index: None, vertex_index: None, },
        X,
        1000000001L
      )
    ),
  )
}

///|
test "composition error 07 inclusive coordinate boundary remains exact" {
  guard boolean_op(
      [pt_rect(x=999999980L, y=-1000000000L, w=20L, h=20L)],
      [],
      Union,
    )
    is Ok(middle) else {
    fail("boundary")
  }
  assert_eq(
    offset_polygons(middle, 0.0).map(internal_canonical),
    Ok(internal_canonical(middle)),
  )
}

///|
test "composition error 08 finite extreme width is NumericFailure not empty" {
  assert_true(
    stroke_polyline(st_internal_line(), 1.0e300)
    is Err(
      NumericFailure(
        { stage: StrokeGenerate, path_index: None, vertex_index: None, },
        _
      )
    ),
  )
}

///|
test "composition error 09 resource error does not become valid empty" {
  let b = cm_budget(2, work=0)
  assert_true(
    cm_run(2, b)
    is Err(ResourceLimitExceeded({ stage: StrokeGenerate, .. }, ScanWork, 0)),
  )
  assert_eq(stroke_polyline(st_internal_line(), 0.0), Ok([]))
}

///|
test "composition error 10 output topology failure survives subsequent phases" {
  let state = new_scan_state(cm_limits())
  let first = wb_error(fn() raise ScanAbort { output_point(state, 42) })
  assert_true(first is InvalidInput({ stage: OutputTopology, .. }, _))
  assert_eq(
    wb_error(fn() raise ScanAbort {
      scan_spend(state, 1, 1, location(Intersections, None, None))
    }),
    first,
  )
  scan_cleanup(state)
  assert_eq(
    wb_error(fn() raise ScanAbort { output_snapshot(state, []) }),
    first,
  )
}

///|
fn cm_scan(limits : ScanLimits) -> ScanState raise {
  guard prepare_scan([wb_rectangle()], [], limits~) is Ok(state) else {
    fail("prepare")
  }
  while state.phase != Complete {
    match engine_step(state, simple_contour_decision) {
      Ok(_) => ()
      Err(e) => fail(e.message())
    }
  }
  state
}
