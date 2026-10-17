///|
test "scan preparation builds isolated circular vertices and extrema" {
  let path = [
    Point64::new(0L, 0L),
    Point64::new(10L, 0L),
    Point64::new(10L, 10L),
    Point64::new(0L, 10L),
  ]
  guard prepare_scan([path], []) is Ok(state) else {
    fail("Expected prepared state")
  }
  assert_eq(state.vertices.length(), 4)
  assert_eq(state.minima.length(), 1)
  assert_eq(state.chains.length(), 2)
  assert_eq(state.vertices[0].prev, Some(3))
  path[0] = Point64::new(-1L, -1L)
  assert_eq(state.vertices[0].point.x, 0L)
  assert_eq(height_pop(state), Some(10L))
  assert_eq(height_pop(state), None)
}

///|
fn wb_point(x : Int64, y : Int64) -> Point64 {
  Point64::new(x, y)
}

///|
fn wb_rectangle(x? : Int64 = 0L) -> Path64 {
  [
    wb_point(x, 0L),
    wb_point(x + 10L, 0L),
    wb_point(x + 10L, 10L),
    wb_point(x, 10L),
  ]
}

///|
fn wb_prepared(paths : Paths64, clip? : Paths64 = []) -> ScanState raise {
  match prepare_scan(paths, clip) {
    Ok(state) => state
    Err(error) => fail(error.message())
  }
}

///|
fn wb_ok(state : ScanState, stable? : Bool = false) -> Unit raise {
  match scan_invariants(state, stable~) {
    Ok(_) => ()
    Err(message) => fail(message)
  }
}

///|
fn wb_drive_clear(state : ScanState) -> Unit raise {
  for steps = 0; steps < 1000; steps = steps + 1 {
    let phase = match scan_step(state) {
      Ok(value) => value
      Err(error) => fail(error.message())
    }
    wb_ok(state)
    match phase {
      Complete => return
      AwaitMaxima(_, a, b) => {
        commit_maxima(state, a, b)
        wb_ok(state)
      }
      AwaitEntryContact(_, _, _) =>
        fail("Unexpected entry contact in clear fixture")
      AwaitHorizontal(_) =>
        fail("Unexpected horizontal crossing in clear-scan fixture")
      AwaitIntersections(_) =>
        fail("Unexpected band crossing in clear-scan fixture")
      _ => ()
    }
  }
  fail("Clear scan exceeded explicit test step bound")
}

///|
test "scan rectangle completes lifecycle with explicit maxima consumption" {
  let state = wb_prepared([wb_rectangle()])
  wb_drive_clear(state)
  assert_eq(state.stats.heights, 2)
  assert_eq(state.stats.peak_active, 2)
  assert_eq(state.stats.horizontal_steps, 2)
  assert_eq(state.exits.length(), 1)
  assert_eq(state.live_edges, 0)
  scan_cleanup(state)
  wb_ok(state)
}

///|
fn wb_before_band(state : ScanState) -> Unit raise {
  for step = 0; step < 100; step = step + 1 {
    guard scan_step(state) is Ok(phase) else {
      fail("Scan failed before a stable band")
    }
    wb_ok(state)
    if phase == PrepareBand {
      wb_ok(state, stable=true)
      return
    }
    match phase {
      AwaitIntersections(_)
      | AwaitHorizontal(_)
      | AwaitMaxima(_, _, _)
      | AwaitEntryContact(_, _, _) =>
        fail("Unexpected pending event before first band")
      _ => ()
    }
  }
  fail("No stable band")
}

///|
fn wb_limited(subject : Paths64, limits : ScanLimits) -> ScanState raise {
  match prepare_scan(subject, [], limits~) {
    Ok(state) => state
    Err(error) => fail(error.message())
  }
}

