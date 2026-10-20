// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn sttw_run(budget : CallBudget) -> Result[PolyTree64, ClipError] {
  stroke_tree_execute(
    st_internal_line(),
    4.0,
    Butt,
    OffsetOptions::new(),
    budget.limits,
    budget~,
  )
}

///|
fn sttw_path_d() -> PathD {
  [PointD::new(0.0, 0.0), PointD::new(0.02, 0.0)]
}

///|
fn sttw_d(budget : CallBudget) -> Result[PolyTreeD, ClipError] {
  decimal_stroke_tree_execute(
    sttw_path_d(),
    0.004,
    dw_precision(3),
    Butt,
    OffsetOptions::new(),
    budget.limits,
    budget~,
  )
}

///|
test "stroke tree: shortcut has preparation cost plus one empty tree and no scan" {
  for
    (path, width) in [
      (st_internal_line(), 0.0),
      ([], 4.0),
      ([Point64::new(1L, 1L)], 4.0),
      ([Point64::new(1L, 1L), Point64::new(1L, 1L)], 4.0),
    ] {
    let flat = dw_budget(kind=2)
    assert_true(
      stroke_execute(
        path,
        width,
        Round,
        OffsetOptions::new(),
        flat.limits,
        budget=flat,
      )
      is Ok([]),
    )
    let b = dw_budget(kind=2)
    let scans : Array[ScanState] = []
    assert_true(
      stroke_compute(
        path,
        width,
        Round,
        OffsetOptions::new(),
        b.limits,
        fn(state) raise ScanAbort {
          scans.push(state)
          tree_build(state)
        },
        tree_empty,
        budget=b,
      )
      is Ok(_),
    )
    assert_eq(scans.length(), 0)
    assert_eq(
      (b.stats.nodes, b.stats.work),
      (flat.stats.nodes + 4, flat.stats.work + 1),
    )
  }
}

///|
test "stroke tree: empty fee is charged atomically after preparation" {
  let measured = dw_budget(kind=2)
  ignore(stroke_prepare([], measured))
  let exact = dw_budget(
    kind=2,
    nodes=measured.stats.nodes + 4,
    work=measured.stats.work + 1,
  )
  assert_true(
    stroke_tree_execute(
      [],
      4.0,
      Square,
      OffsetOptions::new(),
      exact.limits,
      budget=exact,
    )
    is Ok(_),
  )
  for
    b in [
      dw_budget(kind=2, nodes=measured.stats.nodes + 3),
      dw_budget(kind=2, work=measured.stats.work),
    ] {
    assert_true(
      stroke_tree_execute(
        [],
        4.0,
        Square,
        OffsetOptions::new(),
        b.limits,
        budget=b,
      )
      is Err(
        ResourceLimitExceeded(
          { stage: PolyTree, path_index: None, vertex_index: None, },
          _,
          _
        )
      ),
    )
    assert_eq(
      (b.stats.nodes, b.stats.work),
      (measured.stats.nodes, measured.stats.work),
    )
  }
}

///|
test "stroke tree: complete node and work limits exact and one unit short" {
  let measured = dw_budget(kind=2)
  assert_true(sttw_run(measured) is Ok(_))
  let exact = dw_budget(
    kind=2,
    nodes=measured.stats.nodes,
    work=measured.stats.work,
  )
  assert_true(sttw_run(exact) is Ok(_))
  assert_eq(
    (exact.stats.nodes, exact.stats.work),
    (measured.stats.nodes, measured.stats.work),
  )
  assert_true(
    sttw_run(dw_budget(kind=2, nodes=measured.stats.nodes - 1))
    is Err(ResourceLimitExceeded(_, InternalNodes, _)),
  )
  assert_true(
    sttw_run(dw_budget(kind=2, work=measured.stats.work - 1))
    is Err(ResourceLimitExceeded({ stage: PolyTree, .. }, ScanWork, _)),
  )
}

