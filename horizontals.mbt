// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Horizontal layering and explicit ring joins adapted from Clipper2 concepts,
// Copyright (c) Angus Johnson 2010-2025.

///|
fn horizontal_segment(
  state : ScanState,
  first : OutPtId,
  second : OutPtId,
) -> Unit raise ScanAbort {
  let a = output_point(state, first)
  let b = output_point(state, second)
  if a.point.y != b.point.y || a.point.x == b.point.x {
    return
  }
  if output_resolve(state, a.record) != output_resolve(state, b.record) {
    return
  }
  let left = if a.point.x < b.point.x { a.point.x } else { b.point.x }
  let right = if a.point.x > b.point.x { a.point.x } else { b.point.x }
  horizontal_spend(state, 1, 1, location(HorizontalEvents, None, None))
  let segment : HorizontalSegment = {
    first,
    second,
    y: a.point.y,
    left,
    right,
    to_right: a.point.x < b.point.x,
  }
  // Candidates retain node identities. Point contact alone creates no join.
  for existing in state.output.horizontals {
    horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
    if existing.y != segment.y {
      continue
    }
    let low = if existing.left > left { existing.left } else { left }
    let high = if existing.right < right { existing.right } else { right }
    if low >= high {
      continue
    }
    let one = horizontal_node_at(state, existing, low)
    let two = horizontal_node_at(state, segment, low)
    if one != two {
      horizontal_spend(state, 1, 1, location(HorizontalEvents, None, None))
      state.stats.horizontal_joins += 1
      state.output.joins.push({
        first: one,
        second: two,
        left: low,
        right: high,
        consumed: false,
        opposed: existing.to_right != segment.to_right,
      })
    }
  }
  state.output.horizontals.push(segment)
}

///|
/// Locate/split the current horizontal arc; original endpoint identities survive.
fn horizontal_node_at(
  state : ScanState,
  segment : HorizontalSegment,
  x : Int64,
) -> OutPtId raise ScanAbort {
  let start = output_point(state, segment.first)
  if start.point.x == x {
    return segment.first
  }
  if output_point(state, segment.second).point.x == x {
    return segment.second
  }
  let next = output_point(state, start.next)
  let direction = if next.point.y == segment.y &&
    (
      (segment.to_right && next.point.x > start.point.x) ||
      (!segment.to_right && next.point.x < start.point.x)
    ) {
    true
  } else {
    false
  }
  let mut cursor = segment.first
  for steps = 0; steps <= state.output.points.length(); steps = steps + 1 {
    horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
    let a = output_point(state, cursor)
    let target = if direction { a.next } else { a.prev }
    let b = output_point(state, target)
    if a.point.y != segment.y || b.point.y != segment.y {
      output_error(
        state, "Horizontal candidate no longer follows a horizontal arc",
      )
    }
    if b.point.x == x {
      return target
    }
    if (a.point.x < x && x < b.point.x) || (b.point.x < x && x < a.point.x) {
      let record = output_resolve(state, a.record)
      let node = output_new_point(state, record, Point64::new(x, segment.y))
      let left = if direction { cursor } else { target }
      let right = if direction { target } else { cursor }
      state.output.points[node].prev = left
      state.output.points[node].next = right
      state.output.points[left].next = node
      state.output.points[right].prev = node
      state.output.records[record].revision += 1
      return node
    }
    if target == segment.second {
      break
    }
    cursor = target
  }
  output_error(state, "Horizontal overlap point is not on the candidate arc")
}