///|
test "triangle and concave contour classify and complete real chains" {
  for
    path in [
      [wb_point(0L, 0L), wb_point(10L, 0L), wb_point(5L, 10L)],
      [
        wb_point(0L, 0L),
        wb_point(12L, 0L),
        wb_point(12L, 12L),
        wb_point(8L, 12L),
        wb_point(8L, 4L),
        wb_point(4L, 4L),
        wb_point(4L, 12L),
        wb_point(0L, 12L),
      ],
    ] {
    let state = wb_prepared([path])
    wb_ok(state)
    wb_drive_clear(state)
    assert_eq(state.live_edges, 0)
    assert_eq(state.exits.length(), state.minima.length())
  }
}

///|
test "seam-spanning horizontal chains register one extremum per plateau" {
  let path = [
    wb_point(5L, 10L),
    wb_point(0L, 10L),
    wb_point(0L, 0L),
    wb_point(10L, 0L),
    wb_point(10L, 10L),
  ]
  let state = wb_prepared([path])
  wb_ok(state)
  assert_eq(state.minima.length(), 1)
  assert_eq(state.vertices[state.minima[0].vertex].point, wb_point(10L, 10L))
  wb_drive_clear(state)
  assert_eq(state.stats.horizontal_steps, 3)
}

///|
test "empty singleton two-point and entirely horizontal contours retain provenance" {
  let paths = [
    [],
    [wb_point(1L, 2L)],
    [wb_point(0L, 0L), wb_point(1L, 1L)],
    [wb_point(0L, 3L), wb_point(1L, 3L), wb_point(2L, 3L)],
  ]
  let state = wb_prepared(paths)
  wb_ok(state)
  assert_eq(state.paths.length(), 4)
  assert_eq(state.vertices.length(), 6)
  for path in state.paths {
    assert_true(!path.scannable)
  }
  assert_eq(state.minima.length(), 0)
  wb_drive_clear(state)
  assert_eq(state.stats.heights, 0)
}

///|
test "normalized snapshot maps back to original vertices and distinguishes operand roles" {
  let a = wb_point(0L, 0L)
  let b = wb_point(10L, 0L)
  let c = wb_point(0L, 10L)
  let state = wb_prepared([[a, a, b, c, a, a]], clip=[[], [c, b, a]])
  wb_ok(state)
  assert_eq(state.paths[0].raw_count, 6)
  assert_eq(state.paths[0].vertices.length(), 3)
  assert_eq(state.vertices[1].source.vertex, 2)
  assert_eq(state.vertices[2].source.vertex, 3)
  assert_eq(state.vertices[3].source.role, Clip)
  assert_eq(state.vertices[3].source.path, 1)
  assert_eq(state.vertices[3].source.global_path, 2)
}

///|
test "zero area bowtie retains scanning structure and suspends on real crossing" {
  let path = [
    wb_point(-4L, -4L),
    wb_point(4L, 4L),
    wb_point(-4L, 4L),
    wb_point(4L, -4L),
  ]
  assert_eq(area2(path), Ok(0N))
  let state = wb_prepared([path])
  wb_before_band(state)
  let before = wb_edges(state)
  assert_true(scan_step(state) is Ok(AwaitIntersections(-4L)))
  assert_eq(wb_edges(state), before)
  assert_eq(state.current_y, Some(4L))
  assert_true(scan_step(state) is Ok(AwaitIntersections(-4L)))
  wb_ok(state)
}

///|
test "manual intersection event swaps real neighbors before band commit" {
  let state = wb_prepared([
    [wb_point(-4L, -4L), wb_point(4L, 4L), wb_point(-4L, 4L), wb_point(4L, -4L)],
  ])
  wb_before_band(state)
  ignore(scan_step(state))
  let ids = wb_edges(state)
  assert_eq(ids.length(), 2)
  let old_sel = wb_edges(state, auxiliary=true)
  ael_swap(state, ids[0], ids[1])
  wb_ok(state)
  assert_eq(wb_edges(state, auxiliary=true), old_sel)
  commit_band(state, -4L)
  wb_ok(state, stable=true)
  assert_eq(state.current_y, Some(-4L))
  assert_eq(state.sel_head, None)
}

