///|
fn out_fixture(state : ScanState, path : Path64) -> OutRecId raise {
  let id = output_create(state, path[0])
  for i = 1; i < path.length(); i = i + 1 {
    ignore(output_append(state, id, Back, path[i]))
    ix_ok(state)
  }
  output_close(state, id)
  ix_ok(state)
  id
}

///|
fn out_path(state : ScanState, id : OutRecId) -> Path64 raise {
  let rec = state.output.records[output_resolve(state, id)]
  output_ring(state, rec.anchor.unwrap()).map(fn(i) {
    state.output.points[i].point
  })
}

///|
test "output appends front and back with distinct node identity" {
  let state = new_scan_state(Default::default())
  let id = output_create(state, wb_point(0L, 0L))
  ix_ok(state)
  let a = output_append(state, id, Front, wb_point(-4L, 0L))
  ix_ok(state)
  let b = output_append(state, id, Back, wb_point(4L, 0L))
  assert_true(a != b)
  assert_eq(out_path(state, id), [
    wb_point(-4L, 0L),
    wb_point(0L, 0L),
    wb_point(4L, 0L),
  ])
  assert_eq(output_append(state, id, Back, wb_point(4L, 0L)), b)
  assert_eq(state.output.points.length(), 3)
  ix_ok(state)
}

///|
test "nonconsecutive equal coordinates remain different output nodes" {
  let state = new_scan_state(Default::default())
  let id = out_fixture(state, [
    wb_point(0L, 0L),
    wb_point(4L, 0L),
    wb_point(0L, 0L),
    wb_point(0L, 4L),
  ])
  let nodes = output_ring(state, state.output.records[id].anchor.unwrap())
  assert_true(nodes[0] != nodes[2])
  assert_eq(
    state.output.points[nodes[0]].point,
    state.output.points[nodes[2]].point,
  )
  assert_eq(nodes.length(), 4)
}

///|
test "ordinary closed output exports independently without repeated first point" {
  let state = new_scan_state(Default::default())
  ignore(out_fixture(state, wb_rectangle()))
  let paths = output_extract(state)
  assert_eq(paths, [wb_rectangle()])
  scan_cleanup(state)
  assert_eq(paths, [wb_rectangle()])
  let next = new_scan_state(Default::default())
  ignore(out_fixture(next, wb_rectangle(x=20L)))
  assert_eq(output_extract(next), [wb_rectangle(x=20L)])
  paths[0][0] = wb_point(-100L, -100L)
  assert_eq(output_extract(next), [wb_rectangle(x=20L)])
}

///|
test "output end exchange updates both record and active edge references" {
  let state = wb_pool()
  let a = edge_allocate(state, 0)
  let b = edge_allocate(state, 1)
  output_start(state, a, b, wb_point(0L, 10L))
  ix_ok(state)
  output_exchange(state, a, b)
  ix_ok(state)
  assert_eq(edge_get(state, a).output_end.unwrap().side, Back)
  assert_eq(edge_get(state, b).output_end.unwrap().side, Front)
  assert_true(
    wb_error(fn() raise ScanAbort { edge_release(state, a) })
    is InvalidInput(_, _),
  )
}

///|
test "closing an output contour detaches both active ends" {
  let state = wb_pool()
  let a = edge_allocate(state, 0)
  let b = edge_allocate(state, 1)
  output_start(state, a, b, wb_point(0L, 10L))
  ignore(output_add_edge(state, a, wb_point(0L, 0L)))
  ignore(output_add_edge(state, b, wb_point(10L, 0L)))
  output_close_or_merge(state, a, b, wb_point(5L, -5L))
  ix_ok(state)
  assert_true(edge_get(state, a).output_end is None)
  edge_release(state, a)
  edge_release(state, b)
  ix_ok(state)
}

///|
test "merging building contours rebinds surviving ends and resolves old record" {
  for sides in [(0, 1), (0, 0), (1, 1), (1, 0)] {
    let state = wb_pool()
    let a = edge_allocate(state, 0)
    let b = edge_allocate(state, 1)
    let c = edge_allocate(state, 2)
    let d = edge_allocate(state, 3)
    output_start(state, a, b, wb_point(0L, 10L))
    output_start(state, c, d, wb_point(20L, 10L))
    let first = if sides.0 == 0 { a } else { b }
    let second = if sides.1 == 0 { c } else { d }
    output_close_or_merge(state, first, second, wb_point(10L, 5L))
    ix_ok(state)
    assert_eq(output_resolve(state, 1), 0)
    assert_true(state.output.records[1].status is Redirect(0))
    let remaining_a = if first == a { b } else { a }
    let remaining_b = if second == c { d } else { c }
    output_close_or_merge(state, remaining_a, remaining_b, wb_point(10L, 0L))
    ix_ok(state)
    assert_eq(output_extract(state).length(), 1)
  }
}

