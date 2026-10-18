// Generated inputs only; expected geometry is NOT linked into this executable.

///|
fn run_cases() -> Array[Json] {
  [
    actual_case(
      "coincident_difference_evenodd",
      "d1dad3065ed51deb9244ae6227994f0a124d3a88963e770399e3a59eface550a",
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
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "coincident_intersection_evenodd",
      "c31f3e8bf855c2159802798c585e14ea0fba88835313b949ef57305bcd755852",
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
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "coincident_union_evenodd",
      "2135864ab736d0634cbb269b08a381c7dcf7b8913b65ca3795698e4c82fa1c7a",
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
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "coincident_xor_evenodd",
      "9ecfaae7229ae18277dcc99ccdf4916705b14e90c05e9d9ca9d7125aee37d96e",
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
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "concave_difference_evenodd",
      "2a0d94f1017807acc5c2e49a67e387cdb28eb905a4def7bfa7893719fa970d9a",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 4L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(4L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 8L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "concave_intersection_evenodd",
      "73d4af30548499e3c9b766b910e4e00e3de58bb75e7a9e4b1b4788ba0eeb10f7",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 4L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(4L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 8L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "concave_union_evenodd",
      "f3f16d5349149164f1392f255a369ac2f01374d29d0fdec0c08ecc6cfb7f6473",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 4L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(4L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 8L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "concave_xor_evenodd",
      "50f9d2d183e3686c2edbe38102b6aa2c728929b6d245160348972a867171bcfe",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 4L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(4L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 8L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "contained_difference_evenodd",
      "96cf858523172130b9c46a0ef212881120580d0efb71009f258069a657d9cda6",
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
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 8L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "contained_intersection_evenodd",
      "28d622728ae93d0bd0c66f4b404ca5e904f965c9ebe299424c25ce09191f6378",
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
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 8L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "contained_union_evenodd",
      "012dd8d3e376b6ceee549965ce06b7dcc8791a843472a583f8893774c8f6892e",
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
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 8L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "contained_xor_evenodd",
      "a274d2668f7041c2cc8a8470f2e90c1a8e016b5700393df11eb26bfce65cc6de",
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
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 8L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "disjoint_difference_evenodd",
      "86f186256d6e5904d927449815ce19e52d180f13ae7471fd8cd58018b20fc773",
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
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "disjoint_intersection_evenodd",
      "16eb2f9ba0c2454b0e7308e9a384002167a2d62750c23e2aea23326521c7fd90",
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
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "disjoint_union_evenodd",
      "f035c7b77554fe03db7440f0d9e5ee9a286a6db880fe6c7913ba8f380a6d2f7b",
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
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "disjoint_xor_evenodd",
      "c131bb1ae64e0f5088f5ae82e7466a5b982cb6acba511fd7fb5cc38fdf4e396c",
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
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "empty_both_difference_evenodd",
      "f312099b19975c6e1abb1b2f105a307f7b141687d3ffd0431c4bd4957d16ca3c",
      @moonclip.boolean_op([], [], @moonclip.Difference),
    ),
    actual_case(
      "empty_both_intersection_evenodd",
      "dadff11c88c44b318abc0145ed32d873b352f6659c7ebb386670b6ce2936172a",
      @moonclip.boolean_op([], [], @moonclip.Intersection),
    ),
    actual_case(
      "empty_both_union_evenodd",
      "e671f560c81383b9f6ac92b5fbd61584f1136a0b0507cf526fcb7799d0063c41",
      @moonclip.boolean_op([], [], @moonclip.Union),
    ),
    actual_case(
      "empty_both_xor_evenodd",
      "d66488ccd65e8abd6ff47bdfcfe51292e16f07ed87742e62efce599e6c40f146",
      @moonclip.boolean_op([], [], @moonclip.Xor),
    ),
    actual_case(
      "empty_clip_difference_evenodd",
      "9cef49c7000a33cea005e3c5f1503013881f8459055058c7dcb410380a6ed949",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        [],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "empty_clip_intersection_evenodd",
      "158d5969bfc0a75d428266b951ad92f94cdbd8f13458773c7fd2ed2d186f10a9",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        [],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "empty_clip_union_evenodd",
      "a969c628885f225a9057e9f75e86cd3d039caac44bf7481ae746fb3750b0db1c",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        [],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "empty_clip_xor_evenodd",
      "515393961176adc11b671883c97525adb9146073bfec95983c3a9e5b2017a5b7",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        [],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "empty_subject_difference_evenodd",
      "37f80e934a56662c5ad2cc4f6755c0f71caa4a2d319c257cf6312aed9cac0d07",
      @moonclip.boolean_op(
        [],
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "empty_subject_intersection_evenodd",
      "802f24c09d2b2ed6ce098b9e48d32625d8d66760e41895292846edeaf7202e49",
      @moonclip.boolean_op(
        [],
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "empty_subject_union_evenodd",
      "ca68aadf23e095f74f4f3d8804786960f34fc321f5423c830514becda7403c79",
      @moonclip.boolean_op(
        [],
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "empty_subject_xor_evenodd",
      "274bf0d37bab990b4f13634e301805c9866f7100521d4e1a669a9b90e3eda59e",
      @moonclip.boolean_op(
        [],
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "hole_difference_evenodd",
      "f0ea16637f0cd318f479306642b01e6762d57104bd268296e126cd6873b9fbab",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "hole_intersection_evenodd",
      "37b587f490d5f3a3275bce2b30408eec9981770855b10a60eab95d0d9dc2e605",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "hole_union_evenodd",
      "16c1a05092eee26b155eaa5ca083f2419ad12a9b0f9e068dfec5226d055105d3",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "hole_xor_evenodd",
      "ec7b21625523bfb5d9d649413836b1c0fd778181ac88d65e7d8e05f7a1df027e",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-20L, -20L),
            @moonclip.Point64::new(20L, -20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(-20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "island_difference_evenodd",
      "7660961e1f258f853aa87d7468c62bc20a3a5482f57533250147ad9128fa962c",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(20L, -20L),
            @moonclip.Point64::new(-20L, -20L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        [],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "island_intersection_evenodd",
      "754c324b8d68b83d92630c4051c256e647c80635a29de48147591c5a33bf44b2",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(20L, -20L),
            @moonclip.Point64::new(-20L, -20L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        [],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "island_union_evenodd",
      "0169f413b90ebb97d44c16c09ffa187cad7f0f928225e977b70d33dfa927729e",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(20L, -20L),
            @moonclip.Point64::new(-20L, -20L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        [],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "island_xor_evenodd",
      "5740c17afc9f31d68fe665a94d6ec9080fd56455f0384c38951fd9b77b6eb620",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-30L, -30L),
            @moonclip.Point64::new(30L, -30L),
            @moonclip.Point64::new(30L, 30L),
            @moonclip.Point64::new(-30L, 30L),
          ],
          [
            @moonclip.Point64::new(-20L, 20L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(20L, -20L),
            @moonclip.Point64::new(-20L, -20L),
          ],
          [
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(10L, -10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(-10L, 10L),
          ],
        ],
        [],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "multipart_difference_evenodd",
      "1b89c363726a43bd609d139796090cbfc292ffda1c46a56ddaa049703f06e0b2",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "multipart_intersection_evenodd",
      "9cd05ad0aaa1ac02fe26c4152b01421640c5671997aadd0322e312e690f56f66",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "multipart_union_evenodd",
      "fa4467e4fc8ba9003ed4c743bae98d0990f5f4730db601a5580969c5f85ab7c0",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "multipart_xor_evenodd",
      "00867c83c2419da6df001f2fd18bbc09388cc0120d9dbf423cb7358952a09175",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "negative_collinear_difference_evenodd",
      "eaad00d5e3d7ef093270dc6a74587c8faa83b6842698306f4594ff709f687f7f",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-20L, -10L),
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(0L, -10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(-20L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-15L, -15L),
            @moonclip.Point64::new(-5L, -15L),
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(-15L, 5L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "negative_collinear_intersection_evenodd",
      "ea7a761292647cf6fc2e94fd81244166627e43646d6a4234fa98039f27988208",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-20L, -10L),
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(0L, -10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(-20L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-15L, -15L),
            @moonclip.Point64::new(-5L, -15L),
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(-15L, 5L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "negative_collinear_union_evenodd",
      "b0bb174f799942a245463e93792e3b29baab437aa2df0e8f4d71e57c4fb2bec5",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-20L, -10L),
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(0L, -10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(-20L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-15L, -15L),
            @moonclip.Point64::new(-5L, -15L),
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(-15L, 5L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "negative_collinear_xor_evenodd",
      "9ed06091162a7f8033a71204d4a62a856cfee17a6cb620ad24d35ca1320ed3ab",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-20L, -10L),
            @moonclip.Point64::new(-10L, -10L),
            @moonclip.Point64::new(0L, -10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(-20L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-15L, -15L),
            @moonclip.Point64::new(-5L, -15L),
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(-15L, 5L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "overlap_difference_evenodd",
      "f046448f7bcfea0329e8e8a6f06bf715ebde1fe8d9b26743e0f26052a670e0a5",
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
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "overlap_intersection_evenodd",
      "df79229eb2dc6c897778272d4479c41c85765ca64d7fe344895a1d8fc716e174",
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
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "overlap_union_evenodd",
      "c1591f8e6087411bec4c14c63ec38f10065d135c0ddbf842374bec0683062726",
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
      ),
    ),
    actual_case(
      "overlap_xor_evenodd",
      "ef3f24d19b87a0f9604957af9d3098fe5cdd37f8805d9fa05b33249eb3e43d8f",
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
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "self_crossing_difference_evenodd",
      "7fa92d8059d37af5cf78e76f105716218872b0bcd2561ac2c3998e7b1f3b9187",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-8L, -8L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(-8L, 8L),
            @moonclip.Point64::new(8L, -8L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-6L, -6L),
            @moonclip.Point64::new(6L, -6L),
            @moonclip.Point64::new(6L, 6L),
            @moonclip.Point64::new(-6L, 6L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "self_crossing_intersection_evenodd",
      "78aa1e6d5bd4597ef16abe2e5c8d0f91097ec81c25047f6c31d9af2247b38b20",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-8L, -8L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(-8L, 8L),
            @moonclip.Point64::new(8L, -8L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-6L, -6L),
            @moonclip.Point64::new(6L, -6L),
            @moonclip.Point64::new(6L, 6L),
            @moonclip.Point64::new(-6L, 6L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "self_crossing_union_evenodd",
      "b3e05f496b792f3451718f38a81ad2574dc6fdc28e8793fe12e83a7404570bfc",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-8L, -8L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(-8L, 8L),
            @moonclip.Point64::new(8L, -8L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-6L, -6L),
            @moonclip.Point64::new(6L, -6L),
            @moonclip.Point64::new(6L, 6L),
            @moonclip.Point64::new(-6L, 6L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "self_crossing_xor_evenodd",
      "0e8d4d458cf340359bc237d9295f83e1525f5ffd853a35551a51ab90eaa8a34c",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(-8L, -8L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(-8L, 8L),
            @moonclip.Point64::new(8L, -8L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-6L, -6L),
            @moonclip.Point64::new(6L, -6L),
            @moonclip.Point64::new(6L, 6L),
            @moonclip.Point64::new(-6L, 6L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "touch_edge_difference_evenodd",
      "bdcff0940c9ca29360b6deb1d679fcd0300a9b60f882363ed2b5fbefb140a176",
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
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "touch_edge_intersection_evenodd",
      "7757b1e55056bd6eb2f0bcd948f47b7b84403163aa24a355984291bb72a775da",
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
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "touch_edge_union_evenodd",
      "95be5f888a5e1bc41919c1357f5fca9f0845d14c40ef2bec8cd3ed3004f78e30",
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
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "touch_edge_xor_evenodd",
      "ff7477dfcc6066b65a9c9ddca5b85598ce11f8f312a1aba17653bf1c95da24ac",
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
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
    actual_case(
      "touch_vertex_difference_evenodd",
      "1c64be373ddbd6966b5272909b964f175c3575228ae1bf611e0b21841ad50826",
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
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        @moonclip.Difference,
      ),
    ),
    actual_case(
      "touch_vertex_intersection_evenodd",
      "78a869737db376985bd87090fa552b1fd69a4d22dbc5ffad322c534b1bda821f",
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
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        @moonclip.Intersection,
      ),
    ),
    actual_case(
      "touch_vertex_union_evenodd",
      "ab2cf4cc75669ed805466cd586449f59ccf0dd7dca552a80ce078d7ea1a9bbf2",
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
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        @moonclip.Union,
      ),
    ),
    actual_case(
      "touch_vertex_xor_evenodd",
      "297da8ebe32ae185859af77621c699e8c652ba87a4c10f74e5819da81ad84cf7",
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
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 20L),
            @moonclip.Point64::new(10L, 20L),
          ],
        ],
        @moonclip.Xor,
      ),
    ),
  ]
}
