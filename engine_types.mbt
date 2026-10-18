// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Portions adapted from Clipper2, Copyright (c) Angus Johnson 2010-2025.
// Index-based adaptation of Clipper2 engine concepts; see docs/upstream.md.

///|
type VertexId = Int

///|
#warnings("-unused_value")
priv struct EdgeId {
  slot : Int
  generation : Int
} derive(Eq, Debug)

///|
#warnings("-unused_value")
priv enum PathRole {
  Subject
  Clip
} derive(Eq, Debug)

///|
priv struct SourceId {
  role : PathRole
  path : Int
  global_path : Int
  vertex : Int
}

///|
priv struct Vertex {
  point : Point64
  source : SourceId
  mut prev : VertexId?
  mut next : VertexId?
  mut enter : Bool
  mut exit_anchor : VertexId?
}

///|
priv struct PreparedPath {
  role : PathRole
  path : Int
  raw_count : Int
  vertices : Array[VertexId]
  scannable : Bool
}

///|
priv struct LocalMinima {
  vertex : VertexId
  mut backward : Int?
  mut forward : Int?
}

///|
priv struct BoundaryChain {
  minima : Int
  direction : Int
  vertices : Array[VertexId]
  mut left_bound : Bool
}

///|
#warnings("-unused_value")
priv enum HorizontalDirection {
  NonHorizontal
  ToLeft
  ToRight
} derive(Eq, Debug)

///|
priv struct ActiveEdge {
  chain : Int
  mut cursor : Int
  mut bot : VertexId
  mut top : VertexId
  mut current_x : Int64
  mut horizontal_retrace : Bool
  mut horizontal : HorizontalDirection
  mut prev_ael : EdgeId?
  mut next_ael : EdgeId?
  mut prev_sel : EdgeId?
  mut next_sel : EdgeId?
  mut in_ael : Bool
  mut in_sel : Bool
  mut queued_horizontal : Bool
  mut at_exit : Bool
  mut joined : EdgeId?
  wind_dx : Int
  mut wind_count : Int
  mut wind_other : Int
  mut output_end : OutputEnd?
}

///|
priv struct EdgeSlot {
  mut generation : Int
  mut edge : ActiveEdge?
}

///|
priv struct ExitEvent {
  vertex : VertexId
  first_chain : Int
  second_chain : Int
}

///|
#warnings("-unused_value")
priv enum ScanPhase {
  Ready
  EnterMinima
  Horizontals
  PrepareBand
  AwaitIntersections(Int64)
  AwaitEntryContact(VertexId, EdgeId, EdgeId)
  TopVertices
  AwaitHorizontal(EdgeId)
  AwaitMaxima(VertexId, EdgeId, EdgeId)
  Complete
  Failed
} derive(Eq, Debug)

///|
/// Keep input Limits source-compatible. These additional limits are internal.
priv struct ScanLimits {
  input : Limits
  max_nodes : Int
  max_work : Int
}

///|
impl Default for ScanLimits with fn default() {
  { input: Default::default(), max_nodes: 500_000, max_work: 5_000_000, }
}

///|
#warnings("-unused_value")
priv struct ScanStats {
  mut nodes : Int
  mut work : Int
  mut peak_active : Int
  mut heights : Int
  mut comparisons : Int
  mut horizontal_steps : Int
  mut intersection_events : Int
  mut horizontal_joins : Int
  mut output_records : Int
  mut output_points : Int
} derive(Eq, Debug)

///|
priv struct ScanState {
  limits : ScanLimits
  stats : ScanStats
  vertices : Array[Vertex]
  paths : Array[PreparedPath]
  minima : Array[LocalMinima]
  entries : Map[Int64, Array[Int]]
  chains : Array[BoundaryChain]
  heap : Array[Int64]
  heights : Set[Int64]
  slots : Array[EdgeSlot]
  free_slots : Array[Int]
  horizontal_queue : Array[EdgeId]
  exits : Array[ExitEvent]
  mut boolean_rule : WindingRule
  mut boolean_operation : ClipType?
  output : OutputState
  intersections : Array[IntersectEvent]
  mut intersection_cursor : Int
  mut band_built : Int64?
  pending_connections : Array[EngineEvent]
  mut connection_cursor : Int
  mut entry_contact : (VertexId, EdgeId, EdgeId)?
  mut held_horizontal : EdgeId?
  mut ael_head : EdgeId?
  mut sel_head : EdgeId?
  mut live_edges : Int
  mut ael_count : Int
  mut current_y : Int64?
  mut last_popped : Int64?
  mut needs_entries : Bool
  mut phase : ScanPhase
  mut failure : ClipError?
  mut cleaned : Bool
}

