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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "coincident_difference_nonzero",
      "d5c38935ab13fcfa2868e96409583bd42ef72425ed2753bcb70b5fb2eb2cdcbd",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "coincident_intersection_nonzero",
      "05052fee303070f70b548e029c33a63973d10fd42c6d076270fbb4bd1156c80a",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "coincident_union_nonzero",
      "84195fe9a94c0d22150635603ce2564ccb0e3223832ee1c77b90f14decf7d68b",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "coincident_xor_nonzero",
      "88a5ff193cf9c8e95b9caade29859b759cbe89bbdf1f623874c443558da50298",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "concave_difference_nonzero",
      "9463eafa77b615365a04d8d75db754983e3ea5c6cd82bf4c773ebf785b444abe",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "concave_intersection_nonzero",
      "064f50885edd3aa6ce7d6059e14f6a95df305076b973603cd2ec2e2eb4587c5e",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "concave_union_nonzero",
      "a9bfa07f50e4cec16d6f83f64d4363f1450b2c3c977e34dc17ab9f218844176a",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "concave_xor_nonzero",
      "d1a9f22864d1071ef62a190ee05d4c65fbc1f4f8ee8ba5834460f22508dcd913",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "contained_difference_nonzero",
      "219623217e974e9410deda15455d9318b90883ea2269602df0aa67d0b94914af",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "contained_intersection_nonzero",
      "2e5b7774a046fceb0fc082536db408fe878e7cc6976f164eb700f2f09727ed53",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "contained_union_nonzero",
      "51b991e59238cd18ef20667eddf92df8651c6fd4045272dd26fb0a6051d0de23",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "contained_xor_nonzero",
      "a6b698584cd8b51a34bfdfca7d58f83a60a7a8e76b402bd6675bc949ea7d8556",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "disjoint_difference_nonzero",
      "1928f2fc3a28f7e58de065b25e5605a7ac144b4c2228fb1ed4789d62af5dccd3",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "disjoint_intersection_nonzero",
      "08267414e96e66b36cd25407ccba811adcf1e88bd4beb963f9837088fe3fd94e",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "disjoint_union_nonzero",
      "2ba4434be5a9dad7b0a4fda995eb9b4c2c819f881d59cebb77f7ad0a3c6a958b",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "disjoint_xor_nonzero",
      "eb9b92577ae9b4688d623d96115d5a1ec36058028d9b7f02e45d857fed26f281",
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
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "empty_both_difference_evenodd",
      "f312099b19975c6e1abb1b2f105a307f7b141687d3ffd0431c4bd4957d16ca3c",
      @moonclip.boolean_op(
        [],
        [],
        @moonclip.Difference,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_both_difference_nonzero",
      "5503f76e31852b5446c7fa8b02c9b6c2ecf1d7d249822f31bf24e046007f5153",
      @moonclip.boolean_op(
        [],
        [],
        @moonclip.Difference,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "empty_both_intersection_evenodd",
      "dadff11c88c44b318abc0145ed32d873b352f6659c7ebb386670b6ce2936172a",
      @moonclip.boolean_op(
        [],
        [],
        @moonclip.Intersection,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_both_intersection_nonzero",
      "641edfb68ea1f21d8af944edb6b36e350c81de6b1a393cd0a8426998d5a1fed5",
      @moonclip.boolean_op(
        [],
        [],
        @moonclip.Intersection,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "empty_both_union_evenodd",
      "e671f560c81383b9f6ac92b5fbd61584f1136a0b0507cf526fcb7799d0063c41",
      @moonclip.boolean_op([], [], @moonclip.Union, fill_rule=@moonclip.EvenOdd),
    ),
    actual_case(
      "empty_both_union_nonzero",
      "35385e3a0fd02cde13b46f8e87b07afd8eeef02a48b6750991c9404e27d973c7",
      @moonclip.boolean_op([], [], @moonclip.Union, fill_rule=@moonclip.NonZero),
    ),
    actual_case(
      "empty_both_xor_evenodd",
      "d66488ccd65e8abd6ff47bdfcfe51292e16f07ed87742e62efce599e6c40f146",
      @moonclip.boolean_op([], [], @moonclip.Xor, fill_rule=@moonclip.EvenOdd),
    ),
    actual_case(
      "empty_both_xor_nonzero",
      "db4f104c0652fef108685d895c8211532ee4e93c55ba1f75c3d4b0981a59a46c",
      @moonclip.boolean_op([], [], @moonclip.Xor, fill_rule=@moonclip.NonZero),
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_clip_difference_nonzero",
      "9e27a448754a465cdec05ea788449a47d4f7eda5ed4505e369aefefd4f2a8131",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_clip_intersection_nonzero",
      "602c5aeff48c5c0e5d07dc1e638fd6c98b1d4f98d1ec51d438f974b2575af651",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_clip_union_nonzero",
      "f44cbdf2f25a4175b587b5f2f8c68c4341853964f3d143b8ca6b6eef85f3cefe",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_clip_xor_nonzero",
      "e1ab272bddcfc59c7e9cd0209c5ca77c3cd59901b897ccecf9b3943f500ca4a9",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_subject_difference_nonzero",
      "eac77880fe1f2aa98de558db6f88a4a444f63bc1166704bb0858e3491def3543",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_subject_intersection_nonzero",
      "67b4caee5a3ff434f793dd323a899454e0acd9b099f18cc17236c04621ae5a4b",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_subject_union_nonzero",
      "e16100c6f2b63237bc7b38606b765b9cf6199b84a2533b6c3dc0e50becd5d5da",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "empty_subject_xor_nonzero",
      "7a903d3de654543d1526180ce070cc3d97b322a04c1cc015a84ed3e076701bbd",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "hole_difference_nonzero",
      "9f6f2364005e761535dcba1398c557ff266aeef5f600e4f380786c3166af8d65",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "hole_intersection_nonzero",
      "8b57aeaabfec3b77afbfba50ad22ec22424f9af331a999aace1dd659d9482375",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "hole_union_nonzero",
      "bf1e88dcea960dc729be41c779055a57b95018fb3db2e17e836b4fb8fd50abae",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "hole_xor_nonzero",
      "621c42c74ee61d08702d7ef15b6173effc067b198d2777a148f93351f8855249",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "island_difference_nonzero",
      "0e4ec8441ae26eb9d1bee19ec6fef0ad393f804920720c3a251c12be59f3351e",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "island_intersection_nonzero",
      "4411db7a5e3f6dec725818ef81b83218fde2c7c78364c55655f02242f210705d",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "island_union_nonzero",
      "5a1a323459d6f0e85fd32d4d9624a92bc3bda3cb51e0d57f1dfe2d3f9577d4f5",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "island_xor_nonzero",
      "8cdd4a635e4a67dfaaa87524b6a25a720501ab53da5ad94f75909b65f07844db",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "multipart_difference_nonzero",
      "dea6eaac5f19e62255890ab347d47a08b01c9947853bdcb5397b48a6a8fa7caf",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "multipart_intersection_nonzero",
      "b7fd20b1b4b721392011a0ae5bb5bcfd6eed20d6dcb6c8f4a38a1e4b1eaec318",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "multipart_union_nonzero",
      "203149998032ea7a5846d4841770282bd70c13e1807b1e15581504088498d10f",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "multipart_xor_nonzero",
      "4389dd271fc5873496abd90c46b702223aee1ef46f4ce80f3859aed59715cd18",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "negative_collinear_difference_nonzero",
      "3b9693af879543a4d74fd2f538611bd6857c1e28055cde530cf88094b0cee1e9",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "negative_collinear_intersection_nonzero",
      "97b2ed5f0f98115accda15172442133dda9a31dfb5c05b9af0ad791abdc287e5",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "negative_collinear_union_nonzero",
      "4e0cd380076251b8175d3378ade72e72e928e664882bef591c2951cdf70d9918",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "negative_collinear_xor_nonzero",
      "c23c05c1a3a834c3ded9f110476f89e5ed49c0f1085e249f91e8b4d8637d1a62",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "overlap_difference_nonzero",
      "5621be59c0132ce145123c0dec67af36c6926527b390f63f748a5abef3304630",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "overlap_intersection_nonzero",
      "4d117e01947609d9e2286a6518178cc5a08228747e9fd93e54c5b9cd5553ded4",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "overlap_union_nonzero",
      "02d9538cac117d6f91301ff01429f7e7e9cc3631cae57fecd9a52df53ca445b2",
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "overlap_xor_nonzero",
      "3a135d9348130b03e6e599526320b9c9ebd45f995999c006717bf7823f08f9b2",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "self_crossing_difference_nonzero",
      "0cf49e83f97c8123791b7a45ed363355598f8955ac54a1f56e5ce7b6cbcd2eb4",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "self_crossing_intersection_nonzero",
      "22c87f7a185d7b9569684d5d43d7ca62f76347b8ad0c8b05ac5605d8565368c6",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "self_crossing_union_nonzero",
      "00ded4b93794ffe6dc0e8247f486838d35b5eb614b71a00954ec92c8c5b4182b",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "self_crossing_xor_nonzero",
      "72e69660ae93f7f6e5d83e037f32191c7ecb4e09e0d8cf06da008e547d8aeb45",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "touch_edge_difference_nonzero",
      "25a7d801306603d45f8ccfbb2f13d81631e0e0a4b866f581b480629aa88b2428",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "touch_edge_intersection_nonzero",
      "90e5cf16210b969be00704885cd471c11f1eb01996a6bbd2f12d87b8ba9a3cae",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "touch_edge_union_nonzero",
      "f4ddcc11ec06f7223b009ead3f69e3d532bde79a1a6faf14aa5ad582bdb7cde6",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "touch_edge_xor_nonzero",
      "0f6667219d0964f3a82a4d2f5e986fd604f9c7d427952623391157afc512f676",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "touch_vertex_difference_nonzero",
      "84db29815d16448a120df5c1703ee3d45febc3e72200586b87150760debe6987",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "touch_vertex_intersection_nonzero",
      "e96ef4341b1b19bb733ca7a148557089eb9aaacfe1b94a29de3db8aa2ef7440f",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "touch_vertex_union_nonzero",
      "ae521d55248895f877117966dfbeeeaf4140c6905397e758f291fd4030e9d730",
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
        fill_rule=@moonclip.NonZero,
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
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "touch_vertex_xor_nonzero",
      "729169c69817d1604b896d9ebfef49e71be06e94b4422e2146e74c13fdd3b5ff",
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
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_cancel_touch_difference_evenodd",
      "cc4cfc72e1a5704b6ada97b842dd4f3abd83fcc30e0f8414e5ab4a4e438452b5",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(15L, -5L),
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
          [
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(25L, 15L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
        @moonclip.Difference,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_cancel_touch_difference_nonzero",
      "e8d1ab0ef20801bd9cbe47c1b49010c650c3c0123c2658a83b6a0a070541d366",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(15L, -5L),
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
          [
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(25L, 15L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
        @moonclip.Difference,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_cancel_touch_intersection_evenodd",
      "bb3b82204f1bee11a485dc7aebbde77d86381fae5a9b46c95c79c0bfb7ef7dea",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(15L, -5L),
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
          [
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(25L, 15L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
        @moonclip.Intersection,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_cancel_touch_intersection_nonzero",
      "1f154b0b6df8b8619279b36f4c500fb6c157a9b00711be8ca98abd2d91892cc6",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(15L, -5L),
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
          [
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(25L, 15L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
        @moonclip.Intersection,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_cancel_touch_union_evenodd",
      "5168c4d2f5c2d8df30905fa49b4461a0daf49ee84e65d95ed596e10328bcf3ee",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(15L, -5L),
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
          [
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(25L, 15L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
        @moonclip.Union,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_cancel_touch_union_nonzero",
      "1e7481a53a1e27663d5e0018917642f720a6d915314d9ecfaafb368145657b4c",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(15L, -5L),
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
          [
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(25L, 15L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
        @moonclip.Union,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_cancel_touch_xor_evenodd",
      "a33efba1a6f9882ee6e9f7044ab3f7dc30c821dece27fa0d7d18b09b1bd0d584",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(15L, -5L),
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
          [
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(25L, 15L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
        @moonclip.Xor,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_cancel_touch_xor_nonzero",
      "bbb13740e81794aacddf7541013f594a20cef02ba3d9a6f3f3e4ced6fd8cf5f1",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
          [
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(10L, 10L),
          ],
          [
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(30L, 20L),
            @moonclip.Point64::new(20L, 20L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(15L, -5L),
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
          [
            @moonclip.Point64::new(15L, 5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(25L, 15L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
        @moonclip.Xor,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_nested_difference_evenodd",
      "9fc2334c8f1d3e6cfab99fc134dd6e208ce69587469f01d8d0380c2970446b18",
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
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-25L, -15L),
            @moonclip.Point64::new(15L, -15L),
            @moonclip.Point64::new(15L, 15L),
            @moonclip.Point64::new(-25L, 15L),
          ],
          [
            @moonclip.Point64::new(-15L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(-15L, -5L),
          ],
        ],
        @moonclip.Difference,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_nested_difference_nonzero",
      "8c047b8d51d5ba601b34c1e938590a900f2ab349e5e2a15cc9761a3832ee16be",
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
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-25L, -15L),
            @moonclip.Point64::new(15L, -15L),
            @moonclip.Point64::new(15L, 15L),
            @moonclip.Point64::new(-25L, 15L),
          ],
          [
            @moonclip.Point64::new(-15L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(-15L, -5L),
          ],
        ],
        @moonclip.Difference,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_nested_intersection_evenodd",
      "4fd87a6a2d9bf053a5709c8aff2241a3b4774e04a55d6cf62f7cf8bfc49edbcd",
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
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-25L, -15L),
            @moonclip.Point64::new(15L, -15L),
            @moonclip.Point64::new(15L, 15L),
            @moonclip.Point64::new(-25L, 15L),
          ],
          [
            @moonclip.Point64::new(-15L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(-15L, -5L),
          ],
        ],
        @moonclip.Intersection,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_nested_intersection_nonzero",
      "b6779fa899262481a3c20e2922cfe252478c86df2a26cd703c3317591ee1ff89",
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
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-25L, -15L),
            @moonclip.Point64::new(15L, -15L),
            @moonclip.Point64::new(15L, 15L),
            @moonclip.Point64::new(-25L, 15L),
          ],
          [
            @moonclip.Point64::new(-15L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(-15L, -5L),
          ],
        ],
        @moonclip.Intersection,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_nested_union_evenodd",
      "7723949ed78738fa934b03c4b7b4ffa0931ac21d0c20c710fbe748ef1cf30017",
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
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-25L, -15L),
            @moonclip.Point64::new(15L, -15L),
            @moonclip.Point64::new(15L, 15L),
            @moonclip.Point64::new(-25L, 15L),
          ],
          [
            @moonclip.Point64::new(-15L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(-15L, -5L),
          ],
        ],
        @moonclip.Union,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_nested_union_nonzero",
      "35cfb351f9b8e2a9e4bd4861faaf39b03d9639d6ef1f965b49a9dddc1f590665",
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
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-25L, -15L),
            @moonclip.Point64::new(15L, -15L),
            @moonclip.Point64::new(15L, 15L),
            @moonclip.Point64::new(-25L, 15L),
          ],
          [
            @moonclip.Point64::new(-15L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(-15L, -5L),
          ],
        ],
        @moonclip.Union,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_nested_xor_evenodd",
      "9ead859f463a1393bb0ef3fe12eb9c5287fb38fad4766a1000bbe30fb7e09196",
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
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-25L, -15L),
            @moonclip.Point64::new(15L, -15L),
            @moonclip.Point64::new(15L, 15L),
            @moonclip.Point64::new(-25L, 15L),
          ],
          [
            @moonclip.Point64::new(-15L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(-15L, -5L),
          ],
        ],
        @moonclip.Xor,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_nested_xor_nonzero",
      "99d438025aef1028a971cbe9331ef3cadb0969f96a32aaee5a60cb11999c46ae",
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
          [
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(25L, -5L),
            @moonclip.Point64::new(25L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(-25L, -15L),
            @moonclip.Point64::new(15L, -15L),
            @moonclip.Point64::new(15L, 15L),
            @moonclip.Point64::new(-25L, 15L),
          ],
          [
            @moonclip.Point64::new(-15L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, -5L),
            @moonclip.Point64::new(-15L, -5L),
          ],
        ],
        @moonclip.Xor,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_overlap_difference_evenodd",
      "2595bc9c481f9565a9a407482b89376d289a33d8d6bab9e86428dc52417eb413",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
          [
            @moonclip.Point64::new(6L, 0L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(6L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, -3L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(3L, 9L),
          ],
          [
            @moonclip.Point64::new(9L, 6L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(9L, 15L),
          ],
        ],
        @moonclip.Difference,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_overlap_difference_nonzero",
      "5930c2a219052085199c535ffe95bd8caaad8f1f18754ff727b68f4ec27c55b3",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
          [
            @moonclip.Point64::new(6L, 0L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(6L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, -3L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(3L, 9L),
          ],
          [
            @moonclip.Point64::new(9L, 6L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(9L, 15L),
          ],
        ],
        @moonclip.Difference,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_overlap_intersection_evenodd",
      "fa8e56e42c53e354dd4cb1bd358d2da1167d9d162497a62d7b8c603b215255e3",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
          [
            @moonclip.Point64::new(6L, 0L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(6L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, -3L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(3L, 9L),
          ],
          [
            @moonclip.Point64::new(9L, 6L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(9L, 15L),
          ],
        ],
        @moonclip.Intersection,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_overlap_intersection_nonzero",
      "71913beff2b92ae08b1e11ae0ea7056dc0bdb94b0364f2ec13f8fecd6173cb98",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
          [
            @moonclip.Point64::new(6L, 0L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(6L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, -3L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(3L, 9L),
          ],
          [
            @moonclip.Point64::new(9L, 6L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(9L, 15L),
          ],
        ],
        @moonclip.Intersection,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_overlap_union_evenodd",
      "94bc0e8ddd873bf2462c87c3086730eda79b4cd96f56b63f4ccd5c978dadb57c",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
          [
            @moonclip.Point64::new(6L, 0L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(6L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, -3L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(3L, 9L),
          ],
          [
            @moonclip.Point64::new(9L, 6L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(9L, 15L),
          ],
        ],
        @moonclip.Union,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_overlap_union_nonzero",
      "423d95fa7cc6cb8840cc282d8c77c7c0b601cd66c158c730f884f782cc154f7a",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
          [
            @moonclip.Point64::new(6L, 0L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(6L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, -3L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(3L, 9L),
          ],
          [
            @moonclip.Point64::new(9L, 6L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(9L, 15L),
          ],
        ],
        @moonclip.Union,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_overlap_xor_evenodd",
      "bf5800283a082ed319e50f8d63aebbab89976c046993411dfef913ac20c322d0",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
          [
            @moonclip.Point64::new(6L, 0L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(6L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, -3L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(3L, 9L),
          ],
          [
            @moonclip.Point64::new(9L, 6L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(9L, 15L),
          ],
        ],
        @moonclip.Xor,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_overlap_xor_nonzero",
      "c90fe888e15bfd4adfd70e1d34fed7b58b7bbea2830fd178ae9d1da7956bf6c3",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
          [
            @moonclip.Point64::new(6L, 0L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(6L, 12L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, -3L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(3L, 9L),
          ],
          [
            @moonclip.Point64::new(9L, 6L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(9L, 15L),
          ],
        ],
        @moonclip.Xor,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_reversed_difference_evenodd",
      "e1f6b2084f14035630b510041a8ce13236ca58906adb0d689c13f212166a0126",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 12L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(6L, 12L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(6L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, 9L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(3L, -3L),
          ],
          [
            @moonclip.Point64::new(9L, 15L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(9L, 6L),
          ],
        ],
        @moonclip.Difference,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_reversed_difference_nonzero",
      "89d85f680217072d3f1690a3ff690b84cffe8bd18501d304b451f4c42e3dd4d6",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 12L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(6L, 12L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(6L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, 9L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(3L, -3L),
          ],
          [
            @moonclip.Point64::new(9L, 15L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(9L, 6L),
          ],
        ],
        @moonclip.Difference,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_reversed_intersection_evenodd",
      "fa594de174bc103e50c5ad20a584e8f0349434d41f74cb8365e1e7079ace9aea",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 12L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(6L, 12L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(6L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, 9L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(3L, -3L),
          ],
          [
            @moonclip.Point64::new(9L, 15L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(9L, 6L),
          ],
        ],
        @moonclip.Intersection,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_reversed_intersection_nonzero",
      "b2ce1f90e108b74a7d02db37999c256124e5b720a5f3dda7602dd08fec7675e2",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 12L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(6L, 12L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(6L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, 9L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(3L, -3L),
          ],
          [
            @moonclip.Point64::new(9L, 15L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(9L, 6L),
          ],
        ],
        @moonclip.Intersection,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_reversed_union_evenodd",
      "a8367fbca29250a187edc3ca796f902acdb225a9d31974403e26d97711d28b9c",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 12L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(6L, 12L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(6L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, 9L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(3L, -3L),
          ],
          [
            @moonclip.Point64::new(9L, 15L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(9L, 6L),
          ],
        ],
        @moonclip.Union,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_reversed_union_nonzero",
      "ffedd5f7dbe005cb4c377b31f2d24a63d79e13d62a054506127b860c9d20f2d1",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 12L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(6L, 12L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(6L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, 9L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(3L, -3L),
          ],
          [
            @moonclip.Point64::new(9L, 15L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(9L, 6L),
          ],
        ],
        @moonclip.Union,
        fill_rule=@moonclip.NonZero,
      ),
    ),
    actual_case(
      "winding_reversed_xor_evenodd",
      "0206db12e3d882ffc1da53b0097eab4981e23a30858ec0401d33a2ad41ae4336",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 12L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(6L, 12L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(6L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, 9L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(3L, -3L),
          ],
          [
            @moonclip.Point64::new(9L, 15L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(9L, 6L),
          ],
        ],
        @moonclip.Xor,
        fill_rule=@moonclip.EvenOdd,
      ),
    ),
    actual_case(
      "winding_reversed_xor_nonzero",
      "8648467f796b10dc5e7532f6345339b26597213c58db2953d3ce552aba18e387",
      @moonclip.boolean_op(
        [
          [
            @moonclip.Point64::new(0L, 12L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
          [
            @moonclip.Point64::new(6L, 12L),
            @moonclip.Point64::new(18L, 12L),
            @moonclip.Point64::new(18L, 0L),
            @moonclip.Point64::new(6L, 0L),
          ],
        ],
        [
          [
            @moonclip.Point64::new(3L, 9L),
            @moonclip.Point64::new(15L, 9L),
            @moonclip.Point64::new(15L, -3L),
            @moonclip.Point64::new(3L, -3L),
          ],
          [
            @moonclip.Point64::new(9L, 15L),
            @moonclip.Point64::new(21L, 15L),
            @moonclip.Point64::new(21L, 6L),
            @moonclip.Point64::new(9L, 6L),
          ],
        ],
        @moonclip.Xor,
        fill_rule=@moonclip.NonZero,
      ),
    ),
  ]
}
