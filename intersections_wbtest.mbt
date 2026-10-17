///|
fn ix_fixture(
  segments : Array[(Point64, Point64)],
  top? : Int64 = 0L,
) -> ScanState raise {
  let paths = segments.map(fn(pair) {
    [pair.0, pair.1, wb_point(pair.0.x + 100L, pair.1.y)]
  })
  let state = wb_prepared(paths)
  for m in state.minima {
    let id = edge_allocate(state, m.forward.unwrap())
    ael_insert(state, id)
  }
  state.current_y = Some(segments[0].0.y)
  state.phase = AwaitIntersections(top)
  wb_ok(state)
  state
}

///|
fn ix_ok(state : ScanState) -> Unit raise {
  match engine_invariants(state) {
    Ok(_) => ()
    Err(m) => fail(m)
  }
}

///|
test "ordinary line intersection truncates positive and negative fractional coordinates" {
  assert_eq(
    line_intersection(
      wb_point(0L, 4L),
      wb_point(3L, 0L),
      wb_point(3L, 4L),
      wb_point(0L, 0L),
    ),
    Some(wb_point(1L, 2L)),
  )
  assert_eq(
    line_intersection(
      wb_point(0L, 4L),
      wb_point(-3L, 0L),
      wb_point(-3L, 4L),
      wb_point(0L, 0L),
    ),
    Some(wb_point(-1L, 2L)),
  )
  assert_eq(
    line_intersection(
      wb_point(-3L, 0L),
      wb_point(3L, 0L),
      wb_point(0L, -3L),
      wb_point(0L, 4L),
    ),
    Some(wb_point(0L, 0L)),
  )
}

///|
test "ordinary intersection returns endpoint clamps and parallel None" {
  assert_eq(
    line_intersection(
      wb_point(0L, 4L),
      wb_point(4L, 0L),
      wb_point(-1L, 5L),
      wb_point(3L, 5L),
    ),
    Some(wb_point(0L, 4L)),
  )
  assert_eq(
    line_intersection(
      wb_point(0L, 4L),
      wb_point(4L, 0L),
      wb_point(0L, -2L),
      wb_point(6L, -2L),
    ),
    Some(wb_point(4L, 0L)),
  )
  assert_eq(
    line_intersection(
      wb_point(0L, 4L),
      wb_point(4L, 0L),
      wb_point(1L, 4L),
      wb_point(5L, 0L),
    ),
    None,
  )
}

///|
test "vertical near-parallel and coordinate boundary intersections remain finite" {
  assert_eq(
    line_intersection(
      wb_point(0L, 10L),
      wb_point(0L, -10L),
      wb_point(-10L, 10L),
      wb_point(10L, -10L),
    ),
    Some(wb_point(0L, 0L)),
  )
  assert_eq(
    line_intersection(
      wb_point(-1000000000L, 1000000000L),
      wb_point(1000000000L, -1000000000L),
      wb_point(1000000000L, 1000000000L),
      wb_point(-1000000000L, -1000000000L),
    ),
    Some(wb_point(0L, 0L)),
  )
  assert_true(
    line_intersection(
      wb_point(0L, 100L),
      wb_point(999999999L, 0L),
      wb_point(1L, 100L),
      wb_point(1000000000L, 1L),
    )
    is Some(_),
  )
}

///|
test "intersection conversion rejects nonfinite and out-of-range values" {
  for
    value in [
      @double.not_a_number, @double.infinity, -1000000001.0, 1000000001.0,
    ] {
    assert_true(
      wb_error(fn() raise ScanAbort { intersection_integer(value) })
      is NumericFailure(_, _),
    )
  }
}

///|
test "closest-point conversion uses ties-even relative displacement" {
  assert_eq(
    closest_on_segment(wb_point(1L, 0L), wb_point(1L, 1L), wb_point(2L, 0L)),
    wb_point(1L, 1L),
  )
  assert_eq(
    closest_on_segment(wb_point(-1L, 0L), wb_point(-1L, 1L), wb_point(-2L, 0L)),
    wb_point(-1L, 1L),
  )
  assert_eq(
    closest_on_segment(wb_point(99L, 99L), wb_point(2L, 2L), wb_point(2L, 2L)),
    wb_point(2L, 2L),
  )
}

///|
test "band correction clamps ordinary slopes but preserves upstream near-horizontal projection branch" {
  let ordinary = ix_fixture(
    [
      (wb_point(0L, 10L), wb_point(10L, 0L)),
      (wb_point(10L, 10L), wb_point(0L, 0L)),
    ],
    top=8L,
  )
  let ids = wb_edges(ordinary)
  assert_eq(intersection_point(ordinary, ids[0], ids[1], 8L), wb_point(8L, 8L))
  let near = ix_fixture(
    [
      (wb_point(0L, 10L), wb_point(2000L, 0L)),
      (wb_point(400L, 10L), wb_point(1600L, 0L)),
    ],
    top=8L,
  )
  let ids = wb_edges(near)
  assert_eq(intersection_point(near, ids[0], ids[1], 8L), wb_point(1000L, 5L))
}

