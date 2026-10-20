// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn dtw_run(budget : CallBudget) -> Result[PolyTreeD, ClipError] {
  decimal_tree_execute(
    [dw_box()],
    [],
    Union,
    dw_precision(3),
    EvenOdd,
    budget.limits,
    budget~,
  )
}

///|
fn dtw_integer(budget : CallBudget) -> PolyTree64 raise {
  let (left, right) = dw_quantize(budget)
  guard boolean_compute(
      left,
      right,
      Union,
      budget.limits,
      Parity,
      tree_build,
      budget~,
    )
    is Ok(tree) else {
    fail("Expected integer tree")
  }
  tree
}

///|
fn dtw_fixture() -> PolyTree64 {
  let box = [
    Point64::new(0L, 0L),
    Point64::new(1000L, 0L),
    Point64::new(1000L, 1000L),
    Point64::new(0L, 1000L),
  ]
  {
    data: {
      nodes: [
        { contour: box, parent: None, children: [1], depth: 1, },
        { contour: box.copy(), parent: Some(0), children: [2], depth: 2, },
        { contour: box.copy(), parent: Some(1), children: [], depth: 3, },
        { contour: box.copy(), parent: None, children: [], depth: 1, },
      ],
      roots: [0, 3],
    },
  }
}

///|
test "decimal tree: conversion preserves every index depth and coordinate" {
  let original = dtw_fixture()
  let budget = dw_budget()
  let tree = decimal_tree_output(original, dw_precision(3), budget)
  assert_eq(tree.data.roots, original.data.roots)
  assert_eq(tree.data.nodes.length(), original.data.nodes.length())
  for i = 0; i < tree.data.nodes.length(); i = i + 1 {
    let a = original.data.nodes[i]
    let b = tree.data.nodes[i]
    assert_eq(b.parent, a.parent)
    assert_eq(b.children, a.children)
    assert_eq(b.depth, a.depth)
    assert_eq(
      b.contour,
      a.contour.map(fn(p) {
        PointD::new(p.x.to_double() / 1000.0, p.y.to_double() / 1000.0)
      }),
    )
  }
  // Distinct storage, including roots, children, and aliased source contours.
  original.data.roots.clear()
  original.data.nodes[0].children.clear()
  original.data.nodes[0].contour.clear()
  assert_eq(tree.data.roots, [0, 3])
  assert_eq(tree.data.nodes[0].children, [1])
  assert_eq(tree.data.nodes[0].contour.length(), 4)
  assert_eq(tree.data.nodes[1].contour.length(), 4)
}

///|
test "decimal tree: exact storage fee includes slots and object wrappers" {
  let b = dw_budget()
  let tree = decimal_tree_output(dtw_fixture(), dw_precision(3), b)
  // 4 nodes, 16 vertices, 2 root slots + 2 child slots.
  assert_eq(tree.data.nodes.length(), 4)
  assert_eq(b.stats.nodes, 4 + 5 * 4 + 2 * 16)
  assert_eq(b.stats.work, 1 + 2 * 4 + 16)
}

///|
test "decimal tree: empty conversion still charges four wrappers and one work" {
  let empty : PolyTree64 = { data: { nodes: [], roots: [], }, }
  let exact = dw_budget(nodes=4, work=1)
  assert_eq(decimal_tree_output(empty, dw_precision(3), exact).to_paths(), [])
  assert_eq((exact.stats.nodes, exact.stats.work), (4, 1))
  for b in [dw_budget(nodes=3), dw_budget(work=0)] {
    assert_true(
      wb_error(fn() raise ScanAbort {
        decimal_tree_output(empty, dw_precision(3), b)
      })
      is ResourceLimitExceeded(
        { stage: DecimalOutput, path_index: None, vertex_index: None, },
        _,
        _
      ),
    )
  }
}

///|
test "decimal tree: complete call node budget exact and one unit short" {
  let measured = dw_budget()
  assert_true(dtw_run(measured) is Ok(_))
  let exact = dw_budget(nodes=measured.stats.nodes, work=measured.stats.work)
  assert_true(dtw_run(exact) is Ok(_))
  assert_eq(
    (exact.stats.nodes, exact.stats.work),
    (measured.stats.nodes, measured.stats.work),
  )
  let short = dw_budget(
    nodes=measured.stats.nodes - 1,
    work=measured.stats.work,
  )
  assert_true(
    dtw_run(short)
    is Err(
      ResourceLimitExceeded(
        { stage: DecimalOutput, path_index: None, vertex_index: None, },
        InternalNodes,
        _
      )
    ),
  )
}

