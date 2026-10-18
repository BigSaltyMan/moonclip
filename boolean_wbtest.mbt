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

///|
fn internal_compare_path(a : Path64, b : Path64) -> Int {
  for i = 0; i < a.length() && i < b.length(); i = i + 1 {
    if a[i].x != b[i].x {
      return if a[i].x < b[i].x { -1 } else { 1 }
    }
    if a[i].y != b[i].y {
      return if a[i].y < b[i].y { -1 } else { 1 }
    }
  }
  a.length() - b.length()
}

///|
fn internal_canonical(paths : Paths64) -> Paths64 {
  let result = paths.map(fn(path) {
    let mut best = path.copy()
    for start = 1; start < path.length(); start = start + 1 {
      let candidate = Array::makei(path.length(), fn(i) {
        path[(start + i) % path.length()]
      })
      if internal_compare_path(candidate, best) < 0 {
        best = candidate
      }
    }
    best
  })
  for i = 1; i < result.length(); i = i + 1 {
    let mut j = i
    while j > 0 && internal_compare_path(result[j], result[j - 1]) < 0 {
      let tmp = result[j]
      result[j] = result[j - 1]
      result[j - 1] = tmp
      j -= 1
    }
  }
  result
}

///|
fn wi_reverse(path : Path64) -> Path64 {
  Array::makei(path.length(), fn(i) { path[path.length() - i - 1] })
}

///|
fn wi_run(
  subject : Paths64,
  clip : Paths64,
  op : ClipType,
  rule : WindingRule,
) -> Result[Paths64, ClipError] {
  boolean_execute(subject, clip, op, Default::default(), rule~).map(
    internal_canonical,
  )
}

///|
test "winding fill truth table covers minus three through three" {
  let expected = [
    [true, true, false, true],
    [false, true, false, true],
    [true, true, false, true],
    [false, false, false, false],
    [true, true, true, false],
    [false, true, true, false],
    [true, true, true, false],
  ]
  let rules = [Parity, SignedNonZero, Positive, Negative]
  for w = -3; w <= 3; w = w + 1 {
    for i = 0; i < rules.length(); i = i + 1 {
      assert_eq(winding_filled(rules[i], w), expected[w + 3][i])
    }
  }
}

///|
test "signed rule levels distinguish negative and positive boundary counts" {
  let state = wb_prepared([wb_rectangle()])
  state.boolean_rule = Positive
  assert_eq(winding_level(state, -2), -2)
  state.boolean_rule = Negative
  assert_eq(winding_level(state, -2), 2)
  state.boolean_rule = SignedNonZero
  assert_eq(winding_level(state, -2), 2)
  assert_eq(winding_add(state, 3, -1), 2)
}

///|
test "winding rejects upper lower and arbitrary corrupted counts before overflow" {
  for (value, delta) in [(4, 1), (-4, -1), (2147483647, 1), (-2147483648, -1)] {
    let state = wb_prepared([wb_rectangle()])
    let result = try {
      ignore(winding_add(state, value, delta))
      false
    } catch {
      ScanAbort(ExecutionFailure(_, _)) => true
      _ => false
    }
    assert_true(result)
  }
}

///|
test "Cartesian counterclockwise positive and clockwise negative select the same oriented result" {
  let a = wb_rectangle()
  let expected = Ok(internal_canonical([a]))
  assert_eq(wi_run([a], [], Union, Positive), expected)
  assert_eq(wi_run([a], [], Union, Negative), Ok([]))
  assert_eq(wi_run([wi_reverse(a)], [], Union, Negative), expected)
  assert_eq(wi_run([wi_reverse(a)], [], Union, Positive), Ok([]))
}

///|
test "private signed multiplicities two three seven and cancellation retain exact regions" {
  let a = wb_rectangle()
  let r = wi_reverse(a)
  for n in [2, 3, 7] {
    assert_eq(
      wi_run(Array::make(n, a), [], Union, Positive),
      Ok(internal_canonical([a])),
    )
    assert_eq(
      wi_run(Array::make(n, r), [], Union, Negative),
      Ok(internal_canonical([a])),
    )
  }
  for rule in [Positive, Negative] {
    assert_eq(wi_run([a, r], [], Union, rule), Ok([]))
  }
  assert_eq(wi_run([a, a, r], [], Union, Positive), Ok(internal_canonical([a])))
  assert_eq(wi_run([r, r, a], [], Union, Negative), Ok(internal_canonical([a])))
}

