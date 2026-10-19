// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Clipper2-derived ring operations, Copyright (c) Angus Johnson 2010-2025.

///|
type OutPtId = Int

///|
type OutRecId = Int

///|
#warnings("-unused_value")
priv enum OutputSide {
  Front
  Back
} derive(Eq, Debug)

///|
priv struct OutputEnd {
  record : OutRecId
  side : OutputSide
}

///|
#warnings("-unused_value")
priv enum OutputStatus {
  Building
  Closed
  Redirect(OutRecId)
  Invalid
} derive(Eq, Debug)

///|
priv struct OutPt {
  point : Point64
  mut prev : OutPtId
  mut next : OutPtId
  mut record : OutRecId
  mut alive : Bool
}

///|
priv struct OutRec {
  mut anchor : OutPtId?
  mut front_edge : EdgeId?
  mut back_edge : EdgeId?
  mut status : OutputStatus
  split_from : OutRecId?
  // Hints, final geometric parent, alias and split provenance are distinct.
  mut owner_hint : OutRecId?
  mut hint_inside : Bool
  mut geometric_parent : OutRecId?
  mut bounds_cache : (Int, Bounds64)?
  mut revision : Int
}

///|
priv struct HorizontalSegment {
  first : OutPtId
  second : OutPtId
  y : Int64
  left : Int64
  right : Int64
  to_right : Bool
}

///|
priv struct HorizontalJoin {
  first : OutPtId
  second : OutPtId
  left : Int64
  right : Int64
  mut consumed : Bool
  opposed : Bool
}

///|
priv struct OutputState {
  points : Array[OutPt]
  records : Array[OutRec]
  horizontals : Array[HorizontalSegment]
  joins : Array[HorizontalJoin]
}

///|
fn new_output_state() -> OutputState {
  { points: [], records: [], horizontals: [], joins: [], }
}

///|
fn[T] output_error(state : ScanState, message : String) -> T raise ScanAbort {
  scan_abort(state, InvalidInput(location(OutputTopology, None, None), message))
}

///|
fn output_spend(
  state : ScanState,
  nodes : Int,
  work : Int,
  loc? : ErrorLocation = location(OutputTopology, None, None),
) -> Unit raise ScanAbort {
  if state.failure is Some(error) {
    raise ScanAbort(error)
  }
  if state.cleaned {
    output_error(state, "Output state has been cleaned")
  }
  if budget_error(state.budget, nodes, work, loc) is Some(error) {
    scan_abort(state, error)
  }
  state.stats.nodes += nodes
  state.stats.work += work
}

///|
fn output_point(state : ScanState, id : OutPtId) -> OutPt raise ScanAbort {
  if state.failure is Some(error) {
    raise ScanAbort(error)
  }
  if state.cleaned {
    output_error(state, "Output state has been cleaned")
  }
  if id < 0 ||
    id >= state.output.points.length() ||
    !state.output.points[id].alive {
    output_error(state, "Invalid or disposed output node")
  }
  state.output.points[id]
}

///|
fn output_resolve(state : ScanState, id : OutRecId) -> OutRecId raise ScanAbort {
  let mut current = id
  for steps = 0; steps <= state.output.records.length(); steps = steps + 1 {
    output_spend(state, 0, 1)
    if current < 0 || current >= state.output.records.length() {
      output_error(state, "Invalid output record")
    }
    match state.output.records[current].status {
      Redirect(target) => current = target
      Invalid => output_error(state, "Disposed output record")
      _ => return current
    }
  }
  output_error(state, "Cyclic output redirection")
}

///|
fn output_new_record(
  state : ScanState,
  split_from : OutRecId?,
) -> OutRecId raise ScanAbort {
  if split_from is Some(source) &&
    (source < 0 || source >= state.output.records.length()) {
    output_error(state, "Invalid split source record")
  }
  output_spend(state, 1, 1)
  let id = state.output.records.length()
  state.stats.output_records += 1
  state.output.records.push({
    anchor: None,
    front_edge: None,
    back_edge: None,
    status: Building,
    split_from,
    owner_hint: match split_from {
      Some(source) => state.output.records[source].owner_hint
      None => None
    },
    hint_inside: false,
    geometric_parent: None,
    bounds_cache: None,
    revision: 0,
  })
  id
}