///|
test "inverted band cannot be committed without processing its crossing" {
  let state = wb_prepared([
    [wb_point(-4L, -4L), wb_point(4L, 4L), wb_point(-4L, 4L), wb_point(4L, -4L)],
  ])
  wb_before_band(state)
  ignore(scan_step(state))
  assert_true(
    wb_error(fn() raise ScanAbort { commit_band(state, -4L) })
    is InvalidInput(_, _),
  )
  assert_eq(state.phase, Failed)
  wb_ok(state)
}

///|
test "horizontal crossing remains held at an explicit pending boundary" {
  let state = wb_prepared([
    wb_rectangle(),
    [wb_point(5L, 5L), wb_point(15L, 5L), wb_point(15L, 15L), wb_point(5L, 15L)],
  ])
  let mut found = false
  for step = 0; step < 50; step = step + 1 {
    guard scan_step(state) is Ok(phase) else { fail("Unexpected scan failure") }
    wb_ok(state)
    match phase {
      AwaitHorizontal(id) => {
        assert_eq(state.held_horizontal, Some(id))
        assert_true(horizontal_crossing(state, id) is Some(_))
        found = true
        break
      }
      AwaitMaxima(_, a, b) => commit_maxima(state, a, b)
      AwaitIntersections(_) =>
        fail("Fixture should first meet a horizontal crossing")
      _ => ()
    }
  }
  assert_true(found)
}

///|
test "height queue handles zero negatives duplicates and dynamically added heights" {
  let state = new_scan_state(Default::default())
  assert_eq(height_pop(state), None)
  for height in [0L, -5L, 10L, 0L, 10L, -1L] {
    height_push(state, height)
  }
  assert_eq(state.heap.length(), 4)
  assert_eq(height_pop(state), Some(10L))
  height_push(state, 5L)
  assert_eq(height_pop(state), Some(5L))
  assert_eq(height_pop(state), Some(0L))
  assert_eq(height_pop(state), Some(-1L))
  assert_eq(height_pop(state), Some(-5L))
  assert_eq(height_pop(state), None)
}

///|
test "same-height local minima are all entered and processed as one height" {
  let paths = Array::makei(20, fn(i) { wb_rectangle(x=i.to_int64() * 20L) })
  let state = wb_prepared(paths)
  assert_eq(state.minima.length(), 20)
  assert_eq(state.heap.length(), 1)
  wb_before_band(state)
  assert_eq(state.ael_count, 40)
  wb_ok(state, stable=true)
  wb_drive_clear(state)
  assert_eq(state.stats.heights, 2)
  assert_eq(state.exits.length(), 20)
  let many = Array::makei(300, fn(i) { wb_rectangle(x=i.to_int64() * 20L) })
  let prepared = wb_prepared(many)
  let bounded = wb_limited(many, {
    input: Default::default(),
    max_nodes: 100000,
    max_work: prepared.stats.work + 1000,
  })
  assert_true(scan_step(bounded) is Ok(EnterMinima))
  assert_true(scan_step(bounded) is Err(ResourceLimitExceeded(_, ScanWork, _)))
  assert_eq(bounded.phase, Failed)
  wb_ok(bounded)
  scan_cleanup(bounded)
  wb_ok(bounded)
}

///|
test "height insertion above the current stage is rejected" {
  let state = new_scan_state(Default::default())
  state.current_y = Some(0L)
  assert_true(
    wb_error(fn() raise ScanAbort { height_push(state, 1L) })
    is InvalidInput(_, _),
  )
  assert_eq(state.phase, Failed)
}

///|
test "separate operand inputs share raw path and vertex budgets" {
  let limits : ScanLimits = {
    input: { max_input_paths: 2, max_input_vertices: 7, },
    max_nodes: 100,
    max_work: 1000,
  }
  assert_true(
    prepare_scan([wb_rectangle()], [wb_rectangle()], limits~)
    is Err(ResourceLimitExceeded(_, InputVertices, 7)),
  )
  let limits : ScanLimits = {
    input: { max_input_paths: 1, max_input_vertices: 20, },
    max_nodes: 100,
    max_work: 1000,
  }
  assert_true(
    prepare_scan([[]], [[]], limits~)
    is Err(ResourceLimitExceeded(_, InputPaths, 1)),
  )
  let limits : ScanLimits = {
    input: { max_input_paths: 2, max_input_vertices: 8, },
    max_nodes: 100,
    max_work: 1000,
  }
  assert_true(
    prepare_scan([wb_rectangle()], [wb_rectangle(x=20L)], limits~) is Ok(_),
  )
}