///|
priv suberror ScanAbort {
  ScanAbort(ClipError)
}

///|
fn new_scan_state(limits : ScanLimits) -> ScanState {
  {
    limits,
    stats: {
      nodes: 0,
      work: 0,
      peak_active: 0,
      heights: 0,
      comparisons: 0,
      horizontal_steps: 0,
      intersection_events: 0,
      horizontal_joins: 0,
      output_records: 0,
      output_points: 0,
    },
    vertices: [],
    paths: [],
    minima: [],
    entries: Map([]),
    chains: [],
    heap: [],
    heights: Default::default(),
    slots: [],
    free_slots: [],
    horizontal_queue: [],
    exits: [],
    boolean_rule: Parity,
    boolean_operation: None,
    output: new_output_state(),
    intersections: [],
    intersection_cursor: 0,
    band_built: None,
    pending_connections: [],
    connection_cursor: 0,
    entry_contact: None,
    held_horizontal: None,
    ael_head: None,
    sel_head: None,
    live_edges: 0,
    ael_count: 0,
    current_y: None,
    last_popped: None,
    needs_entries: false,
    phase: Ready,
    failure: None,
    cleaned: false,
  }
}

///|
fn[T] scan_abort(state : ScanState, error : ClipError) -> T raise ScanAbort {
  state.failure = Some(error)
  state.phase = Failed
  raise ScanAbort(error)
}

///|
fn scan_live(state : ScanState) -> Unit raise ScanAbort {
  if state.failure is Some(error) {
    raise ScanAbort(error)
  }
  if state.cleaned || state.phase == Complete {
    scan_abort(
      state,
      InvalidInput(location(ScanEvents, None, None), "Scan state has ended"),
    )
  }
}

///|
fn scan_location(
  state : ScanState,
  vertex : VertexId?,
  stage : Stage,
) -> ErrorLocation {
  match vertex {
    Some(id) => {
      let source = state.vertices[id].source
      location(stage, Some(source.global_path), Some(source.vertex))
    }
    None => location(stage, None, None)
  }
}

///|
/// Check a whole associated allocation before consuming any part of it.
fn scan_reserve(
  state : ScanState,
  nodes : Int,
  work : Int,
  loc : ErrorLocation,
) -> Unit raise ScanAbort {
  scan_live(state)
  if nodes < 0 || work < 0 {
    scan_abort(state, InvalidInput(loc, "Budget charges must be non-negative"))
  }
  if nodes > state.limits.max_nodes - state.stats.nodes {
    scan_abort(
      state,
      ResourceLimitExceeded(loc, InternalNodes, state.limits.max_nodes),
    )
  }
  if work > state.limits.max_work - state.stats.work {
    scan_abort(
      state,
      ResourceLimitExceeded(loc, ScanWork, state.limits.max_work),
    )
  }
}

///|
fn scan_spend(
  state : ScanState,
  nodes : Int,
  work : Int,
  loc : ErrorLocation,
) -> Unit raise ScanAbort {
  scan_reserve(state, nodes, work, loc)
  state.stats.nodes += nodes
  state.stats.work += work
}

///|
fn edge_peek(state : ScanState, id : EdgeId) -> ActiveEdge? {
  if id.slot < 0 || id.slot >= state.slots.length() {
    return None
  }
  let slot = state.slots[id.slot]
  if slot.generation != id.generation {
    return None
  }
  slot.edge
}

///|
fn edge_get(state : ScanState, id : EdgeId) -> ActiveEdge raise ScanAbort {
  scan_live(state)
  match edge_peek(state, id) {
    Some(edge) => edge
    None =>
      scan_abort(
        state,
        InvalidInput(
          location(ActiveEdges, None, None),
          "Stale or invalid active edge handle (slot \{id.slot}, generation \{id.generation})",
        ),
      )
  }
}

