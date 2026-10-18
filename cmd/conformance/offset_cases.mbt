// Generated inputs only; expected offset geometry is NOT linked.

///|
fn run_offset_cases() -> Array[Json] {
  [
    actual_offset_case(
      "offset_acute_negative_bevel_evenodd",
      "dc3bb76a6878ecafb9c08bac1258f22aecf2d8067935d51a4f1d27dc05f5ace1",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_negative_bevel_nonzero",
      "13a44e93c85d9381186b83f8f4adc961a0c56ea7f74f9d76600bfc4588bf0e8f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_negative_miter_evenodd",
      "61189b61677caa75f887e1e06a5321d58f0f3d96fe30954626ab7b183c9f7a01",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_negative_miter_nonzero",
      "34273bb8cc8a408e65dcdff578c8b4e627c50f6d918992b0a74a04373dabbe16",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_negative_round_evenodd",
      "16c0ba1a2aee887b3c564c37db1746225d3bf7115a75493d9477f0a3872ddcff",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_negative_round_nonzero",
      "3d080b496963739691761001c07dc8176db256043eb2e196378e207a2bc6c8ab",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_negative_square_evenodd",
      "a2f754e141c13d9e42b07a69d01ba9bdac5542653823e7a15352e1e075e81cd9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_negative_square_nonzero",
      "91658258efd0f9c2849618ba8930d9b03a57ead1aa2408870e824bf9305c10bc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_positive_bevel_evenodd",
      "af0fe412a33b07fa55237461ef39a02766b654c361611e6ae6085af5327c488d",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_positive_bevel_nonzero",
      "434f8b3215c6cf618458ce7f92534891584c7a7f19122feb04821c0a9f0a3919",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_positive_miter_evenodd",
      "bfa8a1545f603c2118553c663d5ab1133537e6f64bdf44c28edac9cd990c4f21",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_positive_miter_nonzero",
      "9d46bd61140d2aa70e0ce7e120395feaadb7a03b9b52b71934b5528da8f48284",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_positive_round_evenodd",
      "3a648bfd7b26f001b08e49cd1e9c2e842c82e1562b8a4777ef87858c7d552d80",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_positive_round_nonzero",
      "ff89d8498b2fc9467cbfc2e8ab306dccb4585c1dc1427640453a7615f4547322",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_positive_square_evenodd",
      "e4f5354103a5e7a73c5200bfb3d011f178a5287b8a014a473552ccd72a92db56",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_acute_positive_square_nonzero",
      "9c0d4eb67e9fe600bc0d89d6976f5eb52e6eafcea1cc002f442937ca27f42b3e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t005_negative_round_evenodd",
      "243e91eaf1ab3412c4f110f052abbf32f50af655ee91d7eae114d9648fc54f03",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t005_negative_round_nonzero",
      "01eef16889de5e6f7dd458a6e13e4eabe5f73c0be34a063403ce08066431c4ed",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t005_positive_round_evenodd",
      "445394babd5151f39e60ae6c836d94b393b2ee2a1ac815747ef494f71dce00dc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t005_positive_round_nonzero",
      "a3cc8d7f84f457dc57eb42547c4fda03301e2286b6ff5786b94eafaf2dde4b90",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t025_negative_round_evenodd",
      "74525ab354e3bc31618aae010670ac7869a745327149e2bf84ba2915138d3c57",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t025_negative_round_nonzero",
      "4abda45050bbc4094b503bb5bdfdc47c7b08f8a6cda94fbbe7c13abee3e99b24",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t025_positive_round_evenodd",
      "dbd0634c9b8e6364a07defcc8276efc4e354c160a920c7dac4a9e3868300153b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t025_positive_round_nonzero",
      "dbbbd116b3e1697fb4bdb67b15f85be6e94f5567ed682d8d5fed54543c114f77",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t100_negative_round_evenodd",
      "cfd3c722181a5e1685f556cc999c2fdd19df771bd8a6fa65fce06e610f3d8a1e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t100_negative_round_nonzero",
      "5ff8b32472672d29bf59d740f509d05f2616fbd405de038f0860f8afa5f15b3c",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t100_positive_round_evenodd",
      "eabfd7b185b1660bedef358c0826589a351e5c7c9eeb58b4883dbc62566799db",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_acute_t100_positive_round_nonzero",
      "2f9ec5b30b5df741762a5d44ffc055603764b15044872268d178ba69c910a936",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(300L, 0L),
            @moonclip.Point64::new(10L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t005_negative_round_evenodd",
      "2b8614ee1a620bb83d3de51182aac3dfb3ee98233ab6eecc30919031519d144d",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t005_negative_round_nonzero",
      "13b0ac4bfa78998e9638a6e55b0e5d75e28e16041fc5d829fa59713110708066",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t005_positive_round_evenodd",
      "d7bd87074439e4edb3ce233c7d481cc7f7c22781b0809cdf2c02480d6576e43a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t005_positive_round_nonzero",
      "402ca0b4f727c000c4920cb7332e9fee8c5194961bea4594f2cec58bbfa950d2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t025_negative_round_evenodd",
      "00d09dc1be81f3af887201c6ae4754766db68c336eef84b16fe2036d4657aaf9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t025_negative_round_nonzero",
      "4dd65a96b604c8cc95c3e45e7c30409f63c1d0f8e4cf3fc5fb023bea1893f42a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t025_positive_round_evenodd",
      "ef67af795b794271349a69fc30b5f3a6f08c6db8c59631510b19a756298fe7d4",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t025_positive_round_nonzero",
      "fadf435ccd27944d0e2757f3205278cbde5cd5469f3b7e01b437afbe1dde8717",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t100_negative_round_evenodd",
      "4587218f5e5c59600551f7f56ed6e136cfefa7019c6301bdbe5016ba72ec2eac",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t100_negative_round_nonzero",
      "74ccecd5954197ee50903dd1432b91bb93050e0f7e2e00f1a7a4d33940a64d46",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t100_positive_round_evenodd",
      "a8a0d0692065d94c1a8e9df225b91393e7f4a20101c82f273cd171de7eb1b3e2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_hole_t100_positive_round_nonzero",
      "62862ca09207e56cba1668f866fb08438592c71c2bb16877365d90aac0d04966",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-150L, -150L),
            @moonclip.Point64::new(150L, -150L),
            @moonclip.Point64::new(150L, 150L),
            @moonclip.Point64::new(-150L, 150L),
          ],
          [
            @moonclip.Point64::new(-50L, 50L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(50L, -50L),
            @moonclip.Point64::new(-50L, -50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t005_negative_round_evenodd",
      "16623d38944ea747412be0645b7ed75492cdfae9147827b53d9c2e1c5e240f0c",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t005_negative_round_nonzero",
      "4c1be582ce3af3b2b3b9d3c6fb5c77d54d15f14cdbdd3dd48076802834ef3364",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t005_positive_round_evenodd",
      "09ab4f6ad4f6478f9160bd2e105b14048632143eb54809a5465400a5da03d982",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t005_positive_round_nonzero",
      "152afe7227fc63834736318b4cb22adf2d08285dfcb10f303a06f7fc5c8d7e1b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t025_negative_round_evenodd",
      "c58fab0a2ca59689d9c9835de8b8c04aa56fc038c0e0d65043fe2b1950366ec8",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t025_negative_round_nonzero",
      "d4869ab9a67b0dcce766331cdf7b4008ef91661f4de5126518213e64e27d1c9a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t025_positive_round_evenodd",
      "44afc310bc767b16dee8f70e3de7f4bb3af8534e9ee584f5eb4d3e94e5e8b992",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t025_positive_round_nonzero",
      "3a1c8c94bbd549b6ea7738491c250e6c52133a2662b5974428edf65f1b1f3321",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t100_negative_round_evenodd",
      "e179da0e8e81ad48ae49af34186e51685a0f42a78293aaf0b4d2f043920076b5",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t100_negative_round_nonzero",
      "21302dcd4cad4df2c1a965a259d70451f414f6b6116d0189e0e0b0a5ba86f2d2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t100_positive_round_evenodd",
      "0464532d7ef3155ac7b458600b9968655d3c3530ebaa817d49dd9e8cfaf9a769",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_neck_t100_positive_round_nonzero",
      "17453e2336cb7319f7e592a1d8bb875d6c7193a7cc97caedde095b57eebf26c9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(100L, 0L),
            @moonclip.Point64::new(100L, 40L),
            @moonclip.Point64::new(150L, 40L),
            @moonclip.Point64::new(150L, 0L),
            @moonclip.Point64::new(250L, 0L),
            @moonclip.Point64::new(250L, 100L),
            @moonclip.Point64::new(150L, 100L),
            @moonclip.Point64::new(150L, 60L),
            @moonclip.Point64::new(100L, 60L),
            @moonclip.Point64::new(100L, 100L),
            @moonclip.Point64::new(0L, 100L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t005_negative_round_evenodd",
      "0e966bebfba4419243802eaeb79570a89b45f80d8acb9c70b256f4e847d0a0f2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t005_negative_round_nonzero",
      "0febf5c319b78376279cd919f4d9f0ddbe7c002c25514fdc8312e4beccfa73b8",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t005_positive_round_evenodd",
      "4cfa7a3443ba63fd451985fc664a76b5e970f71c47c574c60f598d2ee524b721",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t005_positive_round_nonzero",
      "f92893a3caae48f65a80a975f3421ea944ff60dfb1cff3e7981a72055fc099c1",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t025_negative_round_evenodd",
      "ccb7a42c5390432f4669099a89fe9552eb85e44f4fa88c97a82b374813a42d62",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t025_negative_round_nonzero",
      "1783c147b68a7bb36fe63093e61c8edc2382234479f94da4c916d0566896700a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t025_positive_round_evenodd",
      "30e59bfa55c3ae4d1d3aa6891747a32c82fed0ac5354c572c1929a33b0d7ace4",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t025_positive_round_nonzero",
      "16321642640bb6a0eb06a9b48be1b617a6ca7d4ea3b4f8d0358ceff8b08d808a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t100_negative_round_evenodd",
      "720583fd473c3be2f57b7c595958833bfc662648de6efa928fe1cc71c9944e2e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t100_negative_round_nonzero",
      "41ab57725beea1a998c9b29d84321aa351957b13e8830a22eebe72fb54f04ff9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        -10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t100_positive_round_evenodd",
      "4fa77cd018eee0345d4b7c2e9d5ce418bbe659790e7d76e3d48cbb8c77d29fe5",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_arc_rectangle_t100_positive_round_nonzero",
      "53687de654c4e03bcefd2fba6171ea2ca1fa28976dcf25ea9538bd72682f09a2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 50L),
            @moonclip.Point64::new(0L, 50L),
          ],
        ],
        10.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_beyond_bevel_evenodd",
      "d5ae6c62ee000dad9a7c3440101124a4820da480f447272e9bbe68f35c415bfb",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -6.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_beyond_bevel_nonzero",
      "4aa865ddb58125c2230001df50b1d12dc7eea4ccad746f3d1cd1d936922c92a9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -6.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_beyond_miter_evenodd",
      "72ff4cd24492403d2acb38609f249e10b0a1e9d14161bdc2d8a9c9c1f6c2504f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -6.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_beyond_miter_nonzero",
      "deb3b9168a581133b6cfeb0c735537b19733c1d8c89d76d5da42b6fd67368b7e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -6.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_beyond_round_evenodd",
      "c76a5afe5db6655b9050784a7d779005ad159ccecf8efd6b7a11946095960e63",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -6.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_beyond_round_nonzero",
      "6d328eb8ba4c9d9def5b806b870b0578dd24e1ab143712a87d4c0a5bd7ffdb01",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -6.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_beyond_square_evenodd",
      "4a3cc519192258b6c51e59791e958167ea5c7c69c8d69de35b2548785c0fb687",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -6.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_beyond_square_nonzero",
      "155fae7f2df47929d5d8a343f0ea57a781049dcfac310c044b504dd742395497",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -6.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_exact_bevel_evenodd",
      "6cc8d6fbbc15b58b3b77ee4af141e7219f4502c55aac43220eeb0f46283b43d5",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -5.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_exact_bevel_nonzero",
      "46858506791972af64fb72c6543ef506dc608db659b7080234de1719b89dfe65",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -5.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_exact_miter_evenodd",
      "372af97c6d0b6acfe94e9858a7ae0cf33e2e01c93ca9bd8de01488364ce26501",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -5.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_exact_miter_nonzero",
      "de829707aad2cacd6ef14faa58757ec6ec9461a82c0bbd88427fb0bf69656ccc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -5.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_exact_round_evenodd",
      "b1bc187d63c64f34cf48e118e7ccdbea41ebef6a561c49ec78573edeae73194c",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -5.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_exact_round_nonzero",
      "64d9dff002be1dfc49bb7107763a6d6a84232f34ec2e7cfec4fba3f3a6df6313",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -5.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_exact_square_evenodd",
      "14d4fcec05ecea1949795b6355b87a5dbacfc08a7a3ca3821f2ba4a4330a0f4b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -5.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_collapse_exact_square_nonzero",
      "ec63b0da16ffbff66598c09b62268a5b4ac451dfb648f4322b98e766c7723599",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -5.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_negative_bevel_evenodd",
      "1d3e84cc772afa16d7d420332d4c13e8bcf29e9a0721a5c10a406ac3145c3817",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_negative_bevel_nonzero",
      "5f0c54d6ad1c7763c9b29a00f43df17a8cf30da8aae78cdca7810f536b4d47ef",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_negative_miter_evenodd",
      "49660b1d29254f1127b490542387b95c6f666552c88d4d34fb8b5edd965b0632",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_negative_miter_nonzero",
      "099f8a613bb6d963131e6d7bda29b8369ef4b6d28107a1455b690812b5faee4d",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_negative_round_evenodd",
      "0a489f1fb147a70307223e3083d0f71835b1e3786f68233e7de2c395c49143b3",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_negative_round_nonzero",
      "566339a6988885fcab002047a2cccd6829edc0a9019beb085b5706cb6b2f2c35",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_negative_square_evenodd",
      "55e77d6747c93bd57bd78831238d692353f2b79d40802d8555081c2e5cfd5a1e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_negative_square_nonzero",
      "403bb03c1fbca1c184ed6a7749ee6f3f89762d5ba3dcb2b9d149619621ae6b14",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_positive_bevel_evenodd",
      "c287286647dabb4cef9e6502069e9d09b56b348b0483f352cbedace1f71acc1d",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_positive_bevel_nonzero",
      "c98fcb917a62dedcee0dac213f2d8205cdee819ae7ddae73b71d302136edf06f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_positive_miter_evenodd",
      "9a759e28b28b176d41546d2afe6b4c5bf6b74225e8fd4c8860057d0372889f8b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_positive_miter_nonzero",
      "ed2bfb28bdba3c670aa5afb49ec5c12418d58abbb1aa2d0571e949bd12ef0bc3",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_positive_round_evenodd",
      "82193fbaa6404eba61753a84a45055cf98a03721cda5342c0cde73334b5a7620",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_positive_round_nonzero",
      "a03c4c4198285a21d0f21974c7e1f04f5537dffc6bc7cc5bac46b3bd4cce392f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_positive_square_evenodd",
      "2db6fada1a9da879251bcd96e8ffbae8508fed9a7573ce3d24fb769b0eb1e90e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_concave_l_positive_square_nonzero",
      "9ec79bea578a3736025047c06c54d81d3fbe89bc8f2ed6a46b233a21a6c2e982",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(40L, 0L),
            @moonclip.Point64::new(40L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 40L),
            @moonclip.Point64::new(0L, 40L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_negative_bevel_evenodd",
      "6767bd5887a1334e80abb7934ff0f4c50f38e31c0e3e5100260bd080573e1521",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_negative_bevel_nonzero",
      "92aeaaa1650334c4b50f4b32664a9438d14d67934b70c01b7a3a35833b95d4b7",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_negative_miter_evenodd",
      "07c31b8a40ac1b2246755b4d31e4a4fbebb8660ae3540b0bace59ee218e15f32",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_negative_miter_nonzero",
      "21bd66eb616f85c2e0f94ce43705ad0fe46c4b6d571dfc2dba11809c38dc98c7",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_negative_round_evenodd",
      "888bb48195ca69f8cadf7b2d57f826043e16bcbd9081f0b19bd4250c5fdfc5b6",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_negative_round_nonzero",
      "cbe6e5227072870e2ba9d92e01fc536f922a711f4218d61ac010741286dfd54c",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_negative_square_evenodd",
      "c3587047145c20bb29e636605a6ff36accaafa5fbf540431939bfcb835c4fd72",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_negative_square_nonzero",
      "b4b38a8423fd14ef4256cab137f64919fcde10b45f3e85d809bb1c5f28bd29dd",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_positive_bevel_evenodd",
      "3be581567f1ccdd5a6dcfece6632f00368b505ef7b5735806c1be7e252521a21",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        12.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_positive_bevel_nonzero",
      "86e8fe9d4d5309027fc0083777a9ea4c195054efed0e5dfa2f7f19955f8fef42",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        12.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_positive_miter_evenodd",
      "c13e0d80943857318766f72553f39fc83b05a94dc3b194edf65643cfef98f812",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        12.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_positive_miter_nonzero",
      "92519711d41e42f9456390966df75cea1421ad0aa485aba3a8d6952fb4a7b4b8",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        12.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_positive_round_evenodd",
      "d2ad438dcda2d8c2700500328e1b74a02dc3c40db706c8ef8328c56f11ee4a33",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        12.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_positive_round_nonzero",
      "ed0b4b3c832793be23ff37f90b58ad1ab012607765ff31fa5957b7d13c2dd73e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        12.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_positive_square_evenodd",
      "d5460813f697b5479823a3a68673a9901ebb34451cd4ae2654a0f7865dc3b29a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        12.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_hole_positive_square_nonzero",
      "132a43feab38d909601fd106936d79fade848496fe414bd46cd49b304c845fa7",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-10L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(-10L, -10L),
          ],
        ],
        12.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_negative_bevel_evenodd",
      "13a28f0c0cc32d53cc45d52c9ebd55dbf198e19edca5a77ff7bfc40a4a221bba",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_negative_bevel_nonzero",
      "6d1ac3c556f7fb531a190e2f4b7b2bbdc2d61d4c76c4a8424f57a36fc90a8572",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_negative_miter_evenodd",
      "d7c29ab2fc824fc90969d0d857c81630a2d75fa299f445f7e65975144588bf7a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_negative_miter_nonzero",
      "ad9b5f068847b203dff034357302904ccfa303052618e175c6758353d4dd1e91",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_negative_round_evenodd",
      "29fe4427e576fbb7b6d74d8dc4b46bcfd9463478435e35b96564c936ef6353a2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_negative_round_nonzero",
      "0fdcc8cccb152366e435faae3f322074e41778ebeb9f10567309ae301ec6e67e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_negative_square_evenodd",
      "defebfdeca599e4a51f2b9a4d3ac0703ea7c3601a3e9eb23f33e5967fbfe9907",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_negative_square_nonzero",
      "fb05f5cd3ed16017a7390809faa7727868a3b001dc0120c902ae7964b9ec54d7",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        -4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_positive_bevel_evenodd",
      "adeab60518742d59451067c1dc2d89200072260d7904911021afe81acde62f6a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_positive_bevel_nonzero",
      "fa9ea2b1ca346c7c60f92a4335ad1c3ffb3f98d72dd995112dcec4472dcc9dbc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_positive_miter_evenodd",
      "99a8bf83cbb981b97815a3a5e19f9a42ba7657f179848710ea3aea23f349b3fd",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_positive_miter_nonzero",
      "1aecb582a2cf5ee8734bd63e9c8390bc4b7b1e8970a7bcc8a8de126066b04ed6",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_positive_round_evenodd",
      "02a6fc971dc1f76a8318de3bd67daa144bc897c9e6f453c36739256e95bab86a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_positive_round_nonzero",
      "5adc4bff76a68255b8a99a9d04490c4f323263b7da8ff6aa1a25556a362bf37e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_positive_square_evenodd",
      "d3f38b1eb120b86be1344b2ca4257409fe1e6e819d5c939ff79d3c0aabf108c2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_island_positive_square_nonzero",
      "c4ed08e4bc55e0c0e215ed5c20372e4ca9a689254136127dda73d84176b3baa8",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-40L, -40L),
            @moonclip.Point64::new(40L, -40L),
            @moonclip.Point64::new(40L, 40L),
            @moonclip.Point64::new(-40L, 40L),
          ],
          [
            @moonclip.Point64::new(-25L, 25L),
            @moonclip.Point64::new(25L, 25L),
            @moonclip.Point64::new(25L, -25L),
            @moonclip.Point64::new(-25L, -25L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        4.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_miter10_negative_miter_evenodd",
      "42945040d3d07b0d89b19a6d8574f2224aac2430a99ad491816f11aa9b1dfdcf",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_miter10_negative_miter_nonzero",
      "ec3176c8ba940af0ee5c32d7bdff95d36f3c9a95266cdc95610dc5e1b5a7a4d8",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_miter10_positive_miter_evenodd",
      "252658dcf3ae036c53bb5098203e162b16a30846a00034823f897af3c29bb46f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_miter10_positive_miter_nonzero",
      "81a0660386cdbb82f3ea3b3ae1a4e5f8817eff27d7e57382d41fa2917d967b2a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_miter4_negative_miter_evenodd",
      "0eba3d5c761e284abc1de3d8e050ec96bc554f7cdcc5e14196bb9a918b785fb9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_miter4_negative_miter_nonzero",
      "6841d085c9bc651ae4b1087e7c2c9896230d7f5563177881d8490b9ac3eccfcc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_miter4_positive_miter_evenodd",
      "439ecc874204afacfded1baf450a1d8f96a6c12a645dd157e88e21f9edd07d44",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_miter4_positive_miter_nonzero",
      "4e2db0ba2f31d6d9263ab70e718ea5dc7ea792c97e40f65dca31d7a6ade41d72",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(60L, 0L),
            @moonclip.Point64::new(2L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_negative_bevel_evenodd",
      "0331296920cbb8dec431b5f1235e08b2fe47006ec0fc93ed808a62cc8bf4f586",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_negative_bevel_nonzero",
      "effb32f51ecbc289f5257fc667a9542cc4e217f4fe3cdcfdbcf033f7b9ea5962",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_negative_miter_evenodd",
      "72968e89ab861ecdafd9d124e1218a8734dd06c1ae11d8381513b7aadcd29b1f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_negative_miter_nonzero",
      "68143a9e06d9f29741d2d9d2ca25dfe452a64ea27b60ea286692b6aa15fdb31a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_negative_round_evenodd",
      "4eb5aab628cf6d41cc2c7c9e3dcd8ab4858ec2fb6eb9db37d7fcb1fb55b1bffe",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_negative_round_nonzero",
      "ce198327f30e911223cd817dbd51fa62b813619ab6dfd1c813e59fc6a7e85d40",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_negative_square_evenodd",
      "f77b2d8f243c98a1035584f54e7a62c62664a9d72bde92c990c61a565ca4e422",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_negative_square_nonzero",
      "71e821bfedd3b3902395f00f496c515bb0645d09c2bcd16ac4015e2f6f839fbc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_positive_bevel_evenodd",
      "c28a9b7eac801eea446ef1fc2f47751ebbdb93f2c52a4e16864721574960316f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_positive_bevel_nonzero",
      "49e634cec1fb6556da7b1ed8cb8ab724f7723d213bc7b19ff4bd3b8f8847bf6d",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_positive_miter_evenodd",
      "48a5dcc492aea41a451880de79ec6e146eb6d13978a6f93ffe1cbc23ece30be2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_positive_miter_nonzero",
      "644b0dbba124b0df4229f3595ad8858e1a280d77a3711561332000da4eb6e46f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_positive_round_evenodd",
      "a6745558cc1cf9e83195658001669147ae1d58c94798951223e817de8ca36145",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_positive_round_nonzero",
      "7829a9e32f5da06cd1b74cacad7047e86cbfc2c0af3bf865f7121443740eadf9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_positive_square_evenodd",
      "19ba9b768dcfa7f5de5c4ecddbbf85745bf72d2c69faaf0342a77c6574ac3eb6",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_mixed_overlap_positive_square_nonzero",
      "961b44d29b89abd3a214d0d1fd0d86769b9e2a0f7489825624042cbbfdfe7f99",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_negative_bevel_evenodd",
      "b2e7314c49f83e3c35ff4a0e38a52a113933cb853c4159d41a2df83b6f1491c9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_negative_bevel_nonzero",
      "4750071c64d968dc7c0fb25becdd259ecde93901bd83d2c354c2f1495e398910",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_negative_miter_evenodd",
      "a507ebf601f91e59d8e976615c9013a6cb20bbe3ac201121349b6e1d99d7cd4a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_negative_miter_nonzero",
      "621f8e7ae90e63518f013c138ee7ce30909f9fce5bd8a9ccba4162e0a8971a5a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_negative_round_evenodd",
      "09365a487706966718f515f3fee2ba34efa77fd86b5ec04fdc4f504b0d66de08",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_negative_round_nonzero",
      "5e0bf446242f3c2028a0daa62157eb961140a6f8fbe3815c812b1da00d8f4af9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_negative_square_evenodd",
      "2f3d3d6cc5eb8e7b7e5e77a8ace7aa9ae147655a4f33ace5875ab25809193fd6",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_negative_square_nonzero",
      "7b8333f6d31740181810cab16a9dc1956f7df646e985813d3583efc10a5e4428",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_positive_bevel_evenodd",
      "f3c2b0ca809bafbba2dcf5d35e63a0eed807b70785ab9d3487ff02bed0fdc2f3",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_positive_bevel_nonzero",
      "839c5c4cedcfc41fd550b92b1208e2ca7f26d8164203d72fb85c7997202336b9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_positive_miter_evenodd",
      "7413384f8e873e61efbf658bd54833036973ccd5a24591a04a08ccf46b85ce1a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_positive_miter_nonzero",
      "f1eb71d5ffcc22902529c743e857bd5bc7bc38f4494cdbb6e5b13f4ed2243c95",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_positive_round_evenodd",
      "ccceec1f835dda8024dd19c1bbc54872ab399d615493b0cd25b3370d342701d4",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_positive_round_nonzero",
      "40cd3da58f707ba566e2d46cc84de4a57e3f901bd22a2989635d00d8252e3a90",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_positive_square_evenodd",
      "2709c59831c9c11a00d270eec226dafc3d173e08003193efb8edbc418e7c672d",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_multipart_positive_square_nonzero",
      "8d74d3ce26fc996539e70a451020ad1da359d063c5e55b65f4ebf9fd6927a858",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(14L, 0L),
            @moonclip.Point64::new(24L, 0L),
            @moonclip.Point64::new(24L, 10L),
            @moonclip.Point64::new(14L, 10L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_negative_bevel_evenodd",
      "f3f27b1f03b1cd4778610837e73de8802f6f47c693965bad43c33538e75227b5",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_negative_bevel_nonzero",
      "c98c78673c7404171f213a98bb6060ec039f05738645f214c3701a766217eab3",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_negative_miter_evenodd",
      "8b7ea6a41ea119778f32639d75fcad0f3ec696fe5d44f1d2fbdcd7976b3f3232",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_negative_miter_nonzero",
      "cab1e8f4b78503688c66bc107792546eaf4f3bbe57924265cde95835ebcd41dc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_negative_round_evenodd",
      "5356f2592e912c9489bc8e709a32a1acaf4c406e2d4f0e2b6a98c011f2d3f63c",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_negative_round_nonzero",
      "a349741d640856ab993afc690dbafef0872f31381c0dfdd53b84a0123e022ecf",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_negative_square_evenodd",
      "0342b1cf29504740f9625c33b872c4517e7f9557ebf6020db53cb025f0dd93ae",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_negative_square_nonzero",
      "dbc451990ff97fcae7d5ae426273acc49a91398f39203f6028033dbb3e928e8e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_positive_bevel_evenodd",
      "145ee86a37b9ec64a833bc89b4d18832298d4463bdd80f76d8d29e275d706bd4",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_positive_bevel_nonzero",
      "2b15ea0bad16206e6de1eab05859b06f6251c71e2b958ffec882763b396837c0",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_positive_miter_evenodd",
      "1b1aa038dc9746fd64ea9b410479d4eda2b47df919778c296cbb5601327dea33",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_positive_miter_nonzero",
      "98b25a301a57103826978702525d3762407d3da2caf96a546d8f56130c4fc1ff",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_positive_round_evenodd",
      "e35e0b998f0913b5666a5b84e2f51bc507e26fb18d368688d4960a9f35b73a40",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_positive_round_nonzero",
      "75d21780509508b2ee53e0cca4c3e33fd910473cd6de49afe76b97559e80a022",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_positive_square_evenodd",
      "5b3a04d2dc5031fe58da71d2145872a8254f1dc67d793937c90882be066d93b5",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_neck_positive_square_nonzero",
      "7598523832cf712ae14d9ff2d80c317aa461397974a7bd87d45942bacb765693",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 8L),
            @moonclip.Point64::new(30L, 8L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(50L, 0L),
            @moonclip.Point64::new(50L, 20L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(30L, 12L),
            @moonclip.Point64::new(20L, 12L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_negative_bevel_evenodd",
      "e89f8564cc42aac9a9c6667daaebcdf1ae7d8910184b9793ce671c02c1f2d936",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_negative_bevel_nonzero",
      "261e71101c7068e74ac3d488b99d98d28e00243760aec1433afdcd0aad23b8bd",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_negative_miter_evenodd",
      "6b7af045af634ee5cf3e031f25b5a755f14bc2ca53bbbb43f4b260883f3f4bf9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_negative_miter_nonzero",
      "dee2705b23767b48c9af22b4b309447ca67bfc299149422ca90815cd9f28ec61",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_negative_round_evenodd",
      "49b9733f6848d3f8c1148dc7f7ee80f4d54e46de86baf4b153f1c6dc864c6311",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_negative_round_nonzero",
      "1b6cbddcb76e64ea6ba16de34673f19628ae8a03fbe6baf3bfbd8aa776d30276",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_negative_square_evenodd",
      "0a0a4a0fe15f559ed0f8071c3f41e54e37f9c3f0e23b1e70cf01ba7a182135ae",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_negative_square_nonzero",
      "232102315102900256b060ab49eef58775398acf8335d56b4a006a8e06d58db3",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_positive_bevel_evenodd",
      "89dd973e8c0eec0cf4a61d9aa73bf55592d5998f7603898c5a64a08bd339f350",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_positive_bevel_nonzero",
      "ef195755eb5a737e777bdceb2759fc4eba8ea3c6cadfaf70d0214747c3a9265b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_positive_miter_evenodd",
      "14c6262890b7ba9e6ecc3f87be675c9cf74d987b10014138a20d18ae2afdb33e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_positive_miter_nonzero",
      "2d0fab910579b40c39e2430b795d6329d42cbdd38ac11f7208a410bb449c1d33",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_positive_round_evenodd",
      "e1cea9f6ede6255a362161008658c6c402616fc4f5a2fcf1fd7146a35de3aa9f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_positive_round_nonzero",
      "8bc2835a18418fb86b94bfbe230139707ffbe566461b8795a199c4cb8cf02d3b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_positive_square_evenodd",
      "ccd34522946d4a8c046b835c29528003a2fdc9dda69ed27291747382f4570660",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_overlap_positive_square_nonzero",
      "33d57bface9e43f3b7a6e7a30fba156d882f3ba84edeb824ca4c91ffe69055af",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(0L, 20L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_negative_bevel_evenodd",
      "a723234d93ea2f799a0abb801fc2b7fa5e84977489f15ade6c6bc709aa54ae65",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_negative_bevel_nonzero",
      "34d53ef0fc7919f6c69709766eb997569b7ba02f253faafd1ba2a7608e1672e3",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_negative_miter_evenodd",
      "b2aeb1de3b71bebddcc4263a129d827d1de0a2566afea15615b1c5a501cffa05",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_negative_miter_nonzero",
      "20aaf3715c959b0e963d175dd1990a20c1ad8000fa9d7c9736010821198e63b3",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_negative_round_evenodd",
      "5a1ecc11503c41c534afa4fbb2c780c477ada107c5ab3bf9a44d1a07beb1812f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_negative_round_nonzero",
      "85c1ee89cd93a8d2d9c2c73b612ecc9da4ae38743b3a9c7ba42bd5f138057ed0",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_negative_square_evenodd",
      "47b77b5cc42b350bfd3b2c85dae37e9d5ed2ef339716a0a2dc8e99fc371fd188",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_negative_square_nonzero",
      "fd1c3edef640e74f07e252d4c1e2d264dc53475574b22af7161a731f2eb8e462",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        -2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_positive_bevel_evenodd",
      "3dba02308d9f464113d131bfcecdaba407ecc0855dd3a8b0dfe6c43945a8605e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_positive_bevel_nonzero",
      "cd7d30eef026fa17ac622632b66394fd7cc7c2dd1f87d6a61ae42dd8fea5d5a2",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_positive_miter_evenodd",
      "f23ef519f138d55ed69d2ec15de77ca6608a09c1e8f244906fd2c17b2cf48c08",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_positive_miter_nonzero",
      "102c7bd0490192bd037bb88d804de603be5a34778715b7c2933990e9da84da7b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_positive_round_evenodd",
      "5723a619f5b89e1f39643036424664434db79de3e7cef392cf69827f4e1acfd5",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_positive_round_nonzero",
      "c92bd1e1522b1d5419a157767d4302af10792133e16fc663aac54f5f435d1365",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_positive_square_evenodd",
      "e3148f06cc5ed51b0cbaf73abb284b46b18c5d77822c1e1490fa40defbc79d64",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        2.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_rectangle_positive_square_nonzero",
      "7e7983e5dce3419eebb84f75db7277ca9a826da7117a9b635da71d432878e11a",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        2.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_negative_bevel_evenodd",
      "3223c6065e932084522fbf88505a88f981f9fa2723a4ae26e218bf472b7cf7d6",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_negative_bevel_nonzero",
      "15de36d6b2a0e9ffce77133bace11d260b4dedb85bcda272ad4ce7a9dddf4731",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_negative_miter_evenodd",
      "745b2f86741404616f9f5636d9de53fb170ef83eadbeb421c59c0060d75517e0",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_negative_miter_nonzero",
      "5cf1dd1ae0541ac4b88ce41e40a0d09b34295c7fb9c7e28816e5acf609784037",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_negative_round_evenodd",
      "ed8c358607585ca4eb8fdd4828b78e0eb63fd3fb612397761c36d77132bbbf81",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_negative_round_nonzero",
      "5854ca91283a7455c206df63a523fbd9ee4fcf60ea0cad7ede556ac28061da3b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_negative_square_evenodd",
      "de26eb6f19c082e342ef4e4cc758d2cee2d12619e6753835faa26a0b56fb3b31",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_negative_square_nonzero",
      "b3c1522a5b4cca7f9ae3310c0409fcfab68731ee1634b2bfa6b4f934207ed879",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        -3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_positive_bevel_evenodd",
      "af42e3123c9ed0d63da4111cb516c3787d5b3d6c7599e98452294751a50e1850",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_positive_bevel_nonzero",
      "736b32d70f0640369580d9a589342a2673ec0997de93401fff07263d055e7fce",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_positive_miter_evenodd",
      "39a4ba26f19b03fc52f80d5c651916027a80788b464938c97ee762485aefede1",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_positive_miter_nonzero",
      "61e87dec0827d880939be53c82650d1540456f113ec2b5e6117f75b1c588475f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_positive_round_evenodd",
      "2c510ea09f8ef1b9091309d3538e050a1e3623ad23214702316e4ac50359300e",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_positive_round_nonzero",
      "4475258d5fcc3c52a4da14a9d231076e235a07c69b43f4105fad5a6431c8eeca",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_positive_square_evenodd",
      "20b321290529f0d0f30af29b88654d12442e7c3d34d69f1a31bf473abd6846aa",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_self_crossing_positive_square_nonzero",
      "84a60f593b4ad9e25f2b45f82cedf97cf302a94dfe85fb30b3e77a838b3555de",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, -20L),
          ],
        ],
        3.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n049_bevel_evenodd",
      "31a81e3504af548c967d66d0f4d8b831be41535d1c649718689c133813ac8145",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.49,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n049_bevel_nonzero",
      "75017c7c9f222006b854ab7833b0deb0d8286df669cabda422a435b18814efeb",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.49,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n049_miter_evenodd",
      "77ef87236fcedd70e385e4b137fcb61318e600583358005a9b3fff373b5a80ce",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.49,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n049_miter_nonzero",
      "a88feb88ca2676daf4ca9f5a711f2f36b71beeb1a3b5bfbca8ccd3af9e95d84c",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.49,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n049_round_evenodd",
      "084b4dd88587a53bc1507e8131a298615513035bda32bc7c354612dad2f3517d",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.49,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n049_round_nonzero",
      "18caff672761b063977a1969178ed630a197a2da9d43d3ccc87f6fe290652854",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.49,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n049_square_evenodd",
      "574132b97e5cb498ca21bb8c5ce1d23b8b81139db7903d311f4f43c77dffce66",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.49,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n049_square_nonzero",
      "101775aca36c391ef3ad6fb87d8fb64cf6f6073deda48937414ac9bf473627b5",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.49,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n05_bevel_evenodd",
      "84ab5a552d8cdf238383d4e1f6c83f6d39a72e78d66b3adadf24828ee99969dc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.5,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n05_bevel_nonzero",
      "9fd144ca4a1ae22232a03aeaf52f6d3a4aca84a374eb9a0e89d009a0985226d3",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.5,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n05_miter_evenodd",
      "55d91495ee8b39fba761b5249ac77e4f9f4c8171f7e57defed2258d993e7d973",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.5,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n05_miter_nonzero",
      "da2f491c48ef05425adced2ae7db9bdcd73afe45c6eef6ecc27d2a7758706b33",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.5,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n05_round_evenodd",
      "5b8651ae48d2a3155a1e1d89f1eb569a0dbc5c58bc1489eb2576376620aac33b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.5,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n05_round_nonzero",
      "838f50c4509aa97fbd70dcb568b2333f0e35ee6763015326d6942513f033b4ba",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.5,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n05_square_evenodd",
      "8ab3e5f103bb2a9227581662e7482c2bfd64fa29e2b1386171229b0142948a8f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.5,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_n05_square_nonzero",
      "e92f1f263bf2476c06db14b5e82b652cd0119f6eed64f1fbc97e16128d75e6bc",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        -0.5,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p049_bevel_evenodd",
      "4c313d9d0701605014c54adadc0ce577e9d69bd29ba9e6f6ddc3679c43b76c65",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.49,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p049_bevel_nonzero",
      "974febb89b96891d4abbf91853aeddca77072c6344847d8c3ddfd4775c4e52f4",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.49,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p049_miter_evenodd",
      "df607071b2620c7efc8615ce45050280f116b864b438c10ed5c8de8414b997f6",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.49,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p049_miter_nonzero",
      "4f4ca71f1737968737ad3209f751ae967e701a2d17a8f0c172fa4b7da6a998bf",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.49,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p049_round_evenodd",
      "87a30ddf6964bac793502a3d5730b534268b75161e1c7148764ade942628f1d6",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.49,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p049_round_nonzero",
      "3653e69d691efe132066b2f7d33ea1b877d1332d9c9032f0338b032f0effafc1",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.49,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p049_square_evenodd",
      "07a7caad9f58fe819c1f22fcb10bcdffb3b6983b2222049cd6ad51868153a2e9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.49,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p049_square_nonzero",
      "523d72c1874f77c96c5f00b7f3691c2261de6ebd5a402f96c4e83ba85defa0a5",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.49,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p05_bevel_evenodd",
      "3f0d01363432d5994e9da25fb2586c9cd2d8b05ab8768cfc1c89894253b8d340",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.5,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p05_bevel_nonzero",
      "f81e1d3459d55ad8d74c39e9ba6f90f438c2f0a339330d0b396f6682ca5eb512",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.5,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p05_miter_evenodd",
      "40d0ef39fbc1547c0bd208c9a9b63a9f42cffde76558996f2f193f5c2522ee07",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.5,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p05_miter_nonzero",
      "771f792d101dcf309805a078934ba99c5a142a8630172bbc831eb5f22bf11391",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.5,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p05_round_evenodd",
      "3a66942eea20ec1e54c18fb693358f7fc95576b157e2e586fc766a96a924b7fa",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.5,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p05_round_nonzero",
      "48724abdd46e03e15923223782bd5dd771508a57a582ba9ee39f0a33b4289d27",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.5,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p05_square_evenodd",
      "478381b093af6804b4b3668a7d400fc88efe19a7176088d8b1a4ab2e8a26ad1b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.5,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_p05_square_nonzero",
      "ebfea7d7afa14ab1429415bd178e2182b479d47913dcefbdac98b1f133e4819f",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.5,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_zero_bevel_evenodd",
      "dd054a84680c765ba10d64a7fc1c0f86858ebf5e8f51325b2822dff8825babf9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_zero_bevel_nonzero",
      "7d40992f960e8608582401873fd00bda1416c3f5c51998f4e6478d58f22aa0ed",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_zero_miter_evenodd",
      "83508afe9a85d471cab6ec16c9fdeabee7c23cdbe1c7d286c290df1c1b9bfc0c",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_zero_miter_nonzero",
      "11ffe93fb2c97ba63511c8c8667297683fcc549bf8c28e04642ddbba224f24f9",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_zero_round_evenodd",
      "89e6a9876a2d516e3c09dca7357f5befa8dc2bb543680c672744d346ec179561",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_zero_round_nonzero",
      "650761ee2cd2933cbad5ad8a25bdfa44b4e274b2706b7fbe498a57ee875f9c28",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_zero_square_evenodd",
      "6e420f8a57e2a9d95ddc37940c7245ef336ee79fe1b2c47e31c1de24291d80fe",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.0,
        fill_rule=@moonclip.EvenOdd,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "offset_small_zero_square_nonzero",
      "957faf8b1919b2d86841842506d0503081a2a964581b60b240e31049996d360b",
      @moonclip.offset_polygons(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(15L, 0L),
            @moonclip.Point64::new(15L, 10L),
            @moonclip.Point64::new(5L, 10L),
          ],
        ],
        0.0,
        fill_rule=@moonclip.NonZero,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
  ]
}