///|
test "stable merge generates crossings without mutating AEL" {
  let state = ix_fixture([
    (wb_point(-4L, 10L), wb_point(4L, 0L)),
    (wb_point(4L, 10L), wb_point(-4L, 0L)),
  ])
  let before = wb_edges(state)
  build_intersections(state)
  assert_eq(wb_edges(state), before)
  assert_eq(wb_edges(state, auxiliary=true), [before[1], before[0]])
  assert_eq(state.intersections.length(), 1)
  assert_eq(state.intersections[0].point, wb_point(0L, 5L))
  assert_true(process_intersection(state, fn(_) { Ignore }))
  ix_ok(state)
  finish_intersections(state)
  ix_ok(state)
  assert_eq(state.current_y, Some(0L))
  assert_eq(state.intersections.length(), 0)
}

///|
test "same-coordinate multi-edge intersections retain every pair identity" {
  let state = ix_fixture([
    (wb_point(-6L, 10L), wb_point(6L, 0L)),
    (wb_point(0L, 10L), wb_point(0L, 0L)),
    (wb_point(6L, 10L), wb_point(-6L, 0L)),
  ])
  let before = wb_edges(state)
  build_intersections(state)
  assert_eq(state.intersections.length(), 3)
  for event in state.intersections {
    assert_eq(event.point, wb_point(0L, 5L))
  }
  for i = 0; i < 3; i = i + 1 {
    assert_true(process_intersection(state, fn(_) { Ignore }))
    ix_ok(state)
  }
  assert_eq(wb_edges(state), [before[2], before[1], before[0]])
  finish_intersections(state)
  ix_ok(state)
}

///|
test "nonadjacent initial event searches remaining generated events" {
  let state = ix_fixture([
    (wb_point(-6L, 10L), wb_point(6L, 0L)),
    (wb_point(0L, 10L), wb_point(0L, 0L)),
    (wb_point(6L, 10L), wb_point(-6L, 0L)),
  ])
  let before = wb_edges(state)
  build_intersections(state)
  let mut distant = 0
  for i = 0; i < state.intersections.length(); i = i + 1 {
    let e = state.intersections[i]
    if (e.first == before[0] && e.second == before[2]) ||
      (e.second == before[0] && e.first == before[2]) {
      distant = i
    }
  }
  let event = state.intersections[distant]
  state.intersections[distant] = state.intersections[0]
  state.intersections[0] = event
  assert_true(!event_adjacent(state, event))
  assert_true(process_intersection(state, fn(_) { Ignore }))
  assert_eq(state.intersection_cursor, 1)
  while state.intersection_cursor < 3 {
    assert_true(process_intersection(state, fn(_) { Ignore }))
  }
  finish_intersections(state)
  ix_ok(state)
}

///|
test "missing adjacent event fails with explicit intersection stage" {
  let state = ix_fixture([
    (wb_point(-6L, 10L), wb_point(6L, 0L)),
    (wb_point(0L, 10L), wb_point(0L, 0L)),
    (wb_point(6L, 10L), wb_point(-6L, 0L)),
  ])
  build_intersections(state)
  let ids = wb_edges(state)
  let mut distant = state.intersections[0]
  for e in state.intersections {
    if e.first == ids[0] && e.second == ids[2] {
      distant = e
    }
  }
  state.intersections.clear()
  state.intersections.push(distant)
  match
    wb_error(fn() raise ScanAbort {
      process_intersection(state, fn(_) { Ignore })
    }) {
    InvalidInput(loc, _) => assert_eq(loc.stage, Intersections)
    _ => fail("Expected scheduling error")
  }
  assert_eq(state.phase, Failed)
}

///|
test "deferred contribution leaves generated crossing and AEL unchanged" {
  let state = ix_fixture([
    (wb_point(-4L, 10L), wb_point(4L, 0L)),
    (wb_point(4L, 10L), wb_point(-4L, 0L)),
  ])
  build_intersections(state)
  let before = wb_edges(state)
  assert_true(!process_intersection(state, fn(_) { Defer }))
  assert_eq(wb_edges(state), before)
  assert_eq(state.intersection_cursor, 0)
  assert_eq(state.output.records.length(), 0)
}

