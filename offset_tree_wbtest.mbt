// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn otw_integer(
  budget : CallBudget,
  delta? : Double = 2.0,
) -> Result[PolyTree64, ClipError] {
  offset_tree_execute(
    [pt_rect()],
    delta,
    NonZero,
    OffsetOptions::new(),
    budget.limits,
    budget~,
  )
}

///|
fn otw_decimal(
  budget : CallBudget,
  delta? : Double = 0.002,
) -> Result[PolyTreeD, ClipError] {
  decimal_offset_tree_execute(
    [dw_box()],
    delta,
    dw_precision(3),
    NonZero,
    OffsetOptions::new(),
    budget.limits,
    budget~,
  )
}

///|
test "offset tree: empty integer storage charges wrappers before allocating" {
  let exact = dw_budget(nodes=4, work=1)
  assert_eq(tree_empty(exact).to_paths(), [])
  assert_eq((exact.stats.nodes, exact.stats.work), (4, 1))
  for b in [dw_budget(nodes=3), dw_budget(work=0)] {
    assert_true(
      wb_error(fn() raise ScanAbort { tree_empty(b) })
      is ResourceLimitExceeded(
        { stage: PolyTree, path_index: None, vertex_index: None, },
        _,
        _
      ),
    )
    assert_eq((b.stats.nodes, b.stats.work), (0, 0))
  }
}

///|
test "offset tree: normalized empty result adds only the metered empty tree" {
  let flat = dw_budget()
  assert_true(
    offset_execute(
      [],
      2.0,
      NonZero,
      OffsetOptions::new(),
      flat.limits,
      budget=flat,
    )
    is Ok([]),
  )
  let b = dw_budget()
  let callbacks : Array[ScanState] = []
  let result = offset_compute(
    [],
    2.0,
    NonZero,
    OffsetOptions::new(),
    b.limits,
    fn(state) raise ScanAbort {
      callbacks.push(state)
      tree_build(state)
    },
    fn(_, b) raise ScanAbort { tree_empty(b) },
    budget=b,
  )
  assert_true(result is Ok(_))
  assert_eq(callbacks.length(), 0)
  assert_eq(
    (b.stats.nodes, b.stats.work),
    (flat.stats.nodes + 4, flat.stats.work + 1),
  )
}

///|
test "offset tree: shortcut cost is exactly one normalization and tree extraction" {
  for delta in [0.0, -0.0, 0.49, -0.49] {
    let b = dw_budget()
    assert_true(otw_integer(b, delta~) is Ok(_))
    let normalized = dw_budget()
    assert_true(
      boolean_compute(
        [pt_rect()],
        [],
        Union,
        normalized.limits,
        SignedNonZero,
        tree_build,
        budget=normalized,
      )
      is Ok(_),
    )
    assert_eq(
      (b.stats.nodes, b.stats.work),
      (normalized.stats.nodes, normalized.stats.work),
    )
  }
}

///|
test "offset tree: full call node limit exact and one unit short" {
  for delta in [0.0, 2.0] {
    let measured = dw_budget()
    assert_true(otw_integer(measured, delta~) is Ok(_))
    let exact = dw_budget(nodes=measured.stats.nodes, work=measured.stats.work)
    assert_true(otw_integer(exact, delta~) is Ok(_))
    assert_eq(
      (exact.stats.nodes, exact.stats.work),
      (measured.stats.nodes, measured.stats.work),
    )
    assert_true(
      otw_integer(dw_budget(nodes=measured.stats.nodes - 1), delta~)
      is Err(ResourceLimitExceeded(_, InternalNodes, _)),
    )
  }
}

///|
test "offset tree: work limit exact and one unit short in tree verification" {
  for delta in [0.0, 2.0] {
    let measured = dw_budget()
    assert_true(otw_integer(measured, delta~) is Ok(_))
    assert_true(
      otw_integer(dw_budget(work=measured.stats.work), delta~) is Ok(_),
    )
    assert_true(
      otw_integer(dw_budget(work=measured.stats.work - 1), delta~)
      is Err(ResourceLimitExceeded({ stage: PolyTree, .. }, ScanWork, _)),
    )
  }
}

