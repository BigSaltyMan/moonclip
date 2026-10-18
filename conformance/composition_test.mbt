// Generated composition references; both real stages must pass.

///|
// Full recipe SHA256: b8a83b7ae451bc790800343ede2c3b17002898f912d61d70c7690bd1d48f1b06
test "reference composition: composition_boolean_disjoint_in" {
  guard @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(3L, 0L),
          @moonclip.Point64::new(3L, 3L),
          @moonclip.Point64::new(0L, 3L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 10L),
          @moonclip.Point64::new(20L, 10L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 0L),
      ],
      [
        @moonclip.Point64::new(3L, 3L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(3L, 0L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.offset_polygons(
      intermediate,
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(28L, 2L),
          @moonclip.Point64::new(28L, 8L),
          @moonclip.Point64::new(22L, 8L),
          @moonclip.Point64::new(22L, 2L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: fae5429ab6fb1aa1e4ad08ee122bfcf2c2d7f4f5bab37091bb9cdd17402e4ccd
test "reference composition: composition_boolean_disjoint_out" {
  guard @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(3L, 0L),
          @moonclip.Point64::new(3L, 3L),
          @moonclip.Point64::new(0L, 3L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 10L),
          @moonclip.Point64::new(20L, 10L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(30L, 10L),
        @moonclip.Point64::new(20L, 10L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(30L, 0L),
      ],
      [
        @moonclip.Point64::new(3L, 3L),
        @moonclip.Point64::new(0L, 3L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(3L, 0L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.offset_polygons(
      intermediate,
      2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(32L, 12L),
          @moonclip.Point64::new(18L, 12L),
          @moonclip.Point64::new(18L, -2L),
          @moonclip.Point64::new(32L, -2L),
        ],
        [
          @moonclip.Point64::new(5L, 5L),
          @moonclip.Point64::new(-2L, 5L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(5L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 34da37275c913d8b757e008abc020217bab05873831da413d858e65f78846e88
test "reference composition: composition_boolean_hole_in" {
  guard @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(10L, 10L),
          @moonclip.Point64::new(30L, 10L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(10L, 30L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(40L, 40L),
        @moonclip.Point64::new(0L, 40L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(40L, 0L),
      ],
      [
        @moonclip.Point64::new(10L, 10L),
        @moonclip.Point64::new(10L, 30L),
        @moonclip.Point64::new(30L, 30L),
        @moonclip.Point64::new(30L, 10L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.offset_polygons(
      intermediate,
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(38L, 2L),
          @moonclip.Point64::new(38L, 38L),
          @moonclip.Point64::new(2L, 38L),
          @moonclip.Point64::new(2L, 2L),
        ],
        [
          @moonclip.Point64::new(8L, 32L),
          @moonclip.Point64::new(32L, 32L),
          @moonclip.Point64::new(32L, 8L),
          @moonclip.Point64::new(8L, 8L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: e7ab017ca2fc7c33daf83614318eb51b5ccc2ea8dbd4364ba1a3837be4663695
test "reference composition: composition_boolean_hole_out" {
  guard @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(10L, 10L),
          @moonclip.Point64::new(30L, 10L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(10L, 30L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(40L, 40L),
        @moonclip.Point64::new(0L, 40L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(40L, 0L),
      ],
      [
        @moonclip.Point64::new(10L, 10L),
        @moonclip.Point64::new(10L, 30L),
        @moonclip.Point64::new(30L, 30L),
        @moonclip.Point64::new(30L, 10L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.offset_polygons(
      intermediate,
      2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(42L, 42L),
          @moonclip.Point64::new(-2L, 42L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(42L, -2L),
        ],
        [
          @moonclip.Point64::new(12L, 12L),
          @moonclip.Point64::new(12L, 28L),
          @moonclip.Point64::new(28L, 28L),
          @moonclip.Point64::new(28L, 12L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 4431d617a834968a70e8aa45c78cd922719ad87953b137bc3a75aaf04285c46e
test "reference composition: composition_boolean_notch_in" {
  guard @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(10L, -5L),
          @moonclip.Point64::new(30L, -5L),
          @moonclip.Point64::new(30L, 15L),
          @moonclip.Point64::new(10L, 15L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(40L, 40L),
        @moonclip.Point64::new(0L, 40L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(10L, 0L),
        @moonclip.Point64::new(10L, 15L),
        @moonclip.Point64::new(30L, 15L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(40L, 0L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.offset_polygons(
      intermediate,
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(8L, 2L),
          @moonclip.Point64::new(8L, 17L),
          @moonclip.Point64::new(32L, 17L),
          @moonclip.Point64::new(32L, 2L),
          @moonclip.Point64::new(38L, 2L),
          @moonclip.Point64::new(38L, 38L),
          @moonclip.Point64::new(2L, 38L),
          @moonclip.Point64::new(2L, 2L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 9a637b2197c0c377b90c8485e602ebd5b6cb57e3e9ca0ffb0886ca659b6daa74
test "reference composition: composition_boolean_notch_out" {
  guard @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(10L, -5L),
          @moonclip.Point64::new(30L, -5L),
          @moonclip.Point64::new(30L, 15L),
          @moonclip.Point64::new(10L, 15L),
        ],
      ],
      @moonclip.Difference,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(40L, 40L),
        @moonclip.Point64::new(0L, 40L),
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(10L, 0L),
        @moonclip.Point64::new(10L, 15L),
        @moonclip.Point64::new(30L, 15L),
        @moonclip.Point64::new(30L, 0L),
        @moonclip.Point64::new(40L, 0L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.offset_polygons(
      intermediate,
      2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(12L, 13L),
          @moonclip.Point64::new(28L, 13L),
          @moonclip.Point64::new(28L, -2L),
          @moonclip.Point64::new(42L, -2L),
          @moonclip.Point64::new(42L, 42L),
          @moonclip.Point64::new(-2L, 42L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(12L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 274db4781d8892479d430f660cfc67636460f31f9aca8c82121d9e4bbe685d20
test "reference composition: composition_boolean_overlap_in" {
  guard @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(10L, 0L),
          @moonclip.Point64::new(10L, 10L),
          @moonclip.Point64::new(0L, 10L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(5L, 0L),
          @moonclip.Point64::new(15L, 0L),
          @moonclip.Point64::new(15L, 10L),
          @moonclip.Point64::new(5L, 10L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(15L, 0L),
        @moonclip.Point64::new(15L, 10L),
        @moonclip.Point64::new(0L, 10L),
        @moonclip.Point64::new(0L, 0L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.offset_polygons(
      intermediate,
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(13L, 2L),
          @moonclip.Point64::new(13L, 8L),
          @moonclip.Point64::new(2L, 8L),
          @moonclip.Point64::new(2L, 2L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 8b2b71c3b87d277c35952322a0df4985230b99719c378a4acd108efa7922f93b
test "reference composition: composition_boolean_overlap_out" {
  guard @moonclip.boolean_op(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(10L, 0L),
          @moonclip.Point64::new(10L, 10L),
          @moonclip.Point64::new(0L, 10L),
        ],
      ],
      [
        [
          @moonclip.Point64::new(5L, 0L),
          @moonclip.Point64::new(15L, 0L),
          @moonclip.Point64::new(15L, 10L),
          @moonclip.Point64::new(5L, 10L),
        ],
      ],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(15L, 0L),
        @moonclip.Point64::new(15L, 10L),
        @moonclip.Point64::new(0L, 10L),
        @moonclip.Point64::new(0L, 0L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.offset_polygons(
      intermediate,
      2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(17L, 12L),
          @moonclip.Point64::new(-2L, 12L),
          @moonclip.Point64::new(-2L, -2L),
          @moonclip.Point64::new(17L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 714b25fdeb696692416d4af779fc8c2caa2f830e94b003dc1340f943f9fec017
test "reference composition: composition_inset_channel_d2" {
  guard @moonclip.offset_polygons(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(12L, 0L),
          @moonclip.Point64::new(12L, 5L),
          @moonclip.Point64::new(24L, 5L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(36L, 0L),
          @moonclip.Point64::new(36L, 16L),
          @moonclip.Point64::new(24L, 16L),
          @moonclip.Point64::new(24L, 11L),
          @moonclip.Point64::new(12L, 11L),
          @moonclip.Point64::new(12L, 16L),
          @moonclip.Point64::new(0L, 16L),
        ],
      ],
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(10L, 2L),
        @moonclip.Point64::new(10L, 7L),
        @moonclip.Point64::new(26L, 7L),
        @moonclip.Point64::new(26L, 2L),
        @moonclip.Point64::new(34L, 2L),
        @moonclip.Point64::new(34L, 14L),
        @moonclip.Point64::new(26L, 14L),
        @moonclip.Point64::new(26L, 9L),
        @moonclip.Point64::new(10L, 9L),
        @moonclip.Point64::new(10L, 14L),
        @moonclip.Point64::new(2L, 14L),
        @moonclip.Point64::new(2L, 2L),
      ],
    ]),
  )
  guard @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(outcome) else {
    fail("step 2 failed")
  }
  assert_eq(
    reference_tree(outcome),
    ref_sort([
      RefNode(
        1,
        false,
        [
          @moonclip.Point64::new(10L, 7L),
          @moonclip.Point64::new(26L, 7L),
          @moonclip.Point64::new(26L, 2L),
          @moonclip.Point64::new(34L, 2L),
          @moonclip.Point64::new(34L, 14L),
          @moonclip.Point64::new(26L, 14L),
          @moonclip.Point64::new(26L, 9L),
          @moonclip.Point64::new(10L, 9L),
          @moonclip.Point64::new(10L, 14L),
          @moonclip.Point64::new(2L, 14L),
          @moonclip.Point64::new(2L, 2L),
          @moonclip.Point64::new(10L, 2L),
        ],
        [],
      ),
    ]),
  )
  assert_eq(
    canonical_paths(outcome.to_paths()),
    canonical_paths([
      [
        @moonclip.Point64::new(10L, 7L),
        @moonclip.Point64::new(26L, 7L),
        @moonclip.Point64::new(26L, 2L),
        @moonclip.Point64::new(34L, 2L),
        @moonclip.Point64::new(34L, 14L),
        @moonclip.Point64::new(26L, 14L),
        @moonclip.Point64::new(26L, 9L),
        @moonclip.Point64::new(10L, 9L),
        @moonclip.Point64::new(10L, 14L),
        @moonclip.Point64::new(2L, 14L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(10L, 2L),
      ],
    ]),
  )
}

///|
// Full recipe SHA256: cc4d4c9ac021e099f8908853f4a0ce82fd63414beecdf0fd85825d3b0202ae21
test "reference composition: composition_inset_channel_d4" {
  guard @moonclip.offset_polygons(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(12L, 0L),
          @moonclip.Point64::new(12L, 5L),
          @moonclip.Point64::new(24L, 5L),
          @moonclip.Point64::new(24L, 0L),
          @moonclip.Point64::new(36L, 0L),
          @moonclip.Point64::new(36L, 16L),
          @moonclip.Point64::new(24L, 16L),
          @moonclip.Point64::new(24L, 11L),
          @moonclip.Point64::new(12L, 11L),
          @moonclip.Point64::new(12L, 16L),
          @moonclip.Point64::new(0L, 16L),
        ],
      ],
      -4.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(32L, 4L),
        @moonclip.Point64::new(32L, 12L),
        @moonclip.Point64::new(28L, 12L),
        @moonclip.Point64::new(28L, 4L),
      ],
      [
        @moonclip.Point64::new(8L, 4L),
        @moonclip.Point64::new(8L, 12L),
        @moonclip.Point64::new(4L, 12L),
        @moonclip.Point64::new(4L, 4L),
      ],
    ]),
  )
  guard @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(outcome) else {
    fail("step 2 failed")
  }
  assert_eq(
    reference_tree(outcome),
    ref_sort([
      RefNode(
        1,
        false,
        [
          @moonclip.Point64::new(8L, 12L),
          @moonclip.Point64::new(4L, 12L),
          @moonclip.Point64::new(4L, 4L),
          @moonclip.Point64::new(8L, 4L),
        ],
        [],
      ),
      RefNode(
        1,
        false,
        [
          @moonclip.Point64::new(32L, 12L),
          @moonclip.Point64::new(28L, 12L),
          @moonclip.Point64::new(28L, 4L),
          @moonclip.Point64::new(32L, 4L),
        ],
        [],
      ),
    ]),
  )
  assert_eq(
    canonical_paths(outcome.to_paths()),
    canonical_paths([
      [
        @moonclip.Point64::new(8L, 12L),
        @moonclip.Point64::new(4L, 12L),
        @moonclip.Point64::new(4L, 4L),
        @moonclip.Point64::new(8L, 4L),
      ],
      [
        @moonclip.Point64::new(32L, 12L),
        @moonclip.Point64::new(28L, 12L),
        @moonclip.Point64::new(28L, 4L),
        @moonclip.Point64::new(32L, 4L),
      ],
    ]),
  )
}

///|
// Full recipe SHA256: 489685cd7123629d9afc711890c1dc572f543a57bd4cd3d673378fdef4ec37c7
test "reference composition: composition_inset_hole_d2" {
  guard @moonclip.offset_polygons(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
        [
          @moonclip.Point64::new(8L, 32L),
          @moonclip.Point64::new(32L, 32L),
          @moonclip.Point64::new(32L, 8L),
          @moonclip.Point64::new(8L, 8L),
        ],
      ],
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(38L, 2L),
        @moonclip.Point64::new(38L, 38L),
        @moonclip.Point64::new(2L, 38L),
        @moonclip.Point64::new(2L, 2L),
      ],
      [
        @moonclip.Point64::new(6L, 34L),
        @moonclip.Point64::new(34L, 34L),
        @moonclip.Point64::new(34L, 6L),
        @moonclip.Point64::new(6L, 6L),
      ],
    ]),
  )
  guard @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(outcome) else {
    fail("step 2 failed")
  }
  assert_eq(
    reference_tree(outcome),
    ref_sort([
      RefNode(
        1,
        false,
        [
          @moonclip.Point64::new(38L, 38L),
          @moonclip.Point64::new(2L, 38L),
          @moonclip.Point64::new(2L, 2L),
          @moonclip.Point64::new(38L, 2L),
        ],
        [
          RefNode(
            2,
            true,
            [
              @moonclip.Point64::new(6L, 34L),
              @moonclip.Point64::new(34L, 34L),
              @moonclip.Point64::new(34L, 6L),
              @moonclip.Point64::new(6L, 6L),
            ],
            [],
          ),
        ],
      ),
    ]),
  )
  assert_eq(
    canonical_paths(outcome.to_paths()),
    canonical_paths([
      [
        @moonclip.Point64::new(38L, 38L),
        @moonclip.Point64::new(2L, 38L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(38L, 2L),
      ],
      [
        @moonclip.Point64::new(6L, 34L),
        @moonclip.Point64::new(34L, 34L),
        @moonclip.Point64::new(34L, 6L),
        @moonclip.Point64::new(6L, 6L),
      ],
    ]),
  )
}

///|
// Full recipe SHA256: 0a1bc65d82254cfd3bd8a882eb45b6e776a1208a5c1bc47d90c41b051206a680
test "reference composition: composition_inset_hole_d4" {
  guard @moonclip.offset_polygons(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
        [
          @moonclip.Point64::new(8L, 32L),
          @moonclip.Point64::new(32L, 32L),
          @moonclip.Point64::new(32L, 8L),
          @moonclip.Point64::new(8L, 8L),
        ],
      ],
      -4.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(canonical_paths(intermediate), canonical_paths([]))
  guard @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(outcome) else {
    fail("step 2 failed")
  }
  assert_eq(reference_tree(outcome), ref_sort([]))
  assert_eq(canonical_paths(outcome.to_paths()), canonical_paths([]))
}

///|
// Full recipe SHA256: 792c04971b0004394faf35caa0405202314f54d23ea8f9de71b803ee3e24cb21
test "reference composition: composition_inset_island_d2" {
  guard @moonclip.offset_polygons(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(80L, 0L),
          @moonclip.Point64::new(80L, 80L),
          @moonclip.Point64::new(0L, 80L),
        ],
        [
          @moonclip.Point64::new(10L, 70L),
          @moonclip.Point64::new(70L, 70L),
          @moonclip.Point64::new(70L, 10L),
          @moonclip.Point64::new(10L, 10L),
        ],
        [
          @moonclip.Point64::new(24L, 24L),
          @moonclip.Point64::new(56L, 24L),
          @moonclip.Point64::new(56L, 56L),
          @moonclip.Point64::new(24L, 56L),
        ],
        [
          @moonclip.Point64::new(32L, 48L),
          @moonclip.Point64::new(48L, 48L),
          @moonclip.Point64::new(48L, 32L),
          @moonclip.Point64::new(32L, 32L),
        ],
      ],
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(78L, 2L),
        @moonclip.Point64::new(78L, 78L),
        @moonclip.Point64::new(2L, 78L),
        @moonclip.Point64::new(2L, 2L),
      ],
      [
        @moonclip.Point64::new(8L, 72L),
        @moonclip.Point64::new(72L, 72L),
        @moonclip.Point64::new(72L, 8L),
        @moonclip.Point64::new(8L, 8L),
      ],
      [
        @moonclip.Point64::new(54L, 26L),
        @moonclip.Point64::new(54L, 54L),
        @moonclip.Point64::new(26L, 54L),
        @moonclip.Point64::new(26L, 26L),
      ],
      [
        @moonclip.Point64::new(30L, 50L),
        @moonclip.Point64::new(50L, 50L),
        @moonclip.Point64::new(50L, 30L),
        @moonclip.Point64::new(30L, 30L),
      ],
    ]),
  )
  guard @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(outcome) else {
    fail("step 2 failed")
  }
  assert_eq(
    reference_tree(outcome),
    ref_sort([
      RefNode(
        1,
        false,
        [
          @moonclip.Point64::new(78L, 78L),
          @moonclip.Point64::new(2L, 78L),
          @moonclip.Point64::new(2L, 2L),
          @moonclip.Point64::new(78L, 2L),
        ],
        [
          RefNode(
            2,
            true,
            [
              @moonclip.Point64::new(8L, 72L),
              @moonclip.Point64::new(72L, 72L),
              @moonclip.Point64::new(72L, 8L),
              @moonclip.Point64::new(8L, 8L),
            ],
            [
              RefNode(
                3,
                false,
                [
                  @moonclip.Point64::new(54L, 54L),
                  @moonclip.Point64::new(26L, 54L),
                  @moonclip.Point64::new(26L, 26L),
                  @moonclip.Point64::new(54L, 26L),
                ],
                [
                  RefNode(
                    4,
                    true,
                    [
                      @moonclip.Point64::new(30L, 50L),
                      @moonclip.Point64::new(50L, 50L),
                      @moonclip.Point64::new(50L, 30L),
                      @moonclip.Point64::new(30L, 30L),
                    ],
                    [],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ]),
  )
  assert_eq(
    canonical_paths(outcome.to_paths()),
    canonical_paths([
      [
        @moonclip.Point64::new(78L, 78L),
        @moonclip.Point64::new(2L, 78L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(78L, 2L),
      ],
      [
        @moonclip.Point64::new(8L, 72L),
        @moonclip.Point64::new(72L, 72L),
        @moonclip.Point64::new(72L, 8L),
        @moonclip.Point64::new(8L, 8L),
      ],
      [
        @moonclip.Point64::new(54L, 54L),
        @moonclip.Point64::new(26L, 54L),
        @moonclip.Point64::new(26L, 26L),
        @moonclip.Point64::new(54L, 26L),
      ],
      [
        @moonclip.Point64::new(30L, 50L),
        @moonclip.Point64::new(50L, 50L),
        @moonclip.Point64::new(50L, 30L),
        @moonclip.Point64::new(30L, 30L),
      ],
    ]),
  )
}

///|
// Full recipe SHA256: 1fb684651641b018fa6d6e89963719740623e42e4397636651873420a128c1c2
test "reference composition: composition_inset_island_d4" {
  guard @moonclip.offset_polygons(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(80L, 0L),
          @moonclip.Point64::new(80L, 80L),
          @moonclip.Point64::new(0L, 80L),
        ],
        [
          @moonclip.Point64::new(10L, 70L),
          @moonclip.Point64::new(70L, 70L),
          @moonclip.Point64::new(70L, 10L),
          @moonclip.Point64::new(10L, 10L),
        ],
        [
          @moonclip.Point64::new(24L, 24L),
          @moonclip.Point64::new(56L, 24L),
          @moonclip.Point64::new(56L, 56L),
          @moonclip.Point64::new(24L, 56L),
        ],
        [
          @moonclip.Point64::new(32L, 48L),
          @moonclip.Point64::new(48L, 48L),
          @moonclip.Point64::new(48L, 32L),
          @moonclip.Point64::new(32L, 32L),
        ],
      ],
      -4.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(76L, 4L),
        @moonclip.Point64::new(76L, 76L),
        @moonclip.Point64::new(4L, 76L),
        @moonclip.Point64::new(4L, 4L),
      ],
      [
        @moonclip.Point64::new(6L, 74L),
        @moonclip.Point64::new(74L, 74L),
        @moonclip.Point64::new(74L, 6L),
        @moonclip.Point64::new(6L, 6L),
      ],
    ]),
  )
  guard @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(outcome) else {
    fail("step 2 failed")
  }
  assert_eq(
    reference_tree(outcome),
    ref_sort([
      RefNode(
        1,
        false,
        [
          @moonclip.Point64::new(76L, 76L),
          @moonclip.Point64::new(4L, 76L),
          @moonclip.Point64::new(4L, 4L),
          @moonclip.Point64::new(76L, 4L),
        ],
        [
          RefNode(
            2,
            true,
            [
              @moonclip.Point64::new(6L, 74L),
              @moonclip.Point64::new(74L, 74L),
              @moonclip.Point64::new(74L, 6L),
              @moonclip.Point64::new(6L, 6L),
            ],
            [],
          ),
        ],
      ),
    ]),
  )
  assert_eq(
    canonical_paths(outcome.to_paths()),
    canonical_paths([
      [
        @moonclip.Point64::new(76L, 76L),
        @moonclip.Point64::new(4L, 76L),
        @moonclip.Point64::new(4L, 4L),
        @moonclip.Point64::new(76L, 4L),
      ],
      [
        @moonclip.Point64::new(6L, 74L),
        @moonclip.Point64::new(74L, 74L),
        @moonclip.Point64::new(74L, 6L),
        @moonclip.Point64::new(6L, 6L),
      ],
    ]),
  )
}

///|
// Full recipe SHA256: f0b1c23ae72f33ec241cc9aa17aca73d9fb983f2228cbaffb04125472ea0953e
test "reference composition: composition_inset_touch_d2" {
  guard @moonclip.offset_polygons(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
        [
          @moonclip.Point64::new(4L, 32L),
          @moonclip.Point64::new(24L, 32L),
          @moonclip.Point64::new(24L, 8L),
          @moonclip.Point64::new(4L, 8L),
        ],
      ],
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(38L, 2L),
        @moonclip.Point64::new(38L, 38L),
        @moonclip.Point64::new(2L, 38L),
        @moonclip.Point64::new(2L, 34L),
        @moonclip.Point64::new(26L, 34L),
        @moonclip.Point64::new(26L, 6L),
        @moonclip.Point64::new(2L, 6L),
        @moonclip.Point64::new(2L, 2L),
      ],
    ]),
  )
  guard @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(outcome) else {
    fail("step 2 failed")
  }
  assert_eq(
    reference_tree(outcome),
    ref_sort([
      RefNode(
        1,
        false,
        [
          @moonclip.Point64::new(38L, 38L),
          @moonclip.Point64::new(2L, 38L),
          @moonclip.Point64::new(2L, 34L),
          @moonclip.Point64::new(26L, 34L),
          @moonclip.Point64::new(26L, 6L),
          @moonclip.Point64::new(2L, 6L),
          @moonclip.Point64::new(2L, 2L),
          @moonclip.Point64::new(38L, 2L),
        ],
        [],
      ),
    ]),
  )
  assert_eq(
    canonical_paths(outcome.to_paths()),
    canonical_paths([
      [
        @moonclip.Point64::new(38L, 38L),
        @moonclip.Point64::new(2L, 38L),
        @moonclip.Point64::new(2L, 34L),
        @moonclip.Point64::new(26L, 34L),
        @moonclip.Point64::new(26L, 6L),
        @moonclip.Point64::new(2L, 6L),
        @moonclip.Point64::new(2L, 2L),
        @moonclip.Point64::new(38L, 2L),
      ],
    ]),
  )
}

///|
// Full recipe SHA256: 77453cfe557e67abb1456f3f04986a4f879c5de38ad52f7ae583b9c028ea48a6
test "reference composition: composition_inset_touch_d4" {
  guard @moonclip.offset_polygons(
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
        [
          @moonclip.Point64::new(4L, 32L),
          @moonclip.Point64::new(24L, 32L),
          @moonclip.Point64::new(24L, 8L),
          @moonclip.Point64::new(4L, 8L),
        ],
      ],
      -4.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(36L, 4L),
        @moonclip.Point64::new(36L, 36L),
        @moonclip.Point64::new(28L, 36L),
        @moonclip.Point64::new(28L, 4L),
      ],
    ]),
  )
  guard @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    )
    is Ok(outcome) else {
    fail("step 2 failed")
  }
  assert_eq(
    reference_tree(outcome),
    ref_sort([
      RefNode(
        1,
        false,
        [
          @moonclip.Point64::new(36L, 36L),
          @moonclip.Point64::new(28L, 36L),
          @moonclip.Point64::new(28L, 4L),
          @moonclip.Point64::new(36L, 4L),
        ],
        [],
      ),
    ]),
  )
  assert_eq(
    canonical_paths(outcome.to_paths()),
    canonical_paths([
      [
        @moonclip.Point64::new(36L, 36L),
        @moonclip.Point64::new(28L, 36L),
        @moonclip.Point64::new(28L, 4L),
        @moonclip.Point64::new(36L, 4L),
      ],
    ]),
  )
}

///|
// Full recipe SHA256: 2593259d3e50cb4e20be88d9d4e182d050a35f0b6ec3bf35dbafac383e992b99
test "reference composition: composition_stroke_cap_butt" {
  guard @moonclip.stroke_polyline(
      [@moonclip.Point64::new(0L, 10L), @moonclip.Point64::new(18L, 10L)],
      4.0,
      cap=@moonclip.CapType::Butt,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(18L, 12L),
        @moonclip.Point64::new(0L, 12L),
        @moonclip.Point64::new(0L, 8L),
        @moonclip.Point64::new(18L, 8L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.boolean_op(
      intermediate,
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(0L, 20L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(18L, 12L),
          @moonclip.Point64::new(0L, 12L),
          @moonclip.Point64::new(0L, 8L),
          @moonclip.Point64::new(18L, 8L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 28d357cbfd570c34cd68e40cf8d7b18da373a72faa83a555f67d227a2fd36190
test "reference composition: composition_stroke_cap_round" {
  guard @moonclip.stroke_polyline(
      [@moonclip.Point64::new(0L, 10L), @moonclip.Point64::new(18L, 10L)],
      4.0,
      cap=@moonclip.CapType::Round,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(20L, 9L),
        @moonclip.Point64::new(20L, 11L),
        @moonclip.Point64::new(18L, 12L),
        @moonclip.Point64::new(0L, 12L),
        @moonclip.Point64::new(-2L, 11L),
        @moonclip.Point64::new(-2L, 9L),
        @moonclip.Point64::new(0L, 8L),
        @moonclip.Point64::new(18L, 8L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.boolean_op(
      intermediate,
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(0L, 20L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 9L),
          @moonclip.Point64::new(20L, 11L),
          @moonclip.Point64::new(18L, 12L),
          @moonclip.Point64::new(0L, 12L),
          @moonclip.Point64::new(0L, 8L),
          @moonclip.Point64::new(18L, 8L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 8664a988eec142c18d32b8a6d595f76c1d16797e6b71538d94f2302308bcbd55
test "reference composition: composition_stroke_corner_butt" {
  guard @moonclip.stroke_polyline(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      4.0,
      cap=@moonclip.CapType::Butt,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(22L, 20L),
        @moonclip.Point64::new(18L, 20L),
        @moonclip.Point64::new(18L, 2L),
        @moonclip.Point64::new(0L, 2L),
        @moonclip.Point64::new(0L, -2L),
        @moonclip.Point64::new(22L, -2L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.boolean_op(
      intermediate,
      [
        [
          @moonclip.Point64::new(-4L, -4L),
          @moonclip.Point64::new(24L, -4L),
          @moonclip.Point64::new(24L, 24L),
          @moonclip.Point64::new(16L, 24L),
          @moonclip.Point64::new(16L, 4L),
          @moonclip.Point64::new(-4L, 4L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 20L),
          @moonclip.Point64::new(18L, 20L),
          @moonclip.Point64::new(18L, 2L),
          @moonclip.Point64::new(0L, 2L),
          @moonclip.Point64::new(0L, -2L),
          @moonclip.Point64::new(22L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 127826ff2d39fad0bcdda05092ff9259654bef0934d0f1d7ee6670d4e2501a4b
test "reference composition: composition_stroke_corner_round" {
  guard @moonclip.stroke_polyline(
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(20L, 20L),
      ],
      4.0,
      cap=@moonclip.CapType::Round,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(22L, 20L),
        @moonclip.Point64::new(21L, 22L),
        @moonclip.Point64::new(19L, 22L),
        @moonclip.Point64::new(18L, 20L),
        @moonclip.Point64::new(18L, 2L),
        @moonclip.Point64::new(0L, 2L),
        @moonclip.Point64::new(-2L, 1L),
        @moonclip.Point64::new(-2L, -1L),
        @moonclip.Point64::new(0L, -2L),
        @moonclip.Point64::new(22L, -2L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.boolean_op(
      intermediate,
      [
        [
          @moonclip.Point64::new(-4L, -4L),
          @moonclip.Point64::new(24L, -4L),
          @moonclip.Point64::new(24L, 24L),
          @moonclip.Point64::new(16L, 24L),
          @moonclip.Point64::new(16L, 4L),
          @moonclip.Point64::new(-4L, 4L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(22L, 20L),
          @moonclip.Point64::new(21L, 22L),
          @moonclip.Point64::new(19L, 22L),
          @moonclip.Point64::new(18L, 20L),
          @moonclip.Point64::new(18L, 2L),
          @moonclip.Point64::new(0L, 2L),
          @moonclip.Point64::new(-2L, 1L),
          @moonclip.Point64::new(-2L, -1L),
          @moonclip.Point64::new(0L, -2L),
          @moonclip.Point64::new(22L, -2L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: ee6623112b5ee7d75d74ed2d52852fe8d22f30510b47ab2744f3a7c744bea182
test "reference composition: composition_stroke_hole_butt" {
  guard @moonclip.stroke_polyline(
      [@moonclip.Point64::new(-10L, 20L), @moonclip.Point64::new(50L, 20L)],
      4.0,
      cap=@moonclip.CapType::Butt,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(50L, 22L),
        @moonclip.Point64::new(-10L, 22L),
        @moonclip.Point64::new(-10L, 18L),
        @moonclip.Point64::new(50L, 18L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.boolean_op(
      intermediate,
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
        [
          @moonclip.Point64::new(10L, 30L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(30L, 10L),
          @moonclip.Point64::new(10L, 10L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(10L, 22L),
          @moonclip.Point64::new(0L, 22L),
          @moonclip.Point64::new(0L, 18L),
          @moonclip.Point64::new(10L, 18L),
        ],
        [
          @moonclip.Point64::new(40L, 22L),
          @moonclip.Point64::new(30L, 22L),
          @moonclip.Point64::new(30L, 18L),
          @moonclip.Point64::new(40L, 18L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: 1074fc757c44577e13d059c748ce9d0d4fd1ed0797db1bf8682b0f3c2256515f
test "reference composition: composition_stroke_hole_round" {
  guard @moonclip.stroke_polyline(
      [@moonclip.Point64::new(-10L, 20L), @moonclip.Point64::new(50L, 20L)],
      4.0,
      cap=@moonclip.CapType::Round,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(52L, 19L),
        @moonclip.Point64::new(52L, 21L),
        @moonclip.Point64::new(50L, 22L),
        @moonclip.Point64::new(-10L, 22L),
        @moonclip.Point64::new(-12L, 21L),
        @moonclip.Point64::new(-12L, 19L),
        @moonclip.Point64::new(-10L, 18L),
        @moonclip.Point64::new(50L, 18L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.boolean_op(
      intermediate,
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(40L, 0L),
          @moonclip.Point64::new(40L, 40L),
          @moonclip.Point64::new(0L, 40L),
        ],
        [
          @moonclip.Point64::new(10L, 30L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(30L, 10L),
          @moonclip.Point64::new(10L, 10L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(10L, 22L),
          @moonclip.Point64::new(0L, 22L),
          @moonclip.Point64::new(0L, 18L),
          @moonclip.Point64::new(10L, 18L),
        ],
        [
          @moonclip.Point64::new(40L, 22L),
          @moonclip.Point64::new(30L, 22L),
          @moonclip.Point64::new(30L, 18L),
          @moonclip.Point64::new(40L, 18L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: bf9d70ece517a98ef1d0a5582615f84c297ba993d8236a01ce3c4eb4003f8054
test "reference composition: composition_stroke_straight_butt" {
  guard @moonclip.stroke_polyline(
      [@moonclip.Point64::new(-10L, 10L), @moonclip.Point64::new(30L, 10L)],
      4.0,
      cap=@moonclip.CapType::Butt,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(30L, 12L),
        @moonclip.Point64::new(-10L, 12L),
        @moonclip.Point64::new(-10L, 8L),
        @moonclip.Point64::new(30L, 8L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.boolean_op(
      intermediate,
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(0L, 20L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 12L),
          @moonclip.Point64::new(0L, 12L),
          @moonclip.Point64::new(0L, 8L),
          @moonclip.Point64::new(20L, 8L),
        ],
      ]),
    ),
  )
}

///|
// Full recipe SHA256: c6f0268561cedd40aea81c353511675d424e4327890dd5c8ece401499de0849c
test "reference composition: composition_stroke_straight_round" {
  guard @moonclip.stroke_polyline(
      [@moonclip.Point64::new(-10L, 10L), @moonclip.Point64::new(30L, 10L)],
      4.0,
      cap=@moonclip.CapType::Round,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    )
    is Ok(intermediate) else {
    fail("step 1 failed")
  }
  assert_eq(
    canonical_paths(intermediate),
    canonical_paths([
      [
        @moonclip.Point64::new(32L, 9L),
        @moonclip.Point64::new(32L, 11L),
        @moonclip.Point64::new(30L, 12L),
        @moonclip.Point64::new(-10L, 12L),
        @moonclip.Point64::new(-12L, 11L),
        @moonclip.Point64::new(-12L, 9L),
        @moonclip.Point64::new(-10L, 8L),
        @moonclip.Point64::new(30L, 8L),
      ],
    ]),
  )
  assert_eq(
    @moonclip.boolean_op(
      intermediate,
      [
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(0L, 20L),
        ],
      ],
      @moonclip.Intersection,
      fill_rule=@moonclip.NonZero,
    ).map(canonical_paths),
    Ok(
      canonical_paths([
        [
          @moonclip.Point64::new(20L, 12L),
          @moonclip.Point64::new(0L, 12L),
          @moonclip.Point64::new(0L, 8L),
          @moonclip.Point64::new(20L, 8L),
        ],
      ]),
    ),
  )
}
