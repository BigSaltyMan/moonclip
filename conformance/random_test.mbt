// Generated locked random v1 flat contours; do not edit.

///|
// Seed: 20261019; input SHA256: fd93b56bc867d9ed021e3b522daff72e70d860d02aa08cedf9b1331980dc3b4f
test "reference random paths: random_rectangle_intersection_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-12L, -4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(0L, -16L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: a1d5081220b66841d04003158af2d676e72bb1d9fb5aadb1e3cf6db9d7a0b13f
test "reference random paths: random_rectangle_intersection_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-12L, -4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(0L, -16L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 496be5b8fa8a273fb9e8d19fdb520b6182adc996388ae0eb6fc92cc897834fd4
test "reference random paths: random_rectangle_union_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-12L, -4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 628c41ef26dbe7d315f3f0861d52e772439811f702433be09086a3aad864c390
test "reference random paths: random_rectangle_union_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-12L, -4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 6f135a1edb0c128a1f19bc89a61b7508a50c6a4704c0361fe45430fa756b1635
test "reference random paths: random_rectangle_difference_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-12L, -4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, -16L),
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 5fcaa2356d8e09ca2b8883861262123d5a30e286ad8d76b20adcd65858edcc27
test "reference random paths: random_rectangle_difference_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-12L, -4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(0L, -16L),
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 1474585031e2ec428c54228c98347dc93603b2d027c7b6f376a00e3ed93cff72
test "reference random paths: random_rectangle_xor_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-12L, -4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
        ],
      ],
      @moonclip.Xor,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(0L, -16L),
          @moonclip.Point64::new(6L, -16L),
        ],
        [
          @moonclip.Point64::new(0L, -16L),
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 649d4ae274a2a209bef8362ee2e07073cca31cf8fabc138672d34ebb1cfba260
test "reference random paths: random_rectangle_xor_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(-12L, -4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(6L, -16L),
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
        ],
      ],
      @moonclip.Xor,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(6L, -2L),
          @moonclip.Point64::new(-6L, -2L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(0L, -4L),
          @moonclip.Point64::new(0L, -16L),
          @moonclip.Point64::new(6L, -16L),
        ],
        [
          @moonclip.Point64::new(0L, -16L),
          @moonclip.Point64::new(-6L, -16L),
          @moonclip.Point64::new(-6L, -4L),
          @moonclip.Point64::new(-12L, -4L),
          @moonclip.Point64::new(-12L, -18L),
          @moonclip.Point64::new(0L, -18L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: a978fb7b6bb3df7424a43f80448b4a2fd5bb93cc7a0ab2e29c273feb6152d094
test "reference random paths: random_orthogonal_concave_intersection_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(-3L, -12L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: fa77027514dc88b3e339ee1b66cad08e5998c1005c56f0344fd2d0cec21b823b
test "reference random paths: random_orthogonal_concave_intersection_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(-3L, -12L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 40b51bfd218e432e8406a17e418e717c3251f801800896c593445f6bd529b1ff
test "reference random paths: random_orthogonal_concave_union_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-3L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 7fe2079b26b2c228a35e929560c2934e59a13a5fcf8fcecbc04c9a1b0668a9b7
test "reference random paths: random_orthogonal_concave_union_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-3L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 88cadb3754a5925cb387ee98d3554979f42ea80b8a8c542c0c99c303aee084fb
test "reference random paths: random_orthogonal_concave_difference_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-3L, -12L),
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 9cdc0af68660fdc734454a12df6423a190e53725c57c1cbb3da768d5ca749438
test "reference random paths: random_orthogonal_concave_difference_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-3L, -12L),
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 4fc90df36aad6f4d46c48d2d1d3a272dee03dfb501c3a16de5d935cfdecfb83f
test "reference random paths: random_orthogonal_concave_xor_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
        ],
      ],
      @moonclip.Xor,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-3L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
        ],
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-3L, -12L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: a9330966720defe7e8e126b291642fec1681ac4bab112c0abc2e4774c7027a2a
test "reference random paths: random_orthogonal_concave_xor_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
        ],
      ],
      @moonclip.Xor,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-3L, -12L),
          @moonclip.Point64::new(1L, -12L),
          @moonclip.Point64::new(1L, 7L),
          @moonclip.Point64::new(-11L, 7L),
          @moonclip.Point64::new(-11L, 5L),
          @moonclip.Point64::new(-15L, 5L),
          @moonclip.Point64::new(-15L, -14L),
          @moonclip.Point64::new(-3L, -14L),
        ],
        [
          @moonclip.Point64::new(-11L, -12L),
          @moonclip.Point64::new(-11L, -8L),
          @moonclip.Point64::new(-3L, -8L),
          @moonclip.Point64::new(-3L, -12L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 8709206452708b26736abdd91c4c1e7991fe3cae5e6f0848531fd1db1477ffd6
test "reference random paths: random_small_convex_intersection_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(-1L, -12L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: d98fbd342ab159e042b82b4e6c54fc34041c9b05118e5dcb91b07a1656398c36
test "reference random paths: random_small_convex_intersection_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(-1L, -12L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 36497a76540812f2f163dddc1f27ee1b74b4baaef616e5748313c400d7edc553
test "reference random paths: random_small_convex_union_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-1L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: f0fb7e17ba8d2baa36e484c87e29b0a56af3a5eafd25b9ce43aedbfa24904888
test "reference random paths: random_small_convex_union_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-1L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 90746fda0967caf1ea31ac886c0faad46921ae67adacb6113ada35ee87bc98e3
test "reference random paths: random_small_convex_difference_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-1L, -12L),
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 553614492c11960356b8ce691ea322b3736217f1d3d2403c0d1fed5af271f3cf
test "reference random paths: random_small_convex_difference_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(-1L, -12L),
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: 66bd74d3744522134efffbafab4fcb4c4049d66a559e26ce1e242aa551a32055
test "reference random paths: random_small_convex_xor_evenodd" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
        ],
      ],
      @moonclip.Xor,
      fill_rule=@moonclip.EvenOdd,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(-1L, -12L),
          @moonclip.Point64::new(12L, -12L),
        ],
        [
          @moonclip.Point64::new(-1L, -12L),
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
        ],
      ]),
    ),
  )
}

///|
// Seed: 20261019; input SHA256: ba15291521ae3d53cf589e82c06fae5c051a3bae1ae26dcfab36923d0b88b34d
test "reference random paths: random_small_convex_xor_nonzero" {
  assert_eq(
    @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(-10L, 4L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(12L, -12L),
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
        ],
      ],
      @moonclip.Xor,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(12L, 7L),
          @moonclip.Point64::new(-10L, 7L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(1L, 4L),
          @moonclip.Point64::new(7L, -9L),
          @moonclip.Point64::new(-1L, -12L),
          @moonclip.Point64::new(12L, -12L),
        ],
        [
          @moonclip.Point64::new(-1L, -12L),
          @moonclip.Point64::new(-10L, -12L),
          @moonclip.Point64::new(-10L, 4L),
          @moonclip.Point64::new(-15L, -6L),
          @moonclip.Point64::new(-8L, -15L),
        ],
      ]),
    ),
  )
}