///|
test "closed ring merge and split preserve all nodes and split provenance" {
  let state = new_scan_state(Default::default())
  let first = out_fixture(state, wb_rectangle())
  let second = out_fixture(state, wb_rectangle(x=20L))
  let a = state.output.records[first].anchor.unwrap()
  let b = state.output.records[second].anchor.unwrap()
  assert_eq(output_splice(state, a, b), first)
  ix_ok(state)
  assert_eq(output_resolve(state, second), first)
  assert_eq(output_ring(state, a).length(), 8)
  let split = output_splice(state, a, b)
  ix_ok(state)
  assert_eq(state.output.records[split].split_from, Some(first))
  assert_eq(output_ring(state, a).length(), 4)
  assert_eq(output_ring(state, b).length(), 4)
  for repeat = 0; repeat < 3; repeat = repeat + 1 {
    ignore(output_splice(state, a, b))
    ix_ok(state)
    ignore(output_splice(state, a, b))
    ix_ok(state)
  }
}

///|
test "output cleanup preserves collinear option and removes repeated closing point" {
  for preserve in [true, false] {
    let state = new_scan_state(Default::default())
    let id = out_fixture(state, [
      wb_point(0L, 0L),
      wb_point(5L, 0L),
      wb_point(10L, 0L),
      wb_point(10L, 10L),
      wb_point(0L, 10L),
      wb_point(0L, 0L),
    ])
    output_clean(state, id, preserve)
    ix_ok(state)
    assert_eq(out_path(state, id).length(), if preserve { 5 } else { 4 })
  }
}

///|
test "spikes and reference tiny triangles are removed without a new tolerance" {
  let state = new_scan_state(Default::default())
  let id = out_fixture(state, [
    wb_point(0L, 0L),
    wb_point(5L, 0L),
    wb_point(3L, 0L),
    wb_point(10L, 0L),
    wb_point(10L, 10L),
    wb_point(0L, 10L),
  ])
  output_clean(state, id, true)
  ix_ok(state)
  assert_eq(out_path(state, id), [
    wb_point(0L, 0L),
    wb_point(3L, 0L),
    wb_point(10L, 0L),
    wb_point(10L, 10L),
    wb_point(0L, 10L),
  ])
  let tiny = new_scan_state(Default::default())
  ignore(
    out_fixture(tiny, [wb_point(0L, 0L), wb_point(1L, 0L), wb_point(0L, 20L)]),
  )
  assert_eq(output_extract(tiny), [])
  ix_ok(tiny)
}

///|
test "output checker rejects broken links wrong anchors and redirect cycles" {
  for mode in [0, 1, 2, 3] {
    let state = new_scan_state(Default::default())
    let id = out_fixture(state, wb_rectangle())
    let anchor = state.output.records[id].anchor.unwrap()
    if mode == 0 {
      state.output.points[anchor].next = anchor
    } else if mode == 1 {
      state.output.records[id].anchor = Some(999)
    } else if mode == 2 {
      state.output.records[id].status = Redirect(id)
      state.output.records[id].anchor = None
    } else {
      state.output.points[anchor].record = 999
    }
    assert_true(output_invariants(state) is Err(_))
  }
}

///|
test "disposed point and cyclic redirection fail instead of looping" {
  let state = new_scan_state(Default::default())
  let id = out_fixture(state, [
    wb_point(0L, 0L),
    wb_point(1L, 0L),
    wb_point(0L, 1L),
  ])
  output_clean(state, id, true)
  assert_true(
    wb_error(fn() raise ScanAbort { output_point(state, 0) })
    is InvalidInput(_, _),
  )
  let cycle = new_scan_state(Default::default())
  let record = output_create(cycle, wb_point(0L, 0L))
  cycle.output.records[record].status = Redirect(record)
  assert_true(
    wb_error(fn() raise ScanAbort { output_resolve(cycle, record) })
    is InvalidInput(_, _),
  )
}

///|
test "exact output allocation and one-less node quota are atomic" {
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 2,
    max_work: 100,
  }
  let state = new_scan_state(limits)
  ignore(output_create(state, wb_point(0L, 0L)))
  ix_ok(state)
  assert_eq(state.stats.nodes, 2)
  let short = new_scan_state({
    input: limits.input,
    max_nodes: 1,
    max_work: 100,
  })
  assert_true(
    wb_error(fn() raise ScanAbort { output_create(short, wb_point(0L, 0L)) })
    is ResourceLimitExceeded(_, InternalNodes, 1),
  )
  assert_eq(short.output.points.length(), 0)
  assert_eq(short.output.records.length(), 0)
  ix_ok(short)
}

