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
        ),
      ),
    ),
  ]
}
