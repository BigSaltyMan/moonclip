// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Explicit geometry/semantic boundary. No default fill or Boolean operation.

///|
fn flush_connections(
  state : ScanState,
  decide : (EngineEvent) -> ConnectionDecision,
) -> Bool raise ScanAbort {
  while state.connection_cursor < state.pending_connections.length() {
    let event = state.pending_connections[state.connection_cursor]
    if !apply_connection(state, event, decide(event)) {
      if event.kind == EntryContact {
        let vertex = edge_get(state, event.first).bot
        state.entry_contact = Some((vertex, event.first, event.second))
        state.phase = AwaitEntryContact(vertex, event.first, event.second)
      }
      return false
    }
    if event.kind == EntryContact && state.entry_contact is Some(_) {
      state.entry_contact = None
      state.phase = Horizontals
    }
    state.connection_cursor += 1
  }
  state.pending_connections.clear()
  state.connection_cursor = 0
  true
}

///|
/// One real geometry phase; Defer leaves a visible pending action and no fake result.
#warnings("-unused_value")
fn engine_step(
  state : ScanState,
  decide : (EngineEvent) -> ConnectionDecision,
) -> Result[ScanPhase, ClipError] {
  if state.failure is Some(error) {
    return Err(error)
  }
  if state.phase == Complete {
    return Ok(Complete)
  }
  try {
    scan_spend(state, 0, 1, location(ScanEvents, None, None))
    let had_pending = state.connection_cursor <
      state.pending_connections.length()
    if !flush_connections(state, decide) {
      return Ok(state.phase)
    }
    if had_pending {
      return Ok(state.phase)
    }
    match state.phase {
      EnterMinima => {
        let y = state.current_y.unwrap()
        // Preserve the immutable minima indices before enter_height removes the bucket.
        let minima = state.entries.get(y)
        enter_height(state)
        if minima is Some(indices) {
          for index in indices {
            scan_spend(state, 0, 1, location(ScanEvents, None, None))
            let m = state.minima[index]
            let mut first : EdgeId? = None
            let mut second : EdgeId? = None
            let mut cursor = state.ael_head
            while cursor is Some(id) {
              let e = edge_get(state, id)
              scan_spend(
                state,
                0,
                1,
                scan_location(state, Some(e.bot), ScanEvents),
              )
              if state.chains[e.chain].minima == index {
                if first is None {
                  first = Some(id)
                } else {
                  second = Some(id)
                  break
                }
              }
              cursor = e.next_ael
            }
            scan_spend(
              state,
              1,
              1,
              scan_location(state, Some(m.vertex), ScanEvents),
            )
            state.pending_connections.push({
              kind: Minimum,
              first: first.unwrap(),
              second: second.unwrap(),
              point: state.vertices[m.vertex].point,
            })
            for entering in [first.unwrap(), second.unwrap()] {
              let mut resident = state.ael_head
              while resident is Some(other) {
                let edge = edge_get(state, other)
                scan_spend(
                  state,
                  0,
                  1,
                  scan_location(state, Some(m.vertex), ScanEvents),
                )
                let other_min = state.chains[edge.chain].minima
                let older = state.vertices[state.minima[other_min].vertex].point.y >
                  y ||
                  other_min < index
                if other_min != index &&
                  older &&
                  edge.current_x == state.vertices[m.vertex].point.x {
                  scan_spend(
                    state,
                    1,
                    1,
                    scan_location(state, Some(m.vertex), ScanEvents),
                  )
                  state.pending_connections.push({
                    kind: EntryContact,
                    first: entering,
                    second: other,
                    point: state.vertices[m.vertex].point,
                  })
                }
                resident = edge.next_ael
              }
            }
          }
        }
        state.entry_contact = None
        state.phase = Horizontals
        ignore(flush_connections(state, decide))
      }
      AwaitEntryContact(v, a, b) => {
        let event : EngineEvent = {
          kind: EntryContact,
          first: a,
          second: b,
          point: state.vertices[v].point,
        }
        if apply_connection(state, event, decide(event)) {
          state.entry_contact = None
          state.phase = Horizontals
        }
      }
      Horizontals =>
        match horizontal_pop(state) {
          Some(id) => {
            state.phase = AwaitHorizontal(id)
            ignore(process_horizontal(state, id, decide))
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
      AwaitHorizontal(id) => ignore(process_horizontal(state, id, decide))
      AwaitIntersections(_) => {
        build_intersections(state)
        if state.intersection_cursor < state.intersections.length() {
          ignore(process_intersection(state, decide))
        }
        if state.intersection_cursor == state.intersections.length() {
          finish_intersections(state)
        }
      }
      AwaitMaxima(v, a, b) => {
        let event : EngineEvent = {
          kind: Maximum,
          first: a,
          second: b,
          point: state.vertices[v].point,
        }
        if apply_connection(state, event, decide(event)) {
          if edge_get(state, a).output_end is Some(_) ||
            edge_get(state, b).output_end is Some(_) {
            output_error(state, "Maxima decision left live output ends")
          }
          commit_maxima(state, a, b)
        }
      }
      TopVertices => {
        let mut cursor = state.ael_head
        while cursor is Some(id) {
          let edge = edge_get(state, id)
          scan_spend(state, 0, 1, scan_location(state, Some(edge.top), ScanTop))
          cursor = edge.next_ael
          if state.vertices[edge.top].point.y == state.current_y.unwrap() {
            ignore(output_add_edge(state, id, state.vertices[edge.top].point))
            edge_advance(state, id)
          }
        }
        state.phase = Horizontals
      }
      _ =>
        match scan_step(state) {
          Ok(_) => ()
          Err(error) => raise ScanAbort(error)
        }
    }
    Ok(state.phase)
  } catch {
    ScanAbort(error) => {
      state.failure = Some(error)
      state.phase = Failed
      Err(error)
    }
  }
}

///|
#warnings("-unused_value")
fn engine_invariants(state : ScanState) -> Result[Unit, String] {
  match scan_invariants(state) {
    Err(m) => return Err(m)
    Ok(_) => ()
  }
  match output_invariants(state) {
    Err(m) => return Err(m)
    Ok(_) => ()
  }
  if state.intersection_cursor < 0 ||
    state.intersection_cursor > state.intersections.length() ||
    state.connection_cursor < 0 ||
    state.connection_cursor > state.pending_connections.length() {
    return Err("Invalid event cursor")
  }
  for i = state.intersection_cursor; i < state.intersections.length(); i = i + 1 {
    let event = state.intersections[i]
    guard edge_peek(state, event.first) is Some(a) else {
      return Err("Stale first intersection edge")
    }
    guard edge_peek(state, event.second) is Some(b) else {
      return Err("Stale second intersection edge")
    }
    if a.bot != event.first_bot ||
      a.top != event.first_top ||
      b.bot != event.second_bot ||
      b.top != event.second_top {
      return Err("Stale intersection segment")
    }
    if state.failure is None &&
      (
        state.phase != AwaitIntersections(event.top_y) ||
        state.current_y != Some(event.bottom_y)
      ) {
      return Err("Stale intersection stage")
    }
  }
  for i = state.connection_cursor
      i < state.pending_connections.length()
      i = i + 1 {
    let event = state.pending_connections[i]
    if edge_peek(state, event.first) is None ||
      edge_peek(state, event.second) is None {
      return Err("Stale pending connection edge")
    }
  }
  let stats = state.stats
  if stats.intersection_events < 0 ||
    stats.horizontal_joins < 0 ||
    stats.output_records < 0 ||
    stats.output_points < 0 ||
    stats.intersection_events > stats.nodes ||
    stats.horizontal_joins > stats.nodes ||
    stats.output_records > stats.nodes ||
    stats.output_points > stats.nodes {
    return Err("Invalid cumulative topology counters")
  }
  for join in state.output.joins {
    if join.consumed {
      continue
    }
    if join.first < 0 ||
      join.first >= state.output.points.length() ||
      join.second < 0 ||
      join.second >= state.output.points.length() {
      return Err("Invalid horizontal join node")
    }
    let a = state.output.points[join.first]
    let b = state.output.points[join.second]
    if !a.alive || !b.alive || a.point != b.point || join.left >= join.right {
      return Err("Stale horizontal join geometry")
    }
  }
  Ok(())
}