///|
fn output_new_point(
  state : ScanState,
  record : OutRecId,
  point : Point64,
) -> OutPtId raise ScanAbort {
  output_spend(state, 1, 1)
  let id = state.output.points.length()
  state.stats.output_points += 1
  state.output.points.push({ point, prev: id, next: id, record, alive: true, })
  id
}

///|
/// Reserve record and initial node together before either container expands.
fn output_create(
  state : ScanState,
  point : Point64,
  split_from? : OutRecId? = None,
) -> OutRecId raise ScanAbort {
  scan_reserve(state, 2, 2, location(OutputTopology, None, None))
  let record = output_new_record(state, split_from)
  let node = output_new_point(state, record, point)
  state.output.records[record].anchor = Some(node)
  record
}

///|
fn output_append(
  state : ScanState,
  record : OutRecId,
  side : OutputSide,
  point : Point64,
) -> OutPtId raise ScanAbort {
  let id = output_resolve(state, record)
  let rec = state.output.records[id]
  if rec.status != Building {
    output_error(state, "Append requires a building contour")
  }
  let front = rec.anchor.unwrap()
  let back = output_point(state, front).prev
  let endpoint = if side == Front { front } else { back }
  if output_point(state, endpoint).point == point {
    return endpoint
  }
  let node = output_new_point(state, id, point)
  state.output.points[node].prev = back
  state.output.points[node].next = front
  state.output.points[back].next = node
  state.output.points[front].prev = node
  if side == Front {
    rec.anchor = Some(node)
  }
  rec.revision += 1
  node
}

///|
fn output_bind(
  state : ScanState,
  edge_id : EdgeId,
  record : OutRecId,
  side : OutputSide,
) -> Unit raise ScanAbort {
  let id = output_resolve(state, record)
  let edge = edge_get(state, edge_id)
  let rec = state.output.records[id]
  if rec.status != Building || edge.output_end is Some(_) {
    output_error(state, "Output end is already occupied or closed")
  }
  if (side == Front && rec.front_edge is Some(_)) ||
    (side == Back && rec.back_edge is Some(_)) {
    output_error(state, "Output side already has an active edge")
  }
  output_spend(state, 0, 1)
  edge.output_end = Some({ record: id, side, })
  if side == Front {
    rec.front_edge = Some(edge_id)
  } else {
    rec.back_edge = Some(edge_id)
  }
}

///|
fn output_unbind(state : ScanState, edge_id : EdgeId) -> Unit raise ScanAbort {
  let edge = edge_get(state, edge_id)
  if edge.output_end is Some(end) {
    let id = output_resolve(state, end.record)
    let rec = state.output.records[id]
    if end.side == Front {
      rec.front_edge = None
    } else {
      rec.back_edge = None
    }
    edge.output_end = None
  }
}

///|
fn output_add_edge(
  state : ScanState,
  edge_id : EdgeId,
  point : Point64,
) -> OutPtId? raise ScanAbort {
  match edge_get(state, edge_id).output_end {
    None => None
    Some(end) => Some(output_append(state, end.record, end.side, point))
  }
}

///|
fn output_start(
  state : ScanState,
  a : EdgeId,
  b : EdgeId,
  point : Point64,
  split_from? : OutRecId? = None,
) -> Unit raise ScanAbort {
  if a == b ||
    edge_get(state, a).output_end is Some(_) ||
    edge_get(state, b).output_end is Some(_) {
    output_error(state, "Starting contour requires two distinct unbound edges")
  }
  let record = output_create(state, point, split_from~)
  output_bind(state, a, record, Front)
  output_bind(state, b, record, Back)
}

///|
fn output_exchange(
  state : ScanState,
  a : EdgeId,
  b : EdgeId,
) -> Unit raise ScanAbort {
  let ea = edge_get(state, a)
  let eb = edge_get(state, b)
  let x = ea.output_end
  let y = eb.output_end
  output_unbind(state, a)
  output_unbind(state, b)
  if x is Some(e) {
    output_bind(state, b, e.record, e.side)
  }
  if y is Some(e) {
    output_bind(state, a, e.record, e.side)
  }
}