///|
fn horizontal_direction(bot : Point64, top : Point64) -> HorizontalDirection {
  if bot.y != top.y {
    NonHorizontal
  } else if top.x < bot.x {
    ToLeft
  } else {
    ToRight
  }
}

///|
fn edge_allocate(state : ScanState, chain_id : Int) -> EdgeId raise ScanAbort {
  scan_live(state)
  guard chain_id >= 0 && chain_id < state.chains.length() else {
    scan_abort(
      state,
      InvalidInput(location(ActiveEdges, None, None), "Invalid boundary chain"),
    )
  }
  let chain = state.chains[chain_id]
  let bot = chain.vertices[0]
  let top = chain.vertices[1]
  scan_spend(state, 1, 1, scan_location(state, Some(bot), ActiveEdges))
  let edge : ActiveEdge = {
    chain: chain_id,
    cursor: 0,
    bot,
    top,
    current_x: state.vertices[bot].point.x,
    horizontal_retrace: false,
    horizontal: horizontal_direction(
      state.vertices[bot].point,
      state.vertices[top].point,
    ),
    prev_ael: None,
    next_ael: None,
    prev_sel: None,
    next_sel: None,
    in_ael: false,
    in_sel: false,
    queued_horizontal: false,
    at_exit: false,
    joined: None,
    wind_dx: chain.direction,
    wind_count: 0,
    wind_other: 0,
    output_end: None,
  }
  let index = match state.free_slots.pop() {
    Some(index) => index
    None => {
      let index = state.slots.length()
      state.slots.push({ generation: 0, edge: None, })
      index
    }
  }
  let slot = state.slots[index]
  slot.edge = Some(edge)
  state.live_edges += 1
  { slot: index, generation: slot.generation, }
}

///|
fn edge_release(state : ScanState, id : EdgeId) -> Unit raise ScanAbort {
  let edge = edge_get(state, id)
  let loc = scan_location(state, Some(edge.bot), ActiveEdges)
  let entry_reference = match state.entry_contact {
    Some((_, a, b)) => id == a || id == b
    None => false
  }
  let phase_reference = match state.phase {
    AwaitMaxima(_, a, b) => id == a || id == b
    _ => false
  }
  if edge.output_end is Some(_) ||
    state.intersection_cursor < state.intersections.length() ||
    state.connection_cursor < state.pending_connections.length() ||
    entry_reference ||
    phase_reference ||
    edge.prev_ael is Some(_) ||
    edge.next_ael is Some(_) ||
    edge.prev_sel is Some(_) ||
    edge.next_sel is Some(_) ||
    edge.in_ael ||
    edge.in_sel ||
    edge.queued_horizontal ||
    state.held_horizontal == Some(id) {
    scan_abort(
      state,
      InvalidInput(
        loc, "Detach active edge from all chains and pending events before release",
      ),
    )
  }
  let slot = state.slots[id.slot]
  if slot.generation == 2147483647 {
    scan_abort(state, NumericFailure(loc, "Active edge generation exhausted"))
  }
  scan_spend(state, 0, 1, loc)
  slot.edge = None
  slot.generation += 1
  state.free_slots.push(id.slot)
  state.live_edges -= 1
}

///|
fn ael_remove(state : ScanState, id : EdgeId) -> Unit raise ScanAbort {
  let edge = edge_get(state, id)
  let loc = scan_location(state, Some(edge.bot), ActiveEdges)
  let entry_reference = match state.entry_contact {
    Some((_, a, b)) => id == a || id == b
    None => false
  }
  let pending = match state.phase {
    AwaitMaxima(_, a, b) => id == a || id == b
    _ => false
  }
  if entry_reference ||
    pending ||
    edge.queued_horizontal ||
    state.held_horizontal == Some(id) {
    scan_abort(
      state,
      InvalidInput(loc, "Consume pending events before active edge removal"),
    )
  }
  if !edge.in_ael {
    scan_abort(state, InvalidInput(loc, "Edge is not in the active chain"))
  }
  scan_spend(state, 0, 1, loc)
  match edge.prev_ael {
    Some(prev) => edge_get(state, prev).next_ael = edge.next_ael
    None => state.ael_head = edge.next_ael
  }
  if edge.next_ael is Some(next) {
    edge_get(state, next).prev_ael = edge.prev_ael
  }
  edge.prev_ael = None
  edge.next_ael = None
  edge.in_ael = false
  state.ael_count -= 1
}