///|
/// Explicit connection decision; no automatic union based on coordinate equality.
#warnings("-unused_value")
fn execute_horizontal_join(
  state : ScanState,
  index : Int,
  splice : Bool,
) -> Unit raise ScanAbort {
  if index < 0 || index >= state.output.joins.length() {
    output_error(state, "Invalid horizontal join")
  }
  let join = state.output.joins[index]
  if join.consumed {
    output_error(state, "Horizontal join was already consumed")
  }
  horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
  if join.left >= join.right {
    output_error(state, "Horizontal join has no positive overlap")
  }
  let a = output_point(state, join.first)
  let b = output_point(state, join.second)
  // Resolve again now, after any preceding split/merge. No cached record ownership.
  ignore(output_resolve(state, a.record))
  ignore(output_resolve(state, b.record))
  if a.point != b.point {
    output_error(state, "Horizontal join endpoints no longer match")
  }
  if splice && !join.opposed {
    output_error(
      state, "Same-direction overlap requires contribution selection, not a ring splice",
    )
  }
  if splice {
    ignore(output_splice(state, join.first, join.second))
  }
  join.consumed = true
}

///|
fn horizontal_output_span(
  state : ScanState,
  before : OutPtId?,
  edge : EdgeId,
) -> Unit raise ScanAbort {
  if before is Some(a) && output_endpoint(state, edge) is Some(b) && a != b {
    horizontal_segment(state, a, b)
  }
}

///|
/// Consume at most one adjacent crossing; a following call continues the same HE.
fn process_horizontal(
  state : ScanState,
  id : EdgeId,
  decide : (EngineEvent) -> ConnectionDecision,
) -> Bool raise ScanAbort {
  let edge = edge_get(state, id)
  if state.held_horizontal != Some(id) || edge.horizontal == NonHorizontal {
    scan_abort(
      state,
      InvalidInput(
        location(HorizontalEvents, None, None),
        "No matching held horizontal",
      ),
    )
  }
  let start = state.vertices[edge.bot].point
  let end = state.vertices[edge.top].point
  if !state.preserve_collinear || !state.horizontal_started {
    let initial = output_add_edge(
      state,
      id,
      Point64::new(edge.current_x, start.y),
    )
    if state.preserve_collinear && initial is Some(op) {
      fixed_horizontal_trial(state, op)
    }
    state.horizontal_started = true
  }
  let right = edge.horizontal == ToRight
  let neighbor = if right { edge.next_ael } else { edge.prev_ael }
  if neighbor is Some(other) {
    let candidate = edge_get(state, other)
    horizontal_spend(
      state,
      0,
      1,
      scan_location(state, Some(edge.bot), HorizontalEvents),
    )
    let within = if right {
      candidate.current_x >= edge.current_x && candidate.current_x <= end.x
    } else {
      candidate.current_x <= edge.current_x && candidate.current_x >= end.x
    }
    let chain = state.chains[edge.chain]
    let oc = state.chains[candidate.chain]
    let own_start = chain.minima == oc.minima &&
      edge.cursor == 0 &&
      candidate.cursor == 0 &&
      candidate.current_x == start.x
    let own_exit = chain.vertices[chain.vertices.length() - 1] ==
      oc.vertices[oc.vertices.length() - 1] &&
      candidate.at_exit &&
      candidate.current_x == end.x
    if state.preserve_collinear &&
      own_exit &&
      edge.cursor + 2 == chain.vertices.length() {
      state.held_horizontal = None
      edge_advance(state, id)
      state.phase = AwaitMaxima(
        edge.top,
        if right {
          id
        } else {
          other
        },
        if right {
          other
        } else {
          id
        },
      )
      match engine_step(state, decide) {
        Ok(_) => ()
        Err(error) => raise ScanAbort(error)
      }
      state.phase = Horizontals
      return true
    }
    let outgoing_break = if within &&
      candidate.current_x == end.x &&
      candidate.horizontal == NonHorizontal &&
      edge.cursor + 2 < chain.vertices.length() {
      let next = state.vertices[chain.vertices[edge.cursor + 2]].point
      let relation = scan_outgoing_compare(
        state.vertices[candidate.bot].point,
        state.vertices[candidate.top].point,
        next,
      ) catch {
        ScanAbort(error) => scan_abort(state, error)
      }
      if right {
        relation >= 0
      } else {
        relation <= 0
      }
    } else {
      false
    }
    if within && !own_exit && !outgoing_break {
      if state.preserve_collinear || !own_start {
        let event : EngineEvent = {
          kind: HorizontalCrossing,
          first: if right {
            id
          } else {
            other
          },
          second: if right {
            other
          } else {
            id
          },
          point: Point64::new(candidate.current_x, start.y),
        }
        let before = output_endpoint(state, id)
        if !apply_connection(state, event, decide(event)) {
          return false
        }
        if state.preserve_collinear {
          if output_endpoint(state, id) is Some(op) {
            fixed_horizontal_trial(state, op)
          }
        } else {
          horizontal_output_span(state, before, id)
        }
      }
      if right {
        ael_swap(state, id, other)
      } else {
        ael_swap(state, other, id)
      }
      if state.preserve_collinear {
        let point = Point64::new(candidate.current_x, start.y)
        if right {
          if candidate.prev_ael is Some(prev) {
            boolean_check_join(state, prev, other, point)
          }
        } else if candidate.next_ael is Some(next) {
          boolean_check_join(state, other, next, point)
        }
      }
      edge.current_x = candidate.current_x
      state.phase = AwaitHorizontal(id)
      return true
    }
  }
  let before = output_endpoint(state, id)
  let ending = output_add_edge(state, id, end)
  if state.preserve_collinear {
    if ending is Some(op) {
      fixed_horizontal_trial(state, op)
    }
  } else {
    horizontal_output_span(state, before, id)
  }
  commit_horizontal(state, id)
  boolean_check_neighbors(state, id, end)
  true
}

