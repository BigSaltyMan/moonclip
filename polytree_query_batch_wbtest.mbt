// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
test "tree locate batch: shared consumed budget fails at the second query" {
  let tree = boolean_tree(
    [
      pt_rect(w=20L, h=20L),
      pt_rect(x=4L, y=4L, w=12L, h=12L),
      pt_rect(x=8L, y=8L, w=4L, h=4L),
    ],
    [],
    Union,
  ).unwrap()
  let point = Point64::new(-1L, 1L)
  let saved = tree.to_paths()
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 100,
    max_work: 25,
  }
  // Single legacy query: 3 size visits + 3*(1 node + 4 edges) = 18 work;
  // two temporary containers + Outside variant = 3 nodes. No new single-point fee.
  let single = new_call_budget(limits)
  assert_true(
    tree_locate_execute(tree, point, limits, budget=single) is Ok(Outside),
  )
  assert_eq(single.stats.work, 18)
  assert_eq(single.stats.nodes, 3)
  let one = new_call_budget(limits)
  one.stats.work = 1
  assert_true(
    tree_locate_many_execute(tree, [point], Default::default(), budget=one)
    is Ok(_),
  )
  assert_eq(one.stats.work, 22) // history 1 + size 3 + axes 2 + query 15 + append 1
  assert_eq(one.stats.nodes, 5) // batch 1 + query 3 + slot 1
  let batch = new_call_budget(limits)
  batch.stats.work = 1
  assert_true(
    tree_locate_many_execute(
      tree,
      [point, point],
      Default::default(),
      budget=batch,
    )
    is Err(
      ResourceLimitExceeded(
        { stage: PolyTreeQuery, path_index: None, vertex_index: Some(1), },
        ScanWork,
        25
      )
    ),
  )
  // history 1 + size 3 + validation 4 + first query/append 16 = 24;
  // next node costs 1, then its first edge is refused at point index 1.
  assert_eq(batch.stats.work, 25)
  assert_eq(tree.to_paths(), saved)
  assert_eq(tree.locate_many([point, point]).unwrap().length(), 2)
}
