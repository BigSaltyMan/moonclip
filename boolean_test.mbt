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

///|
fn nz_region(
  subject : @moonclip.Paths64,
  clip : @moonclip.Paths64,
  op : @moonclip.ClipType,
  expected : @moonclip.Paths64,
) -> Unit raise {
  assert_eq(
    @moonclip.boolean_op(subject, clip, op, fill_rule=NonZero).map(bb_canonical),
    Ok(bb_canonical(expected)),
  )
}

///|
test "NonZero duplicates retain magnitude two three and seven without inner boundaries" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  for n in [2, 3, 7] {
    nz_region(Array::make(n, a), [], Union, [a])
    nz_region(Array::make(n, bb_reverse(a)), [], Union, [a])
  }
}

///|
test "NonZero opposite duplicates cancel but unequal signed multiplicities remain" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let r = bb_reverse(a)
  nz_region([a, r], [], Union, [])
  nz_region([a, a, r], [], Union, [a])
  nz_region([r, r, a], [], Union, [a])
}

///|
test "explicit EvenOdd and omitted fill rule keep identical behavior" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  for op in [@moonclip.Intersection, Union, Difference, Xor] {
    assert_eq(
      @moonclip.boolean_op([a, a], [a], op),
      @moonclip.boolean_op([a, a], [a], op, fill_rule=EvenOdd),
    )
  }
}

///|
test "NonZero partially overlapping same directions absorb interior boundaries" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let b = bb_rect(5L, 0L, 10L, 10L)
  nz_region([a, b], [], Union, [bb_rect(0L, 0L, 15L, 10L)])
  nz_region([bb_reverse(a), bb_reverse(b)], [], Union, [
    bb_rect(0L, 0L, 15L, 10L),
  ])
}

///|
test "NonZero reversing only one overlapping contour changes its region" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let b = bb_reverse(bb_rect(5L, 0L, 10L, 10L))
  nz_region([a, b], [], Union, [
    bb_rect(0L, 0L, 5L, 10L),
    bb_rect(10L, 0L, 5L, 10L),
  ])
}

///|
test "NonZero same oriented nesting has no hole while opposite nesting does" {
  let a = bb_rect(-20L, -20L, 40L, 40L)
  let b = bb_rect(-10L, -10L, 20L, 20L)
  nz_region([a, b], [], Union, [a])
  nz_region([a, bb_reverse(b)], [], Union, [a, bb_reverse(b)])
}

///|
test "NonZero four levels retain alternating hole island and inner hole" {
  let a = bb_rect(-40L, -40L, 80L, 80L)
  let b = bb_reverse(bb_rect(-30L, -30L, 60L, 60L))
  let c = bb_rect(-20L, -20L, 40L, 40L)
  let d = bb_reverse(bb_rect(-10L, -10L, 20L, 20L))
  nz_region([a, b, c, d], [], Union, [a, b, c, d])
}

///|
test "NonZero repeated operands are independently filled for all four operations" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  for
    (op, expected) in [
      (@moonclip.Intersection, [a]),
      (Union, [a]),
      (Difference, []),
      (Xor, []),
    ] {
    nz_region([a, a], [bb_reverse(a), bb_reverse(a)], op, expected)
  }
}

///|
test "NonZero Difference retains operand roles with double winding" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let b = bb_rect(5L, 0L, 10L, 10L)
  nz_region([a, a], [b, b], Difference, [bb_rect(0L, 0L, 5L, 10L)])
  nz_region([b, b], [a, a], Difference, [bb_rect(10L, 0L, 5L, 10L)])
}

///|
test "NonZero global reversal and input order preserve full contours for every operation" {
  let s = [bb_rect(0L, 0L, 10L, 10L), bb_rect(5L, 0L, 10L, 10L)]
  let c = [bb_rect(3L, -5L, 6L, 20L), bb_reverse(bb_rect(4L, -2L, 3L, 14L))]
  for op in [@moonclip.Intersection, Union, Difference, Xor] {
    let expected = @moonclip.boolean_op(s, c, op, fill_rule=NonZero).map(
      bb_canonical,
    )
    assert_true(expected is Ok(_))
    assert_eq(
      @moonclip.boolean_op(
        s.map(bb_reverse),
        c.map(bb_reverse),
        op,
        fill_rule=NonZero,
      ).map(bb_canonical),
      expected,
    )
    assert_eq(
      @moonclip.boolean_op([s[1], s[0]], [c[1], c[0]], op, fill_rule=NonZero).map(
        bb_canonical,
      ),
      expected,
    )
  }
}

///|
test "NonZero shared arrays repeated calls and result mutation preserve input isolation" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  let saved = @moonclip.copy_path(a)
  let input = [a, a]
  guard @moonclip.boolean_op(input, [], Union, fill_rule=NonZero) is Ok(first) else {
    fail("Expected NonZero region")
  }
  first[0][0] = @moonclip.Point64::new(99L, 99L)
  assert_eq(a, saved)
  nz_region(input, [], Union, [saved])
  a[0] = @moonclip.Point64::new(-1L, 0L)
  assert_eq(first[0][0], @moonclip.Point64::new(99L, 99L))
}

///|
test "NonZero combined raw input budget failure does not affect a subsequent call" {
  let a = bb_rect(0L, 0L, 10L, 10L)
  assert_true(
    @moonclip.boolean_op([a, a], [a], Union, fill_rule=NonZero, limits={
      max_input_paths: 3,
      max_input_vertices: 11,
    })
    is Err(ResourceLimitExceeded(_, InputVertices, 11)),
  )
  nz_region([a, a], [], Union, [a])
}
