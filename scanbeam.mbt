// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Portions adapted from Clipper2, Copyright (c) Angus Johnson 2010-2025.

///|
/// Max-heap plus membership set: O(log H) insertion/removal, no repeated sort.
fn height_push(
  state : ScanState,
  y : Int64,
  vertex? : VertexId? = None,
) -> Unit raise ScanAbort {
  let loc = scan_location(state, vertex, ScanEvents)
  scan_spend(state, 0, 1, loc)
  if state.current_y is Some(current) && y >= current {
    if y == current {
      return
    }
    scan_abort(
      state,
      InvalidInput(loc, "Scan height must be below the current height"),
    )
  }
  if state.last_popped is Some(previous) && y >= previous {
    if y == previous {
      return
    }
    scan_abort(
      state,
      InvalidInput(loc, "Cannot reschedule an already passed scan height"),
    )
  }
  if state.heights.contains(y) {
    return
  }
  scan_spend(state, 1, 1, loc)
  state.heights.add(y)
  state.heap.push(y)
  let mut index = state.heap.length() - 1
  while index > 0 {
    scan_spend(state, 0, 1, loc)
    let parent = (index - 1) / 2
    if state.heap[parent] >= state.heap[index] {
      break
    }
    let value = state.heap[parent]
    state.heap[parent] = state.heap[index]
    state.heap[index] = value
    index = parent
  }
}

///|
fn height_pop(state : ScanState) -> Int64? raise ScanAbort {
  scan_spend(state, 0, 1, location(ScanEvents, None, None))
  if state.heap.is_empty() {
    return None
  }
  let result = state.heap[0]
  let last = state.heap.pop().unwrap()
  state.heights.remove(result)
  if !state.heap.is_empty() {
    state.heap[0] = last
    let mut index = 0
    while index < state.heap.length() / 2 {
      scan_spend(state, 0, 1, location(ScanEvents, None, None))
      let mut child = index * 2 + 1
      if child + 1 < state.heap.length() &&
        state.heap[child + 1] > state.heap[child] {
        child += 1
      }
      if state.heap[index] >= state.heap[child] {
        break
      }
      let value = state.heap[index]
      state.heap[index] = state.heap[child]
      state.heap[child] = value
      index = child
    }
  }
  if state.last_popped is Some(previous) && result >= previous {
    scan_abort(
      state,
      InvalidInput(
        location(ScanEvents, None, None),
        "Scan heights must decrease strictly",
      ),
    )
  }
  state.last_popped = Some(result)
  Some(result)
}

///|
/// Validate the combined operands before creating any internal vertices.
fn scan_check_inputs(
  subject : Paths64,
  clip : Paths64,
  limits : ScanLimits,
  spent_work? : Int = 0,
  internal_input? : Bool = false,
  internal_stage? : Stage = OffsetCleanup,
  raw_stage? : Stage = EnginePrepare,
) -> Result[Int, ClipError] {
  if limits.max_nodes < 0 || limits.max_work < 0 {
    return Err(
      InvalidInput(
        location(raw_stage, None, None),
        "Internal limits must be non-negative",
      ),
    )
  }
  if !internal_input &&
    check_limits(limits.input, raw_stage, subject.length()) is Some(error) {
    return Err(error)
  }
  if !internal_input &&
    clip.length() > limits.input.max_input_paths - subject.length() {
    return Err(
      ResourceLimitExceeded(
        location(raw_stage, Some(limits.input.max_input_paths), None),
        InputPaths,
        limits.input.max_input_paths,
      ),
    )
  }
  let stage = if internal_input { internal_stage } else { raw_stage }
  if clip.length() > 2147483647 - subject.length() {
    return Err(
      ResourceLimitExceeded(
        location(stage, None, None),
        InternalNodes,
        limits.max_nodes,
      ),
    )
  }
  let total = subject.length() + clip.length()
  let mut vertices_left = if internal_input {
    2147483647
  } else {
    limits.input.max_input_vertices
  }
  let initial_work = limits.max_work - spent_work
  let mut work_left = initial_work
  // Preflight the count and coordinate passes without overflowing count sums.
  for _pass = 0; _pass < 2; _pass = _pass + 1 {
    if total > work_left {
      return Err(
        ResourceLimitExceeded(
          location(stage, None, None),
          ScanWork,
          limits.max_work,
        ),
      )
    }
    work_left -= total
  }
  for i = 0; i < total; i = i + 1 {
    let path = if i < subject.length() {
      subject[i]
    } else {
      clip[i - subject.length()]
    }
    if path.length() > vertices_left {
      return Err(
        ResourceLimitExceeded(
          if internal_input {
            location(stage, None, None)
          } else {
            location(stage, Some(i), Some(vertices_left))
          },
          if internal_input {
            InternalNodes
          } else {
            InputVertices
          },
          if internal_input {
            limits.max_nodes
          } else {
            limits.input.max_input_vertices
          },
        ),
      )
    }
    vertices_left -= path.length()
    if path.length() > work_left {
      return Err(
        ResourceLimitExceeded(
          location(
            stage,
            if internal_input {
              None
            } else {
              Some(i)
            },
            if internal_input {
              None
            } else {
              Some(work_left)
            },
          ),
          ScanWork,
          limits.max_work,
        ),
      )
    }
    work_left -= path.length()
  }
  for i = 0; i < total; i = i + 1 {
    let path = if i < subject.length() {
      subject[i]
    } else {
      clip[i - subject.length()]
    }
    for j = 0; j < path.length(); j = j + 1 {
      if check_point(
          path[j],
          location(
            stage,
            if internal_input {
              None
            } else {
              Some(i)
            },
            if internal_input {
              None
            } else {
              Some(j)
            },
          ),
        )
        is Some(error) {
        return Err(error)
      }
    }
  }
  Ok(initial_work - work_left)
}