///|
test "output export budget exhaustion never returns partial success" {
  let base = new_scan_state(Default::default())
  ignore(out_fixture(base, wb_rectangle()))
  ignore(output_extract(base))
  let exact = new_scan_state({
    input: Default::default(),
    max_nodes: base.stats.nodes,
    max_work: base.stats.work,
  })
  ignore(out_fixture(exact, wb_rectangle()))
  assert_eq(output_extract(exact), [wb_rectangle()])
  let short = new_scan_state({
    input: Default::default(),
    max_nodes: base.stats.nodes,
    max_work: base.stats.work - 1,
  })
  ignore(out_fixture(short, wb_rectangle()))
  assert_true(
    wb_error(fn() raise ScanAbort { output_extract(short) })
    is ResourceLimitExceeded(_, ScanWork, _),
  )
  assert_eq(short.phase, Failed)
  ix_ok(short)
}

///|
test "unfinished records cannot be extracted as successful contours" {
  let state = new_scan_state(Default::default())
  ignore(output_create(state, wb_point(0L, 0L)))
  assert_true(
    wb_error(fn() raise ScanAbort { output_extract(state) })
    is InvalidInput(_, _),
  )
}

///|
fn engine_fixture(
  paths : Paths64,
  decide : (EngineEvent) -> ConnectionDecision,
) -> ScanState raise {
  let state = wb_prepared(paths)
  for steps = 0; steps < 1000; steps = steps + 1 {
    match engine_step(state, decide) {
      Err(error) => fail(error.message())
      Ok(Complete) => {
        ix_ok(state)
        return state
      }
      _ => ix_ok(state)
    }
  }
  fail("Explicit engine fixture step bound exhausted")
}

///|
fn simple_contour_decision(event : EngineEvent) -> ConnectionDecision {
  match event.kind {
    Minimum => StartContour
    Maximum => CloseOrMerge
    _ => ContinueContours
  }
}

///|
test "scan-generated rectangle events construct the complete output contour" {
  let state = engine_fixture([wb_rectangle()], simple_contour_decision)
  let paths = output_extract(state, preserve_collinear=false)
  assert_eq(paths.length(), 1)
  assert_eq(area2(paths[0]), Ok(-200N))
  assert_eq(paths[0].length(), 4)
  assert_eq(point_in_polygon(wb_point(5L, 5L), paths[0]), Ok(Inside))
}

///|
test "scan-generated crossing builds two rings with explicit crossing decision" {
  let state = engine_fixture(
    [
      [
        wb_point(-4L, -4L),
        wb_point(4L, 4L),
        wb_point(-4L, 4L),
        wb_point(4L, -4L),
      ],
    ],
    fn(event) {
      match event.kind {
        Minimum => StartContour
        Crossing => CloseAndStart
        Maximum => CloseOrMerge
        _ => ContinueContours
      }
    },
  )
  let paths = output_extract(state, preserve_collinear=false)
  assert_eq(paths.length(), 2)
  assert_eq(paths[0].length(), 3)
  assert_eq(paths[1].length(), 3)
  assert_eq(state.output.records[1].split_from, Some(0))
  assert_eq(area2(paths[0]), Ok(-32N))
  assert_eq(area2(paths[1]), Ok(32N))
}

///|
test "no contribution decision retains pending minimum and creates no output" {
  let state = wb_prepared([wb_rectangle()])
  assert_true(engine_step(state, fn(_) { Defer }) is Ok(EnterMinima))
  assert_true(engine_step(state, fn(_) { Defer }) is Ok(Horizontals))
  assert_eq(state.pending_connections.length(), 1)
  assert_eq(state.connection_cursor, 0)
  assert_eq(state.output.records.length(), 0)
  assert_true(engine_step(state, fn(_) { Defer }) is Ok(Horizontals))
  assert_eq(state.output.records.length(), 0)
  ix_ok(state)
}

///|
test "local self-cross repair preserves the source triangle decision and exact area total" {
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
  let paths = output_extract(state, preserve_collinear=false)
  ix_ok(state)
  assert_eq(paths.length(), 2)
  assert_eq(area2(paths[0]), Ok(750N))
  assert_eq(area2(paths[1]), Ok(50N))
  assert_eq(state.output.records[1].split_from, Some(0))
}

///|
test "micro self-cross repair inserts the fixed fifth coordinate and terminates" {
  let state = new_scan_state(Default::default())
  let id = out_fixture(state, [
    wb_point(0L, 0L),
    wb_point(10L, 10L),
    wb_point(0L, 10L),
    wb_point(10L, 0L),
    wb_point(0L, 5L),
    wb_point(-10L, 0L),
  ])
  output_repair_local(state, id)
  ix_ok(state)
  assert_eq(state.output.points[6].point, wb_point(0L, 5L))
  assert_true(state.output.points.length() < 32)
}