///|
fn horizontal_spend(
  state : ScanState,
  nodes : Int,
  work : Int,
  loc : ErrorLocation,
) -> Unit raise ScanAbort {
  output_spend(state, nodes, work, loc~)
}

///|
priv struct FixedHorizontal {
  mut left : OutPtId
  right : OutPtId
  to_right : Bool
}

///|
fn fixed_horizontal_trial(
  state : ScanState,
  id : OutPtId,
) -> Unit raise ScanAbort {
  let p = output_point(state, id).point
  horizontal_spend(state, 1, 1, location(HorizontalEvents, None, None))
  state.output.horizontals.push({
    first: id,
    second: id,
    y: p.y,
    left: p.x,
    right: p.x,
    to_right: false,
  })
}

///|
fn fixed_horizontal_duplicate(
  state : ScanState,
  id : OutPtId,
  after : Bool,
) -> OutPtId raise ScanAbort {
  let op = output_point(state, id)
  let record = output_resolve(state, op.record)
  let new = output_new_point(state, record, op.point)
  let previous = if after { id } else { op.prev }
  let next = if after { op.next } else { id }
  state.output.points[new].prev = previous
  state.output.points[new].next = next
  state.output.points[previous].next = new
  state.output.points[next].prev = new
  state.output.records[record].revision += 1
  new
}

