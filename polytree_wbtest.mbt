///|
priv enum InternalRefTree {
  InternalRefNode(Int, Bool, Path64, Array[InternalRefTree])
} derive(Eq, Debug)

///|
fn internal_ref_key(tree : InternalRefTree) -> String {
  match tree {
    InternalRefNode(depth, hole, path, children) =>
      depth.to_string() +
      hole.to_string() +
      path.map(fn(p) { p.x.to_string() + "," + p.y.to_string() }).join(";") +
      "(" +
      children.map(internal_ref_key).join("|") +
      ")"
  }
}

///|
fn internal_ref_sort(nodes : Array[InternalRefTree]) -> Array[InternalRefTree] {
  let result = nodes.map(fn(node) {
    match node {
      InternalRefNode(d, h, p, c) =>
        InternalRefNode(d, h, internal_canonical([p])[0], internal_ref_sort(c))
    }
  })
  for i = 1; i < result.length(); i = i + 1 {
    let mut j = i
    while j > 0 && internal_ref_key(result[j]) < internal_ref_key(result[j - 1]) {
      let tmp = result[j]
      result[j] = result[j - 1]
      result[j - 1] = tmp
      j -= 1
    }
  }
  result
}

///|
fn internal_ref_node(node : PolyNode64) -> InternalRefTree {
  InternalRefNode(
    node.depth(),
    node.is_hole(),
    internal_canonical([node.contour()])[0],
    internal_ref_sort(node.children().map(internal_ref_node)),
  )
}

///|
fn internal_reference_tree(tree : PolyTree64) -> Array[InternalRefTree] {
  internal_ref_sort(tree.roots().map(internal_ref_node))
}

///|
fn pt_state(limits? : ScanLimits = Default::default()) -> ScanState raise {
  let state = new_scan_state(limits)
  ignore(out_fixture(state, pt_rect(w=40L, h=40L)))
  ignore(out_fixture(state, wi_reverse(pt_rect(x=10L, y=10L, w=20L, h=20L))))
  state.phase = Complete
  state
}

///|
test "tree containment accepts boundary first vertex and several boundary vertices" {
  let state = new_scan_state(Default::default())
  let outer = pt_rect()
  let triangle = [wb_point(0L, 5L), wb_point(5L, 0L), wb_point(10L, 5L)]
  assert_true(tree_contains(state, outer, triangle))
  assert_eq(
    tree_point(state, 1L, 1L, [
      wb_point(0L, 0L),
      wb_point(1L, 0L),
      wb_point(0L, 1L),
    ]),
    OnBoundary,
  )
}

///|
test "tree exact midpoint determinant remains safe at both coordinate extremes" {
  let state = new_scan_state(Default::default())
  let outer = pt_rect(
    x=-1000000000L,
    y=-1000000000L,
    w=2000000000L,
    h=2000000000L,
  )
  assert_eq(tree_point(state, 1999999999L, 1999999999L, outer), Inside)
  assert_eq(tree_point(state, -2000000000L, 0L, outer), OnBoundary)
  assert_eq(tree_point(state, 2000000001L, 0L, outer), Outside)
}

///|
test "tree contact subdivision rejects a concave outside interval between boundary vertices" {
  let state = new_scan_state(Default::default())
  let l = [
    wb_point(0L, 0L),
    wb_point(20L, 0L),
    wb_point(20L, 5L),
    wb_point(5L, 5L),
    wb_point(5L, 20L),
    wb_point(0L, 20L),
  ]
  assert_true(
    !tree_contains(state, l, [
      wb_point(5L, 20L),
      wb_point(20L, 5L),
      wb_point(5L, 5L),
    ]),
  )
  assert_true(!tree_contains(state, l, pt_rect(x=10L, y=10L, w=5L, h=5L)))
}

///|
test "tree equal bounds and single vertex contact are not ownership proof" {
  let state = new_scan_state(Default::default())
  let a = [wb_point(0L, 0L), wb_point(10L, 0L), wb_point(0L, 10L)]
  let b = [wb_point(10L, 10L), wb_point(0L, 10L), wb_point(10L, 0L)]
  assert_true(!tree_contains(state, a, b))
  assert_true(!tree_contains(state, b, a))
  assert_true(!tree_contains(state, pt_rect(), pt_rect(x=10L, y=10L)))
}