///|
test "output self-cross small-area disposal does not filter the original input" {
  let path = [
    wb_point(-4L, -4L),
    wb_point(4L, 4L),
    wb_point(-4L, 4L),
    wb_point(4L, -4L),
  ]
  let state = new_scan_state(Default::default())
  ignore(out_fixture(state, path))
  assert_eq(output_extract(state), [])
  ix_ok(state)
  assert_eq(wb_prepared([path]).chains.length(), 2)
}

///|
test "split allocation failure leaves a valid merged ring and fresh call succeeds" {
  let measured = new_scan_state(Default::default())
  let ma = out_fixture(measured, wb_rectangle())
  let mb = out_fixture(measured, wb_rectangle(x=20L))
  let mf = measured.output.records[ma].anchor.unwrap()
  let ms = measured.output.records[mb].anchor.unwrap()
  ignore(output_splice(measured, mf, ms))
  let used = measured.stats.nodes
  let ring = output_ring(measured, mf)
  // Allow the entire ring scratch, but not the new split record itself.
  let limit = used + ring.length() + 1
  let state = new_scan_state({
    input: Default::default(),
    max_nodes: limit,
    max_work: 10000,
  })
  let a = out_fixture(state, wb_rectangle())
  let b = out_fixture(state, wb_rectangle(x=20L))
  let first = state.output.records[a].anchor.unwrap()
  let second = state.output.records[b].anchor.unwrap()
  ignore(output_splice(state, first, second))
  let error = wb_error(fn() raise ScanAbort {
    output_splice(state, first, second)
  })
  assert_true(
    error
    is ResourceLimitExceeded(
      { stage: OutputTopology, .. },
      InternalNodes,
      actual
    ) &&
    actual == limit,
  )
  assert_eq(state.stats.nodes, limit)
  assert_eq(state.output.records.length(), 2)
  ix_ok(state)
  let fresh = new_scan_state(Default::default())
  ignore(out_fixture(fresh, wb_rectangle()))
  assert_eq(output_extract(fresh), [wb_rectangle()])
}

///|
test "multiple merge redirections resolve without geometric ownership assumptions" {
  let state = new_scan_state(Default::default())
  let a = out_fixture(state, wb_rectangle())
  let b = out_fixture(state, wb_rectangle(x=20L))
  let c = out_fixture(state, wb_rectangle(x=40L))
  let first = state.output.records[a].anchor.unwrap()
  let second = state.output.records[b].anchor.unwrap()
  let third = state.output.records[c].anchor.unwrap()
  ignore(output_splice(state, first, second))
  ignore(output_splice(state, third, first))
  ix_ok(state)
  assert_eq(output_resolve(state, b), c)
  assert_eq(state.output.records[b].split_from, None)
}

///|
test "scan-generated concave contour merges real entering output chains" {
  let path = [
    wb_point(0L, 0L),
    wb_point(12L, 0L),
    wb_point(12L, 12L),
    wb_point(8L, 12L),
    wb_point(8L, 4L),
    wb_point(4L, 4L),
    wb_point(4L, 12L),
    wb_point(0L, 12L),
  ]
  let state = engine_fixture([path], simple_contour_decision)
  let paths = output_extract(state, preserve_collinear=false)
  ix_ok(state)
  assert_eq(paths.length(), 1)
  assert_eq(paths[0].length(), 8)
  assert_eq(area2(paths[0]), Ok(-224N))
}

///|
test "geometry events and output share exact cumulative work allowance" {
  let base = engine_fixture([wb_rectangle()], simple_contour_decision)
  ignore(output_extract(base))
  for short in [false, true] {
    let state = wb_limited([wb_rectangle()], {
      input: Default::default(),
      max_nodes: base.stats.nodes,
      max_work: base.stats.work - (if short { 1 } else { 0 }),
    })
    for steps = 0; steps < 100; steps = steps + 1 {
      guard engine_step(state, simple_contour_decision) is Ok(phase) else {
        fail("Budget should reach output extraction")
      }
      ix_ok(state)
      if phase == Complete {
        break
      }
    }
    if short {
      assert_true(
        wb_error(fn() raise ScanAbort { output_extract(state) })
        is ResourceLimitExceeded(_, ScanWork, _),
      )
      assert_eq(state.phase, Failed)
    } else {
      assert_eq(output_extract(state).length(), 1)
      assert_eq(state.stats, base.stats)
    }
    ix_ok(state)
  }
}