///|
test "decimal tree: complete call work budget exact and one unit short" {
  let measured = dw_budget()
  assert_true(dtw_run(measured) is Ok(_))
  let exact = dw_budget(nodes=measured.stats.nodes, work=measured.stats.work)
  assert_true(dtw_run(exact) is Ok(_))
  let short = dw_budget(
    nodes=measured.stats.nodes,
    work=measured.stats.work - 1,
  )
  assert_true(
    dtw_run(short)
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
test "decimal tree: successful integer tree does not refund output storage" {
  let measured = dw_budget()
  ignore(dtw_integer(measured))
  let b = dw_budget(nodes=measured.stats.nodes)
  let tree = dtw_integer(b)
  let before = b.stats.nodes
  assert_true(
    wb_error(fn() raise ScanAbort {
      decimal_tree_output(tree, dw_precision(3), b)
    })
    is ResourceLimitExceeded({ stage: DecimalOutput, .. }, InternalNodes, _),
  )
  assert_eq(b.stats.nodes, before)
}

///|
test "decimal tree: successful integer tree still requires decode work" {
  let measured = dw_budget()
  ignore(dtw_integer(measured))
  let b = dw_budget(work=measured.stats.work)
  let tree = dtw_integer(b)
  assert_true(
    wb_error(fn() raise ScanAbort {
      decimal_tree_output(tree, dw_precision(3), b)
    })
    is ResourceLimitExceeded({ stage: DecimalOutput, .. }, ScanWork, _),
  )
  assert_eq(b.stats.work, measured.stats.work)
}

///|
test "decimal tree: supplied budget remains authoritative and cumulative" {
  let measured = dw_budget()
  assert_true(dtw_run(measured) is Ok(_))
  let supplied = dw_budget(
    nodes=measured.stats.nodes + 7,
    work=measured.stats.work + 9,
  )
  budget_spend(supplied, 7, 9, location(DecimalOutput, None, None))
  let fake : ScanLimits = {
    input: { max_input_paths: 0, max_input_vertices: 0, },
    max_nodes: 0,
    max_work: 0,
  }
  assert_true(
    decimal_tree_execute(
      [dw_box()],
      [],
      Union,
      dw_precision(3),
      EvenOdd,
      fake,
      budget=supplied,
    )
    is Ok(_),
  )
  assert_eq(supplied.stats.nodes, measured.stats.nodes + 7)
  assert_eq(supplied.stats.work, measured.stats.work + 9)
  assert_true(
    dtw_run(dw_budget(input={ max_input_paths: 0, max_input_vertices: 0, }))
    is Err(ResourceLimitExceeded(_, InputPaths, 0)),
  )
}

///|
test "decimal tree: conversion failure in callback cleans scan state and retry succeeds" {
  let measured = dw_budget()
  ignore(dtw_integer(measured))
  // Allow the containers and one decoded vertex, fail during the contour.
  let b = dw_budget(nodes=measured.stats.nodes + 8)
  let (left, right) = dw_quantize(b)
  let observed : Array[ScanState] = []
  let result = boolean_compute(
    left,
    right,
    Union,
    b.limits,
    Parity,
    fn(state) raise ScanAbort {
      observed.push(state)
      decimal_tree_output(tree_build(state), dw_precision(3), b)
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
  let state = observed[0]
  assert_true(state.cleaned)
  assert_eq(state.output.points.length(), 0)
  assert_eq(state.output.records.length(), 0)
  assert_eq(state.ael_count, 0)
  assert_true(b.stats.nodes > measured.stats.nodes)
  assert_true(dtw_run(dw_budget()) is Ok(_))
}

///|
test "decimal tree: integer failures retain PolyTree phase" {
  let measured = pt_state()
  ignore(tree_build(measured))
  let state = pt_state(limits={
    input: Default::default(),
    max_nodes: 500000,
    max_work: measured.stats.work - 1,
  })
  // Exhaust work near integer tree verification, before decimal conversion.
  assert_true(
    wb_error(fn() raise ScanAbort { tree_build(state) })
    is ResourceLimitExceeded({ stage: PolyTree, .. }, ScanWork, _),
  )
}

///|
test "decimal tree: real nested contours convert iteratively without topology search" {
  let paths = Array::makei(16, fn(i) {
    let n = (16 - i).to_double() + 0.25
    [
      PointD::new(-n, -n),
      PointD::new(n, -n),
      PointD::new(n, n),
      PointD::new(-n, n),
    ]
  })
  let b = dw_budget()
  guard decimal_tree_execute(
      paths,
      [],
      Union,
      dw_precision(2),
      EvenOdd,
      b.limits,
      budget=b,
    )
    is Ok(tree) else {
    fail("Expected nested tree")
  }
  let mut views = tree.roots()
  for depth = 1; depth <= 16; depth = depth + 1 {
    assert_eq(views.length(), 1)
    assert_eq(views[0].depth(), depth)
    assert_eq(views[0].is_hole(), depth % 2 == 0)
    assert_eq(views[0].contour().length(), 4)
    views = views[0].children()
  }
  assert_eq(views.length(), 0)
}