///|
test "tree touching hole has explicit parent depth and unchanged contour" {
  let state = new_scan_state(Default::default())
  let outer = pt_rect(w=20L, h=20L)
  let hole = wi_reverse([
    wb_point(0L, 10L),
    wb_point(5L, 5L),
    wb_point(10L, 10L),
    wb_point(5L, 15L),
  ])
  ignore(out_fixture(state, outer))
  ignore(out_fixture(state, hole))
  let tree = tree_build(state)
  assert_eq(tree.roots().length(), 1)
  let children = tree.roots()[0].children()
  assert_eq(children.length(), 1)
  assert_eq(children[0].depth(), 2)
  assert_true(children[0].is_hole())
  assert_eq(
    internal_canonical([children[0].contour()]),
    internal_canonical([hole]),
  )
}

///|
test "tree common edge boundary with interior segments is contained exactly" {
  let state = new_scan_state(Default::default())
  assert_true(
    tree_contains(
      state,
      pt_rect(w=20L, h=20L),
      pt_rect(x=0L, y=5L, w=10L, h=10L),
    ),
  )
}

///|
test "tree uses exact remaining node and work budgets including snapshots" {
  let baseline = pt_state()
  ignore(tree_build(baseline))
  let nodes = baseline.stats.nodes
  let work = baseline.stats.work
  let exact = pt_state(limits={
    input: Default::default(),
    max_nodes: nodes,
    max_work: work,
  })
  assert_eq(tree_build(exact).roots().length(), 1)
  assert_eq(exact.stats.nodes, nodes)
  assert_eq(exact.stats.work, work)
  for
    (node_limit, work_limit, kind) in [
      (nodes - 1, work, InternalNodes),
      (nodes, work - 1, ScanWork),
    ] {
    let state = pt_state(limits={
      input: Default::default(),
      max_nodes: node_limit,
      max_work: work_limit,
    })
    let error = try {
      ignore(tree_build(state))
      None
    } catch {
      ScanAbort(e) => Some(e)
    }
    assert_true(
      error
      is Some(
        ResourceLimitExceeded(
          { stage: PolyTree, path_index: None, vertex_index: None, },
          resource,
          _
        )
      ) &&
      resource == kind,
    )
    scan_cleanup(state)
  }
  assert_eq(tree_build(pt_state()).roots().length(), 1)
}

///|
test "tree private Positive and Negative have matching geometric hierarchy" {
  let a = pt_rect(w=40L, h=40L)
  let b = wi_reverse(pt_rect(x=10L, y=10L, w=20L, h=20L))
  guard boolean_tree_execute(
      [a, b],
      [],
      Union,
      Default::default(),
      rule=Positive,
    )
    is Ok(positive) else {
    fail("Expected positive tree")
  }
  guard boolean_tree_execute(
      [wi_reverse(a), wi_reverse(b)],
      [],
      Union,
      Default::default(),
      rule=Negative,
    )
    is Ok(negative) else {
    fail("Expected negative tree")
  }
  assert_eq(
    internal_reference_tree(positive),
    internal_reference_tree(negative),
  )
  assert_eq(positive.roots()[0].children().length(), 1)
}

///|
test "tree ownership hints resolve aliases and discard deleted sources" {
  let state = pt_state()
  let redirected = output_new_record(state, None)
  state.output.records[redirected].status = Redirect(0)
  state.output.records[1].owner_hint = Some(redirected)
  state.output.records[1].hint_inside = true
  assert_eq(tree_build(state).roots()[0].children().length(), 1)
  let deleted = pt_state()
  let id = output_new_record(deleted, None)
  deleted.output.records[id].status = Invalid
  deleted.output.records[1].owner_hint = Some(id)
  assert_eq(tree_build(deleted).roots()[0].children().length(), 1)
}

///|
test "tree bounds cache is revision guarded and finalization invalidates it" {
  let state = pt_state()
  let first = tree_bounds(state, 0, pt_rect(w=40L, h=40L))
  assert_eq(first.max_x, 40L)
  state.output.records[0].revision += 1
  assert_eq(tree_bounds(state, 0, pt_rect(w=50L, h=40L)).max_x, 50L)
  let tree = tree_build(state)
  assert_eq(
    internal_canonical([tree.roots()[0].contour()]),
    internal_canonical([pt_rect(w=40L, h=40L)]),
  )
  assert_eq(state.output.records[0].bounds_cache.unwrap().1.max_x, 40L)
}

///|
fn pt_data() -> TreeData {
  {
    nodes: [
      { contour: pt_rect(w=40L, h=40L), parent: None, children: [1], depth: 1, },
      {
        contour: wi_reverse(pt_rect(x=10L, y=10L, w=20L, h=20L)),
        parent: Some(0),
        children: [],
        depth: 2,
      },
    ],
    roots: [0],
  }
}