///|
/// Only adjacent swaps; SEL is intentionally untouched.
#warnings("-unused_value")
fn ael_swap(
  state : ScanState,
  left : EdgeId,
  right : EdgeId,
) -> Unit raise ScanAbort {
  let a = edge_get(state, left)
  let b = edge_get(state, right)
  let loc = scan_location(state, Some(a.bot), ActiveEdges)
  if !a.in_ael ||
    !b.in_ael ||
    a.next_ael != Some(right) ||
    b.prev_ael != Some(left) {
    scan_abort(
      state,
      InvalidInput(
        loc, "Active edge swap requires adjacent left and right handles",
      ),
    )
  }
  scan_spend(state, 0, 1, loc)
  let prev = a.prev_ael
  let next = b.next_ael
  match prev {
    Some(p) => edge_get(state, p).next_ael = Some(right)
    None => state.ael_head = Some(right)
  }
  if next is Some(n) {
    edge_get(state, n).prev_ael = Some(left)
  }
  b.prev_ael = prev
  b.next_ael = Some(left)
  a.prev_ael = Some(right)
  a.next_ael = next
}

///|
fn sel_clear(state : ScanState) -> Unit raise ScanAbort {
  let mut cursor = state.sel_head
  while cursor is Some(id) {
    let edge = edge_get(state, id)
    scan_spend(state, 0, 1, scan_location(state, Some(edge.bot), ActiveEdges))
    cursor = edge.next_sel
    edge.prev_sel = None
    edge.next_sel = None
    edge.in_sel = false
  }
  state.sel_head = None
}

///|
/// A separate linked snapshot. It is never sorted to silently reorder AEL.
fn sel_snapshot(state : ScanState) -> Unit raise ScanAbort {
  sel_clear(state)
  let mut cursor = state.ael_head
  let mut prev : EdgeId? = None
  while cursor is Some(id) {
    let edge = edge_get(state, id)
    scan_spend(state, 0, 1, scan_location(state, Some(edge.bot), ActiveEdges))
    edge.prev_sel = prev
    edge.next_sel = edge.next_ael
    edge.in_sel = true
    if prev is None {
      state.sel_head = Some(id)
    }
    prev = Some(id)
    cursor = edge.next_ael
  }
}

///|
/// Cleanup is bounded by allocated storage, even after work exhaustion.
/// It cannot resume a failed context or reuse its old handles.
#warnings("-unused_value")
fn scan_cleanup(state : ScanState) -> Unit {
  for slot in state.slots {
    slot.edge = None
  }
  state.free_slots.clear()
  state.horizontal_queue.clear()
  state.heap.clear()
  state.heights.clear()
  state.entries.clear()
  state.intersections.clear()
  state.pending_connections.clear()
  state.intersection_cursor = 0
  state.connection_cursor = 0
  state.band_built = None
  state.output.points.clear()
  state.output.records.clear()
  state.output.horizontals.clear()
  state.output.joins.clear()
  state.ael_head = None
  state.sel_head = None
  state.held_horizontal = None
  state.entry_contact = None
  state.live_edges = 0
  state.ael_count = 0
  state.cleaned = true
  if state.failure is None {
    state.phase = Complete
  }
}

