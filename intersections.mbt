// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Clipper2-derived numeric and event ordering rules, Angus Johnson 2010-2025.

///|
priv struct IntersectEvent {
  first : EdgeId
  second : EdgeId
  first_bot : VertexId
  first_top : VertexId
  second_bot : VertexId
  second_top : VertexId
  point : Point64
  bottom_y : Int64
  top_y : Int64
  serial : Int
  reverses : Bool
}

///|
#warnings("-unused_value")
priv enum EngineEventKind {
  Minimum
  Crossing
  BandContact
  EntryContact
  HorizontalCrossing
  Maximum
} derive(Eq, Debug)

///|
priv struct EngineEvent {
  kind : EngineEventKind
  first : EdgeId
  second : EdgeId
  point : Point64
}

///|
#warnings("-unused_value-unused_constructor")
priv enum ConnectionDecision {
  Defer
  Ignore
  StartContour
  ContinueContours
  ExchangeEnds
  CloseOrMerge
  CloseAndStart
} derive(Eq, Debug)

///|
fn apply_connection(
  state : ScanState,
  event : EngineEvent,
  decision : ConnectionDecision,
) -> Bool raise ScanAbort {
  ignore(edge_get(state, event.first))
  ignore(edge_get(state, event.second))
  if event.kind == Minimum &&
    decision != Defer &&
    decision != Ignore &&
    decision != StartContour {
    output_error(state, "Invalid minimum connection decision")
  }
  if event.kind == Maximum &&
    decision != Defer &&
    decision != Ignore &&
    decision != CloseOrMerge {
    output_error(state, "Invalid maximum connection decision")
  }
  if decision == Defer {
    return false
  }
  scan_spend(state, 0, 1, location(OutputTopology, None, None))
  match decision {
    Ignore => ()
    StartContour => output_start(state, event.first, event.second, event.point)
    ContinueContours => {
      ignore(output_add_edge(state, event.first, event.point))
      ignore(output_add_edge(state, event.second, event.point))
    }
    ExchangeEnds => {
      ignore(output_add_edge(state, event.first, event.point))
      ignore(output_add_edge(state, event.second, event.point))
      output_exchange(state, event.first, event.second)
    }
    CloseOrMerge =>
      output_close_or_merge(state, event.first, event.second, event.point)
    CloseAndStart => {
      guard edge_get(state, event.first).output_end is Some(end) else {
        output_error(state, "Missing split source")
      }
      let source = output_resolve(state, end.record)
      output_close_or_merge(state, event.first, event.second, event.point)
      output_start(
        state,
        event.first,
        event.second,
        event.point,
        split_from=Some(source),
      )
    }
    Defer => ()
  }
  true
}

///|
fn intersection_point(
  state : ScanState,
  first : EdgeId,
  second : EdgeId,
  top_y : Int64,
) -> Point64 raise ScanAbort {
  let a = edge_get(state, first)
  let b = edge_get(state, second)
  let loc = scan_location(state, Some(a.bot), Intersections)
  if a.horizontal != NonHorizontal || b.horizontal != NonHorizontal {
    scan_abort(
      state,
      InvalidInput(loc, "Horizontal edge in nonhorizontal intersection"),
    )
  }
  scan_spend(state, 0, 1, loc)
  let ab = state.vertices[a.bot].point
  let at = state.vertices[a.top].point
  let bb = state.vertices[b.bot].point
  let bt = state.vertices[b.top].point
  try {
    let raw = match line_intersection(ab, at, bb, bt) {
      Some(p) => p
      None => Point64::new(a.current_x, top_y)
    }
    let bottom_y = state.current_y.unwrap()
    if raw.y <= bottom_y && raw.y >= top_y {
      return raw
    }
    let dx1 = ((at.x - ab.x).to_double() / (at.y - ab.y).to_double()).abs()
    let dx2 = ((bt.x - bb.x).to_double() / (bt.y - bb.y).to_double()).abs()
    if dx1 > 100.0 && dx2 > 100.0 {
      if dx1 > dx2 {
        closest_on_segment(raw, ab, at)
      } else {
        closest_on_segment(raw, bb, bt)
      }
    } else if dx1 > 100.0 {
      closest_on_segment(raw, ab, at)
    } else if dx2 > 100.0 {
      closest_on_segment(raw, bb, bt)
    } else {
      let y = if raw.y < top_y { top_y } else { bottom_y }
      let x = if dx1 < dx2 {
        scan_project(ab, at, y)
      } else {
        scan_project(bb, bt, y)
      }
      Point64::new(x, y)
    }
  } catch {
    ScanAbort(error) => scan_abort(state, error)
  }
}