///|
test "tree invariants reject self parent invalid parent and unreachable cycle" {
  assert_true(tree_invariants(pt_data()) is Ok(_))
  let a = pt_data()
  a.nodes[0] = {
    contour: a.nodes[0].contour,
    parent: Some(0),
    children: [1],
    depth: 1,
  }
  assert_true(tree_invariants(a) is Err(_))
  let b = pt_data()
  b.nodes[1] = {
    contour: b.nodes[1].contour,
    parent: Some(99),
    children: [],
    depth: 2,
  }
  assert_true(tree_invariants(b) is Err(_))
  let c = pt_data()
  c.roots.clear()
  assert_true(tree_invariants(c) is Err(_))
}

///|
test "tree invariants reject duplicate child omitted node and inconsistent depth" {
  let a = pt_data()
  a.nodes[0].children.push(1)
  assert_true(tree_invariants(a) is Err(_))
  let b = pt_data()
  b.nodes[0].children.clear()
  assert_true(tree_invariants(b) is Err(_))
  let c = pt_data()
  c.nodes[1].depth = 3
  assert_true(tree_invariants(c) is Err(_))
}

///|
fn pt_rect(
  x? : Int64 = 0L,
  y? : Int64 = 0L,
  w? : Int64 = 10L,
  h? : Int64 = 10L,
) -> Path64 {
  [
    wb_point(x, y),
    wb_point(x + w, y),
    wb_point(x + w, y + h),
    wb_point(x, y + h),
  ]
}

///|
test "finalization dynamic queue includes and cleans local repair split records" {
  let state = new_scan_state(Default::default())
  ignore(
    out_fixture(state, [
      wb_point(0L, 0L),
      wb_point(10L, 10L),
      wb_point(0L, 10L),
      wb_point(10L, 0L),
      wb_point(20L, 0L),
      wb_point(20L, 20L),
      wb_point(0L, 20L),
    ]),
  )
  let ids = output_finalize(state, false)
  assert_eq(ids, [0, 1])
  assert_eq(state.output.records[1].split_from, Some(0))
  assert_eq(
    internal_canonical(output_snapshot(state, ids)),
    internal_canonical([
      [
        wb_point(0L, 0L),
        wb_point(5L, 5L),
        wb_point(10L, 0L),
        wb_point(20L, 0L),
        wb_point(20L, 20L),
        wb_point(0L, 20L),
      ],
      [wb_point(5L, 5L), wb_point(10L, 10L), wb_point(0L, 10L)],
    ]),
  )
}

///|
test "tree split provenance alone never becomes a geometric parent" {
  let state = pt_state()
  state.phase = Ready
  let path = pt_rect(x=100L)
  let id = output_create(state, path[0], split_from=Some(0))
  for i = 1; i < path.length(); i = i + 1 {
    ignore(output_append(state, id, Back, path[i]))
  }
  output_close(state, id)
  let tree = tree_build(state)
  assert_eq(tree.roots().length(), 2)
  let separate = tree.roots().filter(fn(n) { n.contour()[0].x >= 100L })
  assert_eq(separate.length(), 1)
  assert_eq(separate[0].depth(), 1)
  assert_eq(separate[0].children().length(), 0)
  assert_eq(
    internal_canonical([separate[0].contour()]),
    internal_canonical([path]),
  )
}

///|
test "tree inconsistent orphan hole is an execution error instead of a fabricated root" {
  let state = new_scan_state(Default::default())
  ignore(out_fixture(state, wi_reverse(pt_rect())))
  let error = try {
    ignore(tree_build(state))
    None
  } catch {
    ScanAbort(e) => Some(e)
  }
  assert_true(
    error
    is Some(
      ExecutionFailure(
        { stage: PolyTree, path_index: None, vertex_index: None, },
        _
      )
    ),
  )
}

///|
test "tree final output verification rejects contour mismatch duplicate and alias identities" {
  let state = pt_state()
  let tree = tree_build(state)
  assert_true(tree_verify_output(state, [0, 1], tree) is Ok(_))
  let saved = tree.data.nodes[0].contour[0]
  tree.data.nodes[0].contour[0] = wb_point(999L, 999L)
  assert_true(tree_verify_output(state, [0, 1], tree) is Err(_))
  tree.data.nodes[0].contour[0] = saved
  assert_true(tree_verify_output(state, [0, 0], tree) is Err(_))
  let redirected = output_new_record(state, None)
  state.output.records[redirected].status = Redirect(1)
  assert_true(tree_verify_output(state, [0, redirected], tree) is Err(_))
}
