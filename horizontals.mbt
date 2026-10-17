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
  ignore(output_add_edge(state, id, Point64::new(edge.current_x, start.y)))
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
      if !own_start {
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
        horizontal_output_span(state, before, id)
      }
      if right {
        ael_swap(state, id, other)
      } else {
        ael_swap(state, other, id)
      }
      edge.current_x = candidate.current_x
      state.phase = AwaitHorizontal(id)
      return true
    }
  }
  let before = output_endpoint(state, id)
  ignore(output_add_edge(state, id, end))
  horizontal_output_span(state, before, id)
  commit_horizontal(state, id)
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