///|
fn source_location(source : SourceId, stage : Stage) -> ErrorLocation {
  if source.internal_input {
    location(stage, None, None)
  } else {
    location(stage, Some(source.global_path), Some(source.vertex))
  }
}

///|
fn prepare_path(
  state : ScanState,
  raw : Path64,
  role : PathRole,
  path_index : Int,
  global_index : Int,
) -> Unit raise ScanAbort {
  let loc = location(
    EnginePrepare,
    if state.internal_input {
      None
    } else {
      Some(global_index)
    },
    None,
  )
  scan_spend(state, 1, 1, loc)
  // Count exactly before allocating the normalized snapshot or vertex records.
  let mut count = 0
  let mut previous : Point64? = None
  for point in raw {
    scan_spend(state, 0, 1, loc)
    if previous != Some(point) {
      count += 1
      previous = Some(point)
    }
  }
  if count > 1 && previous == Some(raw[0]) {
    count -= 1
  }
  scan_reserve(state, count, raw.length(), loc)
  scan_spend(state, 0, raw.length(), loc)
  let clean = normalize_validated(raw, Closed)
  let ids : Array[VertexId] = []
  let mut original = 0
  for point in clean {
    while raw[original] != point {
      scan_spend(state, 0, 1, loc)
      original += 1
    }
    let source : SourceId = {
      internal_input: state.internal_input,
      role,
      path: path_index,
      global_path: global_index,
      vertex: original,
    }
    scan_spend(state, 1, 1, source_location(source, EnginePrepare))
    ids.push(state.vertices.length())
    state.vertices.push({
      point,
      source,
      prev: None,
      next: None,
      enter: false,
      exit_anchor: None,
    })
    original += 1
  }
  let mut nonhorizontal = false
  for i = 0; i < ids.length(); i = i + 1 {
    let vertex = state.vertices[ids[i]]
    scan_spend(state, 0, 1, source_location(vertex.source, EnginePrepare))
    let previous = ids[(i + ids.length() - 1) % ids.length()]
    let next = ids[(i + 1) % ids.length()]
    vertex.prev = Some(previous)
    vertex.next = Some(next)
    if vertex.point.y != state.vertices[next].point.y {
      nonhorizontal = true
    }
  }
  state.paths.push({
    role,
    path: path_index,
    raw_count: raw.length(),
    vertices: ids,
    scannable: ids.length() >= 3 && nonhorizontal,
  })
}