///|
fn output_ring(
  state : ScanState,
  anchor : OutPtId,
) -> Array[OutPtId] raise ScanAbort {
  output_spend(state, 1, 0)
  let result = []
  let mut cursor = anchor
  for steps = 0; steps <= state.output.points.length(); steps = steps + 1 {
    let node = output_point(state, cursor)
    output_spend(state, 1, 1)
    result.push(cursor)
    cursor = node.next
    if cursor == anchor {
      return result
    }
  }
  output_error(state, "Output ring does not close at its anchor")
}

///|
fn output_close(state : ScanState, record : OutRecId) -> Unit raise ScanAbort {
  let id = output_resolve(state, record)
  let rec = state.output.records[id]
  if rec.status != Building {
    output_error(state, "Contour is not building")
  }
  if rec.front_edge is Some(a) {
    output_unbind(state, a)
  }
  if rec.back_edge is Some(b) {
    output_unbind(state, b)
  }
  output_spend(state, 0, 1)
  rec.status = Closed
}

///|
/// Orient the open chains at the selected ends, then join their actual nodes.
fn output_close_or_merge(
  state : ScanState,
  a : EdgeId,
  b : EdgeId,
  point : Point64,
) -> Unit raise ScanAbort {
  guard edge_get(state, a).output_end is Some(ae) else {
    output_error(state, "Missing first output end")
  }
  guard edge_get(state, b).output_end is Some(be) else {
    output_error(state, "Missing second output end")
  }
  let ar = output_resolve(state, ae.record)
  let br = output_resolve(state, be.record)
  let maximum = output_add_edge(state, a, point)
  if !state.preserve_collinear {
    ignore(output_add_edge(state, b, point))
  }
  if ar == br {
    output_close(state, ar)
    if state.preserve_collinear && maximum is Some(op) {
      state.output.records[ar].anchor = Some(op)
    }
    return
  }
  let ac = state.output.records[ar]
  let bc = state.output.records[br]
  let left = output_ring(state, ac.anchor.unwrap())
  let right = output_ring(state, bc.anchor.unwrap())
  if ae.side == Front {
    output_reverse(state, left)
  }
  if be.side == Back {
    output_reverse(state, right)
  }
  let preserve_front = state.boolean_operation is Some(_) && ae.side == Front
  if preserve_front {
    output_reverse(state, left)
    output_reverse(state, right)
  }
  let remaining_a = if ae.side == Front { ac.back_edge } else { ac.front_edge }
  let remaining_b = if be.side == Front { bc.back_edge } else { bc.front_edge }
  output_spend(state, 0, left.length() + right.length())
  output_unbind(state, a)
  output_unbind(state, b)
  if remaining_a is Some(e) {
    output_unbind(state, e)
  }
  if remaining_b is Some(e) {
    output_unbind(state, e)
  }
  let first = left[0]
  let last = right[right.length() - 1]
  for i = 0; i < left.length(); i = i + 1 {
    let n = state.output.points[left[i]]
    n.prev = if i == 0 { last } else { left[i - 1] }
    n.next = if i + 1 == left.length() { right[0] } else { left[i + 1] }
  }
  for i = 0; i < right.length(); i = i + 1 {
    let n = state.output.points[right[i]]
    n.record = ar
    n.prev = if i == 0 { left[left.length() - 1] } else { right[i - 1] }
    n.next = if i + 1 == right.length() { first } else { right[i + 1] }
  }
  ac.anchor = Some(if preserve_front { right[0] } else { first })
  ac.revision += 1
  bc.anchor = None
  bc.status = Redirect(ar)
  bc.revision += 1
  if remaining_a is Some(e) {
    output_bind(state, e, ar, if preserve_front { Back } else { Front })
  }
  if remaining_b is Some(e) {
    output_bind(state, e, ar, if preserve_front { Front } else { Back })
  }
}

