///|
fn bb_compare(a : @moonclip.Path64, b : @moonclip.Path64) -> Int {
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
fn bb_canonical(paths : @moonclip.Paths64) -> @moonclip.Paths64 {
  let result = paths.map(fn(path) {
    let mut best = path.copy()
    for start = 1; start < path.length(); start = start + 1 {
      let candidate = Array::makei(path.length(), fn(i) {
        path[(start + i) % path.length()]
      })
      if bb_compare(candidate, best) < 0 {
        best = candidate
      }
    }
    best
  })
  for i = 1; i < result.length(); i = i + 1 {
    let mut j = i
    while j > 0 && bb_compare(result[j], result[j - 1]) < 0 {
      let tmp = result[j]
      result[j] = result[j - 1]
      result[j - 1] = tmp
      j -= 1
    }
  }
  result
}

///|
fn bb_rect(x : Int64, y : Int64, w : Int64, h : Int64) -> @moonclip.Path64 {
  [
    @moonclip.Point64::new(x, y),
    @moonclip.Point64::new(x + w, y),
    @moonclip.Point64::new(x + w, y + h),
    @moonclip.Point64::new(x, y + h),
  ]
}

///|
fn bb_reverse(path : @moonclip.Path64) -> @moonclip.Path64 {
  Array::makei(path.length(), fn(i) { path[path.length() - 1 - i] })
}

///|
fn bb_region(
  subject : @moonclip.Paths64,
  clip : @moonclip.Paths64,
  operation : @moonclip.ClipType,
  expected : @moonclip.Paths64,
) -> Unit raise {
  assert_eq(
    @moonclip.boolean_op(subject, clip, operation).map(bb_canonical),
    Ok(bb_canonical(expected)),
  )
}

///|
test "public operations return exact strips with independent operand parity" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let b = bb_rect(5L, 0L, 10L, 10L)
  bb_region([a], [b], Intersection, [bb_rect(5L, 0L, 5L, 10L)])
  bb_region([a], [b], Union, [bb_rect(0L, 0L, 15L, 10L)])
  bb_region([a], [b], Difference, [bb_rect(0L, 0L, 5L, 10L)])
  bb_region([a], [b], Xor, [bb_rect(0L, 0L, 5L, 10L), bb_rect(10L, 0L, 5L, 10L)])
}

///|
test "same operand duplicates cancel in pairs and triples retain odd coverage" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  for op in [@moonclip.Union, Difference, Xor] {
    bb_region([a, a], [], op, [])
    bb_region([a, a, a], [], op, [a])
    bb_region([a, bb_reverse(a)], [], op, [])
  }
  bb_region([a], [a], Union, [a])
  bb_region([a], [a], Intersection, [a])
  bb_region([a], [a], Difference, [])
  bb_region([a], [a], Xor, [])
}

///|
test "within-operand overlaps form parity strips rather than a preliminary union" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let b = bb_rect(5L, 0L, 10L, 10L)
  let expected = [bb_rect(0L, 0L, 5L, 10L), bb_rect(10L, 0L, 5L, 10L)]
  for op in [@moonclip.Union, Difference, Xor] {
    bb_region([a, b], [], op, expected)
  }
}

///|
test "nested same-group contours retain hole and island winding" {
  let outer = bb_rect(-20L, -20L, 40L, 40L)
  let hole = bb_rect(-10L, -10L, 20L, 20L)
  let island = bb_rect(-5L, -5L, 10L, 10L)
  for op in [@moonclip.Union, Difference, Xor] {
    bb_region([outer, hole, island], [], op, [outer, bb_reverse(hole), island])
    bb_region([bb_reverse(outer), hole, bb_reverse(island)], [], op, [
      outer,
      bb_reverse(hole),
      island,
    ])
  }
}

///|
test "public Boolean identity and symmetry compare complete contours" {
  let a = [bb_rect(-8L, -4L, 10L, 12L)]
  let b = [bb_rect(-3L, -7L, 12L, 10L)]
  for op in [@moonclip.Union, Intersection] {
    bb_region(a, a, op, a)
  }
  for op in [@moonclip.Difference, Xor] {
    bb_region(a, a, op, [])
  }
  for op in [@moonclip.Intersection, Union, Xor] {
    let ab = @moonclip.boolean_op(a, b, op).map(bb_canonical)
    assert_eq(ab, @moonclip.boolean_op(b, a, op).map(bb_canonical))
    assert_eq(
      ab,
      @moonclip.boolean_op(a.map(bb_reverse), b.map(bb_reverse), op).map(
        bb_canonical,
      ),
    )
  }
  assert_true(
    @moonclip.boolean_op(a, b, Difference).map(bb_canonical) !=
    @moonclip.boolean_op(b, a, Difference).map(bb_canonical),
  )
}

