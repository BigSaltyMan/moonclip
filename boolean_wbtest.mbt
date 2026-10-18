///|
test "Boolean truth table and role boundary predicates are distinct" {
  for
    (s, c, expected) in [
      (false, false, [false, false, false, false]),
      (true, false, [false, true, true, true]),
      (false, true, [false, true, false, true]),
      (true, true, [true, true, false, false]),
    ] {
    let ops = [Intersection, Union, Difference, Xor]
    for i = 0; i < 4; i = i + 1 {
      assert_eq(boolean_region(ops[i], s, c), expected[i])
    }
  }
  assert_true(boolean_contributes(Difference, Subject, false))
  assert_true(!boolean_contributes(Difference, Clip, false))
}

///|
test "Boolean resource failure is shared and a new call has a fresh context" {
  let a = wb_rectangle()
  assert_true(
    boolean_execute([a], [], Union, {
      input: Default::default(),
      max_nodes: 2,
      max_work: 10000,
    })
    is Err(ResourceLimitExceeded(_, InternalNodes, 2)),
  )
  assert_true(
    boolean_execute([a], [], Union, {
      input: Default::default(),
      max_nodes: 10000,
      max_work: 20,
    })
    is Err(ResourceLimitExceeded(_, ScanWork, 20)),
  )
  assert_true(boolean_op([a], [], Union) is Ok(_))
}

///|
test "automatic contribution decisions preserve combined invariants at every phase" {
  for operation in [Intersection, Union, Difference, Xor] {
    let state = wb_prepared([wb_rectangle()], clip=[
      [
        wb_point(5L, -5L),
        wb_point(15L, -5L),
        wb_point(15L, 5L),
        wb_point(5L, 5L),
      ],
    ])
    state.boolean_operation = Some(operation)
    for steps = 0; steps < 1000; steps = steps + 1 {
      guard engine_step(state, fn(e) { boolean_choose(state, operation, e) })
        is Ok(phase) else {
        fail("Automatic geometry execution failed")
      }
      ix_ok(state)
      if phase == Complete {
        break
      }
    }
    assert_eq(state.phase, Complete)
    for i = 0; i < state.output.joins.length(); i = i + 1 {
      execute_horizontal_join(state, i, state.output.joins[i].opposed)
    }
    boolean_join_seams(state)
    ix_ok(state)
    ignore(output_extract(state))
    ix_ok(state)
  }
}
