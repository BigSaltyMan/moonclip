///|
fn hs_register(
  state : ScanState,
  record : OutRecId,
  a : Int,
  b : Int,
) -> Unit raise {
  let nodes = output_ring(state, state.output.records[record].anchor.unwrap())
  horizontal_segment(state, nodes[a], nodes[b])
  ix_ok(state)
}

///|
test "opposite horizontal partial overlap creates node-identity candidate and merges rings" {
  let state = new_scan_state(Default::default())
  let a = out_fixture(state, wb_rectangle())
  let b = out_fixture(state, [
    wb_point(5L, 10L),
    wb_point(15L, 10L),
    wb_point(15L, 20L),
    wb_point(5L, 20L),
  ])
  hs_register(state, a, 2, 3)
  hs_register(state, b, 0, 1)
  assert_eq(state.output.joins.length(), 1)
  let join = state.output.joins[0]
  assert_eq(join.left, 5L)
  assert_eq(join.right, 10L)
  assert_true(join.first != join.second)
  assert_eq(
    output_point(state, join.first).point,
    output_point(state, join.second).point,
  )
  execute_horizontal_join(state, 0, true)
  ix_ok(state)
  let paths = output_extract(state, preserve_collinear=false)
  assert_eq(paths.length(), 1)
  assert_eq(area2(paths[0]), Ok(400N))
  assert_eq(paths[0].length(), 8)
  assert_eq(output_resolve(state, b), a)
}

///|
test "full opposite overlap joins and cleanup removes the shared spike" {
  let state = new_scan_state(Default::default())
  let a = out_fixture(state, wb_rectangle())
  let b = out_fixture(state, [
    wb_point(0L, 10L),
    wb_point(10L, 10L),
    wb_point(10L, 20L),
    wb_point(0L, 20L),
  ])
  hs_register(state, a, 2, 3)
  hs_register(state, b, 0, 1)
  assert_eq(state.output.joins.length(), 1)
  execute_horizontal_join(state, 0, true)
  ix_ok(state)
  let paths = output_extract(state, preserve_collinear=false)
  assert_eq(paths.length(), 1)
  assert_eq(paths[0].length(), 4)
  assert_eq(area2(paths[0]), Ok(400N))
}

///|
test "endpoint contact disjoint and same-direction spans are not automatic joins" {
  for shift in [10L, 20L] {
    let state = new_scan_state(Default::default())
    let a = out_fixture(state, wb_rectangle())
    let b = out_fixture(state, wb_rectangle(x=shift))
    hs_register(state, a, 0, 1)
    hs_register(state, b, 0, 1)
    assert_eq(state.output.joins.length(), 0)
    ix_ok(state)
  }
  let same = new_scan_state(Default::default())
  let a = out_fixture(same, wb_rectangle())
  let b = out_fixture(same, wb_rectangle(x=5L))
  hs_register(same, a, 0, 1)
  hs_register(same, b, 0, 1)
  assert_eq(same.output.horizontals.length(), 2)
  assert_eq(same.output.joins.length(), 1)
  assert_true(!same.output.joins[0].opposed)
  execute_horizontal_join(same, 0, false)
  ix_ok(same)
}

///|
test "same-ring horizontal join splits instead of assigning a hole owner" {
  let state = new_scan_state(Default::default())
  let a = out_fixture(state, wb_rectangle())
  let b = out_fixture(state, [
    wb_point(0L, 10L),
    wb_point(10L, 10L),
    wb_point(10L, 20L),
    wb_point(0L, 20L),
  ])
  hs_register(state, a, 2, 3)
  hs_register(state, b, 0, 1)
  let join = state.output.joins[0]
  ignore(output_splice(state, join.first, join.second))
  ix_ok(state)
  assert_eq(output_resolve(state, b), a)
  execute_horizontal_join(state, 0, true)
  ix_ok(state)
  assert_true(state.output.records[2].split_from is Some(_))
  assert_eq(output_extract(state, preserve_collinear=false).length(), 2)
}

///|
test "candidate can be rejected explicitly without connecting equal coordinates" {
  let state = new_scan_state(Default::default())
  let a = out_fixture(state, wb_rectangle())
  let b = out_fixture(state, [
    wb_point(0L, 10L),
    wb_point(10L, 10L),
    wb_point(10L, 20L),
    wb_point(0L, 20L),
  ])
  hs_register(state, a, 2, 3)
  hs_register(state, b, 0, 1)
  execute_horizontal_join(state, 0, false)
  ix_ok(state)
  assert_eq(output_extract(state).length(), 2)
  assert_true(
    wb_error(fn() raise ScanAbort { execute_horizontal_join(state, 0, true) })
    is InvalidInput(_, _),
  )
}