///|
/// Swap successors: same closed record splits, different closed records merge.
/// Node identity, not coordinate equality, defines this explicit topology action.
fn output_splice(
  state : ScanState,
  first : OutPtId,
  second : OutPtId,
) -> OutRecId raise ScanAbort {
  if first == second {
    output_error(state, "A splice requires distinct nodes")
  }
  let a = output_point(state, first)
  let b = output_point(state, second)
  let ar = output_resolve(state, a.record)
  let br = output_resolve(state, b.record)
  if state.output.records[ar].status != Closed ||
    state.output.records[br].status != Closed {
    output_error(state, "Ring splice requires completed contours")
  }
  let old_one = output_ring(state, first)
  let total = if ar == br {
    old_one.length()
  } else {
    old_one.length() + output_ring(state, second).length()
  }
  output_spend(state, 0, total + 1)
  let new_record = if ar == br {
    output_new_record(state, Some(ar))
  } else {
    ar
  }
  let an = a.next
  let bn = b.next
  a.next = bn
  state.output.points[bn].prev = first
  b.next = an
  state.output.points[an].prev = second
  // Traversals prepaid by the original disjoint rings; successor swap preserves
  // exactly these nodes and cannot fail halfway through a topology mutation.
  let mut cursor = first
  for steps = 0; steps < total; steps = steps + 1 {
    state.output.points[cursor].record = ar
    cursor = state.output.points[cursor].next
    if cursor == first {
      break
    }
  }
  state.output.records[ar].anchor = Some(first)
  state.output.records[ar].revision += 1
  if ar == br {
    cursor = second
    for steps = 0; steps < total; steps = steps + 1 {
      state.output.points[cursor].record = new_record
      cursor = state.output.points[cursor].next
      if cursor == second {
        break
      }
    }
    state.output.records[new_record].anchor = Some(second)
    state.output.records[new_record].status = Closed
  } else {
    state.output.records[br].anchor = None
    state.output.records[br].status = Redirect(ar)
    state.output.records[br].revision += 1
  }
  new_record
}

///|
fn output_remove_point(
  state : ScanState,
  record : OutRecId,
  id : OutPtId,
) -> Unit raise ScanAbort {
  let node = output_point(state, id)
  output_spend(state, 0, 1)
  let rec = state.output.records[record]
  if node.next == id {
    rec.anchor = None
    rec.status = Invalid
  } else {
    state.output.points[node.prev].next = node.next
    state.output.points[node.next].prev = node.prev
    if rec.anchor == Some(id) {
      rec.anchor = Some(node.next)
    }
  }
  node.alive = false
  rec.revision += 1
}

///|
/// PreserveCollinear matches the reference option. Always remove duplicates/spikes.
fn output_clean(
  state : ScanState,
  record : OutRecId,
  preserve_collinear : Bool,
) -> Unit raise ScanAbort {
  let id = output_resolve(state, record)
  let rec = state.output.records[id]
  if rec.status != Closed {
    output_error(state, "Cleanup requires a completed ring")
  }
  let mut changed = true
  while changed && rec.anchor is Some(anchor) {
    changed = false
    let nodes = output_ring(state, anchor)
    if nodes.length() < 3 {
      for n in nodes {
        output_remove_point(state, id, n)
      }
      return
    }
    for n in nodes {
      let node = output_point(state, n)
      let prev = output_point(state, node.prev).point
      let next = output_point(state, node.next).point
      output_spend(state, 0, 1)
      let collinear = cross_validated(prev, node.point, next) == 0L
      let dot = (node.point.x - prev.x) * (next.x - node.point.x) +
        (node.point.y - prev.y) * (next.y - node.point.y)
      if collinear &&
        (
          node.point == prev ||
          node.point == next ||
          !preserve_collinear ||
          dot < 0L
        ) {
        output_remove_point(state, id, n)
        changed = true
        break
      }
    }
    if !changed && nodes.length() == 3 {
      let mut tiny = false
      for n in nodes {
        let a = state.output.points[n].point
        let b = state.output.points[state.output.points[n].next].point
        if a.x - b.x > -2L &&
          a.x - b.x < 2L &&
          a.y - b.y > -2L &&
          a.y - b.y < 2L {
          tiny = true
        }
      }
      if tiny {
        for n in nodes {
          output_remove_point(state, id, n)
        }
      }
    }
  }
}