///|
test "preparation errors locate clip original raw coordinates before copying" {
  let path = [wb_point(0L, 0L), wb_point(0L, 0L), wb_point(1000000001L, 0L)]
  match prepare_scan([[]], [path]) {
    Err(CoordinateOutOfRange(loc, X, value)) => {
      assert_eq(loc.stage, EnginePrepare)
      assert_eq(loc.path_index, Some(1))
      assert_eq(loc.vertex_index, Some(2))
      assert_eq(value, 1000000001L)
    }
    _ => fail("Expected raw clip coordinate error")
  }
  assert_eq(path.length(), 3)
}

///|
test "negative internal limits and zero node allowances are explicit errors" {
  for
    limits in [
      { input: Default::default(), max_nodes: -1, max_work: 100, },
      { input: Default::default(), max_nodes: 100, max_work: -1, },
    ] {
    assert_true(prepare_scan([], [], limits~) is Err(InvalidInput(_, _)))
  }
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 0,
    max_work: 1000,
  }
  assert_true(
    prepare_scan([wb_rectangle()], [], limits~)
    is Err(ResourceLimitExceeded(_, InternalNodes, 0)),
  )
  assert_true(prepare_scan([], [], limits~) is Ok(_))
}

///|
test "exact preparation node and work budgets pass and one fewer fails" {
  let baseline = wb_prepared([wb_rectangle()])
  let exact : ScanLimits = {
    input: Default::default(),
    max_nodes: baseline.stats.nodes,
    max_work: baseline.stats.work,
  }
  let state = wb_limited([wb_rectangle()], exact)
  wb_ok(state)
  assert_eq(state.stats.nodes, baseline.stats.nodes)
  assert_eq(state.stats.work, baseline.stats.work)
  assert_true(
    prepare_scan([wb_rectangle()], [], limits={
      input: exact.input,
      max_nodes: exact.max_nodes - 1,
      max_work: exact.max_work,
    })
    is Err(ResourceLimitExceeded(_, InternalNodes, _)),
  )
  assert_true(
    prepare_scan([wb_rectangle()], [], limits={
      input: exact.input,
      max_nodes: exact.max_nodes,
      max_work: exact.max_work - 1,
    })
    is Err(ResourceLimitExceeded(_, ScanWork, _)),
  )
}

///|
test "allocation of an associated minima pair preflights both nodes" {
  let baseline = wb_prepared([wb_rectangle()])
  let state = wb_limited([wb_rectangle()], {
    input: Default::default(),
    max_nodes: baseline.stats.nodes + 1,
    max_work: 10000,
  })
  assert_true(scan_step(state) is Ok(EnterMinima))
  assert_true(
    scan_step(state) is Err(ResourceLimitExceeded(_, InternalNodes, _)),
  )
  assert_eq(state.live_edges, 0)
  wb_ok(state)
}

///|
test "full scan budgets are cumulative across stages and repeat deterministically" {
  let baseline = wb_prepared([wb_rectangle()])
  wb_drive_clear(baseline)
  let exact : ScanLimits = {
    input: Default::default(),
    max_nodes: baseline.stats.nodes,
    max_work: baseline.stats.work,
  }
  let state = wb_limited([wb_rectangle()], exact)
  wb_drive_clear(state)
  assert_eq(state.stats, baseline.stats)
  let short = wb_limited([wb_rectangle()], {
    input: exact.input,
    max_nodes: exact.max_nodes,
    max_work: exact.max_work - 1,
  })
  let mut failed = false
  for step = 0; step < 100; step = step + 1 {
    match scan_step(short) {
      Err(ResourceLimitExceeded(_, ScanWork, _)) => {
        failed = true
        break
      }
      Err(error) => fail(error.message())
      Ok(AwaitMaxima(_, a, b)) => commit_maxima(short, a, b)
      Ok(Complete) => fail("One less work unit must fail")
      _ => ()
    }
  }
  assert_true(failed)
  assert_eq(short.phase, Failed)
  scan_cleanup(short)
  wb_ok(short)
  let fresh = wb_prepared([wb_rectangle()])
  wb_drive_clear(fresh)
  assert_eq(fresh.stats, baseline.stats)
}

