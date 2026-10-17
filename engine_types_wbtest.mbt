///|
fn[T] wb_error(action : () -> T raise ScanAbort) -> ClipError raise {
  try action() catch {
    ScanAbort(error) => error
  } noraise {
    _ => fail("Expected internal scan failure")
  }
}

///|
fn wb_edges(
  state : ScanState,
  auxiliary? : Bool = false,
) -> Array[EdgeId] raise {
  let result = []
  let mut cursor = if auxiliary { state.sel_head } else { state.ael_head }
  while cursor is Some(id) {
    assert_true(result.length() <= state.slots.length())
    result.push(id)
    let edge = edge_get(state, id)
    cursor = if auxiliary { edge.next_sel } else { edge.next_ael }
  }
  result
}

///|
fn wb_insert(state : ScanState, chain : Int, x : Int64) -> EdgeId raise {
  let id = edge_allocate(state, chain)
  edge_get(state, id).current_x = x
  ael_insert(state, id)
  wb_ok(state)
  id
}

///|
fn wb_pool() -> ScanState raise {
  wb_prepared([wb_rectangle(), wb_rectangle(x=20L)])
}

///|
test "pool and active list support empty head middle tail and sole removal" {
  let state = wb_pool()
  let middle = wb_insert(state, 0, 10L)
  let head = wb_insert(state, 1, 0L)
  let tail = wb_insert(state, 2, 30L)
  let between = wb_insert(state, 3, 20L)
  assert_eq(wb_edges(state), [head, middle, between, tail])
  for id in [middle, head, tail, between] {
    ael_remove(state, id)
    wb_ok(state)
    edge_release(state, id)
    wb_ok(state)
  }
  assert_eq(state.ael_head, None)
  assert_eq(state.live_edges, 0)
}

///|
test "adjacent swaps update the head and internal reciprocal links" {
  let state = wb_pool()
  let a = wb_insert(state, 0, 0L)
  let b = wb_insert(state, 1, 10L)
  let c = wb_insert(state, 2, 20L)
  let d = wb_insert(state, 3, 30L)
  ael_swap(state, a, b)
  wb_ok(state)
  assert_eq(wb_edges(state), [b, a, c, d])
  ael_swap(state, c, d)
  wb_ok(state)
  assert_eq(wb_edges(state), [b, a, d, c])
  ael_swap(state, a, d)
  wb_ok(state)
  assert_eq(wb_edges(state), [b, d, a, c])
}

///|
test "nonadjacent swap fails before changing links and terminates state" {
  let state = wb_pool()
  let a = wb_insert(state, 0, 0L)
  let b = wb_insert(state, 1, 10L)
  let c = wb_insert(state, 2, 20L)
  let old = wb_edges(state)
  assert_true(
    wb_error(fn() raise ScanAbort { ael_swap(state, a, c) })
    is InvalidInput(_, _),
  )
  assert_eq(state.phase, Failed)
  assert_eq(state.ael_head, Some(a))
  assert_eq(edge_peek(state, a).unwrap().next_ael, Some(b))
  assert_eq(edge_peek(state, b).unwrap().next_ael, Some(c))
  assert_eq(old.length(), 3)
  wb_ok(state)
}

///|
test "double insertion is rejected without duplicating the node" {
  let state = wb_pool()
  let id = wb_insert(state, 0, 0L)
  assert_true(
    wb_error(fn() raise ScanAbort { ael_insert(state, id) })
    is InvalidInput(_, _),
  )
  assert_eq(state.ael_count, 1)
  wb_ok(state)
}

///|
test "removing a detached node is rejected" {
  let state = wb_pool()
  let id = edge_allocate(state, 0)
  assert_true(
    wb_error(fn() raise ScanAbort { ael_remove(state, id) })
    is InvalidInput(_, _),
  )
  assert_eq(state.live_edges, 1)
  wb_ok(state)
}

