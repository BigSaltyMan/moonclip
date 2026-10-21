// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn rcw_rect() -> Bounds64 {
  { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, }
}

///|
fn rcw_line() -> Paths64 {
  [[Point64::new(-5L, 5L), Point64::new(15L, 5L)]]
}

///|
fn rcw_run(b : CallBudget) -> Result[Paths64, ClipError] {
  rect_clip_execute(rcw_rect(), rcw_line(), Default::default(), budget=b)
}

///|
test "rect clip lines: measured node and work boundaries are inclusive" {
  let base = new_call_budget(Default::default())
  assert_true(rcw_run(base) is Ok(_))
  assert_true(base.stats.nodes > 0 && base.stats.work > 0)
  for (dn, dw) in [(0, 0), (1, 0), (0, 1)] {
    let limits : ScanLimits = {
      ..Default::default(),
      max_nodes: base.stats.nodes - dn,
      max_work: base.stats.work - dw,
    }
    let b = new_call_budget(limits)
    let result = rcw_run(b)
    if dn == 0 && dw == 0 {
      assert_true(result is Ok(_))
    } else {
      assert_true(result is Err(ResourceLimitExceeded(_, _, _)))
    }
    assert_true(
      b.stats.nodes <= limits.max_nodes && b.stats.work <= limits.max_work,
    )
  }
}

///|
test "rect clip lines: injected budget history and limits remain authoritative" {
  let base = new_call_budget(Default::default())
  assert_true(rcw_run(base) is Ok(_))
  let b = new_call_budget({
    ..Default::default(),
    max_nodes: base.stats.nodes,
    max_work: base.stats.work,
  })
  b.stats.nodes = 1
  assert_true(rcw_run(b) is Err(ResourceLimitExceeded(_, InternalNodes, _)))
  let c = new_call_budget({
    ..Default::default(),
    max_nodes: base.stats.nodes + 7,
    max_work: base.stats.work + 11,
  })
  c.stats.nodes = 7
  c.stats.work = 11
  assert_true(rcw_run(c) is Ok(_))
  assert_eq(
    (c.stats.nodes, c.stats.work),
    (base.stats.nodes + 7, base.stats.work + 11),
  )
}

///|
test "rect clip lines: zero window has preflight and empty container charges" {
  let empty = new_call_budget(Default::default())
  assert_eq(
    rect_clip_execute(rcw_rect(), [], empty.limits, budget=empty),
    Ok([]),
  )
  assert_eq((empty.stats.nodes, empty.stats.work), (1, 1))
  let r : Bounds64 = { min_x: 0L, min_y: 0L, max_x: 0L, max_y: 10L, }
  let b = new_call_budget(Default::default())
  assert_eq(rect_clip_execute(r, rcw_line(), b.limits, budget=b), Ok([]))
  // One raw path count/coordinate pass (2), two input vertices (2), empty output (1).
  assert_eq((b.stats.nodes, b.stats.work), (1, 5))
  let small = new_call_budget({ ..Default::default(), max_nodes: 0, })
  assert_true(
    rect_clip_execute(r, [], small.limits, budget=small)
    is Err(
      ResourceLimitExceeded(
        { stage: RectClipOutput, path_index: None, vertex_index: None, },
        InternalNodes,
        0
      )
    ),
  )
}

///|
test "rect clip lines: preflight rejects before allocating output and retry is clean" {
  let b = new_call_budget({
    ..Default::default(),
    input: { max_input_paths: 1, max_input_vertices: 1, },
  })
  assert_true(
    rcw_run(b)
    is Err(
      ResourceLimitExceeded({ stage: RectClipParameters, .. }, InputVertices, 1)
    ),
  )
  assert_eq((b.stats.nodes, b.stats.work), (0, 0))
  let retry = new_call_budget(Default::default())
  assert_true(rcw_run(retry) is Ok(_))
  let again = new_call_budget(Default::default())
  assert_eq(rcw_run(again), rcw_run(new_call_budget(Default::default())))
  assert_eq(
    (retry.stats.nodes, retry.stats.work),
    (again.stats.nodes, again.stats.work),
  )
}

///|
test "rect clip lines: evaluation failures retain original vertex while output has no index" {
  let b = new_call_budget({ ..Default::default(), max_work: 10, })
  assert_true(
    rcw_run(b)
    is Err(
      ResourceLimitExceeded(
        { stage: RectClipEvaluate, path_index: Some(0), vertex_index: Some(_), },
        ScanWork,
        _
      )
    ),
  )
  let c = new_call_budget({ ..Default::default(), max_nodes: 10, })
  assert_true(
    rcw_run(c)
    is Err(
      ResourceLimitExceeded(
        { stage: RectClipOutput, path_index: None, vertex_index: None, },
        InternalNodes,
        _
      )
    ),
  )
}

///|
test "rect clip lines: invalid internal limits are checked on empty calls" {
  let invalid : Array[ScanLimits] = [
    { ..Default::default(), max_nodes: -1, },
    { ..Default::default(), max_work: -1, },
  ]
  for limits in invalid {
    assert_true(
      rect_clip_execute(rcw_rect(), [], limits)
      is Err(InvalidInput({ stage: RectClipParameters, .. }, _)),
    )
  }
}