///|
/// Detect a whole equal-height plateau once, including across the input seam.
fn prepare_extrema(
  state : ScanState,
  path : PreparedPath,
  source_extrema : Bool,
) -> Unit raise ScanAbort {
  if !path.scannable {
    return
  }
  let ids = path.vertices
  let n = ids.length()
  let mut start = 0
  while state.vertices[ids[start]].point.y ==
        state.vertices[ids[(start + n - 1) % n]].point.y {
    scan_spend(
      state,
      0,
      1,
      scan_location(state, Some(ids[start]), EnginePrepare),
    )
    start += 1
    if start >= n {
      scan_abort(
        state,
        InvalidInput(
          location(EnginePrepare, None, None),
          "Nonhorizontal contour lost its height transition",
        ),
      )
    }
  }
  let mut offset = 0
  while offset < n {
    let first = ids[(start + offset) % n]
    let y = state.vertices[first].point.y
    let mut count = 1
    while offset + count < n &&
          state.vertices[ids[(start + offset + count) % n]].point.y == y {
      scan_spend(state, 0, 1, scan_location(state, Some(first), EnginePrepare))
      count += 1
    }
    scan_spend(state, 0, 1, scan_location(state, Some(first), EnginePrepare))
    let before = state.vertices[ids[(start + offset + n - 1) % n]].point.y
    let after = state.vertices[ids[(start + offset + count) % n]].point.y
    if y > before && y > after {
      scan_spend(state, 2, 1, scan_location(state, Some(first), EnginePrepare))
      let anchor = if source_extrema {
        ids[(start + offset + count - 1) % n]
      } else {
        first
      }
      state.vertices[anchor].enter = true
      let index = state.minima.length()
      state.minima.push({ vertex: anchor, backward: None, forward: None, })
      match state.entries.get(y) {
        Some(events) => events.push(index)
        None => state.entries[y] = [index]
      }
      height_push(state, y, vertex=Some(first))
    } else if y < before && y < after {
      scan_spend(state, 1, 1, scan_location(state, Some(first), EnginePrepare))
      for k = 0; k < count; k = k + 1 {
        scan_spend(
          state,
          0,
          1,
          scan_location(state, Some(first), EnginePrepare),
        )
        state.vertices[ids[(start + offset + k) % n]].exit_anchor = Some(
          if source_extrema {
            ids[(start + offset + count - 1) % n]
          } else {
            first
          },
        )
      }
    }
    offset += count
  }
}

///|
/// Both bounds stop at the selected exit-plateau anchor. Its convention is
/// explicit in prepare_scan; the original input direction is never reversed.
fn prepare_chain(
  state : ScanState,
  minima_id : Int,
  direction : Int,
  bound : Int,
) -> Int raise ScanAbort {
  let minimum = state.minima[minima_id]
  scan_spend(
    state,
    1,
    1,
    scan_location(state, Some(minimum.vertex), EnginePrepare),
  )
  let ids = [minimum.vertex]
  let mut cursor = minimum.vertex
  let mut ended = false
  for _step = 0; _step < bound; _step = _step + 1 {
    scan_spend(state, 0, 1, scan_location(state, Some(cursor), EnginePrepare))
    cursor = if direction > 0 {
      state.vertices[cursor].next.unwrap()
    } else {
      state.vertices[cursor].prev.unwrap()
    }
    ids.push(cursor)
    if state.vertices[cursor].exit_anchor is Some(anchor) && cursor == anchor {
      ended = true
      break
    }
  }
  if !ended {
    scan_abort(
      state,
      InvalidInput(
        scan_location(state, Some(cursor), EnginePrepare),
        "Boundary chain did not reach an exit within its contour",
      ),
    )
  }
  let index = state.chains.length()
  state.chains.push({
    minima: minima_id,
    direction,
    vertices: ids,
    left_bound: false,
  })
  index
}