///|
test "pool reuse invalidates old handles and clears all edge state" {
  let state = wb_pool()
  let old = wb_insert(state, 0, 0L)
  ael_remove(state, old)
  edge_release(state, old)
  wb_ok(state)
  let fresh = edge_allocate(state, 1)
  wb_ok(state)
  assert_eq(fresh.slot, old.slot)
  assert_true(fresh.generation != old.generation)
  assert_true(edge_peek(state, old) is None)
  let edge = edge_get(state, fresh)
  assert_eq(edge.chain, 1)
  assert_eq(edge.cursor, 0)
  assert_true(
    !edge.in_ael && !edge.in_sel && !edge.queued_horizontal && !edge.at_exit,
  )
  assert_eq(edge.prev_ael, None)
  assert_eq(edge.next_ael, None)
  assert_eq(edge.prev_sel, None)
  assert_eq(edge.next_sel, None)
  assert_true(
    wb_error(fn() raise ScanAbort { edge_get(state, old) })
    is InvalidInput(_, _),
  )
  assert_true(edge_peek(state, fresh) is Some(_))
  wb_ok(state)
}

///|
test "pool growth preserves earlier handles and source-stable chain identities" {
  let state = wb_pool()
  let first = edge_allocate(state, 0)
  for i = 0; i < 80; i = i + 1 {
    ignore(edge_allocate(state, if i % 2 == 0 { 1 } else { 2 }))
  }
  assert_eq(edge_get(state, first).chain, 0)
  assert_eq(edge_get(state, first).bot, state.chains[0].vertices[0])
  wb_ok(state)
}

///|
test "release refuses references from the active chain" {
  let state = wb_pool()
  let id = wb_insert(state, 0, 0L)
  assert_true(
    wb_error(fn() raise ScanAbort { edge_release(state, id) })
    is InvalidInput(_, _),
  )
  assert_true(edge_peek(state, id) is Some(_))
  wb_ok(state)
}

///|
test "auxiliary chain is independent of active swaps and detach operations" {
  let state = wb_pool()
  let a = wb_insert(state, 0, 0L)
  let b = wb_insert(state, 1, 10L)
  sel_snapshot(state)
  wb_ok(state)
  assert_eq(wb_edges(state, auxiliary=true), [a, b])
  ael_swap(state, a, b)
  wb_ok(state)
  assert_eq(wb_edges(state), [b, a])
  assert_eq(wb_edges(state, auxiliary=true), [a, b])
  ael_remove(state, a)
  wb_ok(state)
  assert_true(
    wb_error(fn() raise ScanAbort { edge_release(state, a) })
    is InvalidInput(_, _),
  )
  wb_ok(state)
}

///|
test "auxiliary references can be cleared before freeing detached slots" {
  let state = wb_pool()
  let id = wb_insert(state, 0, 0L)
  sel_snapshot(state)
  ael_remove(state, id)
  sel_clear(state)
  edge_release(state, id)
  assert_eq(state.sel_head, None)
  wb_ok(state)
}

///|
test "queued and held horizontal references prevent pool release" {
  let state = wb_prepared([wb_rectangle()])
  let chain = state.minima[0].forward.unwrap()
  let id = edge_allocate(state, chain)
  ael_insert(state, id)
  horizontal_push(state, id)
  assert_true(
    wb_error(fn() raise ScanAbort { edge_release(state, id) })
    is InvalidInput(_, _),
  )
  wb_ok(state)
  let other = wb_prepared([wb_rectangle()])
  let next = edge_allocate(other, other.minima[0].forward.unwrap())
  ael_insert(other, next)
  horizontal_push(other, next)
  assert_eq(horizontal_pop(other), Some(next))
  wb_ok(other)
  assert_true(
    wb_error(fn() raise ScanAbort { edge_release(other, next) })
    is InvalidInput(_, _),
  )
  wb_ok(other)
}

///|
test "invariant checker detects a broken reciprocal active link" {
  let state = wb_pool()
  let a = wb_insert(state, 0, 0L)
  let b = wb_insert(state, 1, 10L)
  edge_get(state, b).prev_ael = None
  assert_true(scan_invariants(state) is Err(_))
  edge_get(state, b).prev_ael = Some(a)
  wb_ok(state)
}

///|
test "invariant checker detects a cycle and a stale linked handle" {
  let state = wb_pool()
  let id = wb_insert(state, 0, 0L)
  edge_get(state, id).next_ael = Some(id)
  assert_true(scan_invariants(state) is Err(_))
  edge_get(state, id).next_ael = None
  state.ael_head = Some({ slot: id.slot, generation: id.generation + 1, })
  assert_true(scan_invariants(state) is Err(_))
}