///|
test "event validates generation segment and band before execution" {
  for mode in [0, 1, 2] {
    let state = ix_fixture([
      (wb_point(-4L, 10L), wb_point(4L, 0L)),
      (wb_point(4L, 10L), wb_point(-4L, 0L)),
    ])
    build_intersections(state)
    let event = state.intersections[0]
    if mode == 0 {
      state.slots[event.first.slot].generation += 1
    } else if mode == 1 {
      edge_get(state, event.first).bot = event.first_top
    } else {
      state.current_y = Some(9L)
    }
    assert_true(
      wb_error(fn() raise ScanAbort {
        process_intersection(state, fn(_) { Ignore })
      })
      is InvalidInput(_, _),
    )
  }
}

///|
test "many inversion events exhaust shared node budget and cannot resume" {
  let segments = Array::makei(30, fn(i) {
    (wb_point(i.to_int64(), 10L), wb_point((29 - i).to_int64(), 0L))
  })
  let base = ix_fixture(segments)
  let state = wb_limited(
    base.paths.map(fn(p) { p.vertices.map(fn(v) { base.vertices[v].point }) }),
    {
      input: Default::default(),
      max_nodes: base.stats.nodes + 65,
      max_work: 100000,
    },
  )
  for m in state.minima {
    ael_insert(state, edge_allocate(state, m.forward.unwrap()))
  }
  state.current_y = Some(10L)
  state.phase = AwaitIntersections(0L)
  assert_true(
    wb_error(fn() raise ScanAbort { build_intersections(state) })
    is ResourceLimitExceeded(_, InternalNodes, _),
  )
  assert_eq(state.phase, Failed)
  scan_cleanup(state)
  let fresh = ix_fixture([
    (wb_point(-4L, 10L), wb_point(4L, 0L)),
    (wb_point(4L, 10L), wb_point(-4L, 0L)),
  ])
  build_intersections(fresh)
  assert_eq(fresh.intersections.length(), 1)
}

///|
test "distinct bands generate fresh events without coordinate-based deduplication" {
  let state = ix_fixture([
    (wb_point(-4L, 10L), wb_point(4L, 0L)),
    (wb_point(4L, 10L), wb_point(-4L, 0L)),
  ])
  build_intersections(state)
  assert_true(process_intersection(state, fn(_) { Ignore }))
  finish_intersections(state)
  assert_eq(state.intersections.length(), 0)
  assert_eq(state.band_built, None)
  let fresh = ix_fixture([
    (wb_point(-4L, 10L), wb_point(4L, 0L)),
    (wb_point(4L, 10L), wb_point(-4L, 0L)),
  ])
  build_intersections(fresh)
  assert_eq(fresh.intersections.length(), 1)
  assert_eq(fresh.intersections[0].serial, 0)
}

///|
test "coincident projected top positions create explicit non-swapping contact events" {
  let state = ix_fixture([
    (wb_point(-4L, 10L), wb_point(0L, 0L)),
    (wb_point(4L, 10L), wb_point(0L, 0L)),
  ])
  build_intersections(state)
  assert_eq(state.intersections.length(), 1)
  assert_true(!state.intersections[0].reverses)
  let order = wb_edges(state)
  let mut kind = Crossing
  assert_true(
    process_intersection(state, fn(e) {
      kind = e.kind
      Ignore
    }),
  )
  assert_eq(kind, BandContact)
  assert_eq(wb_edges(state), order)
  finish_intersections(state)
  ix_ok(state)
}

///|
test "exact intersection generation quota and one less work unit" {
  let segments = [
    (wb_point(-4L, 10L), wb_point(4L, 0L)),
    (wb_point(4L, 10L), wb_point(-4L, 0L)),
  ]
  let baseline = ix_fixture(segments)
  build_intersections(baseline)
  for short in [false, true] {
    let paths = segments.map(fn(pair) {
      [pair.0, pair.1, wb_point(pair.0.x + 100L, pair.1.y)]
    })
    let state = wb_limited(paths, {
      input: Default::default(),
      max_nodes: baseline.stats.nodes,
      max_work: baseline.stats.work - (if short { 1 } else { 0 }),
    })
    for m in state.minima {
      ael_insert(state, edge_allocate(state, m.forward.unwrap()))
    }
    state.current_y = Some(10L)
    state.phase = AwaitIntersections(0L)
    if short {
      assert_true(
        wb_error(fn() raise ScanAbort { build_intersections(state) })
        is ResourceLimitExceeded(_, ScanWork, _),
      )
    } else {
      build_intersections(state)
      assert_eq(state.stats, baseline.stats)
    }
    ix_ok(state)
  }
}

///|
test "pending event diagnostic rejects corrupted generation and cursor" {
  let state = ix_fixture([
    (wb_point(-4L, 10L), wb_point(4L, 0L)),
    (wb_point(4L, 10L), wb_point(-4L, 0L)),
  ])
  build_intersections(state)
  state.intersection_cursor = 99
  assert_true(engine_invariants(state) is Err(_))
  state.intersection_cursor = 0
  state.slots[state.intersections[0].first.slot].generation += 1
  assert_true(engine_invariants(state) is Err(_))
}