///|
#warnings("-unused_value")
fn output_extract(
  state : ScanState,
  preserve_collinear? : Bool = false,
) -> Paths64 raise ScanAbort {
  let ids = output_finalize(state, preserve_collinear)
  output_snapshot(state, ids)
}

///|
// Dynamic queue: repair may append records. No path or bounds is frozen until
// every original and newly split record has been cleaned and repaired.
fn output_finalize(
  state : ScanState,
  preserve_collinear : Bool,
) -> Array[OutRecId] raise ScanAbort {
  for join in state.output.joins {
    output_spend(state, 0, 1)
    if !join.consumed {
      output_error(
        state, "Horizontal join still needs an explicit connection decision",
      )
    }
  }
  for id = 0; id < state.output.records.length(); id = id + 1 {
    output_spend(state, 0, 1)
    let rec = state.output.records[id]
    rec.geometric_parent = None
    rec.bounds_cache = None
    if rec.status == Building {
      output_error(state, "Cannot export an unfinished contour")
    }
    if rec.status == Closed {
      output_clean(state, id, preserve_collinear)
      if rec.status == Closed {
        output_repair_local(state, id)
      }
      if rec.status == Closed {
        output_clean(state, id, preserve_collinear)
      }
    }
  }
  output_spend(state, 1, state.output.records.length())
  let ids = []
  for id = 0; id < state.output.records.length(); id = id + 1 {
    if state.output.records[id].status == Closed &&
      state.output.records[id].anchor is Some(_) {
      output_spend(state, 1, 0)
      ids.push(id)
    }
  }
  ids
}

///|
fn output_snapshot(
  state : ScanState,
  ids : Array[OutRecId],
) -> Paths64 raise ScanAbort {
  output_spend(state, 1, 0)
  let result = []
  for id in ids {
    let nodes = output_ring(state, state.output.records[id].anchor.unwrap())
    output_spend(state, nodes.length() + 2, nodes.length())
    result.push(nodes.map(fn(n) { state.output.points[n].point }))
  }
  result
}