///|
test "stroke tree: passed ledger limits and previous usage stay authoritative" {
  let measured = dw_budget(kind=2)
  assert_true(sttw_run(measured) is Ok(_))
  let b = dw_budget(
    kind=2,
    nodes=measured.stats.nodes + 7,
    work=measured.stats.work + 9,
  )
  budget_spend(b, 7, 9, location(StrokeGenerate, None, None))
  assert_true(
    stroke_tree_execute(
      st_internal_line(),
      4.0,
      Butt,
      OffsetOptions::new(),
      {
        input: { max_input_paths: 0, max_input_vertices: 0, },
        max_nodes: 0,
        max_work: 0,
      },
      budget=b,
    )
    is Ok(_),
  )
  assert_eq(
    (b.stats.nodes, b.stats.work),
    (measured.stats.nodes + 7, measured.stats.work + 9),
  )
  let short = dw_budget(
    kind=2,
    nodes=measured.stats.nodes,
    work=measured.stats.work,
  )
  budget_spend(short, 7, 9, location(StrokeGenerate, None, None))
  assert_true(sttw_run(short) is Err(ResourceLimitExceeded(_, _, _)))
}

///|
test "stroke tree: preparation and generation are not refunded before cleanup" {
  let measured = dw_budget(kind=2)
  let prepared = stroke_prepare(st_internal_line(), measured)
  let prepare_nodes = measured.stats.nodes
  ignore(stroke_generate(prepared, 2.0, Butt, OffsetOptions::new(), measured))
  let generated_nodes = measured.stats.nodes
  assert_true(
    sttw_run(dw_budget(kind=2, nodes=prepare_nodes))
    is Err(
      ResourceLimitExceeded({ stage: StrokeGenerate, .. }, InternalNodes, _)
    ),
  )
  let short = dw_budget(kind=2, nodes=generated_nodes)
  // The existing scanner allocates its control state in EnginePrepare; its
  // internal-input work preflight uses StrokeCleanup. Preserve both phases.
  assert_eq(
    sttw_run(short).map(fn(_) { () }),
    Err(
      ResourceLimitExceeded(
        location(EnginePrepare, None, None),
        InternalNodes,
        generated_nodes,
      ),
    ),
  )
  assert_true(
    sttw_run(dw_budget(kind=2, work=measured.stats.work))
    is Err(ResourceLimitExceeded({ stage: StrokeCleanup, .. }, ScanWork, _)),
  )
  assert_true(short.stats.nodes >= prepare_nodes)
}

///|
test "stroke tree: invalid ledger and raw empty-path count cannot bypass validation" {
  for
    limits in [
      { input: Default::default(), max_nodes: -1, max_work: 5000000, },
      { input: Default::default(), max_nodes: 500000, max_work: -1, },
      {
        input: { max_input_paths: -1, max_input_vertices: 100, },
        max_nodes: 500000,
        max_work: 5000000,
      },
    ] {
    assert_true(
      stroke_tree_execute([], 0.0, Round, OffsetOptions::new(), limits)
      is Err(InvalidInput({ stage: StrokeParameters, .. }, _)),
    )
  }
  let b = dw_budget(kind=2, input={ max_input_paths: 0, max_input_vertices: 0, })
  assert_true(
    stroke_tree_execute([], 0.0, Butt, OffsetOptions::new(), b.limits, budget=b)
    is Err(ResourceLimitExceeded(_, InputPaths, 0)),
  )
}

///|
test "stroke tree: failed tree extraction cleans the final scan and permits retry" {
  let measured = dw_budget(kind=2)
  assert_true(sttw_run(measured) is Ok(_))
  let b = dw_budget(kind=2, work=measured.stats.work - 1)
  let observed : Array[ScanState] = []
  let result = stroke_compute(
    st_internal_line(),
    4.0,
    Butt,
    OffsetOptions::new(),
    b.limits,
    fn(state) raise ScanAbort {
      observed.push(state)
      tree_build(state)
    },
    tree_empty,
    budget=b,
  )
  assert_true(
    result is Err(ResourceLimitExceeded({ stage: PolyTree, .. }, ScanWork, _)),
  )
  assert_eq(observed.length(), 1)
  assert_true(observed[0].cleaned)
  assert_eq(observed[0].ael_count, 0)
  assert_eq(observed[0].output.points.length(), 0)
  assert_eq(observed[0].output.records.length(), 0)
  assert_true(sttw_run(dw_budget(kind=2)) is Ok(_))
}