///|
fn add_intersection(
  state : ScanState,
  first : EdgeId,
  second : EdgeId,
  top_y : Int64,
) -> Unit raise ScanAbort {
  let a = edge_get(state, first)
  let b = edge_get(state, second)
  let p = intersection_point(state, first, second, top_y)
  scan_spend(state, 1, 1, scan_location(state, Some(a.bot), Intersections))
  state.stats.intersection_events += 1
  state.intersections.push({
    first,
    second,
    first_bot: a.bot,
    first_top: a.top,
    second_bot: b.bot,
    second_top: b.top,
    point: p,
    bottom_y: state.current_y.unwrap(),
    top_y,
    serial: state.intersections.length(),
    reverses: true,
  })
}

///|
fn event_before(a : IntersectEvent, b : IntersectEvent) -> Bool {
  if a.point.y != b.point.y {
    a.point.y > b.point.y
  } else if a.point.x != b.point.x {
    a.point.x < b.point.x
  } else {
    a.serial < b.serial
  }
}

///|
/// Stable bottom-up merge, budgeted comparisons. Tie serial never hides adjacency.
fn sort_intersections(state : ScanState) -> Unit raise ScanAbort {
  let count = state.intersections.length()
  if count < 2 {
    return
  }
  scan_spend(state, 1, count, location(Intersections, None, None))
  let buffer = state.intersections.copy()
  let mut width = 1
  while width < count {
    let mut base = 0
    while base < count {
      let mid = if base + width < count { base + width } else { count }
      let end = if mid + width < count { mid + width } else { count }
      let mut left = base
      let mut right = mid
      for dest = base; dest < end; dest = dest + 1 {
        scan_spend(state, 0, 1, location(Intersections, None, None))
        if left < mid &&
          (
            right >= end ||
            event_before(state.intersections[left], state.intersections[right])
          ) {
          buffer[dest] = state.intersections[left]
          left += 1
        } else {
          buffer[dest] = state.intersections[right]
          right += 1
        }
      }
      base = end
    }
    for i = 0; i < count; i = i + 1 {
      scan_spend(state, 0, 1, location(Intersections, None, None))
      state.intersections[i] = buffer[i]
    }
    width = if width > count / 2 { count } else { width * 2 }
  }
}

///|
/// Stable merges discover only actual top-order inversions, O(A log A + K).
/// AEL remains untouched. SEL is relinked to the computed target order.
#warnings("-unused_value")
fn build_intersections(state : ScanState) -> Unit raise ScanAbort {
  guard state.phase is AwaitIntersections(top_y) else {
    scan_abort(
      state,
      InvalidInput(location(Intersections, None, None), "No pending scan band"),
    )
  }
  if state.band_built == Some(top_y) {
    return
  }
  if state.intersection_cursor < state.intersections.length() {
    scan_abort(
      state,
      InvalidInput(
        location(Intersections, None, None),
        "Unconsumed intersection events",
      ),
    )
  }
  state.intersections.clear()
  state.intersection_cursor = 0
  sel_snapshot(state)
  let n = state.ael_count
  if n > (state.limits.max_work - state.stats.work) / 2 {
    scan_abort(
      state,
      ResourceLimitExceeded(
        location(Intersections, None, None),
        ScanWork,
        state.limits.max_work,
      ),
    )
  }
  scan_spend(state, 2, n * 2, location(Intersections, None, None))
  let edges : Array[(EdgeId, Int64)] = []
  let mut cursor = state.sel_head
  while cursor is Some(id) {
    let edge = edge_get(state, id)
    edges.push((id, projected_x(state, edge, top_y)))
    cursor = edge.next_sel
  }
  let buffer = edges.copy()
  let mut width = 1
  while width < n {
    let mut base = 0
    while base < n {
      let mid = if base + width < n { base + width } else { n }
      let end = if mid + width < n { mid + width } else { n }
      let mut left = base
      let mut right = mid
      for dest = base; dest < end; dest = dest + 1 {
        scan_spend(state, 0, 1, location(Intersections, None, None))
        if left < mid && (right >= end || edges[left].1 <= edges[right].1) {
          buffer[dest] = edges[left]
          left += 1
        } else {
          // Emit every crossed pair in reverse resident order, as upstream SEL.
          for k = mid; k > left; k = k - 1 {
            add_intersection(state, edges[k - 1].0, edges[right].0, top_y)
          }
          buffer[dest] = edges[right]
          right += 1
        }
      }
      base = end
    }
    for i = 0; i < n; i = i + 1 {
      scan_spend(state, 0, 1, location(Intersections, None, None))
      edges[i] = buffer[i]
    }
    width = if width > n / 2 { n } else { width * 2 }
  }
  for i = 0; i < n; i = i + 1 {
    scan_spend(state, 0, 1, location(Intersections, None, None))
    let e = edge_get(state, edges[i].0)
    e.prev_sel = if i == 0 { None } else { Some(edges[i - 1].0) }
    e.next_sel = if i + 1 == n { None } else { Some(edges[i + 1].0) }
  }
  state.sel_head = if n == 0 { None } else { Some(edges[0].0) }
  for i = 1; i < n; i = i + 1 {
    scan_spend(state, 0, 1, location(Intersections, None, None))
    if edges[i - 1].1 == edges[i].1 {
      let a = edge_get(state, edges[i - 1].0)
      let b = edge_get(state, edges[i].0)
      let shared_exit = a.top == b.top &&
        state.vertices[a.top].exit_anchor == Some(a.top)
      if !shared_exit {
        scan_spend(
          state,
          1,
          1,
          scan_location(state, Some(a.bot), Intersections),
        )
        state.stats.intersection_events += 1
        state.intersections.push({
          first: edges[i - 1].0,
          second: edges[i].0,
          first_bot: a.bot,
          first_top: a.top,
          second_bot: b.bot,
          second_top: b.top,
          point: Point64::new(edges[i].1, top_y),
          bottom_y: state.current_y.unwrap(),
          top_y,
          serial: state.intersections.length(),
          reverses: false,
        })
      }
    }
  }
  sort_intersections(state)
  state.band_built = Some(top_y)
}