///|
test "offset tree: injected budget history and limits stay authoritative" {
  let measured = dw_budget()
  assert_true(otw_integer(measured) is Ok(_))
  let b = dw_budget(
    nodes=measured.stats.nodes + 7,
    work=measured.stats.work + 9,
  )
  budget_spend(b, 7, 9, location(OffsetGenerate, None, None))
  assert_true(
    offset_tree_execute(
      [pt_rect()],
      2.0,
      NonZero,
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
  let short = dw_budget(nodes=measured.stats.nodes, work=measured.stats.work)
  budget_spend(short, 7, 9, location(OffsetGenerate, None, None))
  assert_true(otw_integer(short) is Err(ResourceLimitExceeded(_, _, _)))
}

///|
test "offset tree: callback exhaustion cleans both shortcut and cleanup scans" {
  for delta in [0.0, 2.0] {
    let measured = dw_budget()
    assert_true(otw_integer(measured, delta~) is Ok(_))
    let b = dw_budget(work=measured.stats.work - 1)
    let observed : Array[ScanState] = []
    let result = offset_compute(
      [pt_rect()],
      delta,
      NonZero,
      OffsetOptions::new(),
      b.limits,
      fn(state) raise ScanAbort {
        observed.push(state)
        tree_build(state)
      },
      fn(_, b) raise ScanAbort { tree_empty(b) },
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
    assert_true(otw_integer(dw_budget(), delta~) is Ok(_))
  }
}

///|
test "offset tree: decimal complete call exhausts the shared output budget" {
  for delta in [0.0, 0.002] {
    let measured = dw_budget()
    assert_true(otw_decimal(measured, delta~) is Ok(_))
    assert_true(
      otw_decimal(
        dw_budget(nodes=measured.stats.nodes, work=measured.stats.work),
        delta~,
      )
      is Ok(_),
    )
    assert_true(
      otw_decimal(dw_budget(nodes=measured.stats.nodes - 1), delta~)
      is Err(
        ResourceLimitExceeded(
          { stage: DecimalOutput, path_index: None, vertex_index: None, },
          InternalNodes,
          _
        )
      ),
    )
    assert_true(
      otw_decimal(dw_budget(work=measured.stats.work - 1), delta~)
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
test "offset tree: decimal conversion failure cleans its owning scan" {
  for delta in [0.0, 0.002] {
    let grid_delta = delta * 1000.0
    let measured = dw_budget()
    let (grid, _) = dw_quantize(measured)
    assert_true(
      offset_tree_execute(
        grid,
        grid_delta,
        NonZero,
        OffsetOptions::new(),
        measured.limits,
        budget=measured,
      )
      is Ok(_),
    )
    let b = dw_budget(nodes=measured.stats.nodes + 8)
    let (grid, _) = dw_quantize(b)
    let observed : Array[ScanState] = []
    let result = offset_compute(
      grid,
      grid_delta,
      NonZero,
      OffsetOptions::new(),
      b.limits,
      fn(state) raise ScanAbort {
        observed.push(state)
        decimal_tree_output(tree_build(state), dw_precision(3), b)
      },
      fn(_, b) raise ScanAbort {
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
    assert_true(otw_decimal(dw_budget(), delta~) is Ok(_))
  }
}

///|
test "offset tree: decimal normalized empty has no second scan and charges both tree wrappers" {
  let baseline = dw_budget()
  decimal_precheck([], [], dw_precision(3), baseline)
  ignore(decimal_quantize([], [], dw_precision(3), true, baseline))
  assert_true(
    offset_execute(
      [],
      2000.0,
      NonZero,
      OffsetOptions::new(),
      baseline.limits,
      budget=baseline,
    )
    is Ok([]),
  )
  let exact = dw_budget(
    nodes=baseline.stats.nodes + 8,
    work=baseline.stats.work + 2,
  )
  assert_true(
    decimal_offset_tree_execute(
      [],
      2.0,
      dw_precision(3),
      NonZero,
      OffsetOptions::new(),
      exact.limits,
      budget=exact,
    )
    is Ok(_),
  )
  assert_eq(
    (exact.stats.nodes, exact.stats.work),
    (baseline.stats.nodes + 8, baseline.stats.work + 2),
  )
  let short = dw_budget(nodes=baseline.stats.nodes + 7)
  assert_true(
    decimal_offset_tree_execute(
      [],
      2.0,
      dw_precision(3),
      NonZero,
      OffsetOptions::new(),
      short.limits,
      budget=short,
    )
    is Err(
      ResourceLimitExceeded({ stage: DecimalOutput, .. }, InternalNodes, _)
    ),
  )
}