///|
/// Read-only diagnostics bounded by allocated vertices/slots, including on
/// failed states. No mutation or work-budget reset is performed by diagnostics.
#warnings("-unused_value")
fn scan_invariants(
  state : ScanState,
  stable? : Bool = false,
) -> Result[Unit, String] {
  if state.stats.nodes < 0 ||
    state.stats.nodes > state.limits.max_nodes ||
    state.stats.work < 0 ||
    state.stats.work > state.limits.max_work ||
    state.stats.peak_active < state.ael_count ||
    state.stats.comparisons > state.stats.work ||
    state.stats.heights > state.stats.work ||
    state.stats.horizontal_steps > state.stats.work {
    return Err("Invalid execution statistics")
  }
  let owned : Set[Int] = Default::default()
  for p = 0; p < state.paths.length(); p = p + 1 {
    let path = state.paths[p]
    for i = 0; i < path.vertices.length(); i = i + 1 {
      let id = path.vertices[i]
      if id < 0 || id >= state.vertices.length() || owned.contains(id) {
        return Err("Invalid or multiply owned vertex index")
      }
      owned.add(id)
      let vertex = state.vertices[id]
      if vertex.source.role != path.role ||
        vertex.source.path != path.path ||
        vertex.source.global_path != p ||
        vertex.source.vertex < 0 ||
        vertex.source.vertex >= path.raw_count {
        return Err("Invalid original input provenance")
      }
      let previous = path.vertices[(i + path.vertices.length() - 1) %
        path.vertices.length()]
      let next = path.vertices[(i + 1) % path.vertices.length()]
      if vertex.prev != Some(previous) || vertex.next != Some(next) {
        return Err("Incorrect closed vertex neighbors")
      }
    }
  }
  if owned.length() != state.vertices.length() {
    return Err("Unowned internal vertices")
  }
  for minimum in state.minima {
    if minimum.vertex < 0 ||
      minimum.vertex >= state.vertices.length() ||
      !state.vertices[minimum.vertex].enter {
      return Err("Invalid local-enter vertex")
    }
  }
  for chain in state.chains {
    if chain.minima < 0 ||
      chain.minima >= state.minima.length() ||
      chain.vertices.length() < 2 ||
      (chain.direction != 1 && chain.direction != -1) {
      return Err("Invalid boundary chain record")
    }
    if chain.vertices[0] != state.minima[chain.minima].vertex {
      return Err("Boundary origin mismatch")
    }
    for i = 0; i < chain.vertices.length(); i = i + 1 {
      let id = chain.vertices[i]
      if id < 0 || id >= state.vertices.length() {
        return Err("Invalid boundary vertex reference")
      }
      if i > 0 {
        let before = state.vertices[chain.vertices[i - 1]]
        if (if chain.direction > 0 { before.next } else { before.prev }) !=
          Some(id) {
          return Err("Boundary traversal direction mismatch")
        }
      }
    }
    let end = chain.vertices[chain.vertices.length() - 1]
    if state.vertices[end].exit_anchor != Some(end) {
      return Err("Boundary does not end at an exit anchor")
    }
  }
  // Validate slot payloads before following chain identifiers in linked lists.
  for slot in state.slots {
    if slot.edge is Some(edge) {
      if edge.chain < 0 || edge.chain >= state.chains.length() {
        return Err("Invalid active boundary chain")
      }
      let chain = state.chains[edge.chain]
      if edge.cursor < 0 ||
        edge.cursor + 1 >= chain.vertices.length() ||
        edge.bot != chain.vertices[edge.cursor] ||
        edge.top != chain.vertices[edge.cursor + 1] {
        return Err("Invalid boundary cursor")
      }
    }
  }
  let mut alive = 0
  for slot in state.slots {
    if slot.edge is Some(_) {
      alive += 1
    }
  }
  if alive != state.live_edges {
    return Err("Live edge count mismatch")
  }
  let free : Set[Int] = Default::default()
  for index in state.free_slots {
    if index < 0 ||
      index >= state.slots.length() ||
      state.slots[index].edge is Some(_) ||
      free.contains(index) {
      return Err("Invalid free slot list")
    }
    free.add(index)
  }
  let ael : Set[Int] = Default::default()
  let sel : Set[Int] = Default::default()
  let queued : Set[Int] = Default::default()
  for auxiliary in [false, true] {
    let seen = if auxiliary { sel } else { ael }
    let mut previous : EdgeId? = None
    let mut cursor = if auxiliary { state.sel_head } else { state.ael_head }
    let mut previous_x : Int64? = None
    let mut wind = 0
    while cursor is Some(id) {
      if seen.contains(id.slot) {
        return Err("Cycle or duplicate edge in linked chain")
      }
      guard edge_peek(state, id) is Some(edge) else {
        return Err("Linked chain contains stale handle")
      }
      seen.add(id.slot)
      if auxiliary {
        if !edge.in_sel || edge.prev_sel != previous {
          return Err("Nonreciprocal auxiliary links")
        }
      } else {
        if !edge.in_ael || edge.prev_ael != previous {
          return Err("Nonreciprocal active links")
        }
        if stable && previous_x is Some(x) && x > edge.current_x {
          return Err("Unordered stable active chain")
        }
        if stable && previous is Some(previous_id) {
          let earlier = edge_peek(state, previous_id).unwrap()
          let both_ending = state.current_y ==
            Some(state.vertices[earlier.top].point.y) &&
            state.current_y == Some(state.vertices[edge.top].point.y)
          if !both_ending && edge_position_compare(state, earlier, edge) > 0 {
            return Err("Unordered stable boundary directions")
          }
        }
        previous_x = Some(edge.current_x)
        wind += state.chains[edge.chain].direction
      }
      previous = Some(id)
      cursor = if auxiliary { edge.next_sel } else { edge.next_ael }
    }
    if !auxiliary && (seen.length() != state.ael_count || (stable && wind != 0)) {
      return Err("Active count or boundary winding pair mismatch")
    }
  }
  for id in state.horizontal_queue {
    guard edge_peek(state, id) is Some(edge) else {
      return Err("Stale queued horizontal")
    }
    if !edge.in_ael ||
      queued.contains(id.slot) ||
      !edge.queued_horizontal ||
      edge.horizontal == NonHorizontal {
      return Err("Invalid horizontal queue membership")
    }
    queued.add(id.slot)
  }
  if state.held_horizontal is Some(id) {
    guard edge_peek(state, id) is Some(edge) else {
      return Err("Stale held horizontal")
    }
    if !edge.in_ael ||
      edge.queued_horizontal ||
      edge.horizontal == NonHorizontal {
      return Err("Invalid held horizontal")
    }
  }
  for i = 0; i < state.slots.length(); i = i + 1 {
    match state.slots[i].edge {
      None =>
        if !state.cleaned && !free.contains(i) {
          return Err("Released slot missing from free list")
        }
      Some(edge) => {
        if edge.in_ael != ael.contains(i) ||
          edge.in_sel != sel.contains(i) ||
          edge.queued_horizontal != queued.contains(i) {
          return Err("Unreachable linked or pending edge")
        }
        if !edge.in_ael &&
          (edge.prev_ael is Some(_) || edge.next_ael is Some(_)) {
          return Err("Detached edge retains active links")
        }
        if !edge.in_sel &&
          (edge.prev_sel is Some(_) || edge.next_sel is Some(_)) {
          return Err("Detached edge retains auxiliary links")
        }
        if edge.chain < 0 || edge.chain >= state.chains.length() {
          return Err("Invalid active boundary chain")
        }
        let chain = state.chains[edge.chain]
        if edge.cursor < 0 ||
          edge.cursor + 1 >= chain.vertices.length() ||
          edge.bot != chain.vertices[edge.cursor] ||
          edge.top != chain.vertices[edge.cursor + 1] {
          return Err("Invalid boundary cursor")
        }
      }
    }
  }
  for event in state.exits {
    if event.vertex < 0 ||
      event.vertex >= state.vertices.length() ||
      event.first_chain < 0 ||
      event.second_chain < 0 ||
      event.first_chain >= state.chains.length() ||
      event.second_chain >= state.chains.length() {
      return Err("Invalid retained exit provenance")
    }
  }
  if state.entry_contact is Some((vertex, a, b)) {
    if vertex < 0 || vertex >= state.vertices.length() {
      return Err("Invalid entry contact vertex")
    }
    guard edge_peek(state, a) is Some(first) &&
      edge_peek(state, b) is Some(second) else {
      return Err("Stale entry contact handles")
    }
    if !first.in_ael ||
      !second.in_ael ||
      first.current_x != state.vertices[vertex].point.x ||
      second.current_x != first.current_x {
      return Err("Invalid entry contact references")
    }
  }
  match state.phase {
    AwaitEntryContact(vertex, a, b) =>
      if state.entry_contact != Some((vertex, a, b)) {
        return Err("Entry contact phase mismatch")
      }
    AwaitHorizontal(id) =>
      if state.held_horizontal != Some(id) {
        return Err("Pending horizontal phase mismatch")
      }
    AwaitMaxima(vertex, a, b) => {
      guard edge_peek(state, a) is Some(first) &&
        edge_peek(state, b) is Some(second) else {
        return Err("Stale pending maxima pair")
      }
      if !first.at_exit ||
        !second.at_exit ||
        first.top != vertex ||
        second.top != vertex {
        return Err("Pending maxima phase mismatch")
      }
    }
    _ => ()
  }
  Ok(())
}
