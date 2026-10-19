// Generated fixed C++ MinkowskiSum geometry; preserve all collinear vertices.

///|
// Input SHA256: 0c2d0ffd99591f6733260d1ad8b5aa350afa492ca9fb24a51b84028d032ea5d3
test "reference minkowski paths: minkowski_circle_acute_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(4L, 6L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(25L, -3L),
          @moonclip.Point64::new(27L, -2L),
          @moonclip.Point64::new(28L, 0L),
          @moonclip.Point64::new(27L, 2L),
          @moonclip.Point64::new(25L, 3L),
          @moonclip.Point64::new(4L, 9L),
          @moonclip.Point64::new(2L, 8L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: fb8b3ad11e1f576935a17649ce1273aa198f18bff487e2f7d4f8c1f18adcfa99
test "reference minkowski paths: minkowski_circle_acute_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(4L, 6L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(25L, -3L),
          @moonclip.Point64::new(27L, -2L),
          @moonclip.Point64::new(28L, 0L),
          @moonclip.Point64::new(27L, 2L),
          @moonclip.Point64::new(25L, 3L),
          @moonclip.Point64::new(4L, 9L),
          @moonclip.Point64::new(2L, 8L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 6e6ccb11f47000328c62a02ef8ea4f24bc6025c8bc4e71a86435ba67ec072eff
test "reference minkowski paths: minkowski_circle_acute_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(4L, 6L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(25L, -3L),
          @moonclip.Point64::new(27L, -2L),
          @moonclip.Point64::new(28L, 0L),
          @moonclip.Point64::new(27L, 2L),
          @moonclip.Point64::new(25L, 3L),
          @moonclip.Point64::new(4L, 9L),
          @moonclip.Point64::new(2L, 8L),
          @moonclip.Point64::new(1L, 6L),
          @moonclip.Point64::new(2L, 4L),
          @moonclip.Point64::new(4L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: bead5db30b8142f2b57e82861c5c3b46298ba0d282dc2580e8d3dcf8c2a70f2d
test "reference minkowski paths: minkowski_circle_acute_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(4L, 6L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(25L, -3L),
          @moonclip.Point64::new(27L, -2L),
          @moonclip.Point64::new(28L, 0L),
          @moonclip.Point64::new(27L, 2L),
          @moonclip.Point64::new(25L, 3L),
          @moonclip.Point64::new(4L, 9L),
          @moonclip.Point64::new(2L, 8L),
          @moonclip.Point64::new(1L, 6L),
          @moonclip.Point64::new(2L, 4L),
          @moonclip.Point64::new(4L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 6f0424abd3c6c2a66a8b377b47bcea12e03b33aa4ddb991d5943749194d8d650
test "reference minkowski paths: minkowski_circle_diagonal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 13L),
          @moonclip.Point64::new(23L, 15L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(20L, 18L),
          @moonclip.Point64::new(18L, 17L),
          @moonclip.Point64::new(-12L, -3L),
          @moonclip.Point64::new(-13L, -5L),
          @moonclip.Point64::new(-12L, -7L),
          @moonclip.Point64::new(-10L, -8L),
          @moonclip.Point64::new(-8L, -7L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 3ebe05db513895f00bb0c908ed5f2844e8f7695716b3eef5ef53ce37c46a0131
test "reference minkowski paths: minkowski_circle_diagonal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(20L, 15L), @moonclip.Point64::new(-10L, -5L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 13L),
          @moonclip.Point64::new(23L, 15L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(20L, 18L),
          @moonclip.Point64::new(18L, 17L),
          @moonclip.Point64::new(-12L, -3L),
          @moonclip.Point64::new(-13L, -5L),
          @moonclip.Point64::new(-12L, -7L),
          @moonclip.Point64::new(-10L, -8L),
          @moonclip.Point64::new(-8L, -7L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 717bc7480b21d98fc2c854ee8d9d0852d6741f6f0b097a5c8b647b03dd32fba6
test "reference minkowski paths: minkowski_circle_diagonal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 13L),
          @moonclip.Point64::new(23L, 15L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(20L, 18L),
          @moonclip.Point64::new(18L, 17L),
          @moonclip.Point64::new(-12L, -3L),
          @moonclip.Point64::new(-13L, -5L),
          @moonclip.Point64::new(-12L, -7L),
          @moonclip.Point64::new(-10L, -8L),
          @moonclip.Point64::new(-8L, -7L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c74fade725cf0dcb9745a36c0a84b18ce9afba11260657031993a0bd53df25c6
test "reference minkowski paths: minkowski_circle_diagonal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(20L, 15L), @moonclip.Point64::new(-10L, -5L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 13L),
          @moonclip.Point64::new(23L, 15L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(20L, 18L),
          @moonclip.Point64::new(18L, 17L),
          @moonclip.Point64::new(-12L, -3L),
          @moonclip.Point64::new(-13L, -5L),
          @moonclip.Point64::new(-12L, -7L),
          @moonclip.Point64::new(-10L, -8L),
          @moonclip.Point64::new(-8L, -7L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c9dddca226a105b31450376cddb3ba00ecf6699056ea43645136d5f28c88731e
test "reference minkowski paths: minkowski_circle_long_horizontal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(30L, -3L),
          @moonclip.Point64::new(32L, -2L),
          @moonclip.Point64::new(33L, 0L),
          @moonclip.Point64::new(32L, 2L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ca4666b32da69e6701e2bba4414f7e6fd9af78318f7f73a23632121b7488a372
test "reference minkowski paths: minkowski_circle_long_horizontal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(30L, 0L), @moonclip.Point64::new(0L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(30L, -3L),
          @moonclip.Point64::new(32L, -2L),
          @moonclip.Point64::new(33L, 0L),
          @moonclip.Point64::new(32L, 2L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ecc13f2d49f89842c8a6dd863fe73bab73af606b94035089081d1452691da3bd
test "reference minkowski paths: minkowski_circle_long_horizontal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(30L, -3L),
          @moonclip.Point64::new(32L, -2L),
          @moonclip.Point64::new(33L, 0L),
          @moonclip.Point64::new(32L, 2L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 252cf2b6f82e97edb85cca71f2b2c4303e9c36f93f2c74d4d017d5b4463b50f4
test "reference minkowski paths: minkowski_circle_long_horizontal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(30L, 0L), @moonclip.Point64::new(0L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(30L, -3L),
          @moonclip.Point64::new(32L, -2L),
          @moonclip.Point64::new(33L, 0L),
          @moonclip.Point64::new(32L, 2L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 29cab977c546b40b6cf6e1407e4c5340d064d1a02ab0e59a4b1129741d13f97e
test "reference minkowski paths: minkowski_circle_rectangle_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, -3L),
          @moonclip.Point64::new(32L, -2L),
          @moonclip.Point64::new(33L, 0L),
          @moonclip.Point64::new(33L, 20L),
          @moonclip.Point64::new(32L, 22L),
          @moonclip.Point64::new(30L, 23L),
          @moonclip.Point64::new(0L, 23L),
          @moonclip.Point64::new(-2L, 22L),
          @moonclip.Point64::new(-3L, 20L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
        [
          @moonclip.Point64::new(3L, 3L),
          @moonclip.Point64::new(3L, 17L),
          @moonclip.Point64::new(27L, 17L),
          @moonclip.Point64::new(27L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 7e1bd81874be5123171a0817e81f19ae7164e218a00c084b26d5ff0e6d271891
test "reference minkowski paths: minkowski_circle_rectangle_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, -3L),
          @moonclip.Point64::new(32L, -2L),
          @moonclip.Point64::new(33L, 0L),
          @moonclip.Point64::new(33L, 20L),
          @moonclip.Point64::new(32L, 22L),
          @moonclip.Point64::new(30L, 23L),
          @moonclip.Point64::new(0L, 23L),
          @moonclip.Point64::new(-2L, 22L),
          @moonclip.Point64::new(-3L, 20L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
        [
          @moonclip.Point64::new(3L, 3L),
          @moonclip.Point64::new(3L, 17L),
          @moonclip.Point64::new(27L, 17L),
          @moonclip.Point64::new(27L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: f42551f1a75ac3e3b41c4ebfd1798dc2a59da5bac3eab55c852f5f9252cd64d8
test "reference minkowski paths: minkowski_circle_rectangle_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, -3L),
          @moonclip.Point64::new(32L, -2L),
          @moonclip.Point64::new(33L, 0L),
          @moonclip.Point64::new(33L, 20L),
          @moonclip.Point64::new(32L, 22L),
          @moonclip.Point64::new(30L, 23L),
          @moonclip.Point64::new(0L, 23L),
          @moonclip.Point64::new(-2L, 22L),
          @moonclip.Point64::new(-3L, 20L),
          @moonclip.Point64::new(-2L, 18L),
          @moonclip.Point64::new(0L, 17L),
          @moonclip.Point64::new(27L, 17L),
          @moonclip.Point64::new(27L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 639867dbff66115d15a9ac98eda5408ae92dc69c3570f86d2e96a4d02917a0f3
test "reference minkowski paths: minkowski_circle_rectangle_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, -3L),
          @moonclip.Point64::new(32L, -2L),
          @moonclip.Point64::new(33L, 0L),
          @moonclip.Point64::new(33L, 20L),
          @moonclip.Point64::new(32L, 22L),
          @moonclip.Point64::new(30L, 23L),
          @moonclip.Point64::new(0L, 23L),
          @moonclip.Point64::new(-2L, 22L),
          @moonclip.Point64::new(-3L, 20L),
          @moonclip.Point64::new(-2L, 18L),
          @moonclip.Point64::new(0L, 17L),
          @moonclip.Point64::new(27L, 17L),
          @moonclip.Point64::new(27L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 8c995bb67c75123c86d29f295d76aec324b1a288858b7f0c347730f6b4acedce
test "reference minkowski paths: minkowski_circle_repeats_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(18L, 22L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 3L),
          @moonclip.Point64::new(17L, 13L),
          @moonclip.Point64::new(17L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 9dbfb3d5b99c7ada53257b023f2fef9113236289b1fb2609bff0d2cd0f5cf65d
test "reference minkowski paths: minkowski_circle_repeats_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(18L, 22L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 3L),
          @moonclip.Point64::new(17L, 13L),
          @moonclip.Point64::new(17L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c9a69f7eca2180593f81528de8e42ee922624ab9bed023af82a76f5229346f7c
test "reference minkowski paths: minkowski_circle_repeats_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(18L, 22L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 3L),
          @moonclip.Point64::new(17L, 13L),
          @moonclip.Point64::new(17L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 6669c24b98c376bf1245d57c3a34f6ac67a758c8f96af22bbfcce42e5ea0910f
test "reference minkowski paths: minkowski_circle_repeats_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(18L, 22L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 3L),
          @moonclip.Point64::new(17L, 13L),
          @moonclip.Point64::new(17L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 9018140bc483c48eda3faf0ffa0f3c63ee0563716bfc33e49e46f998555a18c5
test "reference minkowski paths: minkowski_circle_retrace_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(5L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(22L, 2L),
          @moonclip.Point64::new(20L, 3L),
          @moonclip.Point64::new(8L, 3L),
          @moonclip.Point64::new(8L, 20L),
          @moonclip.Point64::new(7L, 22L),
          @moonclip.Point64::new(5L, 23L),
          @moonclip.Point64::new(3L, 22L),
          @moonclip.Point64::new(2L, 20L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: d345bb94231570f92c2eada98e1b1f832e8c1e1091c2ca77177c526e0de00c75
test "reference minkowski paths: minkowski_circle_retrace_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(5L, 20L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(22L, 2L),
          @moonclip.Point64::new(20L, 3L),
          @moonclip.Point64::new(8L, 3L),
          @moonclip.Point64::new(8L, 20L),
          @moonclip.Point64::new(7L, 22L),
          @moonclip.Point64::new(5L, 23L),
          @moonclip.Point64::new(3L, 22L),
          @moonclip.Point64::new(2L, 20L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 058bf78bd5a2805306d08322193eeec9d43b1c9832cb16c535ae8c49b2b0cd51
test "reference minkowski paths: minkowski_circle_retrace_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(5L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(22L, 2L),
          @moonclip.Point64::new(20L, 3L),
          @moonclip.Point64::new(8L, 3L),
          @moonclip.Point64::new(8L, 20L),
          @moonclip.Point64::new(7L, 22L),
          @moonclip.Point64::new(5L, 23L),
          @moonclip.Point64::new(3L, 22L),
          @moonclip.Point64::new(2L, 20L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 56ef7a9eb90e9abcf054d67a170811a5ae648663cbc1c01c6b27265466454499
test "reference minkowski paths: minkowski_circle_retrace_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(5L, 20L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(22L, 2L),
          @moonclip.Point64::new(20L, 3L),
          @moonclip.Point64::new(8L, 3L),
          @moonclip.Point64::new(8L, 20L),
          @moonclip.Point64::new(7L, 22L),
          @moonclip.Point64::new(5L, 23L),
          @moonclip.Point64::new(3L, 22L),
          @moonclip.Point64::new(2L, 20L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 6f9dd1d440fc8a57c2e528b911cb393b043d01a29ddde00802d9b98b253160f7
test "reference minkowski paths: minkowski_circle_right_angle_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(18L, 22L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 3L),
          @moonclip.Point64::new(17L, 13L),
          @moonclip.Point64::new(17L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: da515aaffa30c988ea77d8b3d35c8e9d7d40fd19bb5cbf5fe687c897c31b26df
test "reference minkowski paths: minkowski_circle_right_angle_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(18L, 22L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 3L),
          @moonclip.Point64::new(17L, 13L),
          @moonclip.Point64::new(17L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 526e0e5bdb08b31aa6c239ef8fa0cb9cce53292eb6c41aadcce06cfaf79894ee
test "reference minkowski paths: minkowski_circle_right_angle_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(18L, 22L),
          @moonclip.Point64::new(17L, 20L),
          @moonclip.Point64::new(17L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 9029c387577da5293825bd32374c7428bfe5d642687730059adaa22d26127d57
test "reference minkowski paths: minkowski_circle_right_angle_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, -3L),
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(23L, 0L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(18L, 22L),
          @moonclip.Point64::new(17L, 20L),
          @moonclip.Point64::new(17L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: e1ea322da1ad3c6e0a398fdf14dd30f66e3b1fa6a875d45fdc7502ee02e1511d
test "reference minkowski paths: minkowski_circle_selfcross_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 10L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(32L, 8L),
          @moonclip.Point64::new(33L, 10L),
          @moonclip.Point64::new(32L, 12L),
          @moonclip.Point64::new(30L, 13L),
          @moonclip.Point64::new(15L, 8L),
          @moonclip.Point64::new(14L, 10L),
          @moonclip.Point64::new(22L, 18L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(0L, 23L),
          @moonclip.Point64::new(-2L, 22L),
          @moonclip.Point64::new(-3L, 20L),
          @moonclip.Point64::new(-2L, 18L),
          @moonclip.Point64::new(6L, 10L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(14L, 1L),
          @moonclip.Point64::new(18L, -2L),
          @moonclip.Point64::new(20L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 17L),
          @moonclip.Point64::new(13L, 17L),
          @moonclip.Point64::new(10L, 14L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 3b4a2b9519c794afcf820477fabb77d8f2d093e995ec71255dcbf7b03ca7360e
test "reference minkowski paths: minkowski_circle_selfcross_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(32L, 8L),
          @moonclip.Point64::new(33L, 10L),
          @moonclip.Point64::new(32L, 12L),
          @moonclip.Point64::new(30L, 13L),
          @moonclip.Point64::new(15L, 8L),
          @moonclip.Point64::new(14L, 10L),
          @moonclip.Point64::new(22L, 18L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(0L, 23L),
          @moonclip.Point64::new(-2L, 22L),
          @moonclip.Point64::new(-3L, 20L),
          @moonclip.Point64::new(-2L, 18L),
          @moonclip.Point64::new(6L, 10L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(14L, 1L),
          @moonclip.Point64::new(18L, -2L),
          @moonclip.Point64::new(20L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 17L),
          @moonclip.Point64::new(13L, 17L),
          @moonclip.Point64::new(10L, 14L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ddec04127c3b4defece6c66a2815d8c44a0051336ea357bf314175b8469d2b3f
test "reference minkowski paths: minkowski_circle_selfcross_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 10L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(32L, 8L),
          @moonclip.Point64::new(33L, 10L),
          @moonclip.Point64::new(32L, 12L),
          @moonclip.Point64::new(30L, 13L),
          @moonclip.Point64::new(28L, 12L),
          @moonclip.Point64::new(20L, 4L),
          @moonclip.Point64::new(14L, 10L),
          @moonclip.Point64::new(22L, 18L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(0L, 23L),
          @moonclip.Point64::new(-2L, 22L),
          @moonclip.Point64::new(-3L, 20L),
          @moonclip.Point64::new(-2L, 18L),
          @moonclip.Point64::new(6L, 10L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(2L, -2L),
          @moonclip.Point64::new(10L, 6L),
          @moonclip.Point64::new(18L, -2L),
          @moonclip.Point64::new(20L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 17L),
          @moonclip.Point64::new(13L, 17L),
          @moonclip.Point64::new(10L, 14L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 2d20aa4bceecb5639b960a4e16f5029535dbb9a2d5959d9cf4ed2be7063c8adc
test "reference minkowski paths: minkowski_circle_selfcross_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, -2L),
          @moonclip.Point64::new(32L, 8L),
          @moonclip.Point64::new(33L, 10L),
          @moonclip.Point64::new(32L, 12L),
          @moonclip.Point64::new(30L, 13L),
          @moonclip.Point64::new(28L, 12L),
          @moonclip.Point64::new(20L, 4L),
          @moonclip.Point64::new(14L, 10L),
          @moonclip.Point64::new(22L, 18L),
          @moonclip.Point64::new(23L, 20L),
          @moonclip.Point64::new(22L, 22L),
          @moonclip.Point64::new(20L, 23L),
          @moonclip.Point64::new(0L, 23L),
          @moonclip.Point64::new(-2L, 22L),
          @moonclip.Point64::new(-3L, 20L),
          @moonclip.Point64::new(-2L, 18L),
          @moonclip.Point64::new(6L, 10L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(2L, -2L),
          @moonclip.Point64::new(10L, 6L),
          @moonclip.Point64::new(18L, -2L),
          @moonclip.Point64::new(20L, -3L),
        ],
        [
          @moonclip.Point64::new(7L, 17L),
          @moonclip.Point64::new(13L, 17L),
          @moonclip.Point64::new(10L, 14L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 1c69fb11e387035ddebdf8baef273076acc14d9c0c19577709ae3c853f6cab2e
test "reference minkowski paths: minkowski_circle_short_horizontal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, 2L),
          @moonclip.Point64::new(2L, 2L),
          @moonclip.Point64::new(3L, 0L),
          @moonclip.Point64::new(2L, -2L),
          @moonclip.Point64::new(0L, -2L),
          @moonclip.Point64::new(-1L, -2L),
          @moonclip.Point64::new(-2L, 0L),
          @moonclip.Point64::new(-1L, 2L),
        ],
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(3L, 2L),
          @moonclip.Point64::new(1L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(1L, -3L),
          @moonclip.Point64::new(3L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 50d5169dedd9a0a35120f6187c49a1db40973c1949314a760e9218df34340e14
test "reference minkowski paths: minkowski_circle_short_horizontal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(0L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, 2L),
          @moonclip.Point64::new(2L, 2L),
          @moonclip.Point64::new(3L, 0L),
          @moonclip.Point64::new(2L, -2L),
          @moonclip.Point64::new(0L, -2L),
          @moonclip.Point64::new(-1L, -2L),
          @moonclip.Point64::new(-2L, 0L),
          @moonclip.Point64::new(-1L, 2L),
        ],
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(3L, 2L),
          @moonclip.Point64::new(1L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(1L, -3L),
          @moonclip.Point64::new(3L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 863c300a428f6d5eea8773a7ca8a55dd858bdd66373129e69323c2aaefcd50ed
test "reference minkowski paths: minkowski_circle_short_horizontal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, 2L),
          @moonclip.Point64::new(2L, 2L),
          @moonclip.Point64::new(3L, 0L),
          @moonclip.Point64::new(2L, -2L),
          @moonclip.Point64::new(0L, -2L),
          @moonclip.Point64::new(-1L, -2L),
          @moonclip.Point64::new(-2L, 0L),
          @moonclip.Point64::new(-1L, 2L),
        ],
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(3L, 2L),
          @moonclip.Point64::new(1L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(1L, -3L),
          @moonclip.Point64::new(3L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c74c834f50a9015106e04be4bda17554fb6749c8470c4314774987c620142686
test "reference minkowski paths: minkowski_circle_short_horizontal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(3L, 0L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(-2L, 2L),
        @moonclip.Point64::new(-3L, 0L),
        @moonclip.Point64::new(-2L, -2L),
        @moonclip.Point64::new(0L, -3L),
        @moonclip.Point64::new(2L, -2L),
      ],
      [@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(0L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, 2L),
          @moonclip.Point64::new(2L, 2L),
          @moonclip.Point64::new(3L, 0L),
          @moonclip.Point64::new(2L, -2L),
          @moonclip.Point64::new(0L, -2L),
          @moonclip.Point64::new(-1L, -2L),
          @moonclip.Point64::new(-2L, 0L),
          @moonclip.Point64::new(-1L, 2L),
        ],
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(3L, 2L),
          @moonclip.Point64::new(1L, 3L),
          @moonclip.Point64::new(0L, 3L),
          @moonclip.Point64::new(-2L, 2L),
          @moonclip.Point64::new(-3L, 0L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(0L, -3L),
          @moonclip.Point64::new(1L, -3L),
          @moonclip.Point64::new(3L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 610e64935ca7425e6ab86a203b41b80f63aeb3fff423a134104342213378e57d
test "reference minkowski paths: minkowski_concave_acute_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(4L, 6L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(25L, 0L),
          @moonclip.Point64::new(29L, 0L),
          @moonclip.Point64::new(29L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 4L),
          @moonclip.Point64::new(5L, 10L),
          @moonclip.Point64::new(4L, 10L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 9fdb6f45852a708573abfca7e796a89cae8a898d63859d46f860249cf9e46e96
test "reference minkowski paths: minkowski_concave_acute_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(4L, 6L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(25L, 0L),
          @moonclip.Point64::new(29L, 0L),
          @moonclip.Point64::new(29L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 4L),
          @moonclip.Point64::new(5L, 10L),
          @moonclip.Point64::new(4L, 10L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ca88601e8adf791dae344e5bceae14fb542340c13097deaa2a4895517d8234a8
test "reference minkowski paths: minkowski_concave_acute_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(4L, 6L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(25L, 0L),
          @moonclip.Point64::new(29L, 0L),
          @moonclip.Point64::new(29L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 4L),
          @moonclip.Point64::new(5L, 10L),
          @moonclip.Point64::new(4L, 10L),
          @moonclip.Point64::new(4L, 6L),
          @moonclip.Point64::new(11L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: d01ac3884f53ba8f29f2424cd780930c6aa14ec8febbea3670f12b1ecd060b52
test "reference minkowski paths: minkowski_concave_acute_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(4L, 6L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(25L, 0L),
          @moonclip.Point64::new(29L, 0L),
          @moonclip.Point64::new(29L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 4L),
          @moonclip.Point64::new(5L, 10L),
          @moonclip.Point64::new(4L, 10L),
          @moonclip.Point64::new(4L, 6L),
          @moonclip.Point64::new(11L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: b7597433f7402922436cae56d37c43de83fad261392045f1fc7dc3a485c34ea0
test "reference minkowski paths: minkowski_concave_diagonal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-6L, -5L),
          @moonclip.Point64::new(24L, 15L),
          @moonclip.Point64::new(24L, 16L),
          @moonclip.Point64::new(21L, 16L),
          @moonclip.Point64::new(21L, 19L),
          @moonclip.Point64::new(20L, 19L),
          @moonclip.Point64::new(-10L, -1L),
          @moonclip.Point64::new(-10L, -5L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 20ccbf0cfb7d8b1ba924bd90ad5a6ef013834ef60e3619803633ffbb83d5c245
test "reference minkowski paths: minkowski_concave_diagonal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(20L, 15L), @moonclip.Point64::new(-10L, -5L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-6L, -5L),
          @moonclip.Point64::new(24L, 15L),
          @moonclip.Point64::new(24L, 16L),
          @moonclip.Point64::new(21L, 16L),
          @moonclip.Point64::new(21L, 19L),
          @moonclip.Point64::new(20L, 19L),
          @moonclip.Point64::new(-10L, -1L),
          @moonclip.Point64::new(-10L, -5L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: d64f933ced761e23c30f4ffe838cde6eec751453616508c36586e0071e42d6b0
test "reference minkowski paths: minkowski_concave_diagonal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-6L, -5L),
          @moonclip.Point64::new(24L, 15L),
          @moonclip.Point64::new(24L, 16L),
          @moonclip.Point64::new(21L, 16L),
          @moonclip.Point64::new(21L, 19L),
          @moonclip.Point64::new(20L, 19L),
          @moonclip.Point64::new(-10L, -1L),
          @moonclip.Point64::new(-10L, -5L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 94af347b18fc16687aac5e8a7bc042aecf14a7fa4dfc0c6b233c599365ac9a85
test "reference minkowski paths: minkowski_concave_diagonal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(20L, 15L), @moonclip.Point64::new(-10L, -5L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-6L, -5L),
          @moonclip.Point64::new(24L, 15L),
          @moonclip.Point64::new(24L, 16L),
          @moonclip.Point64::new(21L, 16L),
          @moonclip.Point64::new(21L, 19L),
          @moonclip.Point64::new(20L, 19L),
          @moonclip.Point64::new(-10L, -1L),
          @moonclip.Point64::new(-10L, -5L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 90996ced0f9a01bbb34c196520e7d2f696a1a07ebbef7ff130329df0d9859adc
test "reference minkowski paths: minkowski_concave_long_horizontal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(34L, 0L),
          @moonclip.Point64::new(34L, 1L),
          @moonclip.Point64::new(31L, 1L),
          @moonclip.Point64::new(31L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 35fc6dfbedf8125ae1a9263a40b04576ae2aaf883b254a7042341659ea64a99e
test "reference minkowski paths: minkowski_concave_long_horizontal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(30L, 0L), @moonclip.Point64::new(0L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(34L, 0L),
          @moonclip.Point64::new(34L, 1L),
          @moonclip.Point64::new(31L, 1L),
          @moonclip.Point64::new(31L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: fec119a3bcbb37b59f581f2f21c7408e1b75a6175379b5566fe20fec909b1b63
test "reference minkowski paths: minkowski_concave_long_horizontal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(34L, 0L),
          @moonclip.Point64::new(34L, 1L),
          @moonclip.Point64::new(31L, 1L),
          @moonclip.Point64::new(31L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 2481306c993bb3adac30a0069999d3f85ae8f661494e3e1a74679e166310be3f
test "reference minkowski paths: minkowski_concave_long_horizontal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(30L, 0L), @moonclip.Point64::new(0L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(34L, 0L),
          @moonclip.Point64::new(34L, 1L),
          @moonclip.Point64::new(31L, 1L),
          @moonclip.Point64::new(31L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 00522882ffa3c539fbf2bfc692c495eb71bce909ede9100e0995b8f13d9d5bad
test "reference minkowski paths: minkowski_concave_rectangle_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(34L, 0L),
          @moonclip.Point64::new(34L, 1L),
          @moonclip.Point64::new(34L, 21L),
          @moonclip.Point64::new(31L, 21L),
          @moonclip.Point64::new(31L, 24L),
          @moonclip.Point64::new(30L, 24L),
          @moonclip.Point64::new(1L, 24L),
          @moonclip.Point64::new(0L, 24L),
          @moonclip.Point64::new(0L, 20L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(30L, 4L),
          @moonclip.Point64::new(4L, 4L),
          @moonclip.Point64::new(4L, 20L),
          @moonclip.Point64::new(30L, 20L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 5aff07927e7aa6048387f08c8beccdf8b079494c78fb6857bf1925b50f467cb4
test "reference minkowski paths: minkowski_concave_rectangle_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(34L, 0L),
          @moonclip.Point64::new(34L, 20L),
          @moonclip.Point64::new(34L, 21L),
          @moonclip.Point64::new(31L, 21L),
          @moonclip.Point64::new(31L, 24L),
          @moonclip.Point64::new(30L, 24L),
          @moonclip.Point64::new(1L, 24L),
          @moonclip.Point64::new(0L, 24L),
          @moonclip.Point64::new(0L, 20L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(30L, 4L),
          @moonclip.Point64::new(4L, 4L),
          @moonclip.Point64::new(4L, 20L),
          @moonclip.Point64::new(30L, 20L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: a86d3f7896ba9f3f01e0d5eeb612f7775610b906b75bdd0055da20eebab6c3ea
test "reference minkowski paths: minkowski_concave_rectangle_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(34L, 0L),
          @moonclip.Point64::new(34L, 1L),
          @moonclip.Point64::new(34L, 21L),
          @moonclip.Point64::new(31L, 21L),
          @moonclip.Point64::new(31L, 24L),
          @moonclip.Point64::new(30L, 24L),
          @moonclip.Point64::new(1L, 24L),
          @moonclip.Point64::new(0L, 24L),
          @moonclip.Point64::new(0L, 20L),
          @moonclip.Point64::new(30L, 20L),
          @moonclip.Point64::new(30L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 741c30230357e65b4476b686d95e20fd78eff8f276ac1691ae066696814def09
test "reference minkowski paths: minkowski_concave_rectangle_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(34L, 0L),
          @moonclip.Point64::new(34L, 20L),
          @moonclip.Point64::new(34L, 21L),
          @moonclip.Point64::new(31L, 21L),
          @moonclip.Point64::new(31L, 24L),
          @moonclip.Point64::new(30L, 24L),
          @moonclip.Point64::new(1L, 24L),
          @moonclip.Point64::new(0L, 24L),
          @moonclip.Point64::new(0L, 20L),
          @moonclip.Point64::new(30L, 20L),
          @moonclip.Point64::new(30L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c2b652400f8d34d9e9d62d9f0bf5a8215a8a14789dede35ae9a0001766261bb4
test "reference minkowski paths: minkowski_concave_repeats_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(8L, 4L),
          @moonclip.Point64::new(20L, 16L),
          @moonclip.Point64::new(20L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c3b20e05864267fa0f20a8b62cb9b105bcac8a446ccb93d34e16650a2b55edf8
test "reference minkowski paths: minkowski_concave_repeats_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(8L, 4L),
          @moonclip.Point64::new(20L, 16L),
          @moonclip.Point64::new(20L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: eec9af240ba551a8bc65854f6fd1bcb3c248eaaa547f00176b2096f47de99df5
test "reference minkowski paths: minkowski_concave_repeats_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(8L, 4L),
          @moonclip.Point64::new(20L, 16L),
          @moonclip.Point64::new(20L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 104f98aeb7487581a08279e75d85b5010af75b84251a9a2b459ff15b159bee1a
test "reference minkowski paths: minkowski_concave_repeats_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(8L, 4L),
          @moonclip.Point64::new(20L, 16L),
          @moonclip.Point64::new(20L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: efd2244c6d0998ffb0658c0613e9ac201c1ed13d759ed65496e0ffa12aa216fe
test "reference minkowski paths: minkowski_concave_retrace_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(5L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(21L, 1L),
          @moonclip.Point64::new(21L, 4L),
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(9L, 20L),
          @moonclip.Point64::new(9L, 21L),
          @moonclip.Point64::new(6L, 21L),
          @moonclip.Point64::new(6L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 8ae6873b0ff99a7ce7e3e7fafc020cc3f07007881bfdfc1ee227fd7847a6d952
test "reference minkowski paths: minkowski_concave_retrace_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(5L, 20L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(21L, 1L),
          @moonclip.Point64::new(21L, 4L),
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(9L, 20L),
          @moonclip.Point64::new(9L, 21L),
          @moonclip.Point64::new(6L, 21L),
          @moonclip.Point64::new(6L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 40c09423345f31e618d19f620df7703fca5c83ef674e1855548b528b07514ae0
test "reference minkowski paths: minkowski_concave_retrace_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(5L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(21L, 1L),
          @moonclip.Point64::new(21L, 4L),
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(9L, 21L),
          @moonclip.Point64::new(6L, 21L),
          @moonclip.Point64::new(6L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(5L, 20L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 5d2a4a2779592cc60ef2da5f3247bd77a7173d3a6ebddf002c96f9b07bbe5e17
test "reference minkowski paths: minkowski_concave_retrace_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(5L, 20L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(21L, 1L),
          @moonclip.Point64::new(21L, 4L),
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(9L, 20L),
          @moonclip.Point64::new(9L, 21L),
          @moonclip.Point64::new(6L, 21L),
          @moonclip.Point64::new(6L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(5L, 20L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 0da4d4b28883b816b2a731a217db9b6d9e518830ab70d93f68a2047298e066de
test "reference minkowski paths: minkowski_concave_right_angle_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(8L, 4L),
          @moonclip.Point64::new(20L, 16L),
          @moonclip.Point64::new(20L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: a73d22ea06db7d5735f4f1c02c7b24a6a2d164693594bc8b0ce1a2f4ecd35e56
test "reference minkowski paths: minkowski_concave_right_angle_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(8L, 4L),
          @moonclip.Point64::new(20L, 16L),
          @moonclip.Point64::new(20L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: e8c81ea55c892dd783cb50c659a469b8808ed5450f1b1fd4af7c55a8482f8943
test "reference minkowski paths: minkowski_concave_right_angle_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 1L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(20L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 3f2636c9ab3efe06ca5aae2ca3c3fe21cc18478b32fc8c52eb52b179c1a639f6
test "reference minkowski paths: minkowski_concave_right_angle_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(20L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 1990756c34012e805fc7e27926b4c7b121f255efd9b747d380527181b2d301b4
test "reference minkowski paths: minkowski_concave_selfcross_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 10L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(16L, 4L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(34L, 10L),
          @moonclip.Point64::new(34L, 11L),
          @moonclip.Point64::new(31L, 11L),
          @moonclip.Point64::new(31L, 14L),
          @moonclip.Point64::new(30L, 14L),
          @moonclip.Point64::new(15L, 9L),
          @moonclip.Point64::new(14L, 10L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(1L, 24L),
          @moonclip.Point64::new(0L, 24L),
          @moonclip.Point64::new(0L, 20L),
          @moonclip.Point64::new(8L, 12L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(5L, 20L),
          @moonclip.Point64::new(16L, 20L),
          @moonclip.Point64::new(10L, 14L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: fd5dc8392ff1977ce20a83208a21ed77225a89aa500fd5361cbb8b26c6d19dfa
test "reference minkowski paths: minkowski_concave_selfcross_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(16L, 4L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(34L, 10L),
          @moonclip.Point64::new(34L, 11L),
          @moonclip.Point64::new(31L, 11L),
          @moonclip.Point64::new(31L, 14L),
          @moonclip.Point64::new(30L, 14L),
          @moonclip.Point64::new(15L, 9L),
          @moonclip.Point64::new(14L, 10L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(1L, 24L),
          @moonclip.Point64::new(0L, 24L),
          @moonclip.Point64::new(0L, 20L),
          @moonclip.Point64::new(8L, 12L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(5L, 20L),
          @moonclip.Point64::new(16L, 20L),
          @moonclip.Point64::new(10L, 14L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 6491c5e8e1c357b61f17524575b9a72e28c164f9b3c1e919fe9c61af5581647a
test "reference minkowski paths: minkowski_concave_selfcross_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 10L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(12L, 8L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(34L, 10L),
          @moonclip.Point64::new(34L, 11L),
          @moonclip.Point64::new(31L, 11L),
          @moonclip.Point64::new(31L, 14L),
          @moonclip.Point64::new(30L, 14L),
          @moonclip.Point64::new(20L, 4L),
          @moonclip.Point64::new(14L, 10L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(1L, 24L),
          @moonclip.Point64::new(0L, 24L),
          @moonclip.Point64::new(0L, 20L),
          @moonclip.Point64::new(8L, 12L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(5L, 20L),
          @moonclip.Point64::new(16L, 20L),
          @moonclip.Point64::new(10L, 14L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: dd6c1df6cc8fc2fa9edd463fc3465311268c2ecacf153ede9a7c89811eb9af11
test "reference minkowski paths: minkowski_concave_selfcross_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(12L, 8L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(34L, 10L),
          @moonclip.Point64::new(34L, 11L),
          @moonclip.Point64::new(31L, 11L),
          @moonclip.Point64::new(31L, 14L),
          @moonclip.Point64::new(30L, 14L),
          @moonclip.Point64::new(20L, 4L),
          @moonclip.Point64::new(14L, 10L),
          @moonclip.Point64::new(24L, 20L),
          @moonclip.Point64::new(24L, 21L),
          @moonclip.Point64::new(21L, 21L),
          @moonclip.Point64::new(21L, 24L),
          @moonclip.Point64::new(20L, 24L),
          @moonclip.Point64::new(1L, 24L),
          @moonclip.Point64::new(0L, 24L),
          @moonclip.Point64::new(0L, 20L),
          @moonclip.Point64::new(8L, 12L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
        ],
        [
          @moonclip.Point64::new(5L, 20L),
          @moonclip.Point64::new(16L, 20L),
          @moonclip.Point64::new(10L, 14L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ca96408d2bf376111c73300fe49c8ec4812fb9f091582675fd636a8718dd67d1
test "reference minkowski paths: minkowski_concave_short_horizontal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(1L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(1L, 0L),
        ],
        [
          @moonclip.Point64::new(5L, 1L),
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(5L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: b14518888b73b8b253989ca17ab4de708403e4a891464a6fe97b442bfd18da81
test "reference minkowski paths: minkowski_concave_short_horizontal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(0L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(1L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(1L, 0L),
        ],
        [
          @moonclip.Point64::new(5L, 1L),
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(5L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ba14e0cc97b1eb23ffcc953c2b3071ca07661e236c560ab8f5d75c617f673366
test "reference minkowski paths: minkowski_concave_short_horizontal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(1L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(1L, 0L),
        ],
        [
          @moonclip.Point64::new(5L, 1L),
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(5L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 43b29f9b27cdf3fa2e56c17ed2a76888a07a42ebd2b54999a70bff1f39f34c5d
test "reference minkowski paths: minkowski_concave_short_horizontal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(4L, 1L),
        @moonclip.Point64::new(1L, 1L),
        @moonclip.Point64::new(1L, 4L),
        @moonclip.Point64::new(0L, 4L),
      ],
      [@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(0L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(1L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(0L, 4L),
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(1L, 0L),
        ],
        [
          @moonclip.Point64::new(5L, 1L),
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(4L, 0L),
          @moonclip.Point64::new(5L, 0L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 9bcd2bf705a59782bd09553dcd1f0128132873df1269a0dfb77c796b33a6a338
test "reference minkowski paths: minkowski_offcenter_acute_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(4L, 6L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(27L, 1L),
          @moonclip.Point64::new(31L, 1L),
          @moonclip.Point64::new(30L, 4L),
          @moonclip.Point64::new(9L, 10L),
          @moonclip.Point64::new(6L, 9L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(8L, 4L),
          @moonclip.Point64::new(9L, 6L),
          @moonclip.Point64::new(16L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: e06571e7b1b234805a7f4f274c4360c65cb647472711fb0384ac00c2bfd06c8f
test "reference minkowski paths: minkowski_offcenter_acute_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(4L, 6L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(27L, 1L),
          @moonclip.Point64::new(31L, 1L),
          @moonclip.Point64::new(30L, 4L),
          @moonclip.Point64::new(9L, 10L),
          @moonclip.Point64::new(6L, 9L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(8L, 4L),
          @moonclip.Point64::new(9L, 6L),
          @moonclip.Point64::new(16L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 3d34b27ff96a2cbd8b6384c5d4f7edacfc43158dbdfa7f0342acf2c8053b0b5e
test "reference minkowski paths: minkowski_offcenter_acute_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(4L, 6L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(27L, 1L),
          @moonclip.Point64::new(31L, 1L),
          @moonclip.Point64::new(30L, 4L),
          @moonclip.Point64::new(9L, 10L),
          @moonclip.Point64::new(6L, 9L),
          @moonclip.Point64::new(6L, 7L),
          @moonclip.Point64::new(16L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 67be441104c8d3d267e4fdcc36df7c0ef760f8d9c67919ec6d6a6cb59606dab1
test "reference minkowski paths: minkowski_offcenter_acute_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(4L, 6L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(27L, 1L),
          @moonclip.Point64::new(31L, 1L),
          @moonclip.Point64::new(30L, 4L),
          @moonclip.Point64::new(9L, 10L),
          @moonclip.Point64::new(6L, 9L),
          @moonclip.Point64::new(6L, 7L),
          @moonclip.Point64::new(16L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 8e0cb8552d7434cb9289d0088757cafa8c929271756c706b67fa512882aa4e72
test "reference minkowski paths: minkowski_offcenter_diagonal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-4L, -4L),
          @moonclip.Point64::new(26L, 16L),
          @moonclip.Point64::new(25L, 19L),
          @moonclip.Point64::new(22L, 18L),
          @moonclip.Point64::new(-8L, -2L),
          @moonclip.Point64::new(-8L, -4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: bb8d5fed2b2c7d8f11b8fe64f92dd0baf03926ae5ad56968d70859b687983dfe
test "reference minkowski paths: minkowski_offcenter_diagonal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(20L, 15L), @moonclip.Point64::new(-10L, -5L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-4L, -4L),
          @moonclip.Point64::new(26L, 16L),
          @moonclip.Point64::new(25L, 19L),
          @moonclip.Point64::new(22L, 18L),
          @moonclip.Point64::new(-8L, -2L),
          @moonclip.Point64::new(-8L, -4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 77ad5ab6562a049aeb78fe81f931b9be37956d83e96fbd2944470c6b4e237a33
test "reference minkowski paths: minkowski_offcenter_diagonal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-4L, -4L),
          @moonclip.Point64::new(26L, 16L),
          @moonclip.Point64::new(25L, 19L),
          @moonclip.Point64::new(22L, 18L),
          @moonclip.Point64::new(-8L, -2L),
          @moonclip.Point64::new(-8L, -4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 4762471e5a132ebf9f298b9cc5b7cb84e34e4bea059c2cdbfbbf2a6bf92ab388
test "reference minkowski paths: minkowski_offcenter_diagonal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(20L, 15L), @moonclip.Point64::new(-10L, -5L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-4L, -4L),
          @moonclip.Point64::new(26L, 16L),
          @moonclip.Point64::new(25L, 19L),
          @moonclip.Point64::new(22L, 18L),
          @moonclip.Point64::new(-8L, -2L),
          @moonclip.Point64::new(-8L, -4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: d5f3a9d2110523eaae2decf61b08b28d7494d972193550f3818d9e31e441c2e9
test "reference minkowski paths: minkowski_offcenter_long_horizontal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(36L, 1L),
          @moonclip.Point64::new(35L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 588169372e1a327cf9e86cf783be19ca4f7579677f591efb185d1bc0f25332ec
test "reference minkowski paths: minkowski_offcenter_long_horizontal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(30L, 0L), @moonclip.Point64::new(0L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(36L, 1L),
          @moonclip.Point64::new(35L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 74a3589746efb59911da638903815404ef36d4f079f17e9850df2154bb3e1f28
test "reference minkowski paths: minkowski_offcenter_long_horizontal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(36L, 1L),
          @moonclip.Point64::new(35L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 3c2adb9ad8ee15c3c1cbd422dad0f583abd3b6d4dbe39c6d99d11b213f0a5c38
test "reference minkowski paths: minkowski_offcenter_long_horizontal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(30L, 0L), @moonclip.Point64::new(0L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(36L, 1L),
          @moonclip.Point64::new(35L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 9c67c10bf983942a230235480b350d51b9e83caf8c4838fb3dc6ab5852af6312
test "reference minkowski paths: minkowski_offcenter_rectangle_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(36L, 1L),
          @moonclip.Point64::new(36L, 21L),
          @moonclip.Point64::new(35L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(2L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(32L, 4L),
          @moonclip.Point64::new(6L, 4L),
          @moonclip.Point64::new(6L, 21L),
          @moonclip.Point64::new(32L, 21L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 9349f3e81d24a25849839c855b93ba481ce9aa62f56dc63a2031edf079f73ecf
test "reference minkowski paths: minkowski_offcenter_rectangle_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(36L, 1L),
          @moonclip.Point64::new(36L, 21L),
          @moonclip.Point64::new(35L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(2L, 23L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(32L, 4L),
          @moonclip.Point64::new(6L, 4L),
          @moonclip.Point64::new(6L, 21L),
          @moonclip.Point64::new(32L, 21L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 108984fa6eba52a175bc66c18ed4e6f50dc559f93919d4570a32c4dfabe28171
test "reference minkowski paths: minkowski_offcenter_rectangle_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(36L, 1L),
          @moonclip.Point64::new(36L, 21L),
          @moonclip.Point64::new(35L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(2L, 23L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(32L, 21L),
          @moonclip.Point64::new(32L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 327b8bd6c4bd75976023c896fd511ca739dc1d5f1dbe86cd6fc8799e51394026
test "reference minkowski paths: minkowski_offcenter_rectangle_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(36L, 1L),
          @moonclip.Point64::new(36L, 21L),
          @moonclip.Point64::new(35L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(2L, 23L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(32L, 21L),
          @moonclip.Point64::new(32L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: bc475284b0a5f3b3aa1f8230aee900ebb44d180de21586270438ca56e6455b33
test "reference minkowski paths: minkowski_offcenter_repeats_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(22L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(22L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 981a783ae0fb8d4c5154ad4177c434b8e075ce00acb60e6641a43a7c46ea8925
test "reference minkowski paths: minkowski_offcenter_repeats_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(22L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(22L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: e7dd6e0ba7c8370918c0573e40c6b3a41e50e7f9f4f58b067afa071870c0396f
test "reference minkowski paths: minkowski_offcenter_repeats_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(22L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(22L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: a981ee19ed4d6d6af5a65da68ea19c531bab6320dd4e1faf1997268ef819c8a6
test "reference minkowski paths: minkowski_offcenter_repeats_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(22L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(22L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: d1a30ef0aecd126197f77f932405e3a810533bb06eb813688c180ce0c26304c7
test "reference minkowski paths: minkowski_offcenter_retrace_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(5L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(25L, 4L),
          @moonclip.Point64::new(11L, 4L),
          @moonclip.Point64::new(11L, 21L),
          @moonclip.Point64::new(10L, 24L),
          @moonclip.Point64::new(7L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 62d450ffc95f2056999f8590bb7a19de4acc6dc06203a9c19ef86719bc285d66
test "reference minkowski paths: minkowski_offcenter_retrace_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(5L, 20L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(25L, 4L),
          @moonclip.Point64::new(11L, 4L),
          @moonclip.Point64::new(11L, 21L),
          @moonclip.Point64::new(10L, 24L),
          @moonclip.Point64::new(7L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 7c0697db9f76289c028cafbbf5d0faeb1abdaff51f693bfe3397324bbe7b93fd
test "reference minkowski paths: minkowski_offcenter_retrace_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(5L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(25L, 4L),
          @moonclip.Point64::new(11L, 4L),
          @moonclip.Point64::new(11L, 21L),
          @moonclip.Point64::new(10L, 24L),
          @moonclip.Point64::new(7L, 23L),
          @moonclip.Point64::new(7L, 21L),
          @moonclip.Point64::new(7L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 9d0ff015b2753001c3e4956ae8ab164f5b8a7a09241f4729ce9058474bee4a00
test "reference minkowski paths: minkowski_offcenter_retrace_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(5L, 20L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(25L, 4L),
          @moonclip.Point64::new(11L, 4L),
          @moonclip.Point64::new(11L, 21L),
          @moonclip.Point64::new(10L, 24L),
          @moonclip.Point64::new(7L, 23L),
          @moonclip.Point64::new(7L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 1ca584909431eeacbf7e72ab43814d746763ba19666f7958e5384f1059ebb3df
test "reference minkowski paths: minkowski_offcenter_right_angle_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(22L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(22L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c9c17b491fcb5cf8b1493211b3033854644fd21da022e677bc41b452d9bea62b
test "reference minkowski paths: minkowski_offcenter_right_angle_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(22L, 23L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(9L, 4L),
          @moonclip.Point64::new(22L, 17L),
          @moonclip.Point64::new(22L, 4L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: abaeda4ca7436cfba6217c233c332ff3099277d30db55b3cb9b06fedf938ce43
test "reference minkowski paths: minkowski_offcenter_right_angle_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(22L, 23L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(22L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 7c4f3bc6510534b1de10ae9c851b46b2ed085e51d3c6b448bf4e8ce667e88278
test "reference minkowski paths: minkowski_offcenter_right_angle_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(22L, 23L),
          @moonclip.Point64::new(22L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: a005e9e2288ffc8c5e7cbfd6816c9b2eec809ef6727a84fcf22845b6925ce22b
test "reference minkowski paths: minkowski_offcenter_selfcross_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 10L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(18L, 5L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(36L, 11L),
          @moonclip.Point64::new(35L, 14L),
          @moonclip.Point64::new(32L, 13L),
          @moonclip.Point64::new(20L, 9L),
          @moonclip.Point64::new(17L, 12L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(2L, 23L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(11L, 12L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(8L, 21L),
          @moonclip.Point64::new(20L, 21L),
          @moonclip.Point64::new(14L, 15L),
        ],
        [
          @moonclip.Point64::new(14L, 9L),
          @moonclip.Point64::new(15L, 7L),
          @moonclip.Point64::new(11L, 6L),
        ],
        [
          @moonclip.Point64::new(22L, 6L),
          @moonclip.Point64::new(27L, 8L),
          @moonclip.Point64::new(24L, 5L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 8d9ba7ba85ad8e050a758aa3fe2a21a96b7f701f8a289f239c9f2553df52c94d
test "reference minkowski paths: minkowski_offcenter_selfcross_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(18L, 5L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(36L, 11L),
          @moonclip.Point64::new(35L, 14L),
          @moonclip.Point64::new(32L, 13L),
          @moonclip.Point64::new(20L, 9L),
          @moonclip.Point64::new(17L, 12L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(2L, 23L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(11L, 12L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(8L, 21L),
          @moonclip.Point64::new(20L, 21L),
          @moonclip.Point64::new(14L, 15L),
        ],
        [
          @moonclip.Point64::new(14L, 9L),
          @moonclip.Point64::new(15L, 7L),
          @moonclip.Point64::new(11L, 6L),
        ],
        [
          @moonclip.Point64::new(22L, 6L),
          @moonclip.Point64::new(27L, 8L),
          @moonclip.Point64::new(24L, 5L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 0d39e024a04009838a072e3a949e06457ac7dddd182f8a23db7d558ed0234a13
test "reference minkowski paths: minkowski_offcenter_selfcross_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 10L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(14L, 9L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(36L, 11L),
          @moonclip.Point64::new(35L, 14L),
          @moonclip.Point64::new(32L, 13L),
          @moonclip.Point64::new(24L, 5L),
          @moonclip.Point64::new(17L, 12L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(2L, 23L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(11L, 12L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(8L, 21L),
          @moonclip.Point64::new(20L, 21L),
          @moonclip.Point64::new(14L, 15L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 06cc014109bca2f5eb057f8f91793f8637c292b665580cbcfaa3b71aaca001c8
test "reference minkowski paths: minkowski_offcenter_selfcross_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(14L, 9L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(26L, 1L),
          @moonclip.Point64::new(36L, 11L),
          @moonclip.Point64::new(35L, 14L),
          @moonclip.Point64::new(32L, 13L),
          @moonclip.Point64::new(24L, 5L),
          @moonclip.Point64::new(17L, 12L),
          @moonclip.Point64::new(26L, 21L),
          @moonclip.Point64::new(25L, 24L),
          @moonclip.Point64::new(5L, 24L),
          @moonclip.Point64::new(2L, 23L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(11L, 12L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
        ],
        [
          @moonclip.Point64::new(8L, 21L),
          @moonclip.Point64::new(20L, 21L),
          @moonclip.Point64::new(14L, 15L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: f0f492ff29508d5c7d46ae24ea59f8b892f9be42353cd5f9a893a1505ee7fd1e
test "reference minkowski paths: minkowski_offcenter_short_horizontal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(3L, 3L),
          @moonclip.Point64::new(5L, 3L),
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(7L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 413a43c14e37112134f8f00298b7b1bd79854b65a8f48e17f1949a351af69318
test "reference minkowski paths: minkowski_offcenter_short_horizontal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(0L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(3L, 3L),
          @moonclip.Point64::new(5L, 3L),
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(7L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 1c37218e6ca27c6525597c55cbdaf998de0944d131db2bb02803cb6c2ce6a91c
test "reference minkowski paths: minkowski_offcenter_short_horizontal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(3L, 3L),
          @moonclip.Point64::new(5L, 3L),
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(7L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 4bf88a3d69bc8fa847866481fbac0110193f25d26a2f0a4d0e00eb037e9eff32
test "reference minkowski paths: minkowski_offcenter_short_horizontal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 1L),
        @moonclip.Point64::new(5L, 4L),
        @moonclip.Point64::new(2L, 3L),
      ],
      [@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(0L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, 4L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(2L, 3L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(3L, 3L),
          @moonclip.Point64::new(5L, 3L),
          @moonclip.Point64::new(6L, 1L),
          @moonclip.Point64::new(7L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: d9a4cda3980a0a9a8ad050ffb82160ce7bbdb41ecc5083b15eec5bffd4848882
test "reference minkowski paths: minkowski_rectangle_acute_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(4L, 6L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(23L, -1L),
          @moonclip.Point64::new(27L, -1L),
          @moonclip.Point64::new(27L, 1L),
          @moonclip.Point64::new(6L, 7L),
          @moonclip.Point64::new(2L, 7L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(16L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 98214eb92f57b5694d3ef7a58a6d861420fa3de442c6f6ea403757d952ded304
test "reference minkowski paths: minkowski_rectangle_acute_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(4L, 6L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(23L, -1L),
          @moonclip.Point64::new(27L, -1L),
          @moonclip.Point64::new(27L, 1L),
          @moonclip.Point64::new(6L, 7L),
          @moonclip.Point64::new(2L, 7L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(5L, 4L),
          @moonclip.Point64::new(16L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 41ef1dbd8838819ddc4a71d3601a9c325562571f90480e6d500b8d44bfec2e5e
test "reference minkowski paths: minkowski_rectangle_acute_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(4L, 6L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(23L, -1L),
          @moonclip.Point64::new(27L, -1L),
          @moonclip.Point64::new(27L, 1L),
          @moonclip.Point64::new(6L, 7L),
          @moonclip.Point64::new(2L, 7L),
          @moonclip.Point64::new(2L, 5L),
          @moonclip.Point64::new(16L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 351f9a4a0e2ebfbb6e19623d417c11ffdee8c7334b44c94fc33ed0625aa8e113
test "reference minkowski paths: minkowski_rectangle_acute_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(4L, 6L),
        @moonclip.Point64::new(25L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(23L, -1L),
          @moonclip.Point64::new(27L, -1L),
          @moonclip.Point64::new(27L, 1L),
          @moonclip.Point64::new(6L, 7L),
          @moonclip.Point64::new(2L, 7L),
          @moonclip.Point64::new(2L, 5L),
          @moonclip.Point64::new(16L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c21a632ada76237f994e34fe93ebe6c0a1abff4d470f913a844886ec0e265b14
test "reference minkowski paths: minkowski_rectangle_diagonal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-8L, -6L),
          @moonclip.Point64::new(22L, 14L),
          @moonclip.Point64::new(22L, 16L),
          @moonclip.Point64::new(18L, 16L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -6L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: a025fc94cf4ed9505a4965372d738d29d88b706346283fd7863fb7044d12b994
test "reference minkowski paths: minkowski_rectangle_diagonal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(20L, 15L), @moonclip.Point64::new(-10L, -5L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-8L, -6L),
          @moonclip.Point64::new(22L, 14L),
          @moonclip.Point64::new(22L, 16L),
          @moonclip.Point64::new(18L, 16L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -6L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: d82a3de98f0448f60b8c197c57d440b0b8505083bd920330124eb7b0ccf86894
test "reference minkowski paths: minkowski_rectangle_diagonal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(-10L, -5L), @moonclip.Point64::new(20L, 15L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-8L, -6L),
          @moonclip.Point64::new(22L, 14L),
          @moonclip.Point64::new(22L, 16L),
          @moonclip.Point64::new(18L, 16L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -6L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 75e3bdceb80abf7a56f54a36e9c171b8758d5c9e990bee78bd837abcc3a9c0d6
test "reference minkowski paths: minkowski_rectangle_diagonal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(20L, 15L), @moonclip.Point64::new(-10L, -5L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-8L, -6L),
          @moonclip.Point64::new(22L, 14L),
          @moonclip.Point64::new(22L, 16L),
          @moonclip.Point64::new(18L, 16L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -6L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 5757eba6eca111893b1924a704ac9e95955eb6de5ab20b0f9071861c14d084fd
test "reference minkowski paths: minkowski_rectangle_long_horizontal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(28L, -1L),
          @moonclip.Point64::new(32L, -1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: d169c2f9a3d71b4315d5bd9339c82bcf7e3f64d235e734f1fe41ef9825607393
test "reference minkowski paths: minkowski_rectangle_long_horizontal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(30L, 0L), @moonclip.Point64::new(0L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(28L, -1L),
          @moonclip.Point64::new(32L, -1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 7de6418419ea06d19ed6ffa4755aa484fd60511f1f6055e06eafcc13b01e847a
test "reference minkowski paths: minkowski_rectangle_long_horizontal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(28L, -1L),
          @moonclip.Point64::new(32L, -1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c786e776be3e2c0814ededb0660ef5d7ba93c78859c319f4101d7b15269ba1ba
test "reference minkowski paths: minkowski_rectangle_long_horizontal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(30L, 0L), @moonclip.Point64::new(0L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(28L, -1L),
          @moonclip.Point64::new(32L, -1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 3e6a5cfdaf7bcb97124301e420bf2cf4aae7957b8698944c017ca6efed90cdd1
test "reference minkowski paths: minkowski_rectangle_rectangle_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(28L, -1L),
          @moonclip.Point64::new(32L, -1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(32L, 21L),
          @moonclip.Point64::new(28L, 21L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(-2L, 21L),
          @moonclip.Point64::new(-2L, 19L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(2L, 19L),
          @moonclip.Point64::new(28L, 19L),
          @moonclip.Point64::new(28L, 1L),
          @moonclip.Point64::new(2L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 7db3c62039101ad1cd8e4e601ecf50c930623b316e880e918da58de02db9f4e4
test "reference minkowski paths: minkowski_rectangle_rectangle_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(28L, -1L),
          @moonclip.Point64::new(32L, -1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(32L, 19L),
          @moonclip.Point64::new(32L, 21L),
          @moonclip.Point64::new(28L, 21L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(-2L, 21L),
          @moonclip.Point64::new(-2L, 19L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(28L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, 19L),
          @moonclip.Point64::new(28L, 19L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: a4b8885956d678f33924058dddb7fad157293957a23db1d3dbb8a6535d6a6ad2
test "reference minkowski paths: minkowski_rectangle_rectangle_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(0L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(28L, -1L),
          @moonclip.Point64::new(32L, -1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(32L, 21L),
          @moonclip.Point64::new(28L, 21L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(-2L, 21L),
          @moonclip.Point64::new(-2L, 19L),
          @moonclip.Point64::new(28L, 19L),
          @moonclip.Point64::new(28L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 076d05259b6572081de7f35781d40d8b82e856c781bee4d3ebb7bed03c248dfd
test "reference minkowski paths: minkowski_rectangle_rectangle_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(30L, 20L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(28L, -1L),
          @moonclip.Point64::new(32L, -1L),
          @moonclip.Point64::new(32L, 1L),
          @moonclip.Point64::new(32L, 19L),
          @moonclip.Point64::new(32L, 21L),
          @moonclip.Point64::new(28L, 21L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(-2L, 21L),
          @moonclip.Point64::new(-2L, 19L),
          @moonclip.Point64::new(28L, 19L),
          @moonclip.Point64::new(28L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: cf29cfd9191199ac57d2987af8f46feda5d08185bbdd312a67c110ab9ab77891
test "reference minkowski paths: minkowski_rectangle_repeats_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(18L, 15L),
          @moonclip.Point64::new(18L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 795262597b81c8eb0ad6066d05f2505c70a0ed2c89b9410fea10c6af02e6df68
test "reference minkowski paths: minkowski_rectangle_repeats_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(18L, 15L),
          @moonclip.Point64::new(18L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 618258caa80dbd74e328c1d7cc37a03a3676afe97ee7b5ad8c3ee3d136fa5c27
test "reference minkowski paths: minkowski_rectangle_repeats_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(18L, 15L),
          @moonclip.Point64::new(18L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: e789793a0be4b29dda99b9f5c6fa7e509070c31341192843affd99a19fe4e7df
test "reference minkowski paths: minkowski_rectangle_repeats_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(18L, 15L),
          @moonclip.Point64::new(18L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 560a6dfee095740f36ad2a1a2b6c90a45ca9d7e27cee686085d4487c177d732b
test "reference minkowski paths: minkowski_rectangle_retrace_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(5L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(7L, 1L),
          @moonclip.Point64::new(7L, 19L),
          @moonclip.Point64::new(7L, 21L),
          @moonclip.Point64::new(3L, 21L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: a2ebb56834cad1cffc18b45e93205db369dd8b62fd249b590426c9823307e46e
test "reference minkowski paths: minkowski_rectangle_retrace_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(5L, 20L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(7L, 1L),
          @moonclip.Point64::new(7L, 19L),
          @moonclip.Point64::new(7L, 21L),
          @moonclip.Point64::new(3L, 21L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 16e42d52a06a2d83b0b8088b361a59d4a9cf66fab584533e9e1f0b2cf3474112
test "reference minkowski paths: minkowski_rectangle_retrace_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(5L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(7L, 1L),
          @moonclip.Point64::new(7L, 21L),
          @moonclip.Point64::new(3L, 21L),
          @moonclip.Point64::new(3L, 19L),
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 3367e8adc5b74895b4406765549015f77631385ae25307d7b6674fe186af2288
test "reference minkowski paths: minkowski_rectangle_retrace_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(5L, 20L),
        @moonclip.Point64::new(5L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(7L, 1L),
          @moonclip.Point64::new(7L, 19L),
          @moonclip.Point64::new(7L, 21L),
          @moonclip.Point64::new(3L, 21L),
          @moonclip.Point64::new(3L, 19L),
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: c660604f3ae28a83e774b888263491e1059e6435c1106c296b9d33009246739f
test "reference minkowski paths: minkowski_rectangle_right_angle_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(18L, 15L),
          @moonclip.Point64::new(18L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 386886eeef61d1409495760a0ca8f10d6a990cccdca1b37c18ffc5f1c5569303
test "reference minkowski paths: minkowski_rectangle_right_angle_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 1L),
          @moonclip.Point64::new(18L, 15L),
          @moonclip.Point64::new(18L, 1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 633997a2cb1588a2219efc304344b1feb9e703c721d667a3938160366e992eb8
test "reference minkowski paths: minkowski_rectangle_right_angle_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(18L, 19L),
          @moonclip.Point64::new(18L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ca21d2245d08111ccf83ac10fa3220597882d8da9d73afb943868990cf6fda4d
test "reference minkowski paths: minkowski_rectangle_right_angle_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(22L, 1L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(18L, 19L),
          @moonclip.Point64::new(18L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 34430432a90a7b42da196e6b3af2478b349d85babee22421ab150d928ba67f21
test "reference minkowski paths: minkowski_rectangle_selfcross_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 10L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(14L, 3L),
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(32L, 9L),
          @moonclip.Point64::new(32L, 11L),
          @moonclip.Point64::new(28L, 11L),
          @moonclip.Point64::new(16L, 7L),
          @moonclip.Point64::new(13L, 10L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(-2L, 21L),
          @moonclip.Point64::new(-2L, 19L),
          @moonclip.Point64::new(7L, 10L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 19L),
          @moonclip.Point64::new(16L, 19L),
          @moonclip.Point64::new(10L, 13L),
        ],
        [
          @moonclip.Point64::new(10L, 7L),
          @moonclip.Point64::new(11L, 5L),
          @moonclip.Point64::new(7L, 4L),
        ],
        [
          @moonclip.Point64::new(18L, 4L),
          @moonclip.Point64::new(23L, 6L),
          @moonclip.Point64::new(20L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: fe2b449e99a70c808f0bcc330540e6d7807d86bee96dc81dd5bbbf7260db0744
test "reference minkowski paths: minkowski_rectangle_selfcross_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(14L, 3L),
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(32L, 9L),
          @moonclip.Point64::new(32L, 11L),
          @moonclip.Point64::new(28L, 11L),
          @moonclip.Point64::new(16L, 7L),
          @moonclip.Point64::new(13L, 10L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(-2L, 21L),
          @moonclip.Point64::new(-2L, 19L),
          @moonclip.Point64::new(7L, 10L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 19L),
          @moonclip.Point64::new(16L, 19L),
          @moonclip.Point64::new(10L, 13L),
        ],
        [
          @moonclip.Point64::new(10L, 7L),
          @moonclip.Point64::new(11L, 5L),
          @moonclip.Point64::new(7L, 4L),
        ],
        [
          @moonclip.Point64::new(18L, 4L),
          @moonclip.Point64::new(23L, 6L),
          @moonclip.Point64::new(20L, 3L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ce21dba0ed572416555bb5c891084bf575914beb8ffae90fd5c091abedef6d0a
test "reference minkowski paths: minkowski_rectangle_selfcross_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 10L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(10L, 7L),
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(32L, 9L),
          @moonclip.Point64::new(32L, 11L),
          @moonclip.Point64::new(28L, 11L),
          @moonclip.Point64::new(20L, 3L),
          @moonclip.Point64::new(13L, 10L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(-2L, 21L),
          @moonclip.Point64::new(-2L, 19L),
          @moonclip.Point64::new(7L, 10L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 19L),
          @moonclip.Point64::new(16L, 19L),
          @moonclip.Point64::new(10L, 13L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 2fc0facda031d10be0c97492f7e9437b80e9b0cd81e8d52114d9f9b801af842d
test "reference minkowski paths: minkowski_rectangle_selfcross_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 20L),
        @moonclip.Point64::new(20L, 20L),
        @moonclip.Point64::new(0L, 0L),
      ],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(10L, 7L),
          @moonclip.Point64::new(18L, -1L),
          @moonclip.Point64::new(22L, -1L),
          @moonclip.Point64::new(32L, 9L),
          @moonclip.Point64::new(32L, 11L),
          @moonclip.Point64::new(28L, 11L),
          @moonclip.Point64::new(20L, 3L),
          @moonclip.Point64::new(13L, 10L),
          @moonclip.Point64::new(22L, 19L),
          @moonclip.Point64::new(22L, 21L),
          @moonclip.Point64::new(18L, 21L),
          @moonclip.Point64::new(2L, 21L),
          @moonclip.Point64::new(-2L, 21L),
          @moonclip.Point64::new(-2L, 19L),
          @moonclip.Point64::new(7L, 10L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
        ],
        [
          @moonclip.Point64::new(4L, 19L),
          @moonclip.Point64::new(16L, 19L),
          @moonclip.Point64::new(10L, 13L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 6f79035d1eb593c17663bd56ba44c9bd544787aa9a1eb9bff148f9259b575ce5
test "reference minkowski paths: minkowski_rectangle_short_horizontal_closed_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-1L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
          @moonclip.Point64::new(-1L, -1L),
        ],
        [
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(3L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 81ce0e72faa0df2a9262f21880f223057bab02a14f230ab6013a327371b67be9
test "reference minkowski paths: minkowski_rectangle_short_horizontal_closed_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(0L, 0L)],
      true,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-1L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
          @moonclip.Point64::new(-1L, -1L),
        ],
        [
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(3L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: ce391ba2c4eed718db38dcfd5d8fd0027cf4aa0dddba6c7725fc427fdebdb52b
test "reference minkowski paths: minkowski_rectangle_short_horizontal_open_forward" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(1L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-1L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
          @moonclip.Point64::new(-1L, -1L),
        ],
        [
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(3L, -1L),
        ],
      ]),
    ),
  )
}

///|
// Input SHA256: 0783ab66954c4331273e7736f5a8f0ac8e0342f5c03d72c33ffff4c37f930627
test "reference minkowski paths: minkowski_rectangle_short_horizontal_open_reverse" {
  assert_eq(
    @moonclip.minkowski_sum(
      [
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(2L, -1L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(-2L, 1L),
      ],
      [@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(0L, 0L)],
      false,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-1L, 1L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
          @moonclip.Point64::new(-1L, -1L),
        ],
        [
          @moonclip.Point64::new(3L, 1L),
          @moonclip.Point64::new(2L, 1L),
          @moonclip.Point64::new(2L, -1L),
          @moonclip.Point64::new(3L, -1L),
        ],
      ]),
    ),
  )
}
