// Generated original decimal inputs/parameters/hashes only; NO expectations.

///|
fn run_decimal_cases() -> Array[Json] {
  [
    actual_decimal_case(
      "decimal_boolean_hole_difference_evenodd_p0",
      "34c8e0578a034cf0b708a6dc0ba0d6fd14e8e71563e0bd56cb613377d0eb5c23",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_evenodd_p1",
      "50ebdc0dacb45041a4efaaff9674dc6112257c8fe20897c8186b2b9aaba48d15",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_evenodd_p2",
      "e3a4b9e13da9373e14693f1f143ce1f1038bf63d223dfe3cee5aa38c1ee8b913",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_evenodd_p3",
      "f7261e1499b9b5ec7b860209450b566ff13656a9843ff12b1e1b7d25865896f8",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_evenodd_p4",
      "5a255bde3bdb7937a73fa40950cd7044212b58862a3f1538c3c47c91d4656e96",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_evenodd_p5",
      "67ebb422ebcae67dd49336ca00a54ad83f1c16c14b0719d12c3c91cbde344311",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_evenodd_p6",
      "0ed8b48c1c3dc0ac3dde7dab82a38703a2da75f7268653126ba0cc6db4154172",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_nonzero_p0",
      "d97dd5a1e30b6ac6bb84980efc88042ed0c9d79d704d198851b79ce2c6a3eea5",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_nonzero_p1",
      "fc6be374017857541e9dc4fff8c914a006831464b9e8932608aa43fc8cd0434d",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_nonzero_p2",
      "4d5d75be561c5274c3f905f6bf79b056d90f3a980d8041b7010e37e8e0efca08",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_nonzero_p3",
      "03fbe58c53b5dc7ac9c2dd16e6384dcd75708df65c950f83ebe03498d648c0b2",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_nonzero_p4",
      "f6bf2b08f7465c0dd5301c9fa3816f687b766f440e840afe58396343106e430d",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_nonzero_p5",
      "bc73705b2b5c5e96a7304debd91d584a619b9dbd81c577f1890401615cd04a3a",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_difference_nonzero_p6",
      "3ee668a256ba18652e658024c1afa78571e8bc1e70518085da2e0ae6e21a982c",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_evenodd_p0",
      "0f13e3806eb9bad55da9f96235621e9d5d226159f1dcf8026f48673b7c4a939c",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_evenodd_p1",
      "13d55d07744cd96ef740696178647d2cc49f66f540490178ed60327ffbca12b0",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_evenodd_p2",
      "c4f9477ab0c8f585a27203d79b1d7d09a46b33d63795392926eebdec0b5104e5",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_evenodd_p3",
      "73b7a0da16b539cd6ac60c0c7d4a6b5a5ec19c64f9fd1dff95b5597440790c12",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_evenodd_p4",
      "24c089bc6732b373f49e34b724d4f8557b6dc92b58fb976434c4d93a02ab75d3",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_evenodd_p5",
      "9e60090dd904e667663ec427092003b10e8df586058df055204d2a426045f6ab",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_evenodd_p6",
      "2f4808627bfb6394de03f0bfddea1be0ac1830336d4b9dd11a250568ff641258",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_nonzero_p0",
      "6f934e6c4e44e07e757acfee1ffc86d7614ab6c44be732e49ed0dbfce5c90997",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_nonzero_p1",
      "49e4f315d53ee0592b75ec3f8500fd6c03a3a8dc51fcf5e40cb93c7a4f91ae63",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_nonzero_p2",
      "866d7c6aa2fb1f3e34b07d0506c81b219cded91c4528b7de0904e7be289ce180",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_nonzero_p3",
      "d3a6a652556d112d24b8fff558197faeb697696be87fa1a3a9baeb8505a1732a",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_nonzero_p4",
      "a098a47149c53f60bc28796c5a8bedea474ce4b7ea7147d8b18b25b8eb76d10a",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_nonzero_p5",
      "01011e2ad52b9a77fa1d6dbe1a9016b5b610f2df881274c31f19e88abac44e22",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_intersection_nonzero_p6",
      "933d20d2b22d4eeff7505a9751658c90f5c23feee3dd415cb3cdf8e47c8e7967",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_evenodd_p0",
      "d0633e808e74d0d810efc51cf1fc3c6aabd5d45d582ea982b031991ff3654a80",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_evenodd_p1",
      "82a58a2b681ca5ed8d54d7e4ee1a008712e63f6ce7741ff7d82b3dfbb57b6887",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_evenodd_p2",
      "00c45ebc852f6954035811fd7e477ccfffeada89b39a9dbbe792843c8e6cfe47",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_evenodd_p3",
      "4b3f885fee7c9ca631a1fb3beb2ac4c446984d28c6e778fd45a26e8072a388f0",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_evenodd_p4",
      "1b5d1c75f2e585ab67cfe766ba9a14e04ac2f2fa792133375e2008b4b0525aee",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_evenodd_p5",
      "b4b4a3dcf60ea5998011ea8f1d2f454a4cc603ae1f18c44b29642ccb8fd71cc7",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_evenodd_p6",
      "061507bc11d0a6573fef4492745af35d875f5f9d269fa99575da2364af8cb36c",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_nonzero_p0",
      "05af9d6e6c804048910b978aad895924fa1fc8ac13e199711297731202e461cb",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_nonzero_p1",
      "db328cf549e01392cb753d918d5a3216066a76e61e0ead85ea7b784b5f972d28",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_nonzero_p2",
      "a89a434907633b6b0ae7d4e3b3e03c2fa78dbfbfb1242ed9d605eae34759de16",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_nonzero_p3",
      "0367f789460c5178047bfa34b210682b46a2f5d42d58ea21271c62d4c449525b",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_nonzero_p4",
      "2cebc514da7d70404ff6bf78e4b083ffc793461a1b2fed0ee0133685ff35c538",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_nonzero_p5",
      "a9a98561e69de834eb12f26120fb01c7a2884a7c88cc8ed58a3945486a7297d2",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_union_nonzero_p6",
      "da044b230cdfe485d268cd2e7e38a6e19c58e3fd34481d54018ce4078bfcc55f",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_evenodd_p0",
      "485437502ae56c73a9ea9273d41c82f1400033b424bf8c2c101a322b5c1075f6",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_evenodd_p1",
      "3bb3152c09a6bda3e76f298ea7c22b3eb42266aa28d6d7adfe949ab298c0ff85",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_evenodd_p2",
      "1707c17c37c7ef88350cb8326cd8f463f7cd36727106cf964520bfcbf359b115",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_evenodd_p3",
      "a85ea4c5aac9a55bbefda0ccf45d9fd84c0a277b97483cb26fa214e84865553e",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_evenodd_p4",
      "4a3af288b20c081b570091f865b64c63ad2c5cdcd68546bea3ded9297c79aa4e",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_evenodd_p5",
      "ba61a5ec816735c927a21e957f69676b27e38be6da25b89bde4f62ece97111d3",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_evenodd_p6",
      "d0ef8bf98da58cd78f77c4a15e8f894a1c689b17c700876f8685688d11fbe35c",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_nonzero_p0",
      "0a9cc7704cb60bea366f1d3eda1ad15cb7cdfd6e57781a97ef35e1c5301a81a1",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_nonzero_p1",
      "19c4d19dbd93ec35c4d123a7fb531491aee80627758a5d2c38eaeb95ab7a9937",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_nonzero_p2",
      "bc4f3090f7828e94007e7c71a849a90b0a47c4aabfd8a6202c7107d2f55d7121",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_nonzero_p3",
      "70a8669bd804116085318799d28c42042f74c4c30a6905b81e7f9a0770fe7df1",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_nonzero_p4",
      "9b9dea4f80a6a124462c491d549d902a60fa82bf9211605d59862be57ddd4811",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_nonzero_p5",
      "7816d73efde39bbaeea2791d8019e750eb4203c23014755af562a5bd80975d37",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_hole_xor_nonzero_p6",
      "36501c9a70787b071c2a40ed3fd14a779dc883dc368851cbb24351f06e92789c",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(0.125, 0.125),
              @moonclip.PointD::new(40.125, 0.125),
              @moonclip.PointD::new(40.125, 40.125),
              @moonclip.PointD::new(0.125, 40.125),
            ],
            [
              @moonclip.PointD::new(10.125, 30.125),
              @moonclip.PointD::new(30.125, 30.125),
              @moonclip.PointD::new(30.125, 10.125),
              @moonclip.PointD::new(10.125, 10.125),
            ],
          ],
          [
            [
              @moonclip.PointD::new(20.125, -5.875),
              @moonclip.PointD::new(50.125, -5.875),
              @moonclip.PointD::new(50.125, 44.125),
              @moonclip.PointD::new(20.125, 44.125),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_evenodd_p0",
      "c5f83117616f7c9ee4b6bb3577629e5ea29767e749c77ae8256b9d518ecbc87b",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_evenodd_p1",
      "afee88506c25158aa6341e4c746b56a1d1df64810cc1bce9dfaf027aeabb8c16",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_evenodd_p2",
      "486f6fd69b02142145306892adddba631bffeed2f8c3068167eaee2ca29ab916",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_evenodd_p3",
      "d87c997570a218e1ceebbd6ad513920db88c35373fe53c8c1aff58ebe033c937",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_evenodd_p4",
      "7d5221ddc48ee5e92ce9bd668b62f4d45543256e4ddb229b6f648403dd9a4b50",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_evenodd_p5",
      "f1b4cd3a4a9657e7f290d111dd13342f895d1c4d4581ae2fb9c65e431f73b852",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_evenodd_p6",
      "5ab1d8da2567416773af65a31f96e2e2d68c2452e2b7c1d0e09806b1d9367752",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_nonzero_p0",
      "9e1e3df4c33e97e60c35d3066410bc1c2bd86da150a4e9e4f2c26c8b1c76537f",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_nonzero_p1",
      "f6a62aef277278411fcb297b523dc298f38007043792243731a5d35407c6d6c6",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_nonzero_p2",
      "9b1a337971b2bfd6332f5ecaa4ecc6125c3a0ea5c6be94c7cf5672cd72af7ad4",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_nonzero_p3",
      "7e3247352e0b147b14f0ad745acdb8f5b1d23447735156626191e3bf534e62ef",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_nonzero_p4",
      "861e1f0e7bacd3bad79fcece7368501856536d7cf39134a696070ebfac6ea9f8",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_nonzero_p5",
      "0209c8d31cff41a3d597569c6a1ff294de5eee62e2b7bc1a2ed2e426c550455a",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_difference_nonzero_p6",
      "74b62cbf44b55a652d5f6dc489c71303c29c1ee64d119fe72bffd3951b3c6b8a",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_evenodd_p0",
      "68a5e1216585f2cd715f54a40c7db7d3d9298eefd994184c22d03a6d9713049e",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_evenodd_p1",
      "7d97c787d998375058d6a28ee8f61971200cce7ecc536425f18856e31a3af1ac",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_evenodd_p2",
      "a424118575090c0772b5d8564f4d8d5631395bb25f303c89dcf4b66151292f40",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_evenodd_p3",
      "6de7cd54ae475dcef3f16b31c903aee7329ddcf15aef1ad8c86b5c5d093764d3",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_evenodd_p4",
      "3357236abe2c25a337553f6fc0724d0e5311d98d8657dd7dcd8f40b78f7b1343",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_evenodd_p5",
      "d95205c661ee940005178e97d6c6b76686349572ddc304a72b2ec4fcbe72e14c",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_evenodd_p6",
      "a32fd116a4421dda5d1056ab847e1c15b4e9f4d738d6baa2c3c50f023d9d44d9",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_nonzero_p0",
      "74ed3126fcf3b0275c3d84a1fd6708d514d266c5766f61c62d7041755cc19217",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_nonzero_p1",
      "88288d86fc43934eb441bf57883e1e2c9fdf364661c5dd073de2552f06456ba9",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_nonzero_p2",
      "955927ca374d9dd65537e4d6c45fb7ece32322b2b9073e4f2a50ca733c39bd7b",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_nonzero_p3",
      "7495777d61ac08bccd0d11749951081d8bf8ce11809ac0811189e624c782acda",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_nonzero_p4",
      "4d858997407d2bc29c99e2dec58d5a8fb604db712119315a171cc3d63e69981d",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_nonzero_p5",
      "afc9dd4394facbab19130a727059804656960dc35f1745208df8496dca568e29",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_intersection_nonzero_p6",
      "6207cfc183016227ba3ff0be35d4c0bfa377bfcbb808fdcfb5a2533f5070d930",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_evenodd_p0",
      "91ac99fe8da560878097605f6c2e7a98f593097fc96e294737805aa362828643",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_evenodd_p1",
      "1e02b1c1174a53ca27f17d5ac48a726a98c6235b4a0e0ff1d682abdaa066564a",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_evenodd_p2",
      "5df9bdb41ca2208d3e3ee6977eab6597274fd59e57ae91eb528a871c84b5dbf1",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_evenodd_p3",
      "c45b0e9775cd4fc6e4c32b1935005e44b151eca143cbf46585fe67c842fc86bd",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_evenodd_p4",
      "6c0a4b25a1f9e5323707f87c0505831119e26d45bc02a25b79b53d783292c0a2",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_evenodd_p5",
      "c5e69c01514b2d3ad7c830e4217873935628ada38915f94b3b8217ae77dfbcde",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_evenodd_p6",
      "9e4657b97667279861037d36ed2f68e92324a36632a446cde2b00f7251a07b50",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_nonzero_p0",
      "3b6a8d1f9712727660ba56ea26090bdcf122907772fba425e505ab0212be6bac",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_nonzero_p1",
      "b33e9e169c261dfe179c3c5d0ae89c77107c52eb74228932329de0ea222992a5",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_nonzero_p2",
      "117e07f3c6186fe5726910a7f5bd2807d25b8bd0bbdb3eb9ab2f5458861947a1",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_nonzero_p3",
      "fba08b2b4999c474bd40c1653b665f1fcf777b3ce38a78ba748f805f64f39113",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_nonzero_p4",
      "7205f8f7f9fdcab6a83de2d68a9ed3c4aff98f1f561cf2d868a79651ea517a4d",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_nonzero_p5",
      "94c8a611d6208fa4ca96b584ea4df2b1658f66ff1e3cd472dd3d691be4c0d818",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_union_nonzero_p6",
      "5255f7491bfaf50200bb73b633ba19c92c643d7ded042e0943853e863e5e8a94",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_evenodd_p0",
      "b2c73d2407a337f3c283b8a308cc34ab99fcbfe12dd89f5904997c34170f268d",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_evenodd_p1",
      "327e27020ba0baa00cd3b4e3b04bffc010ee4de9f51d417eb70921ab5c26418b",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_evenodd_p2",
      "210fd4ec135712b60f07b68abf50a3e087b64e9c8fba65b6d9d3be64276f5b75",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_evenodd_p3",
      "5bef4ae0c9c681a38c52cdd5a19c887f47dc04e9bff6c345e0007af5abc9aafe",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_evenodd_p4",
      "c7d37276b08a6275a7657d8386ca8bce3f4793cb9d5a977ac55f2e8578f71248",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_evenodd_p5",
      "48c8483fc896c43e9d06f35daf54d359fb6ad053f4663051deba7d036d12b591",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_evenodd_p6",
      "2bfc797a3c31f44c9de59e65ab05716a0bb620dd9449f568f14b41ed40c17d29",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_nonzero_p0",
      "e632e1776bbb8f9b38b1a3deb3767ce942ae5027d211b24f20db9ac8e66eb895",
      "BooleanD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_nonzero_p1",
      "934168b123e046101377be266c8ee4cff31e0c0ba7d1432aab5424c519a178da",
      "BooleanD",
      "DecimalGrid",
      1,
      @moonclip.Precision::new(1).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_nonzero_p2",
      "2f648d82a24ae44ca4c1a295215b24161ca56176cefec5fca9388c7ca6c86deb",
      "BooleanD",
      "DecimalGrid",
      2,
      @moonclip.Precision::new(2).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_nonzero_p3",
      "a964be3c6c5c06731cb7221aafe4092be1b7393c1bf0e96dd92e830dd697242e",
      "BooleanD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_nonzero_p4",
      "545e61b5e6575c80017f8039fba8069cfab13c1066443f332624c24c0afcf5f4",
      "BooleanD",
      "DecimalGrid",
      4,
      @moonclip.Precision::new(4).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_nonzero_p5",
      "bf515458321f7bfb97fe4222a4fadcb1d849baf998a1c8c845889f10a1aed80a",
      "BooleanD",
      "DecimalGrid",
      5,
      @moonclip.Precision::new(5).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_boolean_overlap_xor_nonzero_p6",
      "1e3ce3851c479e8f148df76e63ee8196b92c72cad9a84bfc2dd1ea28979e7720",
      "BooleanD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-10.25, -5.25),
              @moonclip.PointD::new(9.75, -5.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(-10.25, 4.75),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.25, -5.25),
              @moonclip.PointD::new(20.25, -5.25),
              @moonclip.PointD::new(20.25, 4.75),
              @moonclip.PointD::new(0.25, 4.75),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_difference_evenodd_p0",
      "7a0316c805054d8492ab1d931f2c5b1b6d82d398e05aabcc7cce33397575645b",
      "BooleanD",
      "ClipperDCommonGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_difference_evenodd_p3",
      "fa512ff884dda0bc86e48cd9cddb93fe10aba4e8a8b1e66547d1134b2cf265be",
      "BooleanD",
      "ClipperDCommonGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_difference_evenodd_p6",
      "cdb1c5cf6c3f60872b4a576fa4b1b4de71f2a68ec833b691eb315d9a94c0cd27",
      "BooleanD",
      "ClipperDCommonGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_difference_nonzero_p0",
      "13eb11ae229910f1f01bc18dfe7830d995e8bf8a1122d6e77a27fc0ccd478abb",
      "BooleanD",
      "ClipperDCommonGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_difference_nonzero_p3",
      "4f19f1ab6e20b0fb4134be062443e00f7185bcf7ccffa98e612b59e3590414f0",
      "BooleanD",
      "ClipperDCommonGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_difference_nonzero_p6",
      "082b01b4312dd70ea86813b3864efcbeb0beed34820dbdb2cf242f4ff8353c76",
      "BooleanD",
      "ClipperDCommonGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Difference,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_intersection_evenodd_p0",
      "559799c9553dc6f489747181704ae0833a496046f700e2906448747e2b392326",
      "BooleanD",
      "ClipperDCommonGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_intersection_evenodd_p3",
      "1c394422b7e0fd7c846374388fad492163ef6609d7fd9defe2b7939d9967fac2",
      "BooleanD",
      "ClipperDCommonGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_intersection_evenodd_p6",
      "7c63a4f514dfc5a7f631b45951f12e6d4465b89f12efdcdc042d48398e346c33",
      "BooleanD",
      "ClipperDCommonGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_intersection_nonzero_p0",
      "36872cf42fe7e6262baf38fd5a0697d90281acfa92770b54f7ded38c62a57fcd",
      "BooleanD",
      "ClipperDCommonGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_intersection_nonzero_p3",
      "9cbe3768fd73570cc7edea527d78c433cc2e947cd0fcf2458b8632de7c2db102",
      "BooleanD",
      "ClipperDCommonGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_intersection_nonzero_p6",
      "a20ad9f8e941c8a9cb5194731b9bdfcf984a4dc571ba6d9b8dff566be1f5b50e",
      "BooleanD",
      "ClipperDCommonGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Intersection,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_union_evenodd_p0",
      "35dbbfe21642cb38bda2638562131b261b230f129848488115c0a9aa285c0ff0",
      "BooleanD",
      "ClipperDCommonGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_union_evenodd_p3",
      "a834a0e3e5f7e054d77d19843f564be94dd426e54ef6d1add1a72c63c83f087b",
      "BooleanD",
      "ClipperDCommonGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_union_evenodd_p6",
      "c054967cfd65537723140d9f348d03683c97abf18ed0688f7b22285f9d745e38",
      "BooleanD",
      "ClipperDCommonGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_union_nonzero_p0",
      "67204d8427a9788ff581ec879ec8a5f4de7da139390cb0d75456cf4e10283a74",
      "BooleanD",
      "ClipperDCommonGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_union_nonzero_p3",
      "91463d19387993cf50a8e090cdcca1cf373bc56ae33ca04c886e833d0e984dce",
      "BooleanD",
      "ClipperDCommonGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_union_nonzero_p6",
      "14b04fbb0b898991e4d1d75b72476ecb5cda5c27324577cc87b48af4c406a01e",
      "BooleanD",
      "ClipperDCommonGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Union,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_xor_evenodd_p0",
      "057c106e9961c254f990cfcab117865e04341bcc38a066fd65726aea451a7091",
      "BooleanD",
      "ClipperDCommonGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_xor_evenodd_p3",
      "31cdb398068e53e61d90db9988e49a587205139f0b87f44268df6afce4709783",
      "BooleanD",
      "ClipperDCommonGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_xor_evenodd_p6",
      "1666c1bd0eac349839ff06a5823839a4be5d2f38bb1bd8047a9e42ff2046052e",
      "BooleanD",
      "ClipperDCommonGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_xor_nonzero_p0",
      "ada64f26ddee09c43607955be1e4a4b18383c3636199cb48e50e74914c678aae",
      "BooleanD",
      "ClipperDCommonGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_xor_nonzero_p3",
      "8b0f0b96aa515be6bf4c2c0f4e0be4e361bb809bb257ed1d829be3dd55896f40",
      "BooleanD",
      "ClipperDCommonGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_clipperd_xor_nonzero_p6",
      "5f1960739418b195fd4fcd9c10dc2aae9c30d2cb8c99c81816d1f577f5029336",
      "BooleanD",
      "ClipperDCommonGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.boolean_op_d(
          [
            [
              @moonclip.PointD::new(-12.0, -8.0),
              @moonclip.PointD::new(12.0, -8.0),
              @moonclip.PointD::new(12.0, 8.0),
              @moonclip.PointD::new(-12.0, 8.0),
            ],
          ],
          [
            [
              @moonclip.PointD::new(0.0, -8.0),
              @moonclip.PointD::new(24.0, -8.0),
              @moonclip.PointD::new(24.0, 8.0),
              @moonclip.PointD::new(0.0, 8.0),
            ],
          ],
          @moonclip.Xor,
          precision=p,
          fill_rule=@moonclip.NonZero,
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_in_evenodd_p0",
      "94a2ff39a248b0d396faa0c0c688bd870974460aff786aa972a7b4ea034d28bf",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_in_evenodd_p3",
      "dd5d5b76a41da3534f935b76bfe31cfcffb3f05fa6176c90f4c39e5c74be9c05",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_in_evenodd_p6",
      "b422c2b579a4445fbc9c72f063f5379f3cde79b6a0f185448ca47e89c14baf80",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_in_nonzero_p0",
      "8d862a73e25873d723f3b9cb07ccc5702e27f277a1ee37eef8526e2eb2626c9e",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_in_nonzero_p3",
      "bcc44b052dd617c649ac3eedf818eeeba6884b6b13dd9eaeb54938799f3c7ef2",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_in_nonzero_p6",
      "1d8002c1373b6d7f89b9f5da724d91aa8820641ff962c9d6790bf1c521adabac",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_out_evenodd_p0",
      "b7d7e0c4f9bafde2174d6ab960216e3f8962ad50b9adcee084b555ececec816e",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_out_evenodd_p3",
      "45b18f6334c8d6e4d7852f70c1bc01fbe4d1293557639011594d5964c0088e85",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_out_evenodd_p6",
      "a902a81df1ff9d16af07457646c6a4e2731c6297681e0e5f5631cceed7bebcdf",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_out_nonzero_p0",
      "a211912b40e776e24f24a9783c38a56a4425e2abe6ae58077db7ec32e01bae7a",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_out_nonzero_p3",
      "9ec89538dfc7d937ad6aaf6c53536cbc3587fd30d4d305a7a7ba1f885e9a670a",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_bevel_out_nonzero_p6",
      "301f220a5caa161f825580dfd3b5c30d6df44b948d86aa7a9f57ef1c5266b50d",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_in_evenodd_p0",
      "337760a767371b2c64f85e10fde50dc44bd927a423e6cdb3ea5a34b8442b71ed",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_in_evenodd_p3",
      "a1b168a4033e601b1184f183331fd2d95e0bb789c598846bd5c574bcdbc7c88d",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_in_evenodd_p6",
      "adb991a974b326a0b33092073f2bd830f42bd8acfa43da3407967a2860dee971",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_in_nonzero_p0",
      "5e7f0360a784c6b2e709b2d5b0b3c7017aea32ccee0b237d7e672a55beb48159",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_in_nonzero_p3",
      "b2b6afff8ab03f11f387a1c9d7b7fa5947433a0868d2f7bcca1d2bccd8c27e01",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_in_nonzero_p6",
      "91afaca37e9571b37eef933041ec3355b96a14e00230714d42dd0505c1aa5de9",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_out_evenodd_p0",
      "83142d01af0f0374774ad9c73cecf8aa1ec7783e2b629a0df5b81a6567cde936",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_out_evenodd_p3",
      "d081d05c6560a42005eaec9238e7fe8c7c4f3f52258d857738a7cd0c47b394fa",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_out_evenodd_p6",
      "0d17826b8c9289811930670db329708a7d7f7b1129a7f8ba5404f54e773be316",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_out_nonzero_p0",
      "3265dd3b81f8de8bba438452267523bc8a945771469383620a4c88c70f8ea66e",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_out_nonzero_p3",
      "f7fd229b01f6315a3fb6959debbb0d62760c85f31d59e21c27eeecbcf1fc7420",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_miter_out_nonzero_p6",
      "388975c37a0820c9d5ed644095baf3c8082c42428d7ccf4d910d137e3a3413f0",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_in_evenodd_p0",
      "1dc7072df7a1c88ce1735dba5f4cd5cc53498d13bf4d4af0fcc6911c36a67ed9",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_in_evenodd_p3",
      "41a9bca9a0d20f1d0542ed7e9a62dd1c80ac714ca112159384ecc8eda4abc22c",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_in_evenodd_p6",
      "61e7879eb8c549e242e9b9988748768a8a9e9f1e84f2ffea803defc8cae1e6ff",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_in_nonzero_p0",
      "775491b8ac2e064f87fb5cf32ccdc428d4939c45cac7488ecbd808148d40cdfc",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_in_nonzero_p3",
      "492ed0f5ea651b586fda84e7298fca86e474ff4ac06bb5c79e28c6af59f4638c",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_in_nonzero_p6",
      "e02e71406c06aa45849b01a47f3d24e6c8507dc40ad1cb1bc6f7770d09a7de08",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_out_evenodd_p0",
      "d02da64ecea0b9cd3c7f26e5af1bf69af20080a001c7ba9926b885d600916076",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_out_evenodd_p3",
      "38316886541eeb066b4fd2d5822898777fe989312b090b1814a0980c9d7c8c1a",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_out_evenodd_p6",
      "490acaa00d2edd698d077ca4b2461434cd37a77d1844887119ec2065f1cfe5c1",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_out_nonzero_p0",
      "471c2b005bfb21198d709b563d5bd8fa22183862cdb257f4a5bfbaa1c787f9ac",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_out_nonzero_p3",
      "6249f06eb56b0c49d2cc98f82d5e55f7a7e2e4d5292632afcc6d2e299a4b6694",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_round_out_nonzero_p6",
      "4f4c31d98cad06e7d6109d9260bcf02b9c503e296dae219f03e01391e9cceac4",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_in_evenodd_p0",
      "ea6d5efa07570c594bc4424b6bbab6ab6c7a7c6036cf75dd8d162624be1b3e6f",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_in_evenodd_p3",
      "50f21375ef8bffb5e266f94f0b16b12efdbf9d00bdbd169554ef073e31c7786a",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_in_evenodd_p6",
      "ce3af726516566be516f5d56a05522c08d519ef4b97e6d386775c8993a6b3d3c",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_in_nonzero_p0",
      "41041296a99f627ad69115cb01c7c290c295797276583a140db959a59440bd50",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_in_nonzero_p3",
      "19e4d9569900616d0148728331938065c745efc87288bd009fa738cf43e5a684",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_in_nonzero_p6",
      "e8b7c482411394cdb1376cb1d8458ab4723be7efeb1af9302dbfa47dc57d45e4",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          -0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_out_evenodd_p0",
      "1f28de9e8002600c9cd62b49cc426dbaabac7943fb9bb7e9c1f0257c43c4f3f3",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_out_evenodd_p3",
      "70cd471ad06d984ae8f33da228edc4c5212c782915b2b3fb3705cb02de5807a0",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_out_evenodd_p6",
      "e675b21afb3847f5d9e1169031020453315dec62b8b9d97fbb167308906cb05d",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.EvenOdd,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_out_nonzero_p0",
      "6376a9401d8f2589aa49f18daf471398844fe46a5547975ea6be8896012abdfc",
      "OffsetD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_out_nonzero_p3",
      "b42550efefb6b019bb158db178d701684c527d739ec0545bac0812a58ea794f0",
      "OffsetD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_offset_square_out_nonzero_p6",
      "1c1b2d8bb2949a44420754082e8c2fb5d67882737b03ae2ce4b1fc4641fe8fa0",
      "OffsetD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.offset_polygons_d(
          [
            [
              @moonclip.PointD::new(-5.25, -5.25),
              @moonclip.PointD::new(14.75, -5.25),
              @moonclip.PointD::new(14.75, 14.75),
              @moonclip.PointD::new(-5.25, 14.75),
            ],
            [
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(-0.25, -0.25),
            ],
          ],
          0.2,
          precision=p,
          fill_rule=@moonclip.NonZero,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_butt_p0",
      "ac9320319931a70f51b68f9c248d9b7bc57f2224786bf6f40eaeeeb9bd02dd82",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_butt_p3",
      "ebec62730248a0bc1deb9ec33f0dc60683d56ba77fcfe771b17acb4790796a8a",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_butt_p6",
      "31aaddce4f2afd9f9ddb1c6e0fe1ce5ef8292696c7c5d25f0c836c9313e326f9",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_round_p0",
      "79f0307ffe59e880052ea9fa54455ff4267f10a84cb6cf9398764c23df73b6a8",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_round_p3",
      "2a94e0d3bb1bf28ebcf49cd938dc92221d6e5b619325daa558a482c9b39c563f",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_round_p6",
      "48abb6aabe9bb517c968c320bfb0f97975358ad210bb75e1d3ff04817a3563fb",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_square_p0",
      "03c28c0cd37d70038de2b172f1e179e313e8982b25f72eac139bd8a0ef43f999",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_square_p3",
      "abfdc4cb9d8b005b8227c0cdc72360f87fb9d5a2cbfa7b756e07e4ec14df22b3",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_bevel_square_p6",
      "ea36ac31f32813cc4c92b0bd45f68de0ab66e22996efe983ef6248c8c4fe03c9",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Bevel,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_butt_p0",
      "fc82d74834b69ac65524144eb0ce472ae2bd23c49a322c2244d680aeb34b1a59",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_butt_p3",
      "5c865f984623a6b708a4b0f65e7b4ab74318177ed27ca59a9c8856a002f83667",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_butt_p6",
      "ada574e87fd2c0235cd61063dcf0dbdffdeea29a7c09cc8df6717133db3c0f8e",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_round_p0",
      "66a01497641cb8b839f71c3d82a3a483df88ebead4c326e9a0dfa404d87b56b0",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_round_p3",
      "e71fb42b38453cd94eb94a13f74fb70573ff6540f9a182cdc78c72e8f523979f",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_round_p6",
      "464b191e7ebb613b98f82735f95687d48a2a95fa37d23d0d02ae9c52755e9b65",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_square_p0",
      "6a5f743f92505b4b8cfe8892bb6493d6c2527b09b1c152bace5671714307d01a",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_square_p3",
      "82732baf176ee6f781bf6a2590cf397454021130d53b1d2571b5a4efd51c8ee2",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_miter_square_p6",
      "005de65244f7e41b3fc54783a023499fb81410c6eb70aaf04a1f60e576022f68",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Miter,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_butt_p0",
      "8fef505ce4d01e7072faf2bdcb3f41c4efe1c6a91d8bfb1f2e5325381d629567",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_butt_p3",
      "a04fd0f318e68a060dc96928de400b5273102444387eddfc0e6aa55987a795e7",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_butt_p6",
      "ae78f4afde1e7bce82db689b70b02fc7390b8df457c1ce4efb761dd5b2ebb705",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_round_p0",
      "13b4036598d88572dbb970af94e535e8b4a32c2b38bab2b62454024a2e938672",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_round_p3",
      "22d803a00be57852ec8a4ea2a0fb70904f0f6a34d7d169f50d061ba9db74c0de",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_round_p6",
      "757bb28daa04e1e78164affcf5c51ae717ac1bac3a8b824d6bb8fd18d52fd211",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_square_p0",
      "cd85850f709e4aefcd6fde06d0ed481bcce53709625786ea2baf9f72c2aca867",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_square_p3",
      "a9165837686c5a69aec85bf693f9c67bbfe058641204d184f15bad238cab1290",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_round_square_p6",
      "e48d87da5bdea49931e7a7c2c4f40837797e28f70094db679f69265eb796f28d",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Round,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_butt_p0",
      "0b24f9823ebac7f334db0f65cdb376df2c31a6c7b3a70af228047448a53b8d30",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_butt_p3",
      "7c9ff6decd489db9052afbd2ae85ff549c279e2f2d918b4a034853b1fb3ebfc0",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_butt_p6",
      "9f982c3d098fd57ada71198a08a92956ba7b0b6eb14d8746d141929c72b8ffee",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Butt,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_round_p0",
      "813665d0e4ada8089fa2409c5b07c06ccc166e01f7f70dd2ab644889c26a241b",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_round_p3",
      "46110bea122ff1293ad23855b97ec95018ab7a9d477988c2aeacc5e3f8330d64",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_round_p6",
      "5d164f79e1a46db7bed8738ee7fd91e130d0c73a732e5f469bfe5ab107566822",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Round,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_square_p0",
      "15bce0a251d40bb457b9582b72c9f00308619543a65f751c426b1cabf6ca64cf",
      "StrokeD",
      "DecimalGrid",
      0,
      @moonclip.Precision::new(0).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_square_p3",
      "233de1fe5c866158f4dff2d8d24371642dd5c3603fbcede831e496def69c3c9b",
      "StrokeD",
      "DecimalGrid",
      3,
      @moonclip.Precision::new(3).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
    actual_decimal_case(
      "decimal_stroke_square_square_p6",
      "7028df9e7badf7ca48d2819b414eacf22fc9bd8306cedba22fd21528c4f4bf1f",
      "StrokeD",
      "DecimalGrid",
      6,
      @moonclip.Precision::new(6).bind(fn(p) {
        @moonclip.stroke_polyline_d(
          [
            @moonclip.PointD::new(-2.25, -1.25),
            @moonclip.PointD::new(10.75, -1.25),
            @moonclip.PointD::new(10.75, 12.75),
          ],
          0.4,
          precision=p,
          cap=@moonclip.CapType::Square,
          options=@moonclip.OffsetOptions::new(
            join=@moonclip.JoinType::Square,
            miter_limit=2.0,
            arc_tolerance=0.025,
          ),
        )
      }),
    ),
  ]
}