///|
/// Bounded read-only diagnostics, including after resource failure.
#warnings("-unused_value")
fn output_invariants(
  state : ScanState,
  metered? : Bool = false,
) -> Result[Unit, String] {
  let out = state.output
  match validation_charge(state, metered, out.points.length() + 1, 0) {
    Ok(_) => ()
    Err(e) => return Err(e)
  }
  let seen = Array::make(out.points.length(), false)
  for id = 0; id < out.records.length(); id = id + 1 {
    match validation_charge(state, metered, 0, 1) {
      Ok(_) => ()
      Err(e) => return Err(e)
    }
    let rec = out.records[id]
    if rec.revision < 0 {
      return Err("Invalid topology revision")
    }
    let mut root = id
    let mut steps = 0
    while out.records[root].status is Redirect(next) {
      match validation_charge(state, metered, 0, 1) {
        Ok(_) => ()
        Err(e) => return Err(e)
      }
      if next < 0 ||
        next >= out.records.length() ||
        steps >= out.records.length() {
        return Err("Invalid or cyclic redirection")
      }
      root = next
      steps += 1
    }
    if rec.status is Redirect(_) || rec.status == Invalid {
      if rec.anchor is Some(_) ||
        rec.front_edge is Some(_) ||
        rec.back_edge is Some(_) {
        return Err("Inactive record retains references")
      }
      continue
    }
    guard rec.anchor is Some(anchor) else {
      return Err("Missing output anchor")
    }
    let mut cursor = anchor
    for count = 0; count <= out.points.length(); count = count + 1 {
      match validation_charge(state, metered, 0, 1) {
        Ok(_) => ()
        Err(e) => return Err(e)
      }
      if cursor < 0 || cursor >= out.points.length() {
        return Err("Invalid output node")
      }
      let n = out.points[cursor]
      if !n.alive || n.record != id || seen[cursor] {
        return Err("Wrong output ownership or overlapping rings")
      }
      seen[cursor] = true
      if n.next < 0 ||
        n.next >= out.points.length() ||
        n.prev < 0 ||
        n.prev >= out.points.length() {
        return Err("Invalid output link")
      }
      if out.points[n.next].prev != cursor || out.points[n.prev].next != cursor {
        return Err("Broken output reciprocal links")
      }
      cursor = n.next
      if cursor == anchor {
        break
      }
      if count == out.points.length() {
        return Err("Output cycle misses anchor")
      }
    }
    if rec.status == Closed &&
      (rec.front_edge is Some(_) || rec.back_edge is Some(_)) {
      return Err("Closed record retains active ends")
    }
    match validation_charge(state, metered, 3, 0) {
      Ok(_) => ()
      Err(e) => return Err(e)
    }
    for (handle, side) in [(rec.front_edge, Front), (rec.back_edge, Back)] {
      match validation_charge(state, metered, 0, 1) {
        Ok(_) => ()
        Err(e) => return Err(e)
      }
      if handle is Some(e) {
        guard edge_peek(state, e) is Some(edge) else {
          return Err("Stale output edge")
        }
        guard edge.output_end is Some(end) else {
          return Err("Missing output end")
        }
        if end.record != id || end.side != side {
          return Err("Output end mismatch")
        }
      }
    }
    if rec.split_from is Some(source) && (source < 0 || source >= id) {
      return Err("Invalid split provenance")
    }
  }
  for i = 0; i < out.points.length(); i = i + 1 {
    match validation_charge(state, metered, 0, 1) {
      Ok(_) => ()
      Err(e) => return Err(e)
    }
    if out.points[i].alive != seen[i] {
      return Err("Orphan output point")
    }
  }
  for slot in state.slots {
    match validation_charge(state, metered, 0, 1) {
      Ok(_) => ()
      Err(e) => return Err(e)
    }
    if slot.edge is Some(edge) && edge.output_end is Some(end) {
      if end.record < 0 || end.record >= out.records.length() {
        return Err("Invalid active output record")
      }
      let rec = out.records[end.record]
      let handle = if end.side == Front {
        rec.front_edge
      } else {
        rec.back_edge
      }
      guard handle is Some(id) else {
        return Err("Unregistered active output end")
      }
      guard edge_peek(state, id) is Some(other) else {
        return Err("Stale active output end")
      }
      if other.chain != edge.chain {
        return Err("Wrong active output end")
      }
    }
  }
  Ok(())
}

///|
fn output_reverse(
  state : ScanState,
  nodes : Array[OutPtId],
) -> Unit raise ScanAbort {
  for i = 0; i < nodes.length() / 2; i = i + 1 {
    output_spend(state, 0, 1)
    let j = nodes.length() - 1 - i
    let tmp = nodes[i]
    nodes[i] = nodes[j]
    nodes[j] = tmp
  }
}

///|
fn output_endpoint(
  state : ScanState,
  edge : EdgeId,
) -> OutPtId? raise ScanAbort {
  match edge_get(state, edge).output_end {
    None => None
    Some(end) => {
      let rec = state.output.records[output_resolve(state, end.record)]
      let front = rec.anchor.unwrap()
      Some(
        if end.side == Front {
          front
        } else {
          output_point(state, front).prev
        },
      )
    }
  }
}

///|
fn strict_segment_cross(
  a : Point64,
  b : Point64,
  c : Point64,
  d : Point64,
) -> Bool {
  let ac = cross_validated(a, b, c)
  let ad = cross_validated(a, b, d)
  let ca = cross_validated(c, d, a)
  let cb = cross_validated(c, d, b)
  ac != 0L &&
  ad != 0L &&
  ca != 0L &&
  cb != 0L &&
  (ac > 0L) != (ad > 0L) &&
  (ca > 0L) != (cb > 0L)
}

///|
fn output_area2(
  state : ScanState,
  nodes : Array[OutPtId],
) -> BigInt raise ScanAbort {
  let mut sum = Small(0L)
  for id in nodes {
    output_spend(state, 0, 1)
    let n = state.output.points[id]
    let p = state.output.points[n.prev].point
    sum = add_area_term(sum, p.x * n.point.y - p.y * n.point.x)
  }
  exact_area(sum)
}