///|
test "multiple contours share node creation rather than each receiving a fresh quota" {
  let one = wb_prepared([wb_rectangle()])
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: one.stats.nodes,
    max_work: 100000,
  }
  assert_true(
    prepare_scan([wb_rectangle(), wb_rectangle(x=20L)], [], limits~)
    is Err(ResourceLimitExceeded(_, InternalNodes, _)),
  )
}

///|
test "work exhausted in list insertion fails instead of comparing equal" {
  let baseline = wb_pool()
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 1000,
    max_work: baseline.stats.work + 4,
  }
  let state = wb_limited([wb_rectangle(), wb_rectangle(x=20L)], limits)
  let first = wb_insert(state, 0, 0L)
  let second = edge_allocate(state, 1)
  assert_true(
    wb_error(fn() raise ScanAbort { ael_insert(state, second) })
    is ResourceLimitExceeded(_, ScanWork, _),
  )
  assert_eq(state.ael_head, Some(first))
  assert_eq(state.ael_count, 1)
  assert_eq(state.phase, Failed)
  wb_ok(state)
}

///|
test "horizontal traversal exhausts the same shared work context" {
  let base = wb_prepared([wb_rectangle()])
  wb_before_band(base)
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 1000,
    max_work: base.stats.work - 1,
  }
  let state = wb_limited([wb_rectangle()], limits)
  let mut failed = false
  for step = 0; step < 20; step = step + 1 {
    if scan_step(state) is Err(ResourceLimitExceeded(_, ScanWork, _)) {
      failed = true
      break
    }
  }
  assert_true(failed)
  assert_eq(state.phase, Failed)
}

///|
test "opposite input winding is preserved in boundary directions" {
  let path = wb_rectangle()
  let reverse = Array::makei(path.length(), fn(i) {
    path[path.length() - i - 1]
  })
  for input in [path, reverse] {
    let state = wb_prepared([input])
    wb_before_band(state)
    height_push(state, 5L)
    wb_before_band(state)
    assert_eq(state.current_y, Some(5L))
    let ids = wb_edges(state)
    assert_eq(
      state.chains[edge_get(state, ids[0]).chain].direction +
      state.chains[edge_get(state, ids[1]).chain].direction,
      0,
    )
    wb_ok(state, stable=true)
    wb_drive_clear(state)
  }
}

///|
test "fully coincident collinear boundaries stop without arbitrary band resorting" {
  let state = wb_prepared([wb_rectangle(), wb_rectangle()])
  let mut pending = false
  for step = 0; step < 20; step = step + 1 {
    guard scan_step(state) is Ok(phase) else {
      fail("Unexpected coincident preparation failure")
    }
    wb_ok(state)
    match phase {
      AwaitHorizontal(_) | AwaitIntersections(_) | AwaitEntryContact(_, _, _) => {
        pending = true
        break
      }
      _ => ()
    }
  }
  assert_true(pending)
}

///|
fn wb_shared_bends() -> Paths64 {
  [
    [wb_point(0L, 10L), wb_point(0L, 4L), wb_point(4L, 0L), wb_point(8L, 5L)],
    [
      wb_point(0L, 10L),
      wb_point(0L, 8L),
      wb_point(0L, 6L),
      wb_point(-4L, 0L),
      wb_point(-8L, 5L),
    ],
  ]
}

