// Generated original inputs/hashes only; stroke expectations are NOT linked.

///|
fn run_stroke_cases() -> Array[Json] {
  [
    actual_offset_case(
      "stroke_acute_w10_bevel_butt",
      "95d6118987a28401b6a5262d39fa391647a99c54980cc6ab3b3e31512eb7ae44",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_bevel_round",
      "128907d1a4390a2ad2f23c930162e06fb9011c746b068a77cc38854879d4d282",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_bevel_square",
      "9cfd014fc6444a7658ab5b2477548da20b8f3cba7d533501014b4b4c6bb14839",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_miter_butt",
      "bd955bdaa8343aa3150c1007f98965314178a7941824c2678b4281966563a069",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_miter_round",
      "5ef752d1fdebc67b404a59e243e202a3b6563d862edf5660193b563dbc451878",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_miter_square",
      "c2c0f804d35abc0a7609e52f337db9bc02b304f4855f9228c7d5c82b4c6356a4",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_round_butt",
      "3f11e5c1c16ce6c1d86ef83aff6fb18de935246940ff416845fe9a370eda2fab",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_round_round",
      "20a8743e0c79cf634b58f2617ad9d372b7a00a6fd3e4e0590b9525b85b5404af",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_round_square",
      "89910cc2fff11eeaeba8c5aaccc9a32dc2685ac53cbad5ca77e260bab93c135f",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_square_butt",
      "7c6e09b8bacc00d55de748010b080da8860ea3a22bee44212b8be8bd30bff2a0",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_square_round",
      "37e9be71ce4f55afdb2dc463a301ccc3d1e0a4c03a3110b0601e003ee18873bf",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w10_square_square",
      "3265411f59e77431e331baaacd4782d4385b0b3b33866ca1293ab99e6a583994",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_bevel_butt",
      "b5116f50655c1efd02edc44214287dc99c0e2b42514f707563eaaa6fe0c49bbd",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_bevel_round",
      "444f60b3c1504049401c6420b625b78d89884daa0df561df177dd278c43c177b",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_bevel_square",
      "e5d57486ea91ae5fdb94a30b4a308750f67cd56c410f1d8d89508665e3017d79",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_miter_butt",
      "2548b65d30bc1fe80bad6c3d2837cc2e13dd1601f7eb827b8fe62f9bcb202d20",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_miter_round",
      "60ffdcb9a2cd8cd9ee23e3159d8daa6249e6e8f6795102b09d3bd47c467d13d7",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_miter_square",
      "b9887c5e1e84813fa6360e4a509ce4655d8d509034be6de254687d3b97b29533",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_round_butt",
      "f46de11267971dafe86262a139736834b82e0ae352e4c7d7eede34f5aac467c4",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_round_round",
      "6deb3a91f5903ec76a694e2e16cd764231f4e25868f761fa52c709ca6d05e300",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_round_square",
      "ad717245d81571bced085318bf296bd9d795ca6cf01d117ee6548c65e9a6015b",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_square_butt",
      "5e131cd1be5f4c6ec5ba25052c868d09fa0c313921d64308d118235783356d1a",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_square_round",
      "2e8fb4d457779235cd0ac5e5fc7b9abd5ae155895e44e4a561afba40ec501b22",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_acute_w4_square_square",
      "2adc48cff93289c6b786a5ca8a61a3a55e9d56c0651f51dbc44ad955d8de9450",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_acute_t005_miter_round",
      "0d25efeaecc432d24832a6276fd7736395b1df39cdd702502ab4bc117efd1562",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(300L, 0L),
          @moonclip.Point64::new(10L, 50L),
        ],
        20.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_acute_t005_round_butt",
      "5592204b002c202fe6ff61f81876c5bcd04a95be7dd5524d5b47adfcfc98f779",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(300L, 0L),
          @moonclip.Point64::new(10L, 50L),
        ],
        20.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_acute_t025_miter_round",
      "c55628895dccd21099fc76db201e773ecb19e4a161f66e6f2b26a1b6677693f3",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(300L, 0L),
          @moonclip.Point64::new(10L, 50L),
        ],
        20.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_acute_t025_round_butt",
      "9955d1cdf39f014359b7b542c5f10d0b64613053931152eafba9dbde90c9102c",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(300L, 0L),
          @moonclip.Point64::new(10L, 50L),
        ],
        20.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_acute_t100_miter_round",
      "aecaec2040ba2aa5f74e311cbeafc1da5117e8510c38875935a20bae01bf1ba8",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(300L, 0L),
          @moonclip.Point64::new(10L, 50L),
        ],
        20.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_acute_t100_round_butt",
      "765803a71a3a5868c59eddb2999bb427315db40f7c7944203357f35382bd0c3a",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(300L, 0L),
          @moonclip.Point64::new(10L, 50L),
        ],
        20.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_right_angle_t005_miter_round",
      "65499dea580270bbfdba680166b47c142ccba5e6153cee9882d6d2febf7600e8",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(100L, 0L),
          @moonclip.Point64::new(100L, 100L),
        ],
        20.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_right_angle_t005_round_butt",
      "c2695848bf270e270c26d24007e0f8c1e63213a5cb3bd48021e599f1856ff161",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(100L, 0L),
          @moonclip.Point64::new(100L, 100L),
        ],
        20.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.05,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_right_angle_t025_miter_round",
      "ef953afaa1cc25b3443d84468673b4c043452dcb89f08a1b986ae2d4b47b067f",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(100L, 0L),
          @moonclip.Point64::new(100L, 100L),
        ],
        20.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_right_angle_t025_round_butt",
      "15c3a638ab8c01c80568e29229c1423a528df96129cedb084e52f5a6392676bd",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(100L, 0L),
          @moonclip.Point64::new(100L, 100L),
        ],
        20.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.25,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_right_angle_t100_miter_round",
      "aa6025b804a0ce8c337797fee158deaa20aebcf1029d0a0bf2f967995e6e2956",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(100L, 0L),
          @moonclip.Point64::new(100L, 100L),
        ],
        20.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_arc_right_angle_t100_round_butt",
      "a153ee741856bffa5eb646c524c6ca93a08f96083064704c212c9c8e3d4fd9f5",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(100L, 0L),
          @moonclip.Point64::new(100L, 100L),
        ],
        20.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=1.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_bevel_butt",
      "889aa127cc1839ede0fe9b3078fe0fff36e3e04fd2630ae5c4bc3d217fb59177",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_bevel_round",
      "ff14de0c48a83fc02a7bf8a6f95a1987f9382c729bd12cb2a3ea00fdde127a4f",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_bevel_square",
      "a0d3bfd45bcf54387c973f3636f0be68276ec989a0608cfea510bd778a378717",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_miter_butt",
      "9aab6015e2e277b81f93486cf2fc55c79312a227591a04a3b8db81c1bbe0531d",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_miter_round",
      "585b4bdb1f56e241711c38f7f1a83975883a58d91097d75ff8619554f04a6a33",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_miter_square",
      "7577b5c658ce5b33a4067632a4bbd93af06f86cdacd49a0c354be35ad1a28c4a",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_round_butt",
      "50b138b1d9f77b5bf81fa1ab536a2ac55310144346e6c60167496aafba11d596",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_round_round",
      "2cd87abb6dfae2826ede5cd9d0c8ac737223b61448ff4aed8796e07e18bc6fa5",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_round_square",
      "4fd56a1492360665527f2b1d27b7564ce16a6a71cd871566a01f41e263980834",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_square_butt",
      "7dd259ed30513c21fe32e4c9b64e6c9099e7fc1c4fdca83c62e3e1e238aec00e",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_square_round",
      "1fb31625434c97d6ba03e87d1bc204e1f13b5bd488aaf708098d527166f65312",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w10_square_square",
      "50f8c512d6244d0b56b610f0034e7fa8d4a2570edaaf338302a7deaac37662a2",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_bevel_butt",
      "a31ecaccbd1ab8b0930b0bbfbd9878b5051ccce577fbc2c91c90ad1c125aee2f",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_bevel_round",
      "7a8702fd5c3d4155970fb344345261928f387ddfddc71b7ccb384ac272dff1dc",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_bevel_square",
      "f5565fe065328c839f43a2275da4933a6ca5f07ff8256ecaae6554e4250f560e",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_miter_butt",
      "bc22c5bb401b935e9c1097aad5e689855e3612b2731a9478e789ecbbf566754c",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_miter_round",
      "17b10a0eae871699c15378fd01f288ec7a5b018205969660ab2a51bda88a4f82",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_miter_square",
      "5cc515eafa88cd23143cdb29d0bebd6f13d3bac6606587bafe4db957266c1d8e",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_round_butt",
      "5d3948e863b7f4585180cbf9d26bb05a92d41fd77e9351752e4f06c948d2c5a5",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_round_round",
      "cae20380f7bd572ddf49324147bfc64116c8666b3da08d9732a16781c99c653c",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_round_square",
      "283ef5248811853084dc3f624d0f273337d47ecc59849a1c39c4ab8a534a7801",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_square_butt",
      "c46bfa2355d1d3b1a7e48609fefbf8944f8c4e04f9ee8bd344623d92629710a8",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_square_round",
      "4ea348b51b5b940478a5b48ad7b25d38e2f61ca569e67df8ba0c08f0430f317d",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_coincident_ends_w4_square_square",
      "e88805476a41997ac0e42490a22817ee20cad09ba3e88c0f343ff1b585c4941b",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(30L, 0L),
          @moonclip.Point64::new(30L, 30L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_bevel_butt",
      "927415e14cb652557b7bdc13346931660f42c099b4203212eec26f6a88cac881",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_bevel_round",
      "091e7783e4936c0805b4acd8f3939d83c1d15241d5f299091f393ace3bdcb7af",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_bevel_square",
      "382e75611340b720148ca2ee4fcd0d533e54da6a8d6bcfe94c4068a60b8c9bd6",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_miter_butt",
      "9004dafa153585abf3bb17593e148546fb95325cb4252edecc38bfa6b7e2f93c",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_miter_round",
      "663e347dc15d20908657784fd896636cfefbe7fc583f5b0712e69a5207ededf5",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_miter_square",
      "67921251bf7d192bc20fc433b900700652c1ff3446988ff0655f78b1bcc127fa",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_round_butt",
      "004d73fab99f1c4d900fc9f9b0e2bb4829b90e74badf04d16118f6a8299dcad2",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_round_round",
      "3eabb1d7b4f8d82100a03a0beb72c6d96b8d899f39441758d60c549fb387c9b3",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_round_square",
      "0603a6b4d9f70e103888844f1c0a131db410e2f92949689631550bdeb6f6e8f1",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_square_butt",
      "d171576056fb83acd650ba4fb2d7bbfc7df6d2e97de9eaaeca66ea0ecee5c3a4",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_square_round",
      "49c19f0e2cfd49dacf115480c8b874ab714aef4b80e5ffa4daa80e2315f70dee",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w10_square_square",
      "f3a56f348d2bd984b52076106ff55f6fc61a7ebe0d453d84dbe2b2f5158e0ea8",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_bevel_butt",
      "9ba49de662e1a28c737d2bdbe2acf4ab356570a33ee8b15f28b2c938aa16aafb",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_bevel_round",
      "b8f208ddd14f37e2b19e23c9494cee2dd0d484bb0ec5c12fdd862aeeb93d2533",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_bevel_square",
      "611ef6923fc20cee7c10c190fdaf8f554d12b7eb89b52c200bca1871356c88fb",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_miter_butt",
      "3511d7cf1fb21aba22687c83a24c43252aa4874c34bf3e94bd7333683d20a60c",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_miter_round",
      "880e538234da83408b500a675018538e881b03be928693600ddeb4750f59fad1",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_miter_square",
      "5554f9b510c8f9c88c363ff5cd280d9d7dcb1073d8efbc42bd1069a6338cf71b",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_round_butt",
      "2e7ace385a1507d34c7901117eac86405c60d5ebf8f006855a5fd0fe267f8535",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_round_round",
      "fafd60d5f469faa2d15cb4e30efeccf16b5ae24ee8fbb1129c227c4fc8ac1cd3",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_round_square",
      "2fd93a7daaa55ecddc5c593cb9bc3c2d9b12c5ecd1264c259848f43bffc950a4",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_square_butt",
      "0903f7b8ffef271ddff383119b2e6d974705186a0e2c809dcb37d55276dfcf66",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_square_round",
      "ac75aa9c16b17fa38011b66b686c09c07e3d14d01d303dec0a314a88ec10bc26",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_diagonal_w4_square_square",
      "73807cb224716d8145f70663210af6b6c1b857c24cead59317a56f6f20fef481",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(30L, 40L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_bevel_butt",
      "eee7582297ef9504717c3b28fcc4ab058abb1abbd65d9d583980c522298c11d1",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_bevel_round",
      "5ab4fbf9f84221468de42d08a1aeaf7006725c4128f9ecfa40289d6c5e95a651",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_bevel_square",
      "cdff9eaeda8d69f93fd66b7330b06419be68f03be62d30124149060772e1727e",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_miter_butt",
      "d84872c234426de42e32c5887011d8de23961e24211036ea61da618f66e0fe6b",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_miter_round",
      "f857956f9efdca3f579f87fcd5260e7879854049fa22cdb8d8631e3e048116e5",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_miter_square",
      "b3f1edc232393ccc79cf866b7467927141519b52cd6c58452ebda65d05e8776d",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_round_butt",
      "21a8bdf77732678abd7a7710bf583e29a1fc3ef1a22b5f0cc95c03514e80d273",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_round_round",
      "f489f82bf13696529db0a481c1aff10d63f92e2bdd6b518a826cc95b931c86a5",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_round_square",
      "624a4bb2ce105ffbbdbb1a197d12af6e47b2ded01ea84f344e074b6a5c4989d7",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_square_butt",
      "92e8a941bcec0a09ec7091925523de8479abd837b39cbcf96593441aa0c7634f",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_square_round",
      "bb600a86bc2dce3dee3a1ab41689d3d61bdffcc77b4b1e2eede174e5deb94305",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w10_square_square",
      "3cd64983d92bbbdf4486eda9690699a805142d7ee45eeca81df486e70d2c64a8",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_bevel_butt",
      "593c31d818d6ae8d75aec56855d1ec32f58cc83dd350858e52a5debafe40601c",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_bevel_round",
      "d9fe0a95c9a7afa5fd45acbe8feb98c491c29254d79dd7da40c9a623b4ee4666",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_bevel_square",
      "f21ce4e2c842efe39842b615cd83d80893097d402755a684572f29c0a349c81d",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_miter_butt",
      "f928992b5748cde604d2098f2fa1ae1f074390cd0bd15a0e5e3db391a84afc57",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_miter_round",
      "7471d41653776240fd0eab0c387da864a1442775dacbbc9e8636441632efc2e5",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_miter_square",
      "04f41a61b0f73daad8b8ad873126f53d1ed0ec02219f937cb8050564f70b31d7",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_round_butt",
      "337e0ea910a6a58887757057bb5009ed1c901e76f43fea83c2585b892fdd5523",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_round_round",
      "8a4f5d4e2ca77b1e596fb11bddfb4383aa18b524f967fa37e77573902de91ff9",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_round_square",
      "e2743346e2b62b56f3731a2d586637de3dab66a2a41cba27c1c95732b885082a",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_square_butt",
      "429c37c7068717b029af6a5127ef127b89a82c338767cbaabc94d81425b320b8",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_square_round",
      "70f58b9ad4bdc280b8c628fe5cafebb141b21daeef8befda88866763dd8fb6a8",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_horizontal_w4_square_square",
      "edeaecde50b0a9110749140e4df5b3fe55907a10edc204484cf339b186f23750",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_m10_miter_butt",
      "18bcc5a9e9336c7c57c13f4ae636e2b0182c9d1da0d7fede88362da65870216a",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_m10_miter_round",
      "531595a01ac43563e9c9104f23e0e77a0f8c85dbd6ef0f1fd198fb6629a65ff0",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_m10_miter_square",
      "64a93c2eb813a307ba300e4ede176d14a93877352c4aa5f5cabbb9c654a73142",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_m4_miter_butt",
      "b5335b23a2f1d1e4c1bef3576fb97570b7f02c20fdcfed5c61ea69f20cc7c8af",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_m4_miter_round",
      "85433e586f6ea9c70aa1ba1fdc0a8346c4ccbd959a546d10db8d9f537444f007",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_m4_miter_square",
      "987e14f4502438ceac1a27a1358a8482dcaed0ea655a7e4ebcabc865656511a0",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(60L, 0L),
          @moonclip.Point64::new(2L, 10L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_other_m10_miter_butt",
      "5e3e6a4c6093b696afcf0155600643ceeb6ed51ef4428a4f606b4989debe428e",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(50L, 0L),
          @moonclip.Point64::new(4L, -16L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_other_m10_miter_round",
      "5972ad771d6bf14171761ae25c846be21436fd7aeea1b04c6ad7ac14f54e8019",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(50L, 0L),
          @moonclip.Point64::new(4L, -16L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_other_m10_miter_square",
      "590aff884ad2f6b9e554ff8635336935307bbd61281219bf97cbff2aa9dce199",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(50L, 0L),
          @moonclip.Point64::new(4L, -16L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=10.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_other_m4_miter_butt",
      "f00f7c0770d877926db6a9e5c891a60b93f9adaf534055715aed69c11228c70f",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(50L, 0L),
          @moonclip.Point64::new(4L, -16L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_other_m4_miter_round",
      "f35f0828f7d522626121968eb143f5034e6735748bc624e3d9b1637d4b544d13",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(50L, 0L),
          @moonclip.Point64::new(4L, -16L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_miter_acute_other_m4_miter_square",
      "6c29bbc0a09fafcad1c14d89e62a1f17ee2891b6381c6f112d844be2dff56895",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(50L, 0L),
          @moonclip.Point64::new(4L, -16L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=4.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_bevel_butt",
      "838e7698667f38dddcc0f1ccf7611bcf472209db7a9e83594a16f71b2f4fe5bf",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_bevel_round",
      "7f8057cff0d672dbfc35c1b2ad3baebad8e63c4801a09c9973d5d874d3838600",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_bevel_square",
      "eb25b3a5a4965c3025b04fd200c3e8b8b49abab4aa7ef9e0272d04217b8503d4",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_miter_butt",
      "afcb90029e63192a93f3c887aa09db5f7765a24c97591e515cf999d4591f770a",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_miter_round",
      "fd11766b62a2c1eb286bb225562d5e13d548f61fba858af1f24af6f6d7f8b30c",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_miter_square",
      "4442325eca64a26fe32cb833b3fe953b99aa1c41330ea36fa23322d3e8356e8f",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_round_butt",
      "14236118bf562fef8eabad4c9368cfe0a7b881af5166040ebb678680a7e7ba6a",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_round_round",
      "fb6a0bc3cbe9c2c9613910fcfa1056a8438d110d9b5dd040c07da4db54cc13e0",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_round_square",
      "0b78b21d794b6966de507f68b61338c44e0cfe33fccb92cdeb4cba6f936ab3db",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_square_butt",
      "0debb4bbfa45844d4d834c9593bd39c9264cbe80d01325e2a98af1af52942ee1",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_square_round",
      "a290ae49d7adeceb7af89b181d364dabc38023f42cc910f0104594a1cd1b2a54",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w10_square_square",
      "70d5661ca753a1da8fff6614e9376008c88eabe6c37dda19810d1edb98ce6836",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_bevel_butt",
      "d43a56dcd90ae67c309d53018ead0e4ed2f80472bed6488179ca01e038edeef9",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_bevel_round",
      "0c397d33d37134bf0bb2ff82f54fa1653080cbe42da1654f3f95c9c00c89586d",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_bevel_square",
      "05cb10e27f32f496221b570a29eb842188eec52b1b61e0eaca403fc6ccee95fd",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_miter_butt",
      "cfe698b05ea7619b6f7fedf743d3d8551dc29281c705ed9924ba4577135a870c",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_miter_round",
      "7a3fe7c46282efe328eb5a5872b1c21cb2045904dc6991315f05c8ab4f35820c",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_miter_square",
      "d71226f87a9f0d404782c275c14fe931d1a89069f12a2bce321ac44d2bf3ed66",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_round_butt",
      "d79453e13c54b19ed030617c628666331c686fec422b5a730979cabfd6f6cf01",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_round_round",
      "dd76a8ecb6e7e4d370999c2c9b9eb4374bd41f0157192cfe4b878b26b3fb8c4c",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_round_square",
      "6112c3398d3f87326ddcb81248763bc5761cbc56ddffff17b1b044647381727e",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_square_butt",
      "66873c46f5363e87b79e450b0f55ced72ff2cc818ac5e583ca623a9fb1fb8213",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_square_round",
      "9c8885bf41ad92312b0def839fcc98147e54694c4da3957c5b830fa5a35115ee",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_reversal_w4_square_square",
      "7544c792c68804f4c49a9e7bb5268f7b1a14ec2c96b5185cf1b89c9a4ed443f5",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(0L, 0L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_bevel_butt",
      "4a511e2ff81be4e5e6e3cc2ab4e01c3f4d28d6a12267138091e13fc4a4cf04ae",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_bevel_round",
      "3db99e63ea0914e68919f64812242e7d37e4a7f98f959b22b0a7a9945365e757",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_bevel_square",
      "4224227fee9b6e19c91cd9d690bbd54e0fbf3f70ad8a3140a343a8500f7621fb",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_miter_butt",
      "28b986a047a7e2e994d2f8b4dbd3765e32e2ce4a8889deeef2ba733599582aba",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_miter_round",
      "7c2608fe6cf6ac0c57d8fd282de7a7a1e6c266e5b113ee94ff3bb2d7b5e9c510",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_miter_square",
      "2a0e787d56de50aaa97d75555276b5c2e3f29643951070ce62dd976e8d40bc6f",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_round_butt",
      "4478df3189a98c29b90da360d5e12620eece9ea122651c8e11984dcc4df49f2d",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_round_round",
      "41778abd1cda51d6ba4d9a2deabd598add27c90f31d24dd15b2222153396b1f0",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_round_square",
      "64557ee8b1ee2316acf8bce83ae7d90cada63430d1937f7794fa6a0cdc38dc48",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_square_butt",
      "5dc8570190b70da1947ac3d8cea472a54d08b58b7607416a84799e9054e09164",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_square_round",
      "001009f713d4772a65056bf9078834082ab2667c790f94aef542b636e706e7c1",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w10_square_square",
      "40211f9aad7ac22a3bbb7a562c79fde26fcd37aed24cd18891411660cea8499d",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_bevel_butt",
      "2b75b499e20b9d80cfd22da127f52fe4664c8743da3802b968cf29535bd5771e",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_bevel_round",
      "e7ecc301a27f3cec732937f5e469ec30dfa78ffb9e9154bb9673cc49eb7aed90",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_bevel_square",
      "5843556f4638dac2eaf006c4ccd32efb74d8cc09d54ab05750b545cc2d5caf21",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_miter_butt",
      "f74d37b4e2eaebf3b9343499fa53d0058812641c378c5db2f8f2a49176941828",
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
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_miter_round",
      "3e50bda7f43685a3a70ced341661c92e27c42aee830d1d8082679ce5df75f2f4",
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
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_miter_square",
      "fc4e2f52ad4eb605f73eb7fce2fdc1847110eb4d6ceded677d652ee83dac2c87",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_round_butt",
      "ab06ea5e15665e9a4d799e938f711bb881130cf150a772a978e34118792a76a5",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_round_round",
      "eb11be5fa6d7129429b19aab6ac3288f1e0c40ecdc0a53052ce0371f6524d1e5",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_round_square",
      "0257a4d86de4a859cd28a65add10b41f70405012070281c4c278b8309543ede7",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_square_butt",
      "4a820714f58514ceb3e1de63bbddf22e625e2941d4525d96499a87cea4c97631",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_square_round",
      "298a333b9136c50e88aeccaa7a9430dc0f059cfc70ed13b3f90151b8d851fead",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_right_angle_w4_square_square",
      "55e3d2b86afe45f77f44db7f3775c19fae1e5d9147744e306cf5598077aa1b06",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(0L, 0L),
          @moonclip.Point64::new(20L, 0L),
          @moonclip.Point64::new(20L, 20L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_bevel_butt",
      "f7a6bec7c252e2bc14210bc4bbf07a4d32a6d131dba5345a03465c5df7d0352e",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_bevel_round",
      "27e8d124b47c029ddba44b46125898e1e964833131433f8457f8ab6799f4ce98",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_bevel_square",
      "7634d6e5014c514e1afd7d06f824635f9fffbe85f9e20722d06b097b28d65e24",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_miter_butt",
      "c62a449cd3981ad8b1b77fc9178c2805f901b181f0a897bc4b5b0c74642497ff",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_miter_round",
      "a3db731b405d9e54c53286c9a2470c18c5cbbdd7c26d79d4c54859f8d619596c",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_miter_square",
      "b819bc6e0adb972cc98747395be6e7232aae41a4e00145b642d6a0912647e8a8",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_round_butt",
      "07a3531e95c9fc3fd75d792f1dcba5cea5e0b34bdded7b01dc6f7e7d6b351862",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_round_round",
      "bf79d4e08753af2d402cad50108223df1c0557914064b2c2030f190f7a0b5fcc",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_round_square",
      "0b13b539b1e98542b5bf86de2b4b78a6388fc4e04179ab7af9c6b38aba65e264",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_square_butt",
      "c34fc35dd289fdd8352eccf52422ca7a7cf246bbfb149480058ec3f96f7f2276",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_square_round",
      "593d226f16323f53cbcd3b390a7aee4f6f9b410048b5a6bdfa6652af171079a0",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w10_square_square",
      "492e6335752f111414b1bfe435c320bf1741b1cb0eb52c05279ccaf52c23d32a",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_bevel_butt",
      "0b70d749d7025e34bfda4769d37eb0601e0e5c9f43d4392df7a0487a8c119590",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_bevel_round",
      "9924d888cab00692c98b7419c476fbb7be8e4eb54d5f74321091089e920f10b7",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_bevel_square",
      "be8acc8bd1897c7edb805ae053b29ae3e4d36ccf173a742c80effc75934e482a",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_miter_butt",
      "26faf006c8cf4e7b36d2ec36307187d5a3cb6c7d9071a689a1c6f5e65adcfa7e",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_miter_round",
      "fe58978045405dc6964f625b40562fe565e313d4553b2dda841cd30cac423245",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_miter_square",
      "5191e8f4db37ccc56246d5d62da035c4769be96940f73ed194aedb2641374339",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_round_butt",
      "39ae77cff7de53c398ee01750fb0f5fca15c83a2d13c1d8d5059de359c211cba",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_round_round",
      "e0a90a372bfb7a6f2df206b2e8407bc07c00c596de8f1f3d803be9c7de3478e2",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_round_square",
      "c1c5730baa646219e7bacb4432738cfe1e341c4adbf7c60712d689889931f6d2",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_square_butt",
      "694550967499b053bf77ec6ac69b6530b25504978809d978dcba05648d4cc711",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_square_round",
      "b90d7cd986323cc2796d135b1a196c1b3e375dce4ce36197aa596f20ebad6c78",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_self_crossing_w4_square_square",
      "4c472db5cf7a2e57479c5cc7bb9a3b1fa9e7f1f2c6156b9ac5a9d4bda8c2c4ff",
      @moonclip.stroke_polyline(
        [
          @moonclip.Point64::new(-20L, -20L),
          @moonclip.Point64::new(20L, 20L),
          @moonclip.Point64::new(-20L, 20L),
          @moonclip.Point64::new(20L, -20L),
        ],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_bevel_butt",
      "3b4bfe62826a9b8d0583839872d99e2a091256f6a45f76850dbcdfb3b573ac9f",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_bevel_round",
      "6ed0bdba5d01369d2d2a501fda744b98f1a06244491eed5ee652b1f859cdaaba",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_bevel_square",
      "48cc60d01fbc8f237d1f12ef0cd824830a98c32475ce857239835f41d5e4c60d",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_miter_butt",
      "5171958bd7789e1224866ae4f95fe545f65c67a6d9f5d6133884d43152408659",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_miter_round",
      "9d2192730f9b3c14fa67d71a7ff7e0a7f91503f26611bf9606667f79d35b4653",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_miter_square",
      "3e715335106feb76934406a3ae5350dd2ef0c9db5322fb644f1979150ee8a5c8",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_round_butt",
      "1d4886a3576618db2b51fb0361267b99676c47fb62178c6d48a10381ece30f73",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_round_round",
      "c208c3f6da971ee733703b2bcb7cfbd3e2f7d585ab50d6d45b302b8e127dddd0",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_round_square",
      "10ec3bf697c95d1799c2a8b666576dc6e3fd9067ead5aa8fec0db1f6f8dd465d",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_square_butt",
      "98a6d6ff67c75e016f5f50b43b4eab26c9f82553246eda6d346b5e7165bbd7e3",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_square_round",
      "0d634f0b3abb3e25e3521b49a33b9ba4c0cbcb57d5c17944bb973dd435ccd4e3",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w101_square_square",
      "80e75cb83d90a672010f7ef576251b7917f5e9080b24a5b9f221fb26f74cbde4",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.01,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_bevel_butt",
      "42d26b53909878b783c95d76941a80b3257e13ee067c70e8122046007e07e839",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_bevel_round",
      "29aa35190e26b6bcbbd6c375f06d515fba2cf3f1ecceff37e902bb2880f513b4",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_bevel_square",
      "6e632bdb1cdb7c23d2a95e046c606b1ce20190b126521255ff853a4ebe503251",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_miter_butt",
      "ed828079380c1340ad4f0a1932d9b2e3b7b05955fd42cd84ea2af581a3d724d0",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_miter_round",
      "2e13ff1c460f2679020c2323053c245ada19fc823d7e018ab6b6f7c0c57e7bf9",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_miter_square",
      "ffdc4d82c48c77d2af8c07169951a4a78cb0789a6cec837805b1e825bf4a9f05",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_round_butt",
      "854866ba7634163c11f6eb808a68ce1fb294b5df79903e325a2315907ae2c7a0",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_round_round",
      "574f144b34bbbd32d2a6fdce82ca26246da6dfb088e110618b34210b65306ab5",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_round_square",
      "54f86d90a4e9eca4dba5b9aad09c288f310c2ec6ff50cb0291d6f58b15f9687c",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_square_butt",
      "2b0b5d1e418c2b3997546eee1b7b910d77e49f93485953eff3846ca686456897",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_square_round",
      "4fe7b4ed36ee1ffcffcfe9014448b4965bbb065401b4e3382d8bde00dd9977bb",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w199_square_square",
      "7c2d235765d5b1e286198b4c69c5c5b5eaf43e14e81257112c6ea46e95c9ae5d",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.99,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_bevel_butt",
      "f5fe6d9209d5f0383b9e2f08e6d0a56db11ef8dfeff3a513e5577934e6704563",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_bevel_round",
      "2e23e2ceb174bd7566670e5f8f5474ba81b128969b0a6e05b668d543f0c9b835",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_bevel_square",
      "a1d60c40562d91902d93f3d86c173825ef442682b669a916440156846b9b83e7",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_miter_butt",
      "696d4de69f453f24528d59f923caf0836d593f261397843d17d934e04a8bf2b8",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_miter_round",
      "09c469ec47834c21ad0c30c3c1522d59980a43c1765b9bcb6b5ef230c83ab615",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_miter_square",
      "e649ff2bfd1e3a7bc7def9d486d4674276eed0c278ab221d1128e90c39706722",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_round_butt",
      "7c70a1b299351d6d868c18400cb6c9e4f62ba7297be44568679f0bee38d51912",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_round_round",
      "24e0ada71b96ba4ba232c50aff27e648c7a4769edb8ece68889f486da5a866a4",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_round_square",
      "d87f563c71da10245866e9b1708c47d737b7664164f1595f78db3224b5e95ee8",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_square_butt",
      "58077f8de3651571421b6edf0ecb793bb81a0e649a2d2e7ae962bb20716a9efc",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_square_round",
      "177680c9f749510b3ba86d3da0b1b877c7cac1bfe3688de7970f62c6cfbae7d5",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w1_square_square",
      "d052f6db47d3331eced7b73f653673834079641fcce6e1bd93c31cee989b5b34",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        1.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_bevel_butt",
      "5f922a6b1efc0f82a1dfd8717c749652880ef8af47eb9291945e94adc528f7af",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_bevel_round",
      "2b9bd907d4d1cc74871dea82af1e5503afb26c28e814bb147262a673f7f166d4",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_bevel_square",
      "71fb907248ee716ae1807a095f4e26408973b319401b95ddcea489a9a7c37aa5",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_miter_butt",
      "9ca9b5d3abf41c27f0bf8ae15cac7f6dc3a2e0ed2e8b1a19b34260e1f03acbdf",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_miter_round",
      "eebcf4fa3effda4796c151efe1641d7abfbab2c071ebf50c1983fdf317fd9302",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_miter_square",
      "a7c85dacd37edad1d569c87d148ee8f1d58fbbd66e6698a562685645c8f9dd13",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_round_butt",
      "d20b1bc9b939428921c49de0dbd0ebf136dc8931acfb38f44b22c624e7fc89bf",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_round_round",
      "6e122f8c7a12d2a8dd462ec1dc119e0b3aad6d6435ed18244fb155ea4c5baf43",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_round_square",
      "9fa14c51bb27da5d27194305ec7f3de5204f0a17cf92c8b0ded2a8e9b8643abf",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_square_butt",
      "6c3ed167288fa687587b66fce148c35c55729a98a0b08ea4b13ae4bfdbb6c1fc",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_square_round",
      "c2503c60b1e78e9fb8d82f54476585650eec532a6c05705115ac8d322e31e19b",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w2_square_square",
      "e286199f60f44407d3f37e81689773748b11432db25ddbfda01c6ae982d7d971",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        2.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_bevel_butt",
      "b5520d7cf638c742d49eff0b718f2f580de9d79f98eb68332c9be3851ac9612c",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_bevel_round",
      "d6dce4d653802d38e27ec247e8d237397fbaf4915e1a19264a32e44b8e209f0c",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_bevel_square",
      "30e7574b7ddf0501a03c6370900f7fcdc79148aa0ca2b40f469177ce29f6e58d",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_miter_butt",
      "d1e8a36081bf524fe062fcb28e21d972384eafd33a7980bb0a29fab7f9a65055",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_miter_round",
      "3efd7fe728b8a1bd9db82c33a6c9b6993666fd03ca382bd2e876fb27a0ea1271",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_miter_square",
      "f1bbfcc8d2ecac1e07bf4fe26a1131d6f2a662976ff2d35e2992da8c30cec92f",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_round_butt",
      "d0f533bffc1955b9665100bb47ffbf7f05b0ef757a22e92c109ba220c7535203",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_round_round",
      "fbde5182579de7fc57351c8a31be12475321b03167b879d3678531f97363507d",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_round_square",
      "ad2b44b0b40a065246a7b9305a8ece759a25f9a5209c51349de4557fb84df369",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_square_butt",
      "585ec54914f97cc6bb5f405dfae7487847f46de0d616e9bd4e3da60f3e232aa9",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_square_round",
      "9a5b8c75874ee8387c45164d3e39c34aa85f3777d01ac5e477e18bd3b1503b50",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_threshold_w3_square_square",
      "34cc0b659b12ef4d588a6cbd8cb05ff0b7e9d0f9914a3e4233c906c31810294b",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(20L, 0L)],
        3.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_bevel_butt",
      "28fe8a537b8c16fe08a01ed4a9d079f378078b426ab1201a9cb43468bd549bb7",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_bevel_round",
      "f712e8530681dbe760eada76bcedfd61430f3e25744f3e9391029942101e6ec3",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_bevel_square",
      "70e627f384dfdc75b17cc7da849f9b62172e14b74360e8d5f1a44d1b76d8a419",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_miter_butt",
      "b3f361d3fccc57e8850ea085db8a346e89ac8bb2cb0a0279a01598896cf7b999",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_miter_round",
      "b75ecf6ddc0e7385795a444e3e28d717d08496c713f94b2ed89305de87c691c7",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_miter_square",
      "cafd28f3c73e10dcbc795571f0cb272b078f830b4c8b527a32d41807a7ba6934",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_round_butt",
      "d582ccec11b991be3add9fc75be8dcc0d327a141702b48e54e63cea14baa7215",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_round_round",
      "52a251c99221f32d989a6f47e04f423c91de5b0c9a4f1ed1980d763603ee6539",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_round_square",
      "05f51d09215c8f63d48d5ad26f159d319e60dd5130d7f23c7d2957408e4a20bb",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_square_butt",
      "4bccf1b1774d0b6bc69804131176b4c1478063db9a6437357d6858530becd04c",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_square_round",
      "83d72be5f183a4154b5bdb186cacc1e46cf83ac70b451a04e1afecaabc3f3888",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w10_square_square",
      "fff603c89edf996829a3b3faae313f3d4576cafd297edffbdd899e5682af2180",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        10.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_bevel_butt",
      "b95c3b6f3eb58ecafc20fa492da25736766dd777fb9cdf80c16320bba67a8379",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_bevel_round",
      "6f399ad23762f998df1da449b50b391c8118731f86e4434cf50df9a589a3fd03",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_bevel_square",
      "942c0de58512228c0d6bc81a542d2c9060fd9a82fa106947836bd7747ce68ca3",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Bevel,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_miter_butt",
      "780c80e04627d629a3b14ec1289e890a18555a7dd35762f66a740d07d5919679",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_miter_round",
      "5d005d5271179878276b86f31009a5edb47de77f66117d6bf0d826b77a091a28",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_miter_square",
      "6876e57ca34c0bdfbffa4843e04e684d86305e694b388eba3a18f423f8320de7",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Miter,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_round_butt",
      "4c4fbbc1201175e3031bf19e17b51e6c8896e7621b3068dc4f981250705cc3a3",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_round_round",
      "e47a9fb65d13308d00f661414d342215dfd718f92d5a7b1f2899b5e899819f1b",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_round_square",
      "e0d018d0b6ac0ae29dbbad451e3236e93de8025ce2376bef721786ec9b5e6502",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Round,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_square_butt",
      "19cbfe1ece6a3d43b3252d7c6dee5ef520ad94cc8feba7081aab70402d459bc0",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Butt,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_square_round",
      "a77d6a52f7d9f6ec4288d2ecd26818bd39f5ee2a4f020f7c45b7a28de19c6261",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Round,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
    actual_offset_case(
      "stroke_vertical_w4_square_square",
      "59ff561e20281e3cf889f5602c68bb8624aeab5313ea44f049c861ddf2154e84",
      @moonclip.stroke_polyline(
        [@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 20L)],
        4.0,
        cap=@moonclip.CapType::Square,
        options=@moonclip.OffsetOptions::new(
          join=@moonclip.JoinType::Square,
          miter_limit=2.0,
          arc_tolerance=0.0,
        ),
      ),
    ),
  ]
}