///|
fn validate_intersection(
  state : ScanState,
  event : IntersectEvent,
) -> Unit raise ScanAbort {
  let a = edge_get(state, event.first)
  let b = edge_get(state, event.second)
  if state.phase != AwaitIntersections(event.top_y) ||
    state.current_y != Some(event.bottom_y) ||
    a.bot != event.first_bot ||
    a.top != event.first_top ||
    b.bot != event.second_bot ||
    b.top != event.second_top ||
    !a.in_ael ||
    !b.in_ael {
    scan_abort(
      state,
      InvalidInput(
        location(Intersections, None, None),
        "Stale intersection band or edge segment",
      ),
    )
  }
}

///|
fn event_adjacent(
  state : ScanState,
  event : IntersectEvent,
) -> Bool raise ScanAbort {
  validate_intersection(state, event)
  edge_get(state, event.first).next_ael == Some(event.second) ||
  edge_get(state, event.second).next_ael == Some(event.first)
}

///|
/// Process one generated event, or retain it when contribution decisions defer.
#warnings("-unused_value")
fn process_intersection(
  state : ScanState,
  decide : (EngineEvent) -> ConnectionDecision,
) -> Bool raise ScanAbort {
  let index = state.intersection_cursor
  if index >= state.intersections.length() {
    return false
  }
  let mut selected = index
  while selected < state.intersections.length() {
    scan_spend(state, 0, 1, location(Intersections, None, None))
    if event_adjacent(state, state.intersections[selected]) {
      break
    }
    selected += 1
  }
  if selected == state.intersections.length() {
    scan_abort(
      state,
      InvalidInput(
        location(Intersections, None, None),
        "No remaining adjacent intersection event",
      ),
    )
  }
  if selected != index {
    let tmp = state.intersections[index]
    state.intersections[index] = state.intersections[selected]
    state.intersections[selected] = tmp
  }
  let event = state.intersections[index]
  let first_is_left = edge_get(state, event.first).next_ael ==
    Some(event.second)
  let left = if first_is_left { event.first } else { event.second }
  let right = if first_is_left { event.second } else { event.first }
  let action : EngineEvent = {
    kind: if event.reverses {
      Crossing
    } else {
      BandContact
    },
    first: left,
    second: right,
    point: event.point,
  }
  if !apply_connection(state, action, decide(action)) {
    return false
  }
  if event.reverses {
    ael_swap(state, left, right)
  }
  edge_get(state, left).current_x = event.point.x
  edge_get(state, right).current_x = event.point.x
  state.intersection_cursor += 1
  true
}

///|
fn finish_intersections(state : ScanState) -> Unit raise ScanAbort {
  guard state.phase is AwaitIntersections(y) else {
    scan_abort(
      state,
      InvalidInput(
        location(Intersections, None, None),
        "No scan band to finish",
      ),
    )
  }
  if state.intersection_cursor != state.intersections.length() {
    scan_abort(
      state,
      InvalidInput(
        location(Intersections, None, None),
        "Unprocessed intersection events",
      ),
    )
  }
  // The sorted SEL target must equal the actual event-mutated AEL, including ties.
  let mut a = state.ael_head
  let mut s = state.sel_head
  while a is Some(id) {
    scan_spend(state, 0, 1, location(Intersections, None, None))
    if s != a {
      scan_abort(
        state,
        InvalidInput(
          location(Intersections, None, None),
          "Intersection execution disagrees with target order",
        ),
      )
    }
    a = edge_get(state, id).next_ael
    s = edge_get(state, id).next_sel
  }
  if s is Some(_) {
    scan_abort(
      state,
      InvalidInput(
        location(Intersections, None, None),
        "Target chain has extra edges",
      ),
    )
  }
  commit_band(state, y)
  state.intersections.clear()
  state.intersection_cursor = 0
  state.band_built = None
}