///|
test "multiple independent same-height horizontal groups preserve candidates" {
  let state = new_scan_state(Default::default())
  for x in [0L, 30L, 60L] {
    let a = out_fixture(state, wb_rectangle(x~))
    let b = out_fixture(state, [
      wb_point(x, 10L),
      wb_point(x + 10L, 10L),
      wb_point(x + 10L, 20L),
      wb_point(x, 20L),
    ])
    hs_register(state, a, 2, 3)
    hs_register(state, b, 0, 1)
  }
  assert_eq(state.output.joins.length(), 3)
  for index = 0; index < 3; index = index + 1 {
    execute_horizontal_join(state, index, true)
    ix_ok(state)
  }
  assert_eq(output_extract(state, preserve_collinear=false).length(), 3)
}

///|
test "scan horizontal crossing uses adjacent geometry events in both directions" {
  for reverse in [false, true] {
    let a = wb_rectangle()
    let b = [
      wb_point(5L, 5L),
      wb_point(15L, 5L),
      wb_point(15L, 15L),
      wb_point(5L, 15L),
    ]
    let paths = if reverse {
      [
        a.map(fn(p) { wb_point(-p.x, p.y) }),
        b.map(fn(p) { wb_point(-p.x, p.y) }),
      ]
    } else {
      [a, b]
    }
    let events : Array[Point64] = []
    let state = engine_fixture(paths, fn(event) {
      if event.kind == HorizontalCrossing {
        events.push(event.point)
      }
      Ignore
    })
    assert_true(events.length() >= 2)
    assert_true(events.any(fn(p) { p.y == 10L }))
    assert_true(events.any(fn(p) { p.y == 5L }))
    assert_eq(state.live_edges, 0)
    assert_eq(state.output.records.length(), 0)
  }
}

///|
test "scan handles full partial and endpoint horizontal contacts without infinite retry" {
  for shift in [0L, 5L, 10L] {
    let state = engine_fixture(
      [
        wb_rectangle(),
        [
          wb_point(shift, 10L),
          wb_point(shift + 10L, 10L),
          wb_point(shift + 10L, 20L),
          wb_point(shift, 20L),
        ],
      ],
      fn(_) { Ignore },
    )
    assert_eq(state.phase, Complete)
    assert_eq(state.live_edges, 0)
  }
}

///|
test "reversing horizontal chain and seam continue with real generated events" {
  for
    path in [
      [
        wb_point(0L, 0L),
        wb_point(5L, 0L),
        wb_point(5L, 10L),
        wb_point(10L, 10L),
        wb_point(0L, 10L),
      ],
      [
        wb_point(5L, 10L),
        wb_point(0L, 10L),
        wb_point(0L, 0L),
        wb_point(10L, 0L),
        wb_point(10L, 10L),
      ],
      [
        wb_point(0L, 0L),
        wb_point(0L, 0L),
        wb_point(10L, 0L),
        wb_point(10L, 10L),
        wb_point(0L, 10L),
        wb_point(0L, 0L),
      ],
    ] {
    let state = engine_fixture([path], fn(_) { Ignore })
    assert_true(state.stats.horizontal_steps >= 2)
    ix_ok(state)
  }
}

///|
test "entry contacts defer or resume explicitly before horizontal progression" {
  let state = wb_prepared([
    wb_rectangle(),
    [wb_point(0L, 5L), wb_point(4L, 0L), wb_point(-4L, 0L)],
  ])
  let mut saw = false
  for step = 0; step < 100; step = step + 1 {
    guard engine_step(state, fn(event) {
        if event.kind == EntryContact {
          Defer
        } else {
          Ignore
        }
      })
      is Ok(phase) else {
      fail("Unexpected contact failure")
    }
    if phase is AwaitEntryContact(_, _, _) {
      saw = true
      break
    }
  }
  assert_true(saw)
  assert_true(engine_step(state, fn(_) { Ignore }) is Ok(Horizontals))
  assert_true(state.entry_contact is None)
  ix_ok(state)
}