///|
test "multiple distinct intersection heights follow descending y before adjacency scheduling" {
  let state = ix_fixture([
    (wb_point(-8L, 10L), wb_point(4L, 0L)),
    (wb_point(0L, 10L), wb_point(-4L, 0L)),
    (wb_point(8L, 10L), wb_point(-8L, 0L)),
  ])
  build_intersections(state)
  assert_eq(state.intersections.map(fn(e) { e.point }), [
    wb_point(-2L, 5L),
    wb_point(-1L, 4L),
    wb_point(-2L, 3L),
  ])
  let seen : Array[Point64] = []
  for step = 0; step < 3; step = step + 1 {
    assert_true(
      process_intersection(state, fn(e) {
        seen.push(e.point)
        Ignore
      }),
    )
    ix_ok(state)
  }
  assert_eq(seen, [wb_point(-2L, 5L), wb_point(-1L, 4L), wb_point(-2L, 3L)])
  finish_intersections(state)
  ix_ok(state)
}

///|
test "negative fractional intersection truncates both axes toward zero" {
  assert_eq(
    line_intersection(
      wb_point(0L, 0L),
      wb_point(-3L, -3L),
      wb_point(-3L, 0L),
      wb_point(0L, -3L),
    ),
    Some(wb_point(-1L, -1L)),
  )
  let state = ix_fixture(
    [
      (wb_point(-4L, -1L), wb_point(4L, -11L)),
      (wb_point(4L, -1L), wb_point(-4L, -11L)),
    ],
    top=-11L,
  )
  build_intersections(state)
  assert_eq(state.intersections[0].point, wb_point(0L, -6L))
}

///|
test "the same live edge pair crosses in successive segments without event leakage" {
  let state = wb_prepared([
    [
      wb_point(-4L, 10L),
      wb_point(4L, 6L),
      wb_point(-4L, 2L),
      wb_point(4L, -2L),
      wb_point(100L, -2L),
    ],
    [
      wb_point(4L, 10L),
      wb_point(-4L, 6L),
      wb_point(4L, 2L),
      wb_point(-4L, -2L),
      wb_point(100L, -2L),
    ],
  ])
  for m in state.minima {
    ael_insert(state, edge_allocate(state, m.forward.unwrap()))
  }
  state.current_y = Some(10L)
  let ids = wb_edges(state)
  let mut last_bot : VertexId? = None
  for (height, hit) in [(6L, 8L), (2L, 4L), (-2L, 0L)] {
    state.phase = AwaitIntersections(height)
    build_intersections(state)
    assert_eq(state.intersections.length(), 1)
    let event = state.intersections[0]
    assert_eq(event.point, wb_point(0L, hit))
    assert_true(event.first == ids[0] || event.first == ids[1])
    assert_true(last_bot != Some(event.first_bot))
    last_bot = Some(event.first_bot)
    assert_true(process_intersection(state, fn(_) { Ignore }))
    finish_intersections(state)
    assert_eq(state.intersections.length(), 0)
    assert_true(scan_step(state) is Ok(Horizontals))
    ix_ok(state)
  }
  assert_eq(state.stats.intersection_events, 3)
}

///|
test "band correction tests both near-horizontal operand branches and parallel fallback" {
  for
    segments in [
      [
        (wb_point(0L, 10L), wb_point(1000L, 0L)),
        (wb_point(-500L, 10L), wb_point(1500L, 0L)),
      ],
      [
        (wb_point(0L, 10L), wb_point(2000L, 0L)),
        (wb_point(400L, 10L), wb_point(1600L, 0L)),
      ],
    ] {
    let state = ix_fixture(segments, top=8L)
    let ids = wb_edges(state)
    let expected = if segments[0].1.x == 1000L {
      wb_point(500L, 5L)
    } else {
      wb_point(1000L, 5L)
    }
    assert_eq(intersection_point(state, ids[0], ids[1], 8L), expected)
    assert_eq(intersection_point(state, ids[1], ids[0], 8L), expected)
  }
  let parallel = ix_fixture([
    (wb_point(0L, 10L), wb_point(10L, 0L)),
    (wb_point(2L, 10L), wb_point(12L, 0L)),
  ])
  let ids = wb_edges(parallel)
  assert_eq(intersection_point(parallel, ids[0], ids[1], 0L), wb_point(0L, 0L))
}

///|
test "intersection above current band bottom takes the explicit bottom correction" {
  let state = ix_fixture([
    (wb_point(0L, 10L), wb_point(10L, 0L)),
    (wb_point(2L, 10L), wb_point(-8L, 0L)),
  ])
  state.current_y = Some(8L)
  let ids = wb_edges(state)
  assert_eq(intersection_point(state, ids[0], ids[1], 0L), wb_point(0L, 8L))
}
