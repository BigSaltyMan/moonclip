///|
test "area promotes before positive and negative Int64 overflow" {
  assert_true(add_area_term(Small(9223372036854775807L), 1L) is Large(_))
  assert_eq(
    exact_area(add_area_term(Small(9223372036854775807L), 1L)),
    9223372036854775808N,
  )
  assert_true(add_area_term(Small(-9223372036854775808L), -1L) is Large(_))
  assert_eq(
    exact_area(add_area_term(Small(-9223372036854775808L), -1L)),
    -9223372036854775809N,
  )
  assert_true(
    add_area_term(Small(9223372036854775806L), 1L)
    is Small(9223372036854775807L),
  )
  assert_true(
    add_area_term(Small(-9223372036854775807L), -1L)
    is Small(-9223372036854775808L),
  )
}

///|
test "promoted accumulator stays promoted after cancellation" {
  let large = add_area_term(Small(9223372036854775807L), 1L)
  let cancelled = add_area_term(large, -9223372036854775807L)
  assert_true(cancelled is Large(_))
  assert_eq(exact_area(cancelled), 1N)
}

///|
test "area fast and forced exact accumulation agree" {
  let path = [
    Point64::new(-7L, -4L),
    Point64::new(9L, -4L),
    Point64::new(9L, 8L),
    Point64::new(-7L, 8L),
  ]
  let fast = accumulate_area(path, Small(0L))
  let exact = accumulate_area(path, Large(0N))
  assert_true(fast is Small(_))
  assert_true(exact is Large(_))
  assert_eq(exact_area(fast), 384N)
  assert_eq(exact_area(fast), exact_area(exact))
}

///|
test "large loop accumulation takes exact branch in both directions" {
  let a = Point64::new(-1000000000L, -1000000000L)
  let b = Point64::new(1000000000L, -1000000000L)
  let c = Point64::new(1000000000L, 1000000000L)
  let d = Point64::new(-1000000000L, 1000000000L)
  let positive = [a, b, c, d, a, b, c, d]
  let negative = [a, d, c, b, a, d, c, b]
  assert_true(accumulate_area(positive, Small(0L)) is Large(_))
  assert_true(accumulate_area(negative, Small(0L)) is Large(_))
  assert_eq(
    exact_area(accumulate_area(positive, Small(0L))),
    16000000000000000000N,
  )
  assert_eq(
    exact_area(accumulate_area(negative, Small(0L))),
    -16000000000000000000N,
  )
}

///|
test "validated determinant fits conservative eight quintillion bound" {
  let corners = [
    Point64::new(-1000000000L, -1000000000L),
    Point64::new(1000000000L, -1000000000L),
    Point64::new(1000000000L, 1000000000L),
    Point64::new(-1000000000L, 1000000000L),
  ]
  for a in corners {
    for b in corners {
      for c in corners {
        let value = cross_validated(a, b, c)
        assert_true(
          value >= -8000000000000000000L && value <= 8000000000000000000L,
        )
      }
    }
  }
}