///|
test "invariant checker rejects bad vertex source and orphan chain membership" {
  let state = wb_pool()
  let id = wb_insert(state, 0, 0L)
  edge_get(state, id).in_ael = false
  assert_true(scan_invariants(state) is Err(_))
  edge_get(state, id).in_ael = true
  state.vertices[0].next = None
  assert_true(scan_invariants(state) is Err(_))
}

///|
test "slot reuse consumes cumulative nodes and work without refunds" {
  let state = wb_pool()
  let first = edge_allocate(state, 0)
  let initial_nodes = state.stats.nodes
  let initial_work = state.stats.work
  edge_release(state, first)
  let second = edge_allocate(state, 1)
  assert_eq(second.slot, first.slot)
  assert_eq(state.stats.nodes, initial_nodes + 1)
  assert_true(state.stats.work > initial_work)
  wb_ok(state)
}

///|
test "cleanup after a failed operation removes all chain and pending references" {
  let state = wb_pool()
  let id = wb_insert(state, 0, 0L)
  ignore(wb_error(fn() raise ScanAbort { ael_insert(state, id) }))
  scan_cleanup(state)
  wb_ok(state)
  assert_eq(state.phase, Failed)
  assert_eq(state.live_edges, 0)
  assert_eq(state.ael_head, None)
  assert_eq(state.sel_head, None)
  assert_true(scan_step(state) is Err(_))
  let fresh = wb_pool()
  wb_ok(fresh)
  assert_eq(fresh.live_edges, 0)
}

///|
test "explicit rounding covers positive negative half integers and neighbors" {
  for
    (input, expected) in [
      (0.5, 0L),
      (1.5, 2L),
      (2.5, 2L),
      (3.5, 4L),
      (-0.5, 0L),
      (-1.5, -2L),
      (-2.5, -2L),
      (-3.5, -4L),
      (0.49999999999999994, 0L),
      (0.5000000000000001, 1L),
      (-0.49999999999999994, 0L),
      (-0.5000000000000001, -1L),
    ] {
    assert_eq(scan_round_displacement(input), expected)
  }
}

///|
test "projection returns endpoints and vertical edges exactly" {
  let a = wb_point(-7L, 10L)
  let b = wb_point(8L, -10L)
  assert_eq(scan_project(a, b, 10L), -7L)
  assert_eq(scan_project(a, b, -10L), 8L)
  assert_eq(scan_project(wb_point(-9L, 10L), wb_point(-9L, -10L), 0L), -9L)
}

///|
test "projection rounds displacement before adding nonzero origin" {
  assert_eq(scan_project(wb_point(1L, 2L), wb_point(2L, 0L), 1L), 1L)
  assert_eq(scan_project(wb_point(-1L, 2L), wb_point(0L, 0L), 1L), -1L)
  assert_eq(scan_project(wb_point(5L, 2L), wb_point(8L, 0L), 1L), 7L)
  assert_eq(scan_project(wb_point(-5L, 2L), wb_point(-8L, 0L), 1L), -7L)
}

///|
test "projection supports positive negative slopes and coordinate boundaries" {
  assert_eq(scan_project(wb_point(-10L, 10L), wb_point(10L, 0L), 5L), 0L)
  assert_eq(scan_project(wb_point(10L, 10L), wb_point(-10L, 0L), 5L), 0L)
  assert_eq(
    scan_project(
      wb_point(-1000000000L, 1000000000L),
      wb_point(1000000000L, -1000000000L),
      0L,
    ),
    0L,
  )
  assert_eq(
    scan_project(wb_point(999999999L, 2L), wb_point(1000000000L, 0L), 1L),
    999999999L,
  )
}

///|
test "projection rejects horizontals outside heights and nonfinite conversion" {
  assert_true(
    wb_error(fn() raise ScanAbort {
      scan_project(wb_point(0L, 1L), wb_point(2L, 1L), 1L)
    })
    is InvalidInput(_, _),
  )
  assert_true(
    wb_error(fn() raise ScanAbort {
      scan_project(wb_point(0L, 2L), wb_point(2L, 0L), 3L)
    })
    is InvalidInput(_, _),
  )
  for
    value in [
      @double.infinity, @double.neg_infinity, @double.not_a_number, 2000000002.0,
      -2000000002.0,
    ] {
    assert_true(
      wb_error(fn() raise ScanAbort { scan_round_displacement(value) })
      is NumericFailure(_, _),
    )
  }
}