///|
fn fixed_horizontal_convert(state : ScanState) -> Unit raise ScanAbort {
  if state.output.horizontals.is_empty() {
    return
  }
  horizontal_spend(state, 2, 0, location(HorizontalEvents, None, None))
  let segments : Array[FixedHorizontal] = []
  let seen : Set[OutPtId] = Default::default()
  for trial in state.output.horizontals {
    horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
    let original = output_point(state, trial.first)
    let rec = state.output.records[output_resolve(state, original.record)]
    let mut p = trial.first
    let mut n = p
    if rec.status == Building {
      // Our Back endpoint corresponds to the fixed engine's outrec.pts.
      let z = rec.anchor.unwrap()
      let a = output_point(state, z).prev
      while p != z &&
            output_point(state, output_point(state, p).prev).point.y ==
            original.point.y {
        horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
        p = output_point(state, p).prev
      }
      while n != a &&
            output_point(state, output_point(state, n).next).point.y ==
            original.point.y {
        horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
        n = output_point(state, n).next
      }
    } else {
      while output_point(state, p).prev != n &&
            output_point(state, output_point(state, p).prev).point.y ==
            original.point.y {
        horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
        p = output_point(state, p).prev
      }
      while output_point(state, n).next != p &&
            output_point(state, output_point(state, n).next).point.y ==
            original.point.y {
        horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
        n = output_point(state, n).next
      }
    }
    let px = output_point(state, p).point.x
    let nx = output_point(state, n).point.x
    if px == nx {
      continue
    }
    let left = if px < nx { p } else { n }
    if seen.contains(left) {
      continue
    }
    horizontal_spend(state, 3, 1, location(HorizontalEvents, None, None))
    seen.add(left)
    let segment : FixedHorizontal = {
      left,
      right: if px < nx {
        n
      } else {
        p
      },
      to_right: px < nx,
    }
    // Stable insertion order is observable when several horizontal runs start together.
    segments.push(segment)
    let mut j = segments.length() - 1
    while j > 0 {
      horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
      if output_point(state, segments[j - 1].left).point.x <=
        output_point(state, segments[j].left).point.x {
        break
      }
      let temp = segments[j - 1]
      segments[j - 1] = segments[j]
      segments[j] = temp
      j -= 1
    }
  }
  for i = 0; i < segments.length(); i = i + 1 {
    let a = segments[i]
    for j = i + 1; j < segments.length(); j = j + 1 {
      horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
      let b = segments[j]
      if output_point(state, b.left).point.x >=
        output_point(state, a.right).point.x ||
        a.to_right == b.to_right ||
        output_point(state, b.right).point.x <=
        output_point(state, a.left).point.x {
        continue
      }
      let y = output_point(state, a.left).point.y
      let mut first = a
      let mut second = b
      if !a.to_right {
        first = b
        second = a
      }
      // Follow the same directional cursor order, then duplicate actual endpoints;
      // do not insert an arithmetic overlap coordinate into either run.
      if a.to_right {
        while output_point(state, output_point(state, a.left).next).point.y == y &&
              output_point(state, output_point(state, a.left).next).point.x <=
              output_point(state, b.left).point.x {
          horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
          a.left = output_point(state, a.left).next
        }
        while output_point(state, output_point(state, b.left).prev).point.y == y &&
              output_point(state, output_point(state, b.left).prev).point.x <=
              output_point(state, a.left).point.x {
          horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
          b.left = output_point(state, b.left).prev
        }
      } else {
        while output_point(state, output_point(state, a.left).prev).point.y == y &&
              output_point(state, output_point(state, a.left).prev).point.x <=
              output_point(state, b.left).point.x {
          horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
          a.left = output_point(state, a.left).prev
        }
        while output_point(state, output_point(state, b.left).next).point.y == y &&
              output_point(state, output_point(state, b.left).next).point.x <=
              output_point(state, a.left).point.x {
          horizontal_spend(state, 0, 1, location(HorizontalEvents, None, None))
          b.left = output_point(state, b.left).next
        }
      }
      let one = fixed_horizontal_duplicate(state, first.left, true)
      let two = fixed_horizontal_duplicate(state, second.left, false)
      horizontal_spend(state, 1, 1, location(HorizontalEvents, None, None))
      state.stats.horizontal_joins += 1
      state.output.joins.push({
        first: one,
        second: two,
        left: 0L,
        right: 1L,
        consumed: false,
        opposed: true,
      })
    }
  }
  state.output.horizontals.clear()
}

///|
fn fixed_horizontal_join(
  state : ScanState,
  index : Int,
) -> Unit raise ScanAbort {
  let join = state.output.joins[index]
  let ar = output_resolve(state, output_point(state, join.first).record)
  let br = output_resolve(state, output_point(state, join.second).record)
  let anchor = state.output.records[ar].anchor.unwrap()
  let next = output_point(state, join.first).next
  let previous = output_point(state, join.second).prev
  let created = output_splice(state, join.first, previous)
  if output_point(state, anchor).record == ar {
    state.output.records[ar].anchor = Some(anchor)
  }
  if ar == br {
    state.output.records[created].anchor = Some(next)
  }
  join.consumed = true
}