///|
test "zero area self crossing has distinct signed lobes without epsilon" {
  let bow = [
    wb_point(-8L, -8L),
    wb_point(8L, 8L),
    wb_point(-8L, 8L),
    wb_point(8L, -8L),
  ]
  let upper = [wb_point(-8L, 8L), wb_point(0L, 0L), wb_point(8L, 8L)]
  let lower = [wb_point(-8L, -8L), wb_point(8L, -8L), wb_point(0L, 0L)]
  assert_eq(area2(bow), Ok(0N))
  assert_eq(wi_run([bow], [], Union, Positive), Ok(internal_canonical([upper])))
  assert_eq(wi_run([bow], [], Union, Negative), Ok(internal_canonical([lower])))
}

///|
test "private positive original and negative globally reversed inputs agree across operations" {
  let a = wb_rectangle()
  let b = [
    wb_point(5L, -5L),
    wb_point(15L, -5L),
    wb_point(15L, 5L),
    wb_point(5L, 5L),
  ]
  for op in [Intersection, Union, Difference, Xor] {
    let expected = wi_run([a, a], [b, b], op, Positive)
    assert_true(expected is Ok(_))
    assert_eq(
      wi_run(
        [wi_reverse(a), wi_reverse(a)],
        [wi_reverse(b), wi_reverse(b)],
        op,
        Negative,
      ),
      expected,
    )
  }
}

///|
test "signed resource failure is isolated across rules and retries" {
  let a = wb_rectangle()
  for rule in [SignedNonZero, Positive, Negative] {
    assert_true(
      boolean_execute(
        [a, a],
        [],
        Union,
        { input: Default::default(), max_nodes: 500000, max_work: 30, },
        rule~,
      )
      is Err(ResourceLimitExceeded(_, ScanWork, 30)),
    )
    assert_true(wi_run([a], [], Union, rule) is Ok(_))
  }
}

///|
test "source platform endpoints preserve signed winding and combined phase invariants" {
  let a = wb_rectangle()
  for rule in [Parity, SignedNonZero, Positive, Negative] {
    guard prepare_scan([a, a], [], source_extrema=true) is Ok(state) else {
      fail("Expected prepared source")
    }
    state.boolean_operation = Some(Union)
    state.boolean_rule = rule
    for steps = 0; steps < 1000; steps = steps + 1 {
      guard engine_step(state, fn(e) { boolean_choose(state, Union, e) })
        is Ok(phase) else {
        fail("Expected valid winding transitions")
      }
      ix_ok(state)
      if phase == Complete {
        break
      }
    }
    assert_eq(state.phase, Complete)
  }
}

///|
test "signed common edge joins split on segment changes without leaking output ends" {
  let a = wb_rectangle()
  let b = a.map(fn(p) { Point64::new(p.x + 10L, p.y) })
  guard prepare_scan([a, b], [], source_extrema=true) is Ok(state) else {
    fail("Expected adjacent inputs")
  }
  state.boolean_operation = Some(Union)
  state.boolean_rule = SignedNonZero
  let mut joined = false
  for steps = 0; steps < 1000; steps = steps + 1 {
    guard engine_step(state, fn(e) { boolean_choose(state, Union, e) })
      is Ok(phase) else {
      fail("Common-edge lifecycle failed")
    }
    for slot in state.slots {
      if slot.edge is Some(edge) && edge.joined is Some(_) {
        joined = true
      }
    }
    ix_ok(state)
    if phase == Complete {
      break
    }
  }
  assert_true(joined)
  assert_eq(state.phase, Complete)
  for i = 0; i < state.output.joins.length(); i = i + 1 {
    execute_horizontal_join(state, i, state.output.joins[i].opposed)
  }
  boolean_join_seams(state)
  assert_eq(
    internal_canonical(output_extract(state)),
    internal_canonical([
      [
        wb_point(0L, 0L),
        wb_point(20L, 0L),
        wb_point(20L, 10L),
        wb_point(0L, 10L),
      ],
    ]),
  )
}