///|
test "many overlapping horizontal candidates consume shared work and terminate" {
  let base = new_scan_state(Default::default())
  for i = 0; i < 12; i = i + 1 {
    let id = out_fixture(base, wb_rectangle(x=i.to_int64()))
    hs_register(base, id, 0, 1)
  }
  let limits : ScanLimits = {
    input: Default::default(),
    max_nodes: 10000,
    max_work: base.stats.work - 1,
  }
  let short = new_scan_state(limits)
  let mut failed = false
  for i = 0; i < 12; i = i + 1 {
    let id = out_fixture(short, wb_rectangle(x=i.to_int64()))
    let nodes = output_ring(short, short.output.records[id].anchor.unwrap())
    horizontal_segment(short, nodes[0], nodes[1]) catch {
      ScanAbort(ResourceLimitExceeded(_, ScanWork, _)) => {
        failed = true
        break
      }
      ScanAbort(error) => fail(error.message())
    }
  }
  assert_true(failed)
  assert_eq(short.phase, Failed)
  ix_ok(short)
}

///|
test "horizontal candidates must be decided before export" {
  let state = new_scan_state(Default::default())
  let a = out_fixture(state, wb_rectangle())
  let b = out_fixture(state, [
    wb_point(0L, 10L),
    wb_point(10L, 10L),
    wb_point(10L, 20L),
    wb_point(0L, 20L),
  ])
  hs_register(state, a, 2, 3)
  hs_register(state, b, 0, 1)
  assert_true(
    wb_error(fn() raise ScanAbort { output_extract(state) })
    is InvalidInput(_, _),
  )
}

///|
test "all same-point entering contacts retain distinct edge-pair events" {
  let state = wb_prepared([wb_rectangle(), wb_rectangle(), wb_rectangle()])
  let contacts : Array[(EdgeId, EdgeId)] = []
  ignore(engine_step(state, fn(_) { Ignore }))
  ignore(
    engine_step(state, fn(event) {
      if event.kind == EntryContact {
        contacts.push((event.first, event.second))
      }
      Ignore
    }),
  )
  assert_eq(contacts.length(), 12)
  for i = 0; i < contacts.length(); i = i + 1 {
    for j = i + 1; j < contacts.length(); j = j + 1 {
      assert_true(contacts[i] != contacts[j])
    }
  }
  ix_ok(state)
}

///|
test "outgoing endpoint look-ahead shares ties-even rounding and supports long extrapolation" {
  assert_eq(
    scan_outgoing_compare(wb_point(1L, 2L), wb_point(2L, 0L), wb_point(1L, 1L)),
    0,
  )
  assert_eq(
    scan_outgoing_compare(
      wb_point(0L, 10L),
      wb_point(1000000000L, 9L),
      wb_point(0L, -1000000000L),
    ),
    1,
  )
  assert_eq(
    scan_outgoing_compare(
      wb_point(0L, 10L),
      wb_point(-1000000000L, 9L),
      wb_point(0L, -1000000000L),
    ),
    -1,
  )
}

///|
test "same-direction overlap cannot be blindly spliced into an output ring" {
  let state = new_scan_state(Default::default())
  let a = out_fixture(state, wb_rectangle())
  let b = out_fixture(state, wb_rectangle(x=5L))
  hs_register(state, a, 0, 1)
  hs_register(state, b, 0, 1)
  assert_true(
    wb_error(fn() raise ScanAbort { execute_horizontal_join(state, 0, true) })
    is InvalidInput(_, _),
  )
  ix_ok(state)
}

///|
test "scan-generated backtrack overlap is consumed by output topology after scan completion" {
  let path = [
    wb_point(0L, 0L),
    wb_point(5L, 0L),
    wb_point(5L, 10L),
    wb_point(10L, 10L),
    wb_point(0L, 10L),
  ]
  let state = engine_fixture([path], simple_contour_decision)
  assert_true(state.output.joins.length() > 0)
  for i = 0; i < state.output.joins.length(); i = i + 1 {
    execute_horizontal_join(state, i, true)
    ix_ok(state)
  }
  let paths = output_extract(state)
  ix_ok(state)
  assert_eq(paths.length(), 1)
  assert_eq(area2(paths[0]), Ok(100N))
  assert_eq(
    bounds(paths[0]),
    Ok(Some({ min_x: 0L, min_y: 0L, max_x: 5L, max_y: 10L, })),
  )
}