///|
test "integer translation preserves full Boolean structure" {
  let a = [bb_rect(-8L, -4L, 10L, 12L)]
  let b = [bb_rect(-3L, -7L, 12L, 10L)]
  fn translate(paths : @moonclip.Paths64) -> @moonclip.Paths64 {
    paths.map(fn(p) {
      p.map(fn(v) { @moonclip.Point64::new(v.x + 40L, v.y - 30L) })
    })
  }
  for op in [@moonclip.Intersection, Union, Difference, Xor] {
    assert_eq(
      @moonclip.boolean_op(translate(a), translate(b), op).map(bb_canonical),
      @moonclip.boolean_op(a, b, op).map(fn(p) { bb_canonical(translate(p)) }),
    )
  }
}

///|
test "empty fast answers never bypass coordinate or raw input validation" {
  let invalid = [[@moonclip.Point64::new(1000000001L, 0L)]]
  for op in [@moonclip.Intersection, Union, Difference, Xor] {
    assert_true(
      @moonclip.boolean_op([], invalid, op)
      is Err(CoordinateOutOfRange(_, X, 1000000001L)),
    )
    assert_true(
      @moonclip.boolean_op(invalid, [], op)
      is Err(CoordinateOutOfRange(_, X, 1000000001L)),
    )
    bb_region([], [], op, [])
  }
  let a = bb_rect(0L, 0L, 10L, 10L)
  assert_true(
    @moonclip.boolean_op([a], [a], Intersection, limits={
      max_input_paths: 1,
      max_input_vertices: 100,
    })
    is Err(ResourceLimitExceeded(_, InputPaths, 1)),
  )
  assert_true(
    @moonclip.boolean_op([a], [a], Union, limits={
      max_input_paths: 2,
      max_input_vertices: 7,
    })
    is Err(ResourceLimitExceeded(_, InputVertices, 7)),
  )
  assert_true(
    @moonclip.boolean_op([], [], Union, limits={
      max_input_paths: -1,
      max_input_vertices: 100,
    })
    is Err(InvalidInput(_, _)),
  )
  bb_region([a], [], Union, [a])
}

///|
test "raw repeated vertices consume budget before normalization" {
  let p = @moonclip.Point64::new(0L, 0L)
  assert_true(
    @moonclip.boolean_op([[p, p, p, p]], [], Union, limits={
      max_input_paths: 1,
      max_input_vertices: 3,
    })
    is Err(ResourceLimitExceeded(_, InputVertices, 3)),
  )
  bb_region(
    [
      [p],
      [p, p],
      [p, @moonclip.Point64::new(1L, 1L), @moonclip.Point64::new(2L, 2L)],
      [],
    ],
    [],
    Union,
    [],
  )
}

///|
test "normalized closed input and aliased operands do not share result storage" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let raw = [a[0], a[0], a[1], a[2], a[3], a[0]]
  let input = [raw]
  guard @moonclip.boolean_op(input, input, Union) is Ok(result) else {
    fail("Expected union")
  }
  assert_eq(bb_canonical(result), bb_canonical([a]))
  raw[0] = @moonclip.Point64::new(-100L, -100L)
  assert_eq(bb_canonical(result), bb_canonical([a]))
  result[0][0] = @moonclip.Point64::new(99L, 99L)
  assert_eq(input[0][1], a[0])
  bb_region([a], [a], Union, [a])
}

///|
test "coordinates at both legal boundaries are accepted by public Boolean operations" {
  let a = bb_rect(-1000000000L, -1000000000L, 2000000000L, 2000000000L)
  bb_region([a], [], Union, [a])
}

///|
test "noninteger diagonal intersections use the fixed integer conversion" {
  let a = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(9L, 0L),
      @moonclip.Point64::new(0L, 9L),
    ],
  ]
  let b = [bb_rect(2L, 2L, 6L, 6L)]
  bb_region(a, b, Intersection, [
    [
      @moonclip.Point64::new(2L, 2L),
      @moonclip.Point64::new(7L, 2L),
      @moonclip.Point64::new(2L, 7L),
    ],
  ])
}

///|
test "fractional slanted intersections truncate coordinates without tolerance" {
  let a = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(7L, 0L),
      @moonclip.Point64::new(0L, 7L),
    ],
  ]
  let b = [
    [
      @moonclip.Point64::new(0L, 1L),
      @moonclip.Point64::new(7L, 3L),
      @moonclip.Point64::new(0L, 5L),
    ],
  ]
  bb_region(a, b, Intersection, [
    [
      @moonclip.Point64::new(0L, 1L),
      @moonclip.Point64::new(4L, 2L),
      @moonclip.Point64::new(2L, 4L),
      @moonclip.Point64::new(0L, 5L),
    ],
  ])
  assert_eq(
    @moonclip.boolean_op([], [], Union, limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    }),
    Ok([]),
  )
}
