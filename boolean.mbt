// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Closed signed winding contribution and output-side rules adapted from Clipper2,
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
  NonZero
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
#warnings("-unused_constructor")
priv enum WindingRule {
  Parity
  SignedNonZero
  Positive
  Negative
} derive(Eq)

///|
fn winding_filled(rule : WindingRule, count : Int) -> Bool {
  match rule {
    Parity => count % 2 != 0
    SignedNonZero => count != 0
    Positive => count > 0
    Negative => count < 0
  }
}

///|
// Every prefix is a sum of at most vertices.length() unit edge directions.
// Validate before addition or negation; no unchecked abs or sign products.
fn winding_add(
  state : ScanState,
  value : Int,
  delta : Int,
) -> Int raise ScanAbort {
  let bound = state.vertices.length()
  if value < -bound ||
    value > bound ||
    delta < -bound ||
    delta > bound ||
    (delta > 0 && value > bound - delta) ||
    (delta < 0 && value < -bound - delta) {
    scan_abort(
      state,
      ExecutionFailure(
        location(BooleanOp, None, None),
        "Winding count exceeds input edge bound",
      ),
    )
  }
  value + delta
}

///|
fn winding_level(state : ScanState, value : Int) -> Int raise ScanAbort {
  let value = winding_add(state, value, 0)
  match state.boolean_rule {
    Positive => value
    Negative => -value
    Parity | SignedNonZero => if value < 0 { -value } else { value }
  }
}

///|
// wind_count is the signed adjacent region of greater magnitude, not a
// left-prefix count. wind_other is the other operand's prefix at this edge.
fn winding_initialize(state : ScanState, aid : EdgeId) -> Unit raise ScanAbort {
  let a = edge_get(state, aid)
  let role = edge_role(state, a)
  let mut previous = a.prev_ael
  while previous is Some(id) {
    let edge = edge_get(state, id)
    scan_spend(state, 0, 1, scan_location(state, Some(a.bot), BooleanOp))
    if edge_role(state, edge) == role {
      break
    }
    previous = edge.prev_ael
  }
  let mut cursor = state.ael_head
  a.wind_count = a.wind_dx
  a.wind_other = 0
  if previous is Some(id) {
    let edge = edge_get(state, id)
    ignore(winding_add(state, edge.wind_count, 0))
    ignore(winding_add(state, edge.wind_other, 0))
    if edge.wind_count == 0 {
      output_error(state, "Uninitialized preceding winding count")
    }
    if state.boolean_rule != Parity {
      let opposite = (edge.wind_count < 0) != (edge.wind_dx < 0)
      let reversing = edge.wind_dx != a.wind_dx
      if !opposite || edge.wind_count > 1 || edge.wind_count < -1 {
        a.wind_count = if reversing {
          edge.wind_count
        } else {
          winding_add(state, edge.wind_count, a.wind_dx)
        }
      }
    }
    a.wind_other = edge.wind_other
    cursor = edge.next_ael
  }
  while cursor is Some(id) {
    let edge = edge_get(state, id)
    if id == aid {
      break
    }
    scan_spend(state, 0, 1, scan_location(state, Some(a.bot), BooleanOp))
    if edge_role(state, edge) != role {
      a.wind_other = if state.boolean_rule == Parity {
        1 - a.wind_other
      } else {
        winding_add(state, a.wind_other, edge.wind_dx)
      }
    }
    cursor = edge.next_ael
  }
}

///|
fn winding_contributes(
  state : ScanState,
  op : ClipType,
  a : ActiveEdge,
) -> Bool raise ScanAbort {
  (state.boolean_rule == Parity || winding_level(state, a.wind_count) == 1) &&
  boolean_contributes(
    op,
    edge_role(state, a),
    winding_filled(state.boolean_rule, a.wind_other),
  )
}

///|
// A joined pair remains in the AEL for winding updates, but carries no output
// across the canceled seam. Split BEFORE changing either incident segment.
fn boolean_split_join(
  state : ScanState,
  id : EdgeId,
  point : Point64,
) -> Unit raise ScanAbort {
  let edge = edge_get(state, id)
  if edge.joined is Some(other) {
    let pair = edge_get(state, other)
    if pair.joined != Some(id) {
      output_error(state, "Asymmetric active seam")
    }
    edge.joined = None
    pair.joined = None
    if edge.next_ael == Some(other) {
      start_connection(state, id, other, point, true)
    } else if edge.prev_ael == Some(other) {
      start_connection(state, other, id, point, true)
    } else {
      output_error(state, "Nonadjacent active seam")
    }
  }
}

