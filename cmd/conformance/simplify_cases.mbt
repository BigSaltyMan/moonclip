// Generated inputs / parameters / hashes only. NO expected outputs.

///|
fn run_simplify_cases() -> Array[Json] {
  [
    actual_simplify_case(
      "simplify_decimal_acute_closed_p0_e0_25",
      "0ec5f58b2c5a8f931846cb25d4779a943ac842374173e65cf59a06d451abb25e",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_closed_p0_e0_5",
      "8546e670d3858a318f15881cd361f271def7f4093338bbdaa975614795b024f1",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_closed_p0_e2",
      "7c7ba6837e10daf54a3ea2476b648ad2d1c4202fae22d6fac28a67b6051e52d8",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_closed_p3_e0_25",
      "42b193e841699469b0d7e03db056c6653fe088d267e1c490ba4cd6828a8c5943",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_closed_p3_e0_5",
      "847acb65e889dcc551d5e20a943c2766c7e8a14b5ba4d519cb307362bbd989d6",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_closed_p3_e2",
      "1f10621abb2083bc6d5787757e92c10ceddd1bd57c971abfe5f9702a8816a22d",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_closed_p6_e0_25",
      "9759f2c1cc17a74dccb03b9ea77f151984cf4930b373a17a0d632a04712a2f36",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_closed_p6_e0_5",
      "033b011327f75608f8a4bc74d531117a57cc042fb6ee56f067a98a7103d38048",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_closed_p6_e2",
      "7930883cdb15a535ef3ddb812e63686b2a61f512c3d1db5b09a79f9feef5dc4f",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p0_e0_25",
      "42393e826792e13a5ab9bde1022290cbae4a768e841d151a10daf738ded0726a",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p0_e0_5",
      "b77c83c3b68ef5fc8e17943a3011c0f7ed4ec772a12d85b39a66e55202c2d2ff",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p0_e2",
      "4685cc928717d17d867e848ac3da355253809f13ec7dff476a812aab9f3c0d32",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p3_e0_25",
      "fd2baf7fda19dcf1bd8799885423b7e9aa16324c8c589d6bb67b9c0df712e4d7",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p3_e0_5",
      "65d5a0be8b97671e0d68e2a75d247d3fa69439a1c7ef87d8949003787dc288ea",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p3_e2",
      "eaa9ba575a48171151de90a6ab7d9a8fcd9ff1f6dc83983e3bac4fe949d89237",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p6_e0_25",
      "0b7206d3a5f08e8cb00086d6961f0400769659df75366e3ac29f3f4c519500ae",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p6_e0_5",
      "24ae99147cc49c5ded57055b871a0895ada05a54805d91be6206bcb7628fb04b",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_acute_open_p6_e2",
      "33cfcf2f4ce1d409313c39016423bf1b847fdd0ddeea92967b00829d4e509995",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(20.75, 9.75),
              @moonclip.PointD::new(19.75, 0.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p0_e0_25",
      "0e149c993d6becc41bf609062c452a3001eea59347301a14ad780a73ef4019c6",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p0_e0_5",
      "d2f366f158b62c1f035b370ff17750d6c6abd5da355e77a6f7a3a6857eb3187e",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p0_e2",
      "e987e65b4d8a091f764f465aeb46a20d4d528679faee9f094e82db1fc7851e92",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p3_e0_25",
      "ba202ab0a6c2984d9f2b00098d1f2fd23c7bab4ea616d69fdea84904d1089ede",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p3_e0_5",
      "e7ae9b54d11cd854d8c167c37674aa771ecef982c5e0ae299652537be121cbb2",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p3_e2",
      "aab87759d80e3413df40d0f69d56df4c429e89e2738b45b5424707c1703366ad",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p6_e0_25",
      "358c618747765e9c673ee03cbf6585502db41bedd2742943b788b3ed8a7415eb",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p6_e0_5",
      "44aff0dc57eb9c3d481a725f01d0458147626f0191241a0f2f2d960a3fcf567c",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_closed_p6_e2",
      "f8f68b31d04835b77859d57c36371ce9ac2f39ff18d7bb5f641eec6a355df4d7",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p0_e0_25",
      "d166ff7c3d714913e3c649b6a8670c429269a0313004686f2d34c0e6a2049a6f",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p0_e0_5",
      "0f0cc692fbcdacda106d14b827ec78109acd9da7b12aff17ef1c323d97203601",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p0_e2",
      "4c606755aa14824942c7a8fb04d598fbb1ff7b0dce817359952de8b4c9fe0f91",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p3_e0_25",
      "5b4777cb7387f93bb66110496fdeb458e838e8bf1ec8bbfe632e0072886abcf0",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p3_e0_5",
      "cb3beefd02fdf65bfc6692edc600264af271a2bf100efe90f5cd7a220a277d27",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p3_e2",
      "b3ba41686fabd220e36cb4f26a46c782816de962ab21dfaa59474c5572b63dd9",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p6_e0_25",
      "7d45f6e3d7e495a778fea3b9308d096785534a26dc1b0208cc336c28de25f297",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p6_e0_5",
      "3a2c2b2707f0448c35d149aa020c325b77fdd1accec328e4bd360ad5cfd1e6eb",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_bowtie_open_p6_e2",
      "02d6876eb9d63e99b0293b555b7667fcb23e687be8681a8ee772379231b66e38",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(9.75, -0.25),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p0_e0_25",
      "f452d021788c23b7a5c60e01b388b0b571c78e9f53200328955a78af9f048ac0",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p0_e0_5",
      "dba83dc07682d674478e841241073ebf00a777f38df4ea1e496e1252892669f8",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p0_e2",
      "d75e8828be3e8311a810476a72f5372552290707bd1e941e106faab6bb39b0db",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p3_e0_25",
      "2dfaced37eb5a6e1e47f7c11dac9939d29f40ef5d369b64bfba2e132922e7ebc",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p3_e0_5",
      "dbeea7661c51770526d7bad00fc424fdba750dad0da9433fc030a28d1ff9dd4e",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p3_e2",
      "647cc712353e8ddda94e4912736fe69f6d3a2cd6a16e4f66c858b9b39143ce0e",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p6_e0_25",
      "ac2e713a590e5e1ad1b1acadba2230d15c4f612772564a9d5db8c57bed9fea7d",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p6_e0_5",
      "78a95a2912f71a361eb84d5b2e50ea33f7f0f1628ee0bb4cd6c5cd35df27cfcc",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_closed_p6_e2",
      "b465b5448f231dae567c176e749b0f32b60f80fa2cfe4467ddd968df0c4878e7",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p0_e0_25",
      "c131344f31a95ff18afe74afe9d0bd4872511503d4418a2517ea37035a7ff694",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p0_e0_5",
      "e56156c753eed4bb06f4de26770732138fbbcb54131adbd88e201d1faadf75dc",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p0_e2",
      "51408bb2e759582ab605081bad178574701c9504aa51c7d2b42cfc607f927cb5",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p3_e0_25",
      "7bc098bcc0114d9e061699fde2cae41694725d9e44b066c55513650a29b9d43b",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p3_e0_5",
      "9d6f4b752c40b3892f5db36eb8ebf427390a6e1ae4305858941031d37af844f2",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p3_e2",
      "c98889abde3d1066a4e0a1c43c65042f30cf42da3afe8ece102a7642c9a57088",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p6_e0_25",
      "51eee402c63cf7669cb0222101f420a4a5e9fa78a00c640cf5aaa0e0a0994ae3",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p6_e0_5",
      "67d87a67b57cb6b5b868038c237182d7cefb23aa5ecb7eb9030eb65856cb3434",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_channel_open_p6_e2",
      "3e059dee11fe5107620b44e479d82155dbbe95902e7dbd37d8c4e09191ab275e",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 3.75),
              @moonclip.PointD::new(19.75, 3.75),
              @moonclip.PointD::new(19.75, -0.25),
              @moonclip.PointD::new(29.75, -0.25),
              @moonclip.PointD::new(29.75, 9.75),
              @moonclip.PointD::new(19.75, 9.75),
              @moonclip.PointD::new(19.75, 5.75),
              @moonclip.PointD::new(9.75, 5.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p0_e0_25",
      "dbac383ba1aceaf5900a856543c12cd4e7a32e0880c1e8d99b3655b5c62b51b8",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p0_e0_5",
      "5debe04eb0e1bb124778d9612636059408b3f947713ab105067700cf63faa0e3",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p0_e2",
      "2fd8da1a37ab7ce2045524f4e78733576533cc8e7897209361052b4f3d97ca14",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p3_e0_25",
      "531dc2f01899b1f49cc09785d548b8112bb6b1f7efd9ef706241999326680c19",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p3_e0_5",
      "70f26d569e27aa22bed54aec1baf6760e086ebbf53f54e8361aaeb50bb4b0e9c",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p3_e2",
      "9965508b4217c4cb6e7ad48871be1ff9b0347ea1b32b10041acae9fbc38cb782",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p6_e0_25",
      "a26947f33ccbec43140f63d878c8fbf62277e3720eb39db8218c3d65adc39ece",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p6_e0_5",
      "5e4eaa8cbafe86149728b000433be0949b0256a87d3f0f5d14547b494197279d",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_closed_p6_e2",
      "dbc659e9105a4ea4138fe5e4e547b69eef651c61cf09e60ac5ac297f02079be5",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p0_e0_25",
      "3bfec37b3d4fc0c3bf3eb8e02fb4b4fb4454a1534b42a963e71b87a38350dfe5",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p0_e0_5",
      "3fceb0be04a7517a6dad6726fdf4cdc21bdca6bd76352dd3d57b9bffb32a9fc2",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p0_e2",
      "d24c998e2db2b66fb4cc1dc0dad05c10836c93ad34909fe1e9afd98f1d3bc662",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p3_e0_25",
      "a6da5ab3f993111099f6aeda8ceb8a83c8a5dc2cd6b61436fef1aabe31cd707d",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p3_e0_5",
      "c614f347469b6f9c50f695c29f2d15f41687aad30edb7a52799ecdea20ec1ca5",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p3_e2",
      "9a7d8a8cd67fb9cb1c36ae9ec42bd307de653d87f4c8337f9a908cb4489500c0",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p6_e0_25",
      "8d2f75634eccd9142436ba1fca0d111246a4c7382659cb2aaec6b45e510fff44",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p6_e0_5",
      "41771cc667782984117a4b7b70fe9255398ed55e2146c6608d1e7150fa5a20ba",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_dense_open_p6_e2",
      "945bd0a681445285ad47ea1e1631d701493ed7a23addc249efa1a7833a37d674",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(3.75, 3.75),
              @moonclip.PointD::new(-0.25, 3.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p0_e0_25",
      "124f83204eb2b1860740a39a320e06b2cee3ea908916f97e377636fc3104bb97",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p0_e0_5",
      "0c981d6a0c9e8616b706b496073c2c9acc66b951411d9bafc4f2701580eb97fa",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p0_e2",
      "2d2c83caa253300b2266969b9fccf9f96e2198b773cea4728091990f0fb47bde",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p3_e0_25",
      "823f4a4cd8dbe83a3adc222fa6ae5cf54454d1316174ae65ca771395b76bd95a",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p3_e0_5",
      "e260e102e586fe477dc5f0f34a4a5c03da30f0aff72cdb0b111cc5421becacf3",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p3_e2",
      "8b09cb6380447be1f1b9385aeca7885da5c3e62abdef65e24a392feeaa42b2fd",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p6_e0_25",
      "4f458123fb85647cb6a0a6783cef54c8bed877039d09be1f147f82a5ae89d025",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p6_e0_5",
      "74b69904bb638d8cbcf9029bda6bd6002bd5f3c9569c2109502de6c4b947ee78",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_closed_p6_e2",
      "1ef9ba7968cf442b9dcf09c30b605468614541172377638260f9cc33bbd098cb",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p0_e0_25",
      "d8d8277edbf8b4f7bb54d3fd72c72ee515333e459f4bb4e810a18214e9fcdbdb",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p0_e0_5",
      "5a7c5a4374b877fa574046d60b8d181cecd551ebce2f51503c63f0b3a1ca5967",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p0_e2",
      "011b6d135f5eae3783a658a887e726c726d4d4bf1f21e1e209bb36d8ef591d72",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p3_e0_25",
      "3dae75c1b836c60e5936625327be7dc83b176bff013956e16f97efe94879ceb3",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p3_e0_5",
      "88cd4fa915cd75122e356e93322294574d58ca26e61106f0b2ebed764fe4f468",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p3_e2",
      "4fa5ec3dd70e0193a0ec82e812ab3c9edeb6bb29dcae38959cf199b66b74f6f8",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p6_e0_25",
      "490ac0728dff5a0694480241993015969eb46689265c2eb225e72cae94c96ee7",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p6_e0_5",
      "e37edf596efadd06e731aefe7bd06d05868b865efce84838421baaeda1ceac7e",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_mixed_open_p6_e2",
      "36737ebc5963fb1c1b315cb4d667c2cd9f656bc4db0cae6ddde2c23a77b04d70",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [],
            [@moonclip.PointD::new(0.75, 0.75)],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(0.75, -0.25),
              @moonclip.PointD::new(1.75, -0.25),
              @moonclip.PointD::new(2.75, -0.25),
            ],
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p0_e0_25",
      "86ba9b8337b4edfb773a3f1f8c3470459fd3a6d2a5af2076cdc17979dee0d9f2",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p0_e0_5",
      "74412dff8f7c4a6d08469855007ee3c2560e6b1ab0d8b495dc0582083e70e89c",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p0_e2",
      "d43370fbb069736036190ef620b2c7776163168f4d0b8e6ac7ef653683afbd79",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p3_e0_25",
      "15e150ddbc5a86733d1cc60c16c585eb12cd783f514d5c4778f3edf09c05a366",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p3_e0_5",
      "4ad9fcd298cf245e475ae7d5b98cdab8c38a22b7753a2b4091bab9e7fe068e8c",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p3_e2",
      "1766c48799de15a183c9042adbdab4173fd850b4c1df898a8bf2a904b5fac714",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p6_e0_25",
      "93d321ee7ae83f382337c0ff59383727573e2abb6f6a97a54047a5fb4eda2ea5",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p6_e0_5",
      "00c4b917e191850b17c24b3e81f8fe7f5c76fd7037178c2009418d6b59b301ff",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_closed_p6_e2",
      "aa978a6a0fda97376a6b36c8a903b4a35a73b329eed35187e29d283397124abf",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p0_e0_25",
      "8a30fd7232e187cb29b21aec2d355a4a6ee5dc7f13919833494306c4d99706bb",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p0_e0_5",
      "821126a614c747679902668356a1e2abea7bc88b57c625d94ef0298307602373",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p0_e2",
      "1bc78642c6f6d66dbb7497dbb26cfca9f1b0a6941300d793f68b3970e861bec1",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p3_e0_25",
      "d1586b04a34d9f5f939604b47dbffbd614d6f4f662343913280e47accddc8dee",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p3_e0_5",
      "3bc651c662c25c1f0b37196b6a4399511c1c325c753afb4d5578a5d5a6eeed2a",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p3_e2",
      "108168a02afc6ff56a3b7f6c66c67baccd256b4362ba457f8da4d143430a67af",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p6_e0_25",
      "26b3cc39b1d347b99ca93b91a05e689e74666d27885d9ae755c24e254d51459b",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p6_e0_5",
      "9d5a0eb908f39e0153ff8a8dfd32e45e3c2a91b9a2a30ef45faa0b933d7e37e9",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_notch_open_p6_e2",
      "25ee70b9397cf1c0111b999e2f8f407b3df2641f74462489f95ce2a4ceb81858",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(11.75, -0.25),
              @moonclip.PointD::new(11.75, 11.75),
              @moonclip.PointD::new(6.75, 11.75),
              @moonclip.PointD::new(6.75, 1.75),
              @moonclip.PointD::new(4.75, 1.75),
              @moonclip.PointD::new(4.75, 11.75),
              @moonclip.PointD::new(-0.25, 11.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p0_e0_25",
      "05299c46dff968e2ffc4d58b1c7326ad9c02d065bf5bf6723fffda04b1e80e1e",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p0_e0_5",
      "24ed16bca1aa4289e18fa069c87166a9c34eb06899805b19e06b94be5ff658a6",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p0_e2",
      "7862b9579af4498df20a15fa762b6ba1b1ba2e8ffdc05c41bf79e22390a3cca9",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p3_e0_25",
      "17180a054ac86803e8b33924d4aadb0228dff7657404792d339105dff1cab1ec",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p3_e0_5",
      "8eb2cfcec26f93fb4c67809a0caee760f0b18f7063bbb3f6c39672cc51afb52d",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p3_e2",
      "dd999b2f70e123d34e044436a5a5176ce71da892add273f5a748c138c6a71837",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p6_e0_25",
      "f2a366d5b48efeeb5af89181b115a538c6f41a77cab48ebbd98e31ec24d797f5",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p6_e0_5",
      "c25774a1d0fcda7c73e0ea13e90b4b69f10d604ad66f42627b97c64638532d03",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_closed_p6_e2",
      "8595cce88a79bb71b113bcf9faab83ac9d3a2dbb3469bf1f5fcf622f2760baf1",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p0_e0_25",
      "77910e22701efff3f9ddd6d7da7d30f413d14172f3d4aaf958a0427c4162402d",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p0_e0_5",
      "bad85324f8832d152ae24cbe2264b3e03501ccf1b409945b40f370a7ed173775",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p0_e2",
      "606623ef8630a3972fddeb4ec485f0fd9e1e1513d8d49ff2404ade6a1ae82587",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p3_e0_25",
      "b82385506a9348e43ced7ad694a61af850fa850216b93677ca0cafd7a0b7df58",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p3_e0_5",
      "b822c3fa8bc4ca14fdb06e4d217e8ced5515260ba0ce416e0e610a554a7e12dd",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p3_e2",
      "89bfc2aab2724f60b964f956897519c6171c10fb85b3fa4c7b57b727504c7546",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p6_e0_25",
      "8063b705eb7d2a076032c4d43e9e85a05a9fbfa908bf73c8b72961d20bc4aae4",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p6_e0_5",
      "280334ab7b5e1c5511671de2f8d81fddf1f419492b4fdbc3c50c5aac07526103",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_rectangle_open_p6_e2",
      "322194e66fe214fd1e6b6e3f5fa8bec924da6672c1eec36e448bc256d15c8bce",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(4.75, -0.25),
              @moonclip.PointD::new(9.75, -0.25),
              @moonclip.PointD::new(9.75, 4.75),
              @moonclip.PointD::new(9.75, 9.75),
              @moonclip.PointD::new(4.75, 9.75),
              @moonclip.PointD::new(-0.25, 9.75),
              @moonclip.PointD::new(-0.25, 4.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p0_e0_25",
      "a72e0cf7c0fc484173882703290074ec8e940599e64b5d1f60654892386aa095",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p0_e0_5",
      "8872be4bfc480fd9b216dd72c1fdac9819093965fc4882aae43046ba0e7d8a7c",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p0_e2",
      "91658a8c1222da262bbacb237d0503fd6f4cb31498c8206250dc0f09029eea73",
      "SimplifyD",
      "Closed",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p3_e0_25",
      "46d6f0f30903e31713dcaec8f00963c43e33e04cba14962337aa1ac4e5488d65",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p3_e0_5",
      "7e70cb73f3df09ed80f0025a7a77230fecbb38aaead0915075c3d83a23c04c50",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p3_e2",
      "cc75772f7cb09bc33836d9af5f12117fa01a7dc56cfbff4b194a0fddf60f24a5",
      "SimplifyD",
      "Closed",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p6_e0_25",
      "5577e7151e7c503c84c8753875f8b42c60c4ecd32204ae6afc23364d24cadc12",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p6_e0_5",
      "12fc60ad3883141ca322b6a0b5a067e78d449b7d071dacbc742f64d6bd80d465",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_closed_p6_e2",
      "d1c5e98bad7729baab9e0115390d012c302061f6aacaf054b5e27b88ad89452e",
      "SimplifyD",
      "Closed",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Closed,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p0_e0_25",
      "b1bf51c29c8320466220edf160a113b7fccf34e9beae0ae45f8fb5f26fbb4a12",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p0_e0_5",
      "09dec6a58c810c3a82d96a3e8ff1c54387ea5906c89d529c74cad4bb357ab6c4",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p0_e2",
      "5958f13082527567d6c07356d1b7d784e0f19f2ffbda71363f622d415d9493d0",
      "SimplifyD",
      "Open",
      0,
      @moonclip.Precision::new(0)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p3_e0_25",
      "e0079eb22aa7346dbbb95482eaa59110d216503c3d0675e698abcc91c974bd3f",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p3_e0_5",
      "343bbbeec14cd890b50e9623effd9f6117fa5d778cac47e42eeb3cc09a358557",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p3_e2",
      "e979ee9cba2289d018ff8ad8e13ba37997029ec96902afb6e94c0b4f12f5bf1a",
      "SimplifyD",
      "Open",
      3,
      @moonclip.Precision::new(3)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p6_e0_25",
      "90d5ab497d4aa7c5f9cf1c309e2085d59be77b4f5781f763d6eab778543df4ad",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.25,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p6_e0_5",
      "fad9f2cf967260d1d13ccb149580ad0d9286c5a16c74eb31903cfc57f4248160",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=0.5,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_decimal_saw_open_p6_e2",
      "ee96efaecfa559619eb8b276cd08e6f8638690cad2926e67bb473cabc1436669",
      "SimplifyD",
      "Open",
      6,
      @moonclip.Precision::new(6)
      .bind(fn(p) {
        @moonclip.simplify_paths_d(
          [
            [
              @moonclip.PointD::new(-0.25, -0.25),
              @moonclip.PointD::new(1.75, 0.75),
              @moonclip.PointD::new(3.75, -0.25),
              @moonclip.PointD::new(5.75, 0.75),
              @moonclip.PointD::new(7.75, -0.25),
              @moonclip.PointD::new(7.75, 7.75),
              @moonclip.PointD::new(-0.25, 7.75),
            ],
          ],
          precision=p,
          options=@moonclip.SimplifyOptions::new(
            epsilon=2.0,
            mode=@moonclip.Open,
          ),
        )
      })
      .map(fn(value) { simplify_json_d(value, 1000000.0) }),
    ),
    actual_simplify_case(
      "simplify_integer_acute_closed_e0_25",
      "07a5ffc9d242d4607aa9198033d8d4aab77b7f07ee4f280c64a6d92fd396f176",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(21L, 10L),
            @moonclip.Point64::new(20L, 1L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_acute_closed_e0_5",
      "b70b7122832f896402082d224405d7b867931f1c6eb6da55cbf0a1f1ed0e65ef",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(21L, 10L),
            @moonclip.Point64::new(20L, 1L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_acute_closed_e1",
      "a5d3b9db00d30a0713b2d98c75d29afbc576e3591e1aefc9c6cc2ef09c31d7f4",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(21L, 10L),
            @moonclip.Point64::new(20L, 1L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_acute_closed_e4",
      "45a69ee5ff0ad23cb5b57a9d9e03224bc6349a35916f28aab0bb6913f211c205",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(21L, 10L),
            @moonclip.Point64::new(20L, 1L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_acute_open_e0_25",
      "90bdad3e053180f9d840865ce52626464fccad5ff303473b229a4dc0ca41d915",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(21L, 10L),
            @moonclip.Point64::new(20L, 1L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_acute_open_e0_5",
      "f9fe608e8d4518674a878db6dcc258822df9b1480ceeddb2bd6dca526dd6b649",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(21L, 10L),
            @moonclip.Point64::new(20L, 1L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_acute_open_e1",
      "ce7a7e26dceb5b841eee18fddda74fbcb575208dfc06ec7e11ae07970f1008ca",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(21L, 10L),
            @moonclip.Point64::new(20L, 1L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_acute_open_e4",
      "ccec1de19a3c2160e1801df628c96f71b7f93b4606b9f71a51c184a93c3ab14e",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(21L, 10L),
            @moonclip.Point64::new(20L, 1L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_bowtie_closed_e0_25",
      "7f214f77195fd76c67b8924c71eb524ca6b3a0ac321c7f58f10873b5e8748591",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_bowtie_closed_e0_5",
      "1ef994bb3dcff77625280d3004d7d3d730efcc68d936464acb4c625086521ca1",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_bowtie_closed_e1",
      "851f7e26a1013a6d9a733dccc025d40ccf577af210b8962ff98c1a1ba9b7bf3d",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_bowtie_closed_e4",
      "5082c7acc4b22907bab7a149edc1ec56a6ca2393f4b6e6e338c1dc7d5affd9a8",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_bowtie_open_e0_25",
      "9b98be840c8bf991b9e307895ec4e6171677d2726442b3b2a3a4b7ab9655c2a2",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_bowtie_open_e0_5",
      "50782b4278f8a046d7deb743eca0310fca1441998baad0f18bbc59cc8771d664",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_bowtie_open_e1",
      "33bc7501f5e4b557517a910be91aa38eceef69beee89733fa9ecb3c90961c228",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_bowtie_open_e4",
      "3ecd533a0a6dea6e51d0783ae881665d1c62caea0b3d49c920e23676bd15eead",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(10L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_channel_closed_e0_25",
      "e2842d7e826474aefe4148dc3ea807898d43424b7587e99a1cc858a9a388e884",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 4L),
            @moonclip.Point64::new(20L, 4L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 6L),
            @moonclip.Point64::new(10L, 6L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_channel_closed_e0_5",
      "66f09fb48174f55502f026038dbd9de0f8019fb226c65d519f2f515dbb546db6",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 4L),
            @moonclip.Point64::new(20L, 4L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 6L),
            @moonclip.Point64::new(10L, 6L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_channel_closed_e1",
      "7935e8a12a9abeff9f43d5a81cd9a9928e6bcb8f2a62924c0aa1e2202ed67248",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 4L),
            @moonclip.Point64::new(20L, 4L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 6L),
            @moonclip.Point64::new(10L, 6L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_channel_closed_e4",
      "1859cd927fb7746ba84faffce804f9e2ef4015332caca3c4e5176ef2186455c6",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 4L),
            @moonclip.Point64::new(20L, 4L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 6L),
            @moonclip.Point64::new(10L, 6L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_channel_open_e0_25",
      "2b479f0a9068bdfdcf867e91b9a82a06b9d4089ae7845c294bc08b6e77be5948",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 4L),
            @moonclip.Point64::new(20L, 4L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 6L),
            @moonclip.Point64::new(10L, 6L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_channel_open_e0_5",
      "2de7e731c2bad750b29a2e2ced59e3b2f74ce429d1ca3e6897580ca7aaa317ec",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 4L),
            @moonclip.Point64::new(20L, 4L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 6L),
            @moonclip.Point64::new(10L, 6L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_channel_open_e1",
      "d03d4b9fda898a68769b803fc7e4b91fe4393d666e26d5dbb4fdf5d156a81daf",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 4L),
            @moonclip.Point64::new(20L, 4L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 6L),
            @moonclip.Point64::new(10L, 6L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_channel_open_e4",
      "9303dbe7c104faeb7fc22b019a360e738783fd8daab0911a24b0f5b19dec3c73",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 4L),
            @moonclip.Point64::new(20L, 4L),
            @moonclip.Point64::new(20L, 0L),
            @moonclip.Point64::new(30L, 0L),
            @moonclip.Point64::new(30L, 10L),
            @moonclip.Point64::new(20L, 10L),
            @moonclip.Point64::new(20L, 6L),
            @moonclip.Point64::new(10L, 6L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_dense_closed_e0_25",
      "cfb73d5ac0f9666f20c7f6ce21043067f04171c17c09c7265325fdc0b7eb4087",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(0L, 4L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_dense_closed_e0_5",
      "287e8f1f25affb6fd87f10d8781757fe6dd5b7aac808134327fe3ef2e66ea333",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(0L, 4L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_dense_closed_e1",
      "87974aacc50e3c817db6769c19233073bed1f71c8151b39d05f20aeb3d6aa6fa",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(0L, 4L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_dense_closed_e4",
      "5d73e5815de08158cf2b9f1d6ced4a4fd679a657229022010383b68c08a678fe",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(0L, 4L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_dense_open_e0_25",
      "958c1e338905e211aaa76255b313448529c5ef083fee858055489086a3e15645",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(0L, 4L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_dense_open_e0_5",
      "4b80ad460c8c3f323166ddd3d91de949e0abe1286aad10e605fcbb412d9cb12e",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(0L, 4L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_dense_open_e1",
      "54f8030469f208b1265597342bdf473a56916963446e2ef1ddd02e73d0dd6db4",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(0L, 4L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_dense_open_e4",
      "39de18cfa8558d49dc6c7cb9d04804ef07c067d9083de914360ba38c88cf4324",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(4L, 4L),
            @moonclip.Point64::new(0L, 4L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_mixed_closed_e0_25",
      "3b75d7fe6b649f5b4a8b922b08347f1caf6b589e1366ac390a123064bc6ba8aa",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
          ],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_mixed_closed_e0_5",
      "b23b70cc95e5cfa5fa9dcbec22634bfb10103f34f33b92a1c4b6b848c77df200",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
          ],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_mixed_closed_e1",
      "69fd17cae04a6810d6d96f043721bff0d970e8956a4a4c19fd3023d129558265",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
          ],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_mixed_closed_e4",
      "3f5361117e636a495fdddb9c505c4e4cb64e74c5fc251771bacad878496c0070",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
          ],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_mixed_open_e0_25",
      "d4193f547b83c1552f2b9cd3a2eaf96516fba8420073351950ade31cdaf5d3f7",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
          ],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_mixed_open_e0_5",
      "e7e41406ef31bddccbc41c3f8d4531d79ed3a1260a174380c562ba686f1623a0",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
          ],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_mixed_open_e1",
      "70e863f24fe2bb40d2dc942e7997fd8042a44e89fc9c5452ae482f2381f77a2d",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
          ],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_mixed_open_e4",
      "209a2d6abc45da1ae014067cdb046643da076c16d8bd3ee5d62336319ac3aad4",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [],
          [@moonclip.Point64::new(1L, 1L)],
          [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(10L, 0L)],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(1L, 0L),
            @moonclip.Point64::new(2L, 0L),
            @moonclip.Point64::new(3L, 0L),
          ],
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_notch_closed_e0_25",
      "c03a9277bc659e55708db9ecf4e268647f2bb3c36efa5a11828af134a1b033dd",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(7L, 12L),
            @moonclip.Point64::new(7L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(5L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_notch_closed_e0_5",
      "d31dc1f3f572df45c3b3ab94198fcc15af9b38c4ec193eafccd7149bb4951f85",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(7L, 12L),
            @moonclip.Point64::new(7L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(5L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_notch_closed_e1",
      "23bdcb021c94b4e59f6c1e8ea709f205b454952642788ceafca776bc55bb051a",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(7L, 12L),
            @moonclip.Point64::new(7L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(5L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_notch_closed_e4",
      "382674521afd023984ea4b33d570f7932328cd9d7ac610453d4861a93e1287ba",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(7L, 12L),
            @moonclip.Point64::new(7L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(5L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_notch_open_e0_25",
      "8cf0365cae4b28e1aab30a38021c9b39f1ff02d2aab218f0d71838058fce16b4",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(7L, 12L),
            @moonclip.Point64::new(7L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(5L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_notch_open_e0_5",
      "997a42ebfd0322f9ab813e1c5a1e13c3247c963a0ab2a4708e9251984f1f4a36",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(7L, 12L),
            @moonclip.Point64::new(7L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(5L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_notch_open_e1",
      "6838265a69b5ece09d228ee6fc37c699e9ffd944e017fd552c5ffe0a90c6c9b3",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(7L, 12L),
            @moonclip.Point64::new(7L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(5L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_notch_open_e4",
      "5a4bd20d6da955dd6257ba03ac4e6eb7c7b4b3dd561a539adec5196f35589e20",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(12L, 0L),
            @moonclip.Point64::new(12L, 12L),
            @moonclip.Point64::new(7L, 12L),
            @moonclip.Point64::new(7L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(5L, 12L),
            @moonclip.Point64::new(0L, 12L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_rectangle_closed_e0_25",
      "ff22b6c6b469b1787137ed5632a90162ba3f0d3cb0ded379c93afb12e3bb6898",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(5L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 5L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_rectangle_closed_e0_5",
      "2c68653c12bbd762a42ba764f96cff5bccecbae9c7497fe269f4d00e6f97a59c",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(5L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 5L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_rectangle_closed_e1",
      "132f493f5c80fd8a7809d7c3527eefb6307da65dca3639e2e00a63822dbb1d65",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(5L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 5L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_rectangle_closed_e4",
      "9efe54395d3c339158078a44ea68807ccc1b0348530f163bc2f92686d1c32338",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(5L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 5L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_rectangle_open_e0_25",
      "078af4bd4bf9969b8d93caece1f3687dd289885707f0484e2da7a170a3d10967",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(5L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 5L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_rectangle_open_e0_5",
      "abf80b669aa5f167931e018940e4dc184bad0da948b2a8f4d849e332a17a55b4",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(5L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 5L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_rectangle_open_e1",
      "e01f7085991947f5e056fd9ec28e0528d21453f5b707dc6685822848210836ec",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(5L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 5L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_rectangle_open_e4",
      "fd8bcfd9efe8be413235c3c889bc5e3592d6e57044c01e2a77dbdde9b0324305",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(5L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 5L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_repeats_closed_e0_25",
      "12cdc03e0f487f83efcb353fc149aadcf9314f903da36dd81941a58caea7453b",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_repeats_closed_e0_5",
      "d394eab3e52709984f4fbf3818c6d3cf5eb3e9fd272c6c6609bd6c6ae6f336d4",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_repeats_closed_e1",
      "77339d2f6fe57abaa78c20f77fec6e6ba5173a7ecc9f21ff9f714ce20470d75d",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_repeats_closed_e4",
      "f917447ccec4de1af2c18688ce720b7b5d3588d04fc7e6db8b54a17d163cec67",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_repeats_open_e0_25",
      "8f831bf7fa17b6fe0cc0aa0eeeb7f01ae90cc403c148f101a78a4f874606838c",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_repeats_open_e0_5",
      "518ee0b8fe5bd637ca12dc0676d1679262c340ea5bd61003f13025238f5c52dd",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_repeats_open_e1",
      "ba12fb376c92578a90f0cc447bfba15c27f99396ad852a5de0ae63603552e47e",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_repeats_open_e4",
      "b74358a59f2183834721a6efa08c2ee7fcbaa57485625da3be8e95bc4edd90d6",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_retrace_closed_e0_25",
      "08231d09650499e108cfa2118af46be9319e49b841f8b8287eb6d813ee7cf7b6",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_retrace_closed_e0_5",
      "e9a048186ca69427fcdc0824a74724027f665fb1aa0b57b89312b99ea49fba7f",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_retrace_closed_e1",
      "d9c28932512dad58f958eae5d4351cbca7bf12c86fbf648d2477768baca80515",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_retrace_closed_e4",
      "03adfa827d563d34cc4648ffc72017ae0c64036733d491d543675a3b6e7b0a28",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_retrace_open_e0_25",
      "9ef6043198e0494092670cc4b084cf9cde4736df3dd9fe5ce3b6b93a51fd53ac",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_retrace_open_e0_5",
      "2e91570ce082892f3b309b22b4344b820abc03efac3d9f7a67b472b4f28ab2c0",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_retrace_open_e1",
      "64160f05147e3cb5733418e6b39d059c42491be01332feae4fe6bcc37feead38",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_retrace_open_e4",
      "86b8b7f404ff86180de1e2d680a444f9ebf1aa7d648078b97e1ec8404ccd683b",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(0L, 10L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_saw_closed_e0_25",
      "24f49d3684c004a600a8733bef4e0fd7d0e746b5111eca2384acd5a9a1c6fcfb",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(6L, 1L),
            @moonclip.Point64::new(8L, 0L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(0L, 8L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_saw_closed_e0_5",
      "de6747f67bb95123994beb81e1184b94f0e9f51180476e3009b585ecc7475744",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(6L, 1L),
            @moonclip.Point64::new(8L, 0L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(0L, 8L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.5,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_saw_closed_e1",
      "39b4d7af34c49d8976743636cd43503fdda4c0d9f906f4aab705e6f806669344",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(6L, 1L),
            @moonclip.Point64::new(8L, 0L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(0L, 8L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=1.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_saw_closed_e4",
      "ffc519222a009f84f818596edaa374839a7d179b03e4fcbeade368ea1d2f225e",
      "Simplify64",
      "Closed",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(6L, 1L),
            @moonclip.Point64::new(8L, 0L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(0L, 8L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=4.0,
          mode=@moonclip.Closed,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_saw_open_e0_25",
      "42cb8c81b7334d1c0481affdcba352343e38cd092b3fe6e9a5e286676c2e5d32",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(6L, 1L),
            @moonclip.Point64::new(8L, 0L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(0L, 8L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(
          epsilon=0.25,
          mode=@moonclip.Open,
        ),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_saw_open_e0_5",
      "3ad4c9e30d4be262c9da0f81b94b26e6a46fc7a6717173b9b91ff1a299cf240c",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(6L, 1L),
            @moonclip.Point64::new(8L, 0L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(0L, 8L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_saw_open_e1",
      "35cb55588568c96ad49dbbf4c3d1840c8118d22f7cb0125f7b4ce0b31ac1d71d",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(6L, 1L),
            @moonclip.Point64::new(8L, 0L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(0L, 8L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=1.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
    actual_simplify_case(
      "simplify_integer_saw_open_e4",
      "5d299601617742e463c2264aa932a50d58f024211b8f01eebc7ee02fbb7f2c14",
      "Simplify64",
      "Open",
      0,
      @moonclip.simplify_paths(
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(4L, 0L),
            @moonclip.Point64::new(6L, 1L),
            @moonclip.Point64::new(8L, 0L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(0L, 8L),
          ],
        ],
        options=@moonclip.SimplifyOptions::new(epsilon=4.0, mode=@moonclip.Open),
      ).map(fn(value) { simplify_json(value) }),
    ),
  ]
}