///|
/// Fixed FixSelfIntersects local four-edge repair, including the micro-crossing
/// duplicate branch. Area thresholds use exact integers with explicit scaling:
/// upstream Area = S/2, upstream AreaTriangle = T (twice triangle area).
fn output_repair_local(
  state : ScanState,
  record : OutRecId,
) -> Unit raise ScanAbort {
  let rec = state.output.records[record]
  let mut again = true
  while again && rec.status == Closed {
    again = false
    let nodes = output_ring(state, rec.anchor.unwrap())
    if nodes.length() < 4 {
      return
    }
    for id in nodes {
      output_spend(state, 0, 1)
      let node = state.output.points[id]
      let prev = state.output.points[node.prev]
      let next = state.output.points[node.next]
      let far = state.output.points[next.next]
      if !strict_segment_cross(prev.point, node.point, next.point, far.point) {
        continue
      }
      let fifth = state.output.points[far.next]
      if strict_segment_cross(prev.point, node.point, far.point, fifth.point) {
        // Duplicate before op with the fifth coordinate, as fixed upstream.
        let extra = output_new_point(state, record, fifth.point)
        state.output.points[extra].prev = node.prev
        state.output.points[extra].next = id
        prev.next = extra
        node.prev = extra
        rec.revision += 1
        again = true
        break
      }
      let sum = output_area2(state, nodes)
      let absolute = if sum < 0N { -sum } else { sum }
      if absolute < 4N {
        for n in nodes {
          output_remove_point(state, record, n)
        }
        return
      }
      let point = match
        line_intersection(prev.point, node.point, next.point, far.point) {
        Some(p) => p
        None =>
          output_error(
            state, "Local self-crossing has no numerical intersection",
          )
      }
      let triangle = BigInt::from_int64(
        cross_validated(point, node.point, next.point),
      )
      let abs_triangle = if triangle < 0N { -triangle } else { triangle }
      let keep_triangle = abs_triangle >= 1N &&
        (abs_triangle * 2N > absolute || (triangle > 0N) == (sum > 0N))
      let insert_main = point != prev.point && point != far.point
      let needed = (if insert_main { 1 } else { 0 }) +
        (if keep_triangle { 2 } else { 0 })
      // Preflight all related record/node allocations and mutation work together.
      if needed > state.budget.limits.max_nodes - state.budget.stats.nodes {
        scan_abort(
          state,
          ResourceLimitExceeded(
            location(OutputTopology, None, None),
            InternalNodes,
            state.limits.max_nodes,
          ),
        )
      }
      if needed + 1 > state.budget.limits.max_work - state.budget.stats.work {
        scan_abort(
          state,
          ResourceLimitExceeded(
            location(OutputTopology, None, None),
            ScanWork,
            state.limits.max_work,
          ),
        )
      }
      output_spend(state, 0, 1)
      let saved_prev = node.prev
      let saved_next = node.next
      let saved_far = next.next
      let main_node = if insert_main {
        Some(output_new_point(state, record, point))
      } else {
        None
      }
      let new_rec = if keep_triangle {
        Some(output_new_record(state, Some(record)))
      } else {
        None
      }
      let triangle_node = match new_rec {
        Some(r) => Some(output_new_point(state, r, point))
        None => None
      }
      match main_node {
        Some(n) => {
          state.output.points[n].prev = saved_prev
          state.output.points[n].next = saved_far
          prev.next = n
          far.prev = n
        }
        None => {
          prev.next = saved_far
          far.prev = saved_prev
        }
      }
      rec.anchor = Some(saved_prev)
      rec.revision += 1
      match (new_rec, triangle_node) {
        (Some(r), Some(n)) => {
          node.record = r
          next.record = r
          node.prev = n
          next.next = n
          state.output.points[n].prev = saved_next
          state.output.points[n].next = id
          state.output.records[r].anchor = Some(n)
          state.output.records[r].status = Closed
        }
        _ => {
          node.alive = false
          next.alive = false
        }
      }
      again = true
      break
    }
  }
}