///|
#warnings("-unused_value")
fn prepare_scan(
  subject : Paths64,
  clip : Paths64,
  limits? : ScanLimits = Default::default(),
  source_extrema? : Bool = false,
  budget? : CallBudget,
  internal_input? : Bool = false,
) -> Result[ScanState, ClipError] {
  let budget = match budget {
    Some(value) => value
    None => new_call_budget(limits)
  }
  let limits = budget.limits
  let preflight_work = match
    scan_check_inputs(
      subject,
      clip,
      limits,
      spent_work=budget.stats.work,
      internal_input~,
      internal_stage=budget.cleanup_stage,
    ) {
    Err(error) => return Err(error)
    Ok(work) => work
  }
  let state = new_scan_state(limits, budget~, internal_input~)
  try {
    scan_spend(state, 0, preflight_work, location(EnginePrepare, None, None))
    for i = 0; i < subject.length(); i = i + 1 {
      prepare_path(state, subject[i], Subject, i, i)
    }
    for i = 0; i < clip.length(); i = i + 1 {
      prepare_path(state, clip[i], Clip, i, subject.length() + i)
    }
    for path in state.paths {
      prepare_extrema(state, path, source_extrema)
    }
    for i = 0; i < state.minima.length(); i = i + 1 {
      let min = state.minima[i]
      let global = state.vertices[min.vertex].source.global_path
      let bound = state.paths[global].vertices.length()
      scan_reserve(
        state,
        2,
        2,
        scan_location(state, Some(min.vertex), EnginePrepare),
      )
      let backward = prepare_chain(state, i, -1, bound)
      let forward = prepare_chain(state, i, 1, bound)
      min.backward = Some(backward)
      min.forward = Some(forward)
      let bot = state.vertices[min.vertex].point
      let a = state.vertices[state.chains[backward].vertices[1]].point
      let b = state.vertices[state.chains[forward].vertices[1]].point
      let backward_left = if a.y == bot.y {
        a.x < bot.x
      } else if b.y == bot.y {
        b.x > bot.x
      } else {
        cross_validated(bot, a, b) > 0L
      }
      state.chains[backward].left_bound = backward_left
      state.chains[forward].left_bound = !backward_left
    }
    Ok(state)
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
/// Geometric relation only. Zero means collinear direction, not source identity.
fn edge_position_compare(
  state : ScanState,
  a : ActiveEdge,
  b : ActiveEdge,
) -> Int {
  if a.current_x < b.current_x {
    return -1
  }
  if a.current_x > b.current_x {
    return 1
  }
  if a.horizontal != NonHorizontal || b.horizontal != NonHorizontal {
    return 0
  }
  let ab = state.vertices[a.bot].point
  let at = state.vertices[a.top].point
  let bb = state.vertices[b.bot].point
  let bt = state.vertices[b.top].point
  let determinant = cross_components(
    at.x - ab.x,
    at.y - ab.y,
    bt.x - bb.x,
    bt.y - bb.y,
  )
  if determinant > 0L {
    -1
  } else if determinant < 0L {
    1
  } else {
    0
  }
}

///|
fn chain_lookahead(
  state : ScanState,
  edge : ActiveEdge,
  origin : Point64,
  through : Point64,
) -> Int64 raise ScanAbort {
  let chain = state.chains[edge.chain]
  for i = edge.cursor + 2; i < chain.vertices.length(); i = i + 1 {
    scan_spend(
      state,
      0,
      1,
      scan_location(state, Some(chain.vertices[i]), ActiveEdges),
    )
    let turn = cross_validated(
      origin,
      through,
      state.vertices[chain.vertices[i]].point,
    )
    if turn != 0L {
      return turn
    }
  }
  0L
}

///|
fn stable_chain_before(
  state : ScanState,
  a : ActiveEdge,
  b : ActiveEdge,
) -> Bool {
  let ac = state.chains[a.chain]
  let bc = state.chains[b.chain]
  let av = state.vertices[state.minima[ac.minima].vertex].source
  let bv = state.vertices[state.minima[bc.minima].vertex].source
  if av.global_path != bv.global_path {
    return av.global_path < bv.global_path
  }
  if av.vertex != bv.vertex {
    return av.vertex < bv.vertex
  }
  ac.direction < bc.direction
}

///|
/// State-dependent closed-path insertion predicate adapted from IsValidAelOrder.
/// Do not pass this predicate to a generic sorting function.
fn resident_before_new(
  state : ScanState,
  resident : ActiveEdge,
  newcomer : ActiveEdge,
) -> Bool raise ScanAbort {
  scan_spend(state, 0, 1, scan_location(state, Some(newcomer.bot), ActiveEdges))
  state.stats.comparisons += 1
  if newcomer.current_x != resident.current_x {
    return newcomer.current_x > resident.current_x
  }
  let rt = state.vertices[resident.top].point
  let nb = state.vertices[newcomer.bot].point
  let nt = state.vertices[newcomer.top].point
  let turn = cross_validated(rt, nb, nt)
  if turn != 0L {
    return turn < 0L
  }
  if rt.y > nt.y {
    let next_turn = chain_lookahead(state, resident, nb, rt)
    if next_turn != 0L {
      return next_turn < 0L
    }
  } else if nt.y > rt.y {
    let next_turn = chain_lookahead(state, newcomer, nb, nt)
    if next_turn != 0L {
      return next_turn > 0L
    }
  }
  let rc = state.chains[resident.chain]
  let nc = state.chains[newcomer.chain]
  let rb = state.vertices[resident.bot].point
  let rm = state.minima[rc.minima]
  if rb.y != nb.y || state.vertices[rm.vertex].point.y != nb.y {
    return nc.left_bound
  }
  if rc.left_bound != nc.left_bound {
    return nc.left_bound
  }
  let r_alt = if rc.direction > 0 {
    rm.backward.unwrap()
  } else {
    rm.forward.unwrap()
  }
  let nm = state.minima[nc.minima]
  let n_alt = if nc.direction > 0 {
    nm.backward.unwrap()
  } else {
    nm.forward.unwrap()
  }
  let rp = state.vertices[state.chains[r_alt].vertices[1]].point
  let np = state.vertices[state.chains[n_alt].vertices[1]].point
  let alternate_turn = cross_validated(rp, nb, np)
  if alternate_turn != 0L {
    return (alternate_turn > 0L) == nc.left_bound
  }
  stable_chain_before(state, resident, newcomer)
}

///|
fn ael_insert(state : ScanState, id : EdgeId) -> Unit raise ScanAbort {
  let edge = edge_get(state, id)
  let loc = scan_location(state, Some(edge.bot), ActiveEdges)
  if edge.in_ael {
    scan_abort(state, InvalidInput(loc, "Active edge is already inserted"))
  }
  scan_spend(state, 0, 1, loc)
  let mut before : EdgeId? = None
  let mut after = state.ael_head
  while after is Some(resident) {
    scan_spend(state, 0, 1, loc)
    if !resident_before_new(state, edge_get(state, resident), edge) {
      break
    }
    before = after
    after = edge_get(state, resident).next_ael
  }
  edge.prev_ael = before
  edge.next_ael = after
  match before {
    Some(prev) => edge_get(state, prev).next_ael = Some(id)
    None => state.ael_head = Some(id)
  }
  if after is Some(next) {
    edge_get(state, next).prev_ael = Some(id)
  }
  edge.in_ael = true
  state.ael_count += 1
  if state.ael_count > state.stats.peak_active {
    state.stats.peak_active = state.ael_count
  }
}

///|
fn horizontal_push(state : ScanState, id : EdgeId) -> Unit raise ScanAbort {
  let edge = edge_get(state, id)
  let loc = scan_location(state, Some(edge.bot), ScanEvents)
  if !edge.in_ael ||
    edge.at_exit ||
    edge.horizontal == NonHorizontal ||
    edge.queued_horizontal ||
    state.held_horizontal == Some(id) {
    scan_abort(
      state,
      InvalidInput(loc, "Invalid or duplicate horizontal event"),
    )
  }
  scan_spend(state, 1, 1, loc)
  edge.queued_horizontal = true
  state.horizontal_queue.push(id)
}

///|
fn horizontal_pop(state : ScanState) -> EdgeId? raise ScanAbort {
  scan_spend(state, 0, 1, location(ScanEvents, None, None))
  if state.held_horizontal is Some(_) {
    scan_abort(
      state,
      InvalidInput(
        location(ScanEvents, None, None),
        "A horizontal event is still pending",
      ),
    )
  }
  let result = state.horizontal_queue.pop()
  if result is Some(id) {
    edge_get(state, id).queued_horizontal = false
    state.held_horizontal = Some(id)
  }
  result
}

///|
fn schedule_edge(state : ScanState, id : EdgeId) -> Unit raise ScanAbort {
  let edge = edge_get(state, id)
  if edge.horizontal != NonHorizontal {
    horizontal_push(state, id)
  } else {
    height_push(state, state.vertices[edge.top].point.y, vertex=Some(edge.top))
  }
}

///|
/// Advance one real boundary segment; terminal edge retains its exit pairing.
fn edge_advance(state : ScanState, id : EdgeId) -> Unit raise ScanAbort {
  let edge = edge_get(state, id)
  let chain = state.chains[edge.chain]
  let loc = scan_location(state, Some(edge.top), ScanTop)
  if edge.at_exit || edge.queued_horizontal || state.held_horizontal == Some(id) {
    scan_abort(
      state,
      InvalidInput(
        loc, "Boundary advancement requires a consumed endpoint event",
      ),
    )
  }
  if state.current_y != Some(state.vertices[edge.top].point.y) {
    scan_abort(
      state,
      InvalidInput(loc, "Boundary segment has not reached its endpoint height"),
    )
  }
  scan_spend(state, 0, 1, loc)
  edge.current_x = state.vertices[edge.top].point.x
  if edge.cursor + 2 == chain.vertices.length() {
    edge.at_exit = true
    return
  }
  let previous_horizontal = edge.horizontal
  edge.cursor += 1
  edge.bot = edge.top
  edge.top = chain.vertices[edge.cursor + 1]
  edge.horizontal = horizontal_direction(
    state.vertices[edge.bot].point,
    state.vertices[edge.top].point,
  )
  edge.horizontal_retrace = previous_horizontal != NonHorizontal &&
    edge.horizontal != NonHorizontal &&
    previous_horizontal != edge.horizontal
  schedule_edge(state, id)
}

///|
/// Return the actual crossing candidate, leaving it and the held horizontal live.
fn horizontal_crossing(
  state : ScanState,
  id : EdgeId,
) -> EdgeId? raise ScanAbort {
  let edge = edge_get(state, id)
  scan_spend(state, 0, 1, scan_location(state, Some(edge.bot), ScanEvents))
  if edge.horizontal_retrace {
    return Some(id)
  }
  let a = state.vertices[edge.bot].point
  let b = state.vertices[edge.top].point
  let low = if a.x < b.x { a.x } else { b.x }
  let high = if a.x > b.x { a.x } else { b.x }
  let chain = state.chains[edge.chain]
  let mut cursor = state.ael_head
  while cursor is Some(other) {
    let candidate = edge_get(state, other)
    scan_spend(state, 0, 1, scan_location(state, Some(edge.bot), ScanEvents))
    if other != id {
      state.stats.comparisons += 1
    }
    if other != id && candidate.current_x >= low && candidate.current_x <= high {
      let other_chain = state.chains[candidate.chain]
      let own_start = chain.minima == other_chain.minima &&
        candidate.current_x == a.x &&
        edge.cursor == 0 &&
        candidate.cursor == 0
      let same_exit = chain.vertices[chain.vertices.length() - 1] ==
        other_chain.vertices[other_chain.vertices.length() - 1] &&
        candidate.current_x == b.x &&
        candidate.at_exit
      if !own_start && !same_exit {
        return Some(other)
      }
    }
    cursor = candidate.next_ael
  }
  None
}

///|
/// Trusted event-consumer boundary: Commit 5 must process crossing/output events
/// before calling this. The automatic driver only calls it for a clear span.
fn commit_horizontal(state : ScanState, id : EdgeId) -> Unit raise ScanAbort {
  let edge = edge_get(state, id)
  if state.held_horizontal != Some(id) || edge.horizontal == NonHorizontal {
    scan_abort(
      state,
      InvalidInput(
        scan_location(state, Some(edge.bot), ScanEvents),
        "Horizontal commit does not match the pending event",
      ),
    )
  }
  scan_spend(state, 0, 1, scan_location(state, Some(edge.bot), ScanEvents))
  state.held_horizontal = None
  state.stats.horizontal_steps += 1
  edge_advance(state, id)
  state.phase = Horizontals
}

///|
fn enter_height(state : ScanState) -> Unit raise ScanAbort {
  let y = state.current_y.unwrap()
  if state.entries.get(y) is Some(events) {
    for index in events {
      let minimum = state.minima[index]
      let mut contact : EdgeId? = None
      let mut existing = state.ael_head
      while existing is Some(handle) {
        let edge = edge_get(state, handle)
        scan_spend(
          state,
          0,
          1,
          scan_location(state, Some(minimum.vertex), ScanEvents),
        )
        state.stats.comparisons += 1
        if edge.current_x == state.vertices[minimum.vertex].point.x {
          contact = Some(handle)
          break
        }
        existing = edge.next_ael
      }
      scan_reserve(
        state,
        2,
        2,
        scan_location(state, Some(minimum.vertex), ScanEvents),
      )
      let backward = edge_allocate(state, minimum.backward.unwrap())
      let forward = edge_allocate(state, minimum.forward.unwrap())
      let first = if state.chains[edge_get(state, backward).chain].left_bound {
        backward
      } else {
        forward
      }
      let second = if first == backward { forward } else { backward }
      ael_insert(state, first)
      ael_insert(state, second)
      schedule_edge(state, first)
      schedule_edge(state, second)
      if state.entry_contact is None && contact is Some(resident) {
        scan_spend(
          state,
          1,
          1,
          scan_location(state, Some(minimum.vertex), ScanEvents),
        )
        state.entry_contact = Some((minimum.vertex, first, resident))
      }
    }
    state.entries.remove(y)
  }
}

///|
fn projected_x(
  state : ScanState,
  edge : ActiveEdge,
  y : Int64,
) -> Int64 raise ScanAbort {
  scan_spend(state, 0, 1, scan_location(state, Some(edge.bot), ScanBand))
  scan_project(
    state.vertices[edge.bot].point,
    state.vertices[edge.top].point,
    y,
  ) catch {
    ScanAbort(error) => scan_abort(state, error)
  }
}

///|
/// Conservatively suspend on inversions or ambiguous projected ties. Never sort AEL.
fn band_needs_events(state : ScanState, y : Int64) -> Bool raise ScanAbort {
  let mut cursor = state.ael_head
  while cursor is Some(id) {
    let edge = edge_get(state, id)
    let x = projected_x(state, edge, y)
    if edge.next_ael is Some(next) {
      let other = edge_get(state, next)
      let nx = projected_x(state, other, y)
      scan_spend(state, 0, 1, scan_location(state, Some(edge.bot), ScanBand))
      state.stats.comparisons += 1
      if edge.current_x == other.current_x &&
        edge_position_compare(state, edge, other) > 0 {
        return true
      }
      let shared_exit = edge.top == other.top &&
        state.vertices[edge.top].exit_anchor == Some(edge.top)
      if x > nx || (x == nx && !shared_exit) {
        return true
      }
    }
    cursor = edge.next_ael
  }
  false
}

///|
/// Apply a band after verified event processing. An unchanged inverted AEL fails.
fn commit_band(state : ScanState, y : Int64) -> Unit raise ScanAbort {
  scan_live(state)
  if state.phase != AwaitIntersections(y) {
    scan_abort(
      state,
      InvalidInput(
        location(ScanBand, None, None),
        "Band commit does not match the pending height",
      ),
    )
  }
  let mut cursor = state.ael_head
  let mut previous : Int64? = None
  while cursor is Some(id) {
    let edge = edge_get(state, id)
    let x = projected_x(state, edge, y)
    if previous is Some(px) && px > x {
      scan_abort(
        state,
        InvalidInput(
          scan_location(state, Some(edge.bot), ScanBand),
          "Intersection events have not restored active edge order",
        ),
      )
    }
    previous = Some(x)
    cursor = edge.next_ael
  }
  sel_clear(state)
  cursor = state.ael_head
  while cursor is Some(id) {
    let edge = edge_get(state, id)
    edge.current_x = projected_x(state, edge, y)
    cursor = edge.next_ael
  }
  state.current_y = Some(y)
  state.stats.heights += 1
  state.needs_entries = true
  state.phase = TopVertices
}

///|
fn find_maxima(state : ScanState) -> ScanPhase? raise ScanAbort {
  let mut cursor = state.ael_head
  while cursor is Some(id) {
    let edge = edge_get(state, id)
    scan_spend(state, 0, 1, scan_location(state, Some(edge.top), ScanTop))
    if edge.at_exit {
      let mut next = edge.next_ael
      while next is Some(other) {
        let candidate = edge_get(state, other)
        scan_spend(state, 0, 1, scan_location(state, Some(edge.top), ScanTop))
        if candidate.at_exit && edge.top == candidate.top {
          return Some(AwaitMaxima(edge.top, id, other))
        }
        next = candidate.next_ael
      }
      scan_abort(
        state,
        InvalidInput(
          scan_location(state, Some(edge.top), ScanTop),
          "Unpaired boundary exit",
        ),
      )
    }
    cursor = edge.next_ael
  }
  None
}

///|
/// Explicit maxima consumer; preserves immutable chain provenance before release.
#warnings("-unused_value")
fn commit_maxima(
  state : ScanState,
  first : EdgeId,
  second : EdgeId,
) -> Unit raise ScanAbort {
  let a = edge_get(state, first)
  let b = edge_get(state, second)
  if state.phase != AwaitMaxima(a.top, first, second) ||
    !a.at_exit ||
    !b.at_exit ||
    a.top != b.top ||
    a.next_ael != Some(second) {
    scan_abort(
      state,
      InvalidInput(
        scan_location(state, Some(a.top), ScanTop),
        "Maxima commit requires the pending adjacent exit pair",
      ),
    )
  }
  scan_spend(state, 1, 1, scan_location(state, Some(a.top), ScanTop))
  state.exits.push({
    vertex: a.top,
    first_chain: a.chain,
    second_chain: b.chain,
  })
  // Pending phase no longer references handles before either slot is released.
  state.phase = Horizontals
  ael_remove(state, first)
  ael_remove(state, second)
  edge_release(state, first)
  edge_release(state, second)
}

///|
/// One real phase per call. Await* states are stable boundaries, never no-ops
/// pretending that intersections, horizontal crossings or output joins ran.
#warnings("-unused_value")
fn scan_step(state : ScanState) -> Result[ScanPhase, ClipError] {
  if state.failure is Some(error) {
    return Err(error)
  }
  if state.phase == Complete {
    return Ok(Complete)
  }
  try {
    scan_spend(state, 0, 1, location(ScanEvents, None, None))
    match state.phase {
      Ready =>
        match height_pop(state) {
          None => state.phase = Complete
          Some(y) => {
            state.current_y = Some(y)
            state.stats.heights += 1
            state.phase = EnterMinima
          }
        }
      EnterMinima => {
        enter_height(state)
        state.phase = match state.entry_contact {
          Some((vertex, a, b)) => AwaitEntryContact(vertex, a, b)
          None => Horizontals
        }
      }
      Horizontals =>
        match horizontal_pop(state) {
          Some(id) =>
            if horizontal_crossing(state, id) is Some(_) {
              state.phase = AwaitHorizontal(id)
            } else {
              commit_horizontal(state, id)
            }
          None =>
            match find_maxima(state) {
              Some(phase) => state.phase = phase
              None =>
                if state.needs_entries {
                  state.needs_entries = false
                  state.phase = EnterMinima
                } else {
                  state.phase = PrepareBand
                }
            }
        }
      PrepareBand =>
        match height_pop(state) {
          None =>
            if state.ael_count == 0 {
              state.phase = Complete
            } else {
              scan_abort(
                state,
                InvalidInput(
                  location(ScanBand, None, None),
                  "Active boundaries remain without a scheduled endpoint",
                ),
              )
            }
          Some(y) => {
            sel_snapshot(state)
            state.phase = AwaitIntersections(y)
            if !band_needs_events(state, y) {
              commit_band(state, y)
            }
          }
        }
      TopVertices => {
        let mut cursor = state.ael_head
        while cursor is Some(id) {
          let edge = edge_get(state, id)
          scan_spend(state, 0, 1, scan_location(state, Some(edge.top), ScanTop))
          cursor = edge.next_ael
          if state.vertices[edge.top].point.y == state.current_y.unwrap() {
            edge_advance(state, id)
          }
        }
        state.phase = Horizontals
      }
      AwaitIntersections(_)
      | AwaitHorizontal(_)
      | AwaitMaxima(_, _, _)
      | AwaitEntryContact(_, _, _) => ()
      Complete | Failed => ()
    }
    Ok(state.phase)
  } catch {
    ScanAbort(error) => Err(error)
  }
}