///|
test "collinear insertion looks beyond repeated straight segments before source tie break" {
  let state = wb_prepared(wb_shared_bends())
  let left = edge_allocate(state, state.minima[1].forward.unwrap())
  let right = edge_allocate(state, state.minima[0].forward.unwrap())
  let a = edge_get(state, left)
  let b = edge_get(state, right)
  assert_eq(edge_position_compare(state, a, b), 0)
  assert_true(!stable_chain_before(state, a, b))
  let work = state.stats.work
  assert_true(resident_before_new(state, a, b))
  assert_eq(state.stats.work - work, 3)
  assert_eq(state.stats.comparisons, 1)
  wb_ok(state)
}

///|
test "collinear starting bounds use left identity before arbitrary input ordering" {
  let state = wb_prepared([
    [wb_point(0L, 10L), wb_point(0L, 5L), wb_point(5L, 0L), wb_point(10L, 5L)],
    [wb_point(0L, 10L), wb_point(0L, 5L), wb_point(-5L, 0L), wb_point(-10L, 5L)],
  ])
  let a = edge_get(
    state,
    edge_allocate(state, state.minima[1].forward.unwrap()),
  )
  let b = edge_get(
    state,
    edge_allocate(state, state.minima[0].forward.unwrap()),
  )
  assert_true(!state.chains[a.chain].left_bound)
  assert_true(state.chains[b.chain].left_bound)
  assert_true(!stable_chain_before(state, a, b))
  assert_true(resident_before_new(state, a, b))
}

///|
test "lookahead work exhaustion is an error rather than an equality result" {
  let base = wb_prepared(wb_shared_bends())
  let state = wb_limited(wb_shared_bends(), {
    input: Default::default(),
    max_nodes: 1000,
    max_work: base.stats.work + 4,
  })
  let a = edge_get(
    state,
    edge_allocate(state, state.minima[1].forward.unwrap()),
  )
  let b = edge_get(
    state,
    edge_allocate(state, state.minima[0].forward.unwrap()),
  )
  assert_true(
    wb_error(fn() raise ScanAbort { resident_before_new(state, a, b) })
    is ResourceLimitExceeded(_, ScanWork, _),
  )
  assert_eq(state.phase, Failed)
  wb_ok(state)
}

///|
test "boundary advancement checks work before mutating its cursor" {
  let base = wb_prepared([wb_rectangle()])
  let state = wb_limited([wb_rectangle()], {
    input: Default::default(),
    max_nodes: 1000,
    max_work: base.stats.work + 1,
  })
  let id = edge_allocate(state, state.minima[0].backward.unwrap())
  let edge = edge_get(state, id)
  state.current_y = Some(state.vertices[edge.top].point.y)
  let error = wb_error(fn() raise ScanAbort { edge_advance(state, id) })
  match error {
    ResourceLimitExceeded(loc, ScanWork, _) => {
      assert_eq(loc.stage, ScanTop)
      assert_eq(loc.path_index, Some(0))
      assert_true(loc.vertex_index is Some(_))
    }
    _ => fail("Expected located boundary work error")
  }
  assert_eq(edge.cursor, 0)
  wb_ok(state)
}

///|
test "duplicate height inserted after consumption does not create another phase" {
  let state = new_scan_state(Default::default())
  height_push(state, 0L)
  assert_eq(height_pop(state), Some(0L))
  height_push(state, 0L)
  height_push(state, -1L)
  assert_eq(height_pop(state), Some(-1L))
  assert_eq(height_pop(state), None)
}

///|
test "multiple extrema retain every plateau and pair boundary exits" {
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
  let state = wb_prepared([path])
  assert_eq(state.minima.length(), 2)
  assert_eq(state.chains.length(), 4)
  wb_drive_clear(state)
  assert_eq(state.stats.heights, 3)
  assert_eq(state.stats.peak_active, 4)
  assert_eq(state.exits.length(), 2)
}

