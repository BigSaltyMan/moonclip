// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "tree locate: consumed ledger rejects without changing tree or retry" {
  let tree = boolean_tree(
    [
      pt_rect(w=20L, h=20L),
      pt_rect(x=4L, y=4L, w=12L, h=12L),
      pt_rect(x=8L, y=8L, w=4L, h=4L),
    ],
    [],
    Union,
  ).unwrap()
  let saved = tree.to_paths()
  let point = Point64::new(10L, 10L)
  let measured = new_call_budget(Default::default())
  assert_true(
    tree_locate_execute(tree, point, Default::default(), budget=measured)
    is Ok(Inside(_)),
  )
  let limited = new_call_budget({
    input: Default::default(),
    max_nodes: 500000,
    max_work: measured.stats.work,
  })
  limited.stats.work = 1
  assert_true(
    tree_locate_execute(tree, point, Default::default(), budget=limited)
    is Err(
      ResourceLimitExceeded(
        { stage: PolyTreeQuery, path_index: None, vertex_index: None, },
        ScanWork,
        _
      )
    ),
  )
  assert_true(limited.stats.work > 1)
  assert_eq(tree.to_paths(), saved)
  assert_true(tree.locate(point) is Ok(Inside(_)))
}