///|
test "stroke tree: decimal output consumes remaining node and work allowances" {
  let measured = dw_budget(kind=2)
  assert_true(sttw_d(measured) is Ok(_))
  let exact = dw_budget(
    kind=2,
    nodes=measured.stats.nodes,
    work=measured.stats.work,
  )
  assert_true(sttw_d(exact) is Ok(_))
  assert_eq(
    (exact.stats.nodes, exact.stats.work),
    (measured.stats.nodes, measured.stats.work),
  )
  assert_true(
    sttw_d(dw_budget(kind=2, nodes=measured.stats.nodes - 1))
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalOutput, path_index: None, vertex_index: None, },
        InternalNodes,
        _
      )
    ),
  )
  assert_true(
    sttw_d(dw_budget(kind=2, work=measured.stats.work - 1))
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalOutput, path_index: None, vertex_index: None, },
        ScanWork,
        _
      )
    ),
  )
}

///|
test "stroke tree: conversion exhaustion follows scan cleanup without partial results" {
  let measured = dw_budget(kind=2)
  decimal_precheck([sttw_path_d()], [], dw_precision(3), measured)
  let (grid, _) = decimal_quantize(
    [sttw_path_d()],
    [],
    dw_precision(3),
    false,
    measured,
  )
  assert_true(
    stroke_tree_execute(
      grid[0],
      4.0,
      Butt,
      OffsetOptions::new(),
      measured.limits,
      budget=measured,
    )
    is Ok(_),
  )
  let b = dw_budget(kind=2, nodes=measured.stats.nodes + 8)
  decimal_precheck([sttw_path_d()], [], dw_precision(3), b)
  let (grid, _) = decimal_quantize(
    [sttw_path_d()],
    [],
    dw_precision(3),
    false,
    b,
  )
  let observed : Array[ScanState] = []
  let result = stroke_compute(
    grid[0],
    4.0,
    Butt,
    OffsetOptions::new(),
    b.limits,
    fn(state) raise ScanAbort {
      observed.push(state)
      decimal_tree_output(tree_build(state), dw_precision(3), b)
    },
    fn(b) raise ScanAbort {
      decimal_tree_output(tree_empty(b), dw_precision(3), b)
    },
    budget=b,
  )
  assert_true(
    result
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalOutput, path_index: None, vertex_index: None, },
        InternalNodes,
        _
      )
    ),
  )
  assert_eq(observed.length(), 1)
  assert_true(observed[0].cleaned)
  assert_eq(observed[0].output.points.length(), 0)
  assert_eq(observed[0].output.records.length(), 0)
  assert_true(
    sttw_d(dw_budget(kind=2, nodes=measured.stats.nodes + 8))
    is Err(
      ResourceLimitExceeded({ stage: DecimalOutput, .. }, InternalNodes, _)
    ),
  )
  assert_true(sttw_d(dw_budget(kind=2)) is Ok(_))
}

///|
test "stroke tree: decimal shortcut charges both empty trees after open quantization" {
  for (path, width) in [(sttw_path_d(), 0.0), ([], 0.004)] {
    let baseline = dw_budget(kind=2)
    decimal_precheck([path], [], dw_precision(3), baseline)
    let (grid, _) = decimal_quantize(
      [path],
      [],
      dw_precision(3),
      false,
      baseline,
    )
    assert_true(
      stroke_execute(
        grid[0],
        width * 1000.0,
        Butt,
        OffsetOptions::new(),
        baseline.limits,
        budget=baseline,
      )
      is Ok([]),
    )
    let b = dw_budget(
      kind=2,
      nodes=baseline.stats.nodes + 8,
      work=baseline.stats.work + 2,
    )
    assert_true(
      decimal_stroke_tree_execute(
        path,
        width,
        dw_precision(3),
        Butt,
        OffsetOptions::new(),
        b.limits,
        budget=b,
      )
      is Ok(_),
    )
    assert_eq(
      (b.stats.nodes, b.stats.work),
      (baseline.stats.nodes + 8, baseline.stats.work + 2),
    )
    let short = dw_budget(kind=2, nodes=baseline.stats.nodes + 7)
    assert_true(
      decimal_stroke_tree_execute(
        path,
        width,
        dw_precision(3),
        Butt,
        OffsetOptions::new(),
        short.limits,
        budget=short,
      )
      is Err(
        ResourceLimitExceeded({ stage: DecimalOutput, .. }, InternalNodes, _)
      ),
    )
  }
}