///|
fn boolean_check_join(
  state : ScanState,
  left : EdgeId,
  right : EdgeId,
  point : Point64,
) -> Unit raise ScanAbort {
  scan_spend(state, 0, 1, location(BooleanOp, None, None))
  let a = edge_get(state, left)
  let b = edge_get(state, right)
  if a.horizontal != NonHorizontal ||
    b.horizontal != NonHorizontal ||
    a.joined is Some(_) ||
    b.joined is Some(_) ||
    a.output_end is None ||
    b.output_end is None {
    return
  }
  let at = state.vertices[a.top].point
  let bt = state.vertices[b.top].point
  if (point.y < at.y + 2L || point.y < bt.y + 2L) &&
    (
      state.vertices[a.bot].point.y > point.y ||
      state.vertices[b.bot].point.y > point.y
    ) {
    return
  }
  if !point_on_segment_validated(point, state.vertices[a.bot].point, at) ||
    !point_on_segment_validated(point, state.vertices[b.bot].point, bt) ||
    cross_validated(at, point, bt) != 0L {
    return
  }
  close_connection(state, left, right, point)
  a.joined = Some(right)
  b.joined = Some(left)
}

///|
fn boolean_check_neighbors(
  state : ScanState,
  id : EdgeId,
  point : Point64,
) -> Unit raise ScanAbort {
  if state.boolean_operation is None {
    return
  }
  let edge = edge_get(state, id)
  if edge.prev_ael is Some(prev) {
    boolean_check_join(state, prev, id, point)
  }
  if edge.next_ael is Some(next) {
    boolean_check_join(state, id, next, point)
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
      winding_initialize(state, event.first)
      b.wind_count = a.wind_count
      b.wind_other = a.wind_other
      if winding_contributes(state, operation, a) {
        StartContour
      } else {
        Ignore
      }
    }
    EntryContact | BandContact => Ignore
    Maximum => {
      boolean_split_join(state, event.first, event.point)
      boolean_split_join(state, event.second, event.point)
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
      boolean_split_join(state, event.first, event.point)
      boolean_split_join(state, event.second, event.point)
      if ar == br {
        if state.boolean_rule == Parity {
          let old = a.wind_count
          a.wind_count = b.wind_count
          b.wind_count = old
        } else {
          let av = winding_add(state, a.wind_count, b.wind_dx)
          let bv = winding_add(state, b.wind_count, -a.wind_dx)
          a.wind_count = if av == 0 { -a.wind_count } else { av }
          b.wind_count = if bv == 0 { -b.wind_count } else { bv }
        }
      } else {
        a.wind_other = if state.boolean_rule == Parity {
          1 - a.wind_other
        } else {
          winding_add(state, a.wind_other, b.wind_dx)
        }
        b.wind_other = if state.boolean_rule == Parity {
          1 - b.wind_other
        } else {
          winding_add(state, b.wind_other, -a.wind_dx)
        }
      }
      let ah = a.output_end is Some(_)
      let bh = b.output_end is Some(_)
      let aw = winding_level(state, a.wind_count)
      let bw = winding_level(state, b.wind_count)
      let a_boundary = aw == 0 || aw == 1
      let b_boundary = bw == 0 || bw == 1
      if (!ah && !a_boundary) || (!bh && !b_boundary) {
        return Ignore
      }
      if ah && bh {
        if !a_boundary || !b_boundary || (ar != br && operation != Xor) {
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
      } else if ar != br {
        StartContour
      } else if aw == 1 && bw == 1 {
        let ac = winding_level(state, a.wind_other)
        let bc = winding_level(state, b.wind_other)
        let start = match operation {
          Union => ac <= 0 || bc <= 0
          Difference =>
            if ar == Clip {
              ac > 0 && bc > 0
            } else {
              ac <= 0 && bc <= 0
            }
          Intersection => ac > 0 && bc > 0
          Xor => true
        }
        if start {
          StartContour
        } else {
          Ignore
        }
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
  rule? : WindingRule = Parity,
) -> Result[Paths64, ClipError] {
  let state = match prepare_scan(subject, clip, limits~, source_extrema=true) {
    Ok(s) => s
    Err(e) => return Err(e)
  }
  state.boolean_rule = rule
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
/// Closed paths, independent operand filling; fixed preserve_collinear=false,
/// reverse_solution=false. Difference is Subject minus Clip.
pub fn boolean_op(
  subject : Paths64,
  clip : Paths64,
  operation : ClipType,
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  boolean_execute(
    subject,
    clip,
    operation,
    { input: limits, max_nodes: 500000, max_work: 5000000, },
    rule=match fill_rule {
      EvenOdd => Parity
      NonZero => SignedNonZero
    },
  )
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
      boolean_check_neighbors(state, left, event.point)
      boolean_check_neighbors(state, right, event.point)
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
