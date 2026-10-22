// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "stroke batch: consumed ledger is shared and independent retry succeeds" {
  let paths = [
    st_internal_line(),
    [Point64::new(30L, 0L), Point64::new(50L, 0L)],
  ]
  let measured = st_budget()
  assert_true(
    stroke_batch_execute(
      paths,
      2.0,
      Butt,
      Default::default(),
      st_limits(),
      budget=measured,
    )
    is Ok(_),
  )
  let limited = st_budget(limits={
    input: Default::default(),
    max_nodes: measured.stats.nodes,
    max_work: 5000000,
  })
  limited.stats.nodes = 1
  limited.stats.work = 1
  assert_true(
    stroke_batch_execute(
      paths,
      2.0,
      Butt,
      Default::default(),
      st_limits(),
      budget=limited,
    )
    is Err(ResourceLimitExceeded(_, InternalNodes, _)),
  )
  assert_true(limited.stats.nodes > 1)
  assert_true(limited.stats.work > 1)
  assert_eq(limited.limits.max_nodes, measured.stats.nodes)
  assert_true(stroke_polylines(paths, 2.0) is Ok(_))
}
