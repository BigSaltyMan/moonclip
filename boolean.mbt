// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Closed EvenOdd contribution and output-side rules adapted from Clipper2,
// Copyright (c) Angus Johnson 2010-2025.

///|
pub(all) enum ClipType {
  Intersection
  Union
  Difference
  Xor
} derive(Eq, Debug)

///|
pub(all) enum FillRule {
  EvenOdd
} derive(Eq, Debug)

///|
fn boolean_region(operation : ClipType, subject : Bool, clip : Bool) -> Bool {
  match operation {
    Intersection => subject && clip
    Union => subject || clip
    Difference => subject && !clip
    Xor => subject != clip
  }
}

///|
fn edge_role(state : ScanState, edge : ActiveEdge) -> PathRole {
  state.vertices[state.minima[state.chains[edge.chain].minima].vertex].source.role
}

///|
fn boolean_contributes(
  operation : ClipType,
  role : PathRole,
  other : Bool,
) -> Bool {
  if role == Subject {
    boolean_region(operation, false, other) !=
    boolean_region(operation, true, other)
  } else {
    boolean_region(operation, other, false) !=
    boolean_region(operation, other, true)
  }
}

///|
fn start_connection(
  state : ScanState,
  a : EdgeId,
  b : EdgeId,
  point : Point64,
  is_new : Bool,
  split_from? : OutRecId? = None,
) -> Unit raise ScanAbort {
  if state.boolean_operation is None {
    output_start(state, a, b, point, split_from~)
    return
  }
  let mut previous = edge_get(state, a).prev_ael
  let mut ascending : Bool? = None
  while previous is Some(id) {
    scan_spend(
      state,
      0,
      1,
      scan_location(state, Some(edge_get(state, a).bot), BooleanOp),
    )
    let edge = edge_get(state, id)
    if edge.output_end is Some(end) {
      ascending = Some(end.side == Back)
      break
    }
    previous = edge.prev_ael
  }
  let front_first = match ascending {
    None => !is_new
    Some(value) => value == is_new
  }
  if front_first {
    output_start(state, a, b, point, split_from~)
  } else {
    output_start(state, b, a, point, split_from~)
  }
}

///|
fn boolean_decision(
  state : ScanState,
  operation : ClipType,
  event : EngineEvent,
) -> ConnectionDecision raise ScanAbort {
  let a = edge_get(state, event.first)
  let b = edge_get(state, event.second)
  let ar = edge_role(state, a)
  let br = edge_role(state, b)
  match event.kind {
    Minimum => {
      let mut other = false
      let mut cursor = state.ael_head
      while cursor is Some(id) && id != event.first {
        let edge = edge_get(state, id)
        scan_spend(state, 0, 1, scan_location(state, Some(a.bot), BooleanOp))
        if edge_role(state, edge) != ar {
          other = !other
        }
        cursor = edge.next_ael
      }
      a.wind_other = other
      b.wind_other = other
      if boolean_contributes(operation, ar, other) {
        StartContour
      } else {
        Ignore
      }
    }
    EntryContact | BandContact => Ignore
    Maximum => {
      let ah = a.output_end is Some(_)
      let bh = b.output_end is Some(_)
      if ah != bh {
        scan_abort(
          state,
          ExecutionFailure(
            scan_location(state, Some(a.top), BooleanOp),
            "Mismatched contributing maxima",
          ),
        )
      }
      if ah {
        CloseOrMerge
      } else {
        Ignore
      }
    }
    Crossing | HorizontalCrossing => {
      if ar != br {
        a.wind_other = !a.wind_other
        b.wind_other = !b.wind_other
      }
      let ah = a.output_end is Some(_)
      let bh = b.output_end is Some(_)
      if ah && bh {
        if ar != br && operation != Xor {
          CloseOrMerge
        } else {
          let ae = a.output_end.unwrap()
          let be = b.output_end.unwrap()
          if ae.side == Back ||
            output_resolve(state, ae.record) == output_resolve(state, be.record) {
            CloseAndStart
          } else {
            ExchangeEnds
          }
        }
      } else if ah || bh {
        ExchangeEnds
      } else if ar != br || boolean_contributes(operation, ar, a.wind_other) {
        StartContour
      } else {
        Ignore
      }
    }
  }
}

