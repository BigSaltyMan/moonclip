// Generated inputs/parameters/hashes only; NO expected contours.

///|
fn composition_case_0() -> Json {
  let id = "composition_boolean_disjoint_in"
  let digest = "b8a83b7ae451bc790800343ede2c3b17002898f912d61d70c7690bd1d48f1b06"
  let intermediate = match
    @moonclip.boolean_op(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.offset_polygons(
      intermediate,
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(id, digest, "BooleanThenOffset", intermediate, outcome)
}

///|
fn composition_case_1() -> Json {
  let id = "composition_boolean_disjoint_out"
  let digest = "fae5429ab6fb1aa1e4ad08ee122bfcf2c2d7f4f5bab37091bb9cdd17402e4ccd"
  let intermediate = match
    @moonclip.boolean_op(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.offset_polygons(
      intermediate,
      2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(id, digest, "BooleanThenOffset", intermediate, outcome)
}

///|
fn composition_case_2() -> Json {
  let id = "composition_boolean_hole_in"
  let digest = "34da37275c913d8b757e008abc020217bab05873831da413d858e65f78846e88"
  let intermediate = match
    @moonclip.boolean_op(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.offset_polygons(
      intermediate,
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(id, digest, "BooleanThenOffset", intermediate, outcome)
}

///|
fn composition_case_3() -> Json {
  let id = "composition_boolean_hole_out"
  let digest = "e7ab017ca2fc7c33daf83614318eb51b5ccc2ea8dbd4364ba1a3837be4663695"
  let intermediate = match
    @moonclip.boolean_op(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.offset_polygons(
      intermediate,
      2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(id, digest, "BooleanThenOffset", intermediate, outcome)
}

///|
fn composition_case_4() -> Json {
  let id = "composition_boolean_notch_in"
  let digest = "4431d617a834968a70e8aa45c78cd922719ad87953b137bc3a75aaf04285c46e"
  let intermediate = match
    @moonclip.boolean_op(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.offset_polygons(
      intermediate,
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(id, digest, "BooleanThenOffset", intermediate, outcome)
}

///|
fn composition_case_5() -> Json {
  let id = "composition_boolean_notch_out"
  let digest = "9a637b2197c0c377b90c8485e602ebd5b6cb57e3e9ca0ffb0886ca659b6daa74"
  let intermediate = match
    @moonclip.boolean_op(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.offset_polygons(
      intermediate,
      2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(id, digest, "BooleanThenOffset", intermediate, outcome)
}

///|
fn composition_case_6() -> Json {
  let id = "composition_boolean_overlap_in"
  let digest = "274db4781d8892479d430f660cfc67636460f31f9aca8c82121d9e4bbe685d20"
  let intermediate = match
    @moonclip.boolean_op(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.offset_polygons(
      intermediate,
      -2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(id, digest, "BooleanThenOffset", intermediate, outcome)
}

///|
fn composition_case_7() -> Json {
  let id = "composition_boolean_overlap_out"
  let digest = "8b2b71c3b87d277c35952322a0df4985230b99719c378a4acd108efa7922f93b"
  let intermediate = match
    @moonclip.boolean_op(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.offset_polygons(
      intermediate,
      2.0,
      fill_rule=@moonclip.NonZero,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(id, digest, "BooleanThenOffset", intermediate, outcome)
}

///|
fn composition_case_8() -> Json {
  let id = "composition_inset_channel_d2"
  let digest = "714b25fdeb696692416d4af779fc8c2caa2f830e94b003dc1340f943f9fec017"
  let intermediate = match
    @moonclip.offset_polygons(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id,
    digest,
    "InsetThenTree",
    intermediate,
    outcome.to_paths(),
    tree=actual_tree(outcome),
  )
}

///|
fn composition_case_9() -> Json {
  let id = "composition_inset_channel_d4"
  let digest = "cc4d4c9ac021e099f8908853f4a0ce82fd63414beecdf0fd85825d3b0202ae21"
  let intermediate = match
    @moonclip.offset_polygons(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id,
    digest,
    "InsetThenTree",
    intermediate,
    outcome.to_paths(),
    tree=actual_tree(outcome),
  )
}

///|
fn composition_case_10() -> Json {
  let id = "composition_inset_hole_d2"
  let digest = "489685cd7123629d9afc711890c1dc572f543a57bd4cd3d673378fdef4ec37c7"
  let intermediate = match
    @moonclip.offset_polygons(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id,
    digest,
    "InsetThenTree",
    intermediate,
    outcome.to_paths(),
    tree=actual_tree(outcome),
  )
}

///|
fn composition_case_11() -> Json {
  let id = "composition_inset_hole_d4"
  let digest = "0a1bc65d82254cfd3bd8a882eb45b6e776a1208a5c1bc47d90c41b051206a680"
  let intermediate = match
    @moonclip.offset_polygons(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id,
    digest,
    "InsetThenTree",
    intermediate,
    outcome.to_paths(),
    tree=actual_tree(outcome),
  )
}

///|
fn composition_case_12() -> Json {
  let id = "composition_inset_island_d2"
  let digest = "792c04971b0004394faf35caa0405202314f54d23ea8f9de71b803ee3e24cb21"
  let intermediate = match
    @moonclip.offset_polygons(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id,
    digest,
    "InsetThenTree",
    intermediate,
    outcome.to_paths(),
    tree=actual_tree(outcome),
  )
}

///|
fn composition_case_13() -> Json {
  let id = "composition_inset_island_d4"
  let digest = "1fb684651641b018fa6d6e89963719740623e42e4397636651873420a128c1c2"
  let intermediate = match
    @moonclip.offset_polygons(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id,
    digest,
    "InsetThenTree",
    intermediate,
    outcome.to_paths(),
    tree=actual_tree(outcome),
  )
}

///|
fn composition_case_14() -> Json {
  let id = "composition_inset_touch_d2"
  let digest = "f0b1c23ae72f33ec241cc9aa17aca73d9fb983f2228cbaffb04125472ea0953e"
  let intermediate = match
    @moonclip.offset_polygons(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id,
    digest,
    "InsetThenTree",
    intermediate,
    outcome.to_paths(),
    tree=actual_tree(outcome),
  )
}

///|
fn composition_case_15() -> Json {
  let id = "composition_inset_touch_d4"
  let digest = "77453cfe557e67abb1456f3f04986a4f879c5de38ad52f7ae583b9c028ea48a6"
  let intermediate = match
    @moonclip.offset_polygons(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
    @moonclip.boolean_tree(
      intermediate,
      [],
      @moonclip.Union,
      fill_rule=@moonclip.NonZero,
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id,
    digest,
    "InsetThenTree",
    intermediate,
    outcome.to_paths(),
    tree=actual_tree(outcome),
  )
}

///|
fn composition_case_16() -> Json {
  let id = "composition_stroke_cap_butt"
  let digest = "2593259d3e50cb4e20be88d9d4e182d050a35f0b6ec3bf35dbafac383e992b99"
  let intermediate = match
    @moonclip.stroke_polyline(
      [@moonclip.Point64::new(0L, 10L), @moonclip.Point64::new(18L, 10L)],
      4.0,
      cap=@moonclip.CapType::Butt,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id, digest, "StrokeThenIntersection", intermediate, outcome,
  )
}

///|
fn composition_case_17() -> Json {
  let id = "composition_stroke_cap_round"
  let digest = "28d357cbfd570c34cd68e40cf8d7b18da373a72faa83a555f67d227a2fd36190"
  let intermediate = match
    @moonclip.stroke_polyline(
      [@moonclip.Point64::new(0L, 10L), @moonclip.Point64::new(18L, 10L)],
      4.0,
      cap=@moonclip.CapType::Round,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id, digest, "StrokeThenIntersection", intermediate, outcome,
  )
}

///|
fn composition_case_18() -> Json {
  let id = "composition_stroke_corner_butt"
  let digest = "8664a988eec142c18d32b8a6d595f76c1d16797e6b71538d94f2302308bcbd55"
  let intermediate = match
    @moonclip.stroke_polyline(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id, digest, "StrokeThenIntersection", intermediate, outcome,
  )
}

///|
fn composition_case_19() -> Json {
  let id = "composition_stroke_corner_round"
  let digest = "127826ff2d39fad0bcdda05092ff9259654bef0934d0f1d7ee6670d4e2501a4b"
  let intermediate = match
    @moonclip.stroke_polyline(
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id, digest, "StrokeThenIntersection", intermediate, outcome,
  )
}

///|
fn composition_case_20() -> Json {
  let id = "composition_stroke_hole_butt"
  let digest = "ee6623112b5ee7d75d74ed2d52852fe8d22f30510b47ab2744f3a7c744bea182"
  let intermediate = match
    @moonclip.stroke_polyline(
      [@moonclip.Point64::new(-10L, 20L), @moonclip.Point64::new(50L, 20L)],
      4.0,
      cap=@moonclip.CapType::Butt,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id, digest, "StrokeThenIntersection", intermediate, outcome,
  )
}

///|
fn composition_case_21() -> Json {
  let id = "composition_stroke_hole_round"
  let digest = "1074fc757c44577e13d059c748ce9d0d4fd1ed0797db1bf8682b0f3c2256515f"
  let intermediate = match
    @moonclip.stroke_polyline(
      [@moonclip.Point64::new(-10L, 20L), @moonclip.Point64::new(50L, 20L)],
      4.0,
      cap=@moonclip.CapType::Round,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id, digest, "StrokeThenIntersection", intermediate, outcome,
  )
}

///|
fn composition_case_22() -> Json {
  let id = "composition_stroke_straight_butt"
  let digest = "bf9d70ece517a98ef1d0a5582615f84c297ba993d8236a01ce3c4eb4003f8054"
  let intermediate = match
    @moonclip.stroke_polyline(
      [@moonclip.Point64::new(-10L, 10L), @moonclip.Point64::new(30L, 10L)],
      4.0,
      cap=@moonclip.CapType::Butt,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id, digest, "StrokeThenIntersection", intermediate, outcome,
  )
}

///|
fn composition_case_23() -> Json {
  let id = "composition_stroke_straight_round"
  let digest = "c6f0268561cedd40aea81c353511675d424e4327890dd5c8ece401499de0849c"
  let intermediate = match
    @moonclip.stroke_polyline(
      [@moonclip.Point64::new(-10L, 10L), @moonclip.Point64::new(30L, 10L)],
      4.0,
      cap=@moonclip.CapType::Round,
      options=@moonclip.OffsetOptions::new(
        join=@moonclip.JoinType::Miter,
        miter_limit=2.0,
        arc_tolerance=0.0,
      ),
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 1, e)
  }
  let outcome = match
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
    ) {
    Ok(value) => value
    Err(e) => return composition_failure(id, digest, 2, e, intermediate~)
  }
  composition_success(
    id, digest, "StrokeThenIntersection", intermediate, outcome,
  )
}

///|
fn run_composition_cases() -> Array[Json] {
  [
    composition_case_0(),
    composition_case_1(),
    composition_case_2(),
    composition_case_3(),
    composition_case_4(),
    composition_case_5(),
    composition_case_6(),
    composition_case_7(),
    composition_case_8(),
    composition_case_9(),
    composition_case_10(),
    composition_case_11(),
    composition_case_12(),
    composition_case_13(),
    composition_case_14(),
    composition_case_15(),
    composition_case_16(),
    composition_case_17(),
    composition_case_18(),
    composition_case_19(),
    composition_case_20(),
    composition_case_21(),
    composition_case_22(),
    composition_case_23(),
  ]
}