///|
test "zero work budget rejects raw preflight and cannot leak into a new call" {
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 1000,
    max_work: 0,
  }
  assert_true(
    prepare_scan([wb_rectangle()], [], limits~)
    is Err(ResourceLimitExceeded(_, ScanWork, 0)),
  )
  let fresh = wb_prepared([wb_rectangle()])
  wb_drive_clear(fresh)
  assert_eq(fresh.stats.heights, 2)
}

///|
test "pending horizontal cannot be detached or advanced before consumption" {
  for operation in [0, 1] {
    let state = wb_prepared([wb_rectangle()])
    let id = edge_allocate(state, state.minima[0].forward.unwrap())
    ael_insert(state, id)
    horizontal_push(state, id)
    state.current_y = Some(10L)
    let error = if operation == 0 {
      wb_error(fn() raise ScanAbort { ael_remove(state, id) })
    } else {
      wb_error(fn() raise ScanAbort { edge_advance(state, id) })
    }
    assert_true(error is InvalidInput(_, _))
    wb_ok(state)
    assert_eq(state.ael_count, 1)
  }
}

///|
test "negative charges cannot restore consumed budget" {
  let state = new_scan_state(Default::default())
  assert_true(
    wb_error(fn() raise ScanAbort {
      scan_spend(state, -1, 0, location(ScanEvents, None, None))
    })
    is InvalidInput(_, _),
  )
  assert_eq(state.stats.nodes, 0)
  assert_eq(state.stats.work, 0)
}

///|
test "source tie ordering stays deterministic after reversing pool slot allocation" {
  for churn in [false, true] {
    let state = wb_prepared([wb_rectangle(), wb_rectangle()])
    if churn {
      let ids = Array::makei(4, fn(i) { i })
      let handles : Array[EdgeId] = []
      for i in ids {
        handles.push(edge_allocate(state, 3 - i))
      }
      for handle in handles {
        edge_release(state, handle)
      }
      wb_ok(state)
    }
    assert_true(scan_step(state) is Ok(EnterMinima))
    assert_true(scan_step(state) is Ok(AwaitEntryContact(_, _, _)))
    wb_ok(state)
    let order = wb_edges(state).map(fn(id) raise ScanAbort {
      state.vertices[state.minima[state.chains[edge_get(state, id).chain].minima].vertex].source.global_path
    })
    assert_eq(order, [0, 1, 0, 1])
  }
}

///|
test "horizontal backtracking is a pending overlap instead of a silently consumed span" {
  let state = wb_prepared([
    [
      wb_point(0L, 0L),
      wb_point(5L, 0L),
      wb_point(5L, 10L),
      wb_point(10L, 10L),
      wb_point(0L, 10L),
    ],
  ])
  let mut pending = false
  for step = 0; step < 50; step = step + 1 {
    guard scan_step(state) is Ok(phase) else {
      fail("Unexpected retrace preparation error")
    }
    wb_ok(state)
    match phase {
      AwaitHorizontal(id) => {
        assert_true(edge_get(state, id).horizontal_retrace)
        assert_eq(horizontal_crossing(state, id), Some(id))
        pending = true
        break
      }
      AwaitMaxima(_, a, b) => commit_maxima(state, a, b)
      _ => ()
    }
  }
  assert_true(pending)
}

///|
test "new minimum contacting a resident edge retains explicit event handles" {
  let state = wb_prepared([
    wb_rectangle(),
    [wb_point(0L, 5L), wb_point(4L, 0L), wb_point(-4L, 0L)],
  ])
  let mut pending = false
  for step = 0; step < 50; step = step + 1 {
    guard scan_step(state) is Ok(phase) else {
      fail("Unexpected entry-contact error")
    }
    wb_ok(state)
    match phase {
      AwaitEntryContact(vertex, a, b) => {
        assert_eq(state.vertices[vertex].point, wb_point(0L, 5L))
        assert_eq(edge_get(state, a).current_x, edge_get(state, b).current_x)
        pending = true
        break
      }
      AwaitMaxima(_, a, b) => commit_maxima(state, a, b)
      _ => ()
    }
  }
  assert_true(pending)
  assert_true(scan_step(state) is Ok(AwaitEntryContact(_, _, _)))
}