///|
fn boolean_execute(
  subject : Paths64,
  clip : Paths64,
  operation : ClipType,
  limits : ScanLimits,
) -> Result[Paths64, ClipError] {
  let state = match prepare_scan(subject, clip, limits~) {
    Ok(s) => s
    Err(e) => return Err(e)
  }
  state.boolean_operation = Some(operation)
  try {
    while state.phase != Complete {
      match engine_step(state, fn(e) { boolean_choose(state, operation, e) }) {
        Ok(_) => ()
        Err(e) => raise ScanAbort(e)
      }
    }
    for i = 0; i < state.output.joins.length(); i = i + 1 {
      execute_horizontal_join(state, i, state.output.joins[i].opposed)
    }
    match engine_invariants(state) {
      Ok(_) => ()
      Err(message) =>
        scan_abort(
          state,
          ExecutionFailure(location(BooleanOp, None, None), message),
        )
    }
    boolean_join_seams(state)
    let result = output_extract(state, preserve_collinear=false)
    scan_cleanup(state)
    Ok(result)
  } catch {
    ScanAbort(error) => {
      scan_cleanup(state)
      // Internal state failures are not invalid caller data.
      Err(
        match error {
          InvalidInput(loc, message) => ExecutionFailure(loc, message)
          _ => error
        },
      )
    }
  }
}

///|
/// Closed paths, independent operand parity; fixed preserve_collinear=false,
/// reverse_solution=false. Difference is Subject minus Clip.
pub fn boolean_op(
  subject : Paths64,
  clip : Paths64,
  operation : ClipType,
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  match fill_rule {
    EvenOdd =>
      boolean_execute(subject, clip, operation, {
        input: limits,
        max_nodes: 500000,
        max_work: 5000000,
      })
  }
}

///|
fn boolean_choose(
  state : ScanState,
  operation : ClipType,
  event : EngineEvent,
) -> ConnectionDecision {
  boolean_decision(state, operation, event) catch {
    ScanAbort(error) => {
      state.failure = Some(error)
      state.phase = Failed
      Defer
    }
  }
}

///|
/// Insert the paired right bound next to the left, then execute its actual
/// crossings while moving it into geometric order. Batch sorting loses these
/// output side effects when a new bound starts on an existing edge.
fn boolean_enter_height(
  state : ScanState,
  operation : ClipType,
) -> Unit raise ScanAbort {
  let y = state.current_y.unwrap()
  if state.entries.get(y) is Some(events) {
    for index in events {
      let minimum = state.minima[index]
      scan_reserve(
        state,
        2,
        2,
        scan_location(state, Some(minimum.vertex), ScanEvents),
      )
      let back = edge_allocate(state, minimum.backward.unwrap())
      let forward = edge_allocate(state, minimum.forward.unwrap())
      let left = if state.chains[edge_get(state, back).chain].left_bound {
        back
      } else {
        forward
      }
      let right = if left == back { forward } else { back }
      ael_insert(state, left)
      let a = edge_get(state, left)
      let b = edge_get(state, right)
      scan_spend(
        state,
        0,
        1,
        scan_location(state, Some(minimum.vertex), ScanEvents),
      )
      b.prev_ael = Some(left)
      b.next_ael = a.next_ael
      if a.next_ael is Some(next) {
        edge_get(state, next).prev_ael = Some(right)
      }
      a.next_ael = Some(right)
      b.in_ael = true
      state.ael_count += 1
      if state.ael_count > state.stats.peak_active {
        state.stats.peak_active = state.ael_count
      }
      let event : EngineEvent = {
        kind: Minimum,
        first: left,
        second: right,
        point: state.vertices[minimum.vertex].point,
      }
      ignore(
        apply_connection(
          state,
          event,
          boolean_decision(state, operation, event),
        ),
      )
      while b.next_ael is Some(next) {
        scan_spend(
          state,
          0,
          1,
          scan_location(state, Some(minimum.vertex), ScanEvents),
        )
        if !resident_before_new(state, edge_get(state, next), b) {
          break
        }
        let crossing : EngineEvent = {
          kind: Crossing,
          first: right,
          second: next,
          point: event.point,
        }
        ignore(
          apply_connection(
            state,
            crossing,
            boolean_decision(state, operation, crossing),
          ),
        )
        ael_swap(state, right, next)
      }
      schedule_edge(state, left)
      schedule_edge(state, right)
    }
    state.entries.remove(y)
  }
  state.entry_contact = None
  state.phase = Horizontals
}

///|
fn output_insert_arc(
  state : ScanState,
  from : OutPtId,
  point : Point64,
) -> OutPtId raise ScanAbort {
  let a = output_point(state, from)
  let to = a.next
  let b = output_point(state, to)
  if a.point == point {
    return from
  }
  if b.point == point {
    return to
  }
  if !point_on_segment_validated(point, a.point, b.point) {
    output_error(state, "Shared-edge endpoint is not on its output arc")
  }
  let record = output_resolve(state, a.record)
  let node = output_new_point(state, record, point)
  state.output.points[node].prev = from
  state.output.points[node].next = to
  a.next = node
  b.prev = node
  state.output.records[record].revision += 1
  node
}

///|
/// Resolve positive-length coincident result seams, including nonhorizontal
/// joins. Opposed directed boundaries bound filled regions on opposite sides.
/// Endpoint-only contacts remain distinct topology.
fn boolean_join_seams(state : ScanState) -> Unit raise ScanAbort {
  let mut changed = true
  while changed {
    changed = false
    let arcs : Array[OutPtId] = []
    for i = 0; i < state.output.records.length(); i = i + 1 {
      output_spend(state, 0, 1)
      let rec = state.output.records[i]
      if rec.status == Closed {
        output_clean(state, i, false)
        if rec.anchor is Some(anchor) {
          let nodes = output_ring(state, anchor)
          output_spend(state, 0, nodes.length())
          for n in nodes {
            arcs.push(n)
          }
        }
      }
    }
    for i = 0; i < arcs.length() && !changed; i = i + 1 {
      let a = output_point(state, arcs[i])
      let b = output_point(state, a.next)
      for j = i + 1; j < arcs.length(); j = j + 1 {
        output_spend(state, 0, 1)
        let c = output_point(state, arcs[j])
        let d = output_point(state, c.next)
        if cross_validated(a.point, b.point, c.point) != 0L ||
          cross_validated(a.point, b.point, d.point) != 0L {
          continue
        }
        let dx = b.point.x - a.point.x
        let dy = b.point.y - a.point.y
        let dot = dx * (d.point.x - c.point.x) + dy * (d.point.y - c.point.y)
        if dot >= 0L {
          continue
        }
        let x_axis = dx != 0L
        let av = if x_axis { a.point.x } else { a.point.y }
        let bv = if x_axis { b.point.x } else { b.point.y }
        let cv = if x_axis { c.point.x } else { c.point.y }
        let dv = if x_axis { d.point.x } else { d.point.y }
        let low = max64(min64(av, bv), min64(cv, dv))
        let high = min64(max64(av, bv), max64(cv, dv))
        if low >= high {
          continue
        }
        let point = if av == low {
          a.point
        } else if bv == low {
          b.point
        } else if cv == low {
          c.point
        } else {
          d.point
        }
        let first = output_insert_arc(state, arcs[i], point)
        let second = output_insert_arc(state, arcs[j], point)
        if first == second {
          continue
        }
        ignore(output_splice(state, first, second))
        changed = true
        break
      }
    }
  }
}

///|
fn min64(a : Int64, b : Int64) -> Int64 {
  if a < b {
    a
  } else {
    b
  }
}

///|
fn max64(a : Int64, b : Int64) -> Int64 {
  if a > b {
    a
  } else {
    b
  }
}

///|
fn close_connection(
  state : ScanState,
  a : EdgeId,
  b : EdgeId,
  point : Point64,
) -> Unit raise ScanAbort {
  if state.boolean_operation is None {
    output_close_or_merge(state, a, b, point)
    return
  }
  guard edge_get(state, a).output_end is Some(ae) else {
    output_error(state, "Missing first contributing output")
  }
  guard edge_get(state, b).output_end is Some(be) else {
    output_error(state, "Missing second contributing output")
  }
  if ae.side == be.side {
    scan_abort(
      state,
      ExecutionFailure(
        location(OutputTopology, None, None),
        "Closed contour maxima require opposite output sides",
      ),
    )
  }
  let ar = output_resolve(state, ae.record)
  let br = output_resolve(state, be.record)
  if ar <= br {
    output_close_or_merge(state, a, b, point)
  } else {
    output_close_or_merge(state, b, a, point)
  }
}
