// Generated inputs and hashes only; NO expected output linked.

///|
fn run_rectclip_cases() -> Array[Json] {
  [
    actual_offset_case(
      "rectclip_collinear",
      "bfb2d366ae23230de277b8294fa491033ce16f36a4fb03d7b6e1339295b72888",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(1L, 5L),
            @moonclip.Point64::new(3L, 5L),
            @moonclip.Point64::new(6L, 5L),
            @moonclip.Point64::new(9L, 5L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_corner_exit",
      "5d2b19b759021faab6ffd97286f5e196cf14d7be39aa8ffc6d2ff1e0cd595b08",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(15L, 15L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_corners",
      "3810f3af01f0ba36f72d1b000b8b574dfc92d4724dcfa754ca09c2db15e55057",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(10L, 0L),
            @moonclip.Point64::new(10L, 10L),
            @moonclip.Point64::new(0L, 10L),
            @moonclip.Point64::new(0L, 0L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_diagonal",
      "c1ecdc17987d4c8607945b2218a3b24cb6dbfd7f6f85e5b37bd7cce1713238f5",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [[@moonclip.Point64::new(-5L, -5L), @moonclip.Point64::new(15L, 15L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_edge_transition",
      "356caf6cc0672a0cfb604a26fd5ea65fd17f946956acca279330b09389c54f4d",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(0L, 5L),
            @moonclip.Point64::new(0L, 8L),
            @moonclip.Point64::new(5L, 8L),
            @moonclip.Point64::new(10L, 8L),
            @moonclip.Point64::new(10L, 5L),
            @moonclip.Point64::new(15L, 5L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_empty",
      "a6238e37b0a89e277f9bfe15c569db20a468d2ae0a05a73395e3c359e0446980",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [],
      ),
    ),
    actual_offset_case(
      "rectclip_endpoint",
      "d496bf64637f07fcdd71cf06ae15e71a0eed8840f22865d9bda80d073f54927c",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [@moonclip.Point64::new(-10L, 5L), @moonclip.Point64::new(0L, 5L)],
          [@moonclip.Point64::new(10L, 5L), @moonclip.Point64::new(20L, 5L)],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_explicit_closed",
      "cc78773b5b0f94b7e5d780800492f28dfcb782d17697a7e17cefb6194ec5cba2",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(2L, 2L),
            @moonclip.Point64::new(8L, 2L),
            @moonclip.Point64::new(8L, 8L),
            @moonclip.Point64::new(2L, 2L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_half_negative",
      "636bb2e0227e4af1bcdfcf35ae6372edcaf1a0d2a94d78c4132def7f3339f87a",
      @moonclip.rect_clip_lines(
        { min_x: -10L, min_y: -10L, max_x: 0L, max_y: 0L, },
        [[@moonclip.Point64::new(-12L, -6L), @moonclip.Point64::new(2L, 1L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_half_positive",
      "dc973f14008b00d1d45dfb2372981357ea52dc982455f46454b3be33c3f54e88",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-2L, 0L),
            @moonclip.Point64::new(2L, 1L),
            @moonclip.Point64::new(12L, 6L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_horizontal",
      "e14231036e650efe69a3b1e32e340ec3c2b5cb526679915c6d5014f223165a9b",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-10L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(20L, 5L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_identical",
      "784ff44c92dbbc650dba49afb00cdba7b1a76d74eb99883941f21879cae8ac35",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_inside",
      "50da0fc94a9465af21071acbcba6a7ed7cab2eab082d48faf9eb2ff88f0a80c5",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(1L, 1L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(9L, 2L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_inside_edge",
      "7bda542de2fb447d020704ccf95fd3205290fc0e0b3b088d241ad78e39c0a952",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(9L, 0L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_large",
      "168ccc297c84bdcc00b689dc3de97e6cc659e137c170ab0caf25409ba75c6793",
      @moonclip.rect_clip_lines(
        {
          min_x: -999999999L,
          min_y: -999999999L,
          max_x: 999999999L,
          max_y: 999999999L,
        },
        [
          [
            @moonclip.Point64::new(-1000000000L, -999999999L),
            @moonclip.Point64::new(1000000000L, 999999998L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_left_edge",
      "0037997713de218ff8949b6c601bacd5dbc7dc9eee6267088da81f580f532d83",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(0L, 1L),
            @moonclip.Point64::new(0L, 5L),
            @moonclip.Point64::new(0L, 9L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_max_y_edge",
      "e33474806e49ff1e66c8dc774916b417e74c37cbaf08ce8f3656eea46fbbe916",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [[@moonclip.Point64::new(9L, 10L), @moonclip.Point64::new(1L, 10L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_min_y_edge",
      "acaba60d128e8008a98c8f6e2ff80e977f6e6aae84ecd1d24fba81d88597a656",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [[@moonclip.Point64::new(1L, 0L), @moonclip.Point64::new(9L, 0L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_multipath",
      "4091e8ef13f56279103e03e0e3a0538aa46f82eda9e26dfc61bab3d89d09abc9",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [@moonclip.Point64::new(-5L, 3L), @moonclip.Point64::new(15L, 3L)],
          [@moonclip.Point64::new(15L, 7L), @moonclip.Point64::new(-5L, 7L)],
          [],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_near_endpoint",
      "d3976e1cde3eed0a4f6bb9a55748f4adffd5b4529f8c26c5841470b44af33738",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-1L, 0L),
            @moonclip.Point64::new(999999999L, 1L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_negative",
      "c0939cdde43765e069e3f50b38aa8812d7f156a1f3f2f0f074e4af2e617f04a4",
      @moonclip.rect_clip_lines(
        { min_x: -10L, min_y: -10L, max_x: 0L, max_y: 0L, },
        [[@moonclip.Point64::new(-20L, -7L), @moonclip.Point64::new(5L, -3L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_outside",
      "59c910b4365b01a10f27354a0e01f9a268227b04ffee0059de5f6f294142e743",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [[@moonclip.Point64::new(-5L, -3L), @moonclip.Point64::new(-1L, 20L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_outside_edge",
      "d8b33f30b09d90037185e7672ac865991e019eab93e0d775654800ed3e1a2d8e",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-5L, 0L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, 0L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_reentry",
      "f88803be220c81c3a5f834525c3b3d50119127523de7337c15c02d12c0409ae0",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-5L, 2L),
            @moonclip.Point64::new(5L, 2L),
            @moonclip.Point64::new(15L, 2L),
            @moonclip.Point64::new(15L, 8L),
            @moonclip.Point64::new(5L, 8L),
            @moonclip.Point64::new(-5L, 8L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_repeats",
      "ef16698314729e80c8119eaa66ae91e8c2ef4c0b2bd1efebc12d93f2fe227f25",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(15L, 5L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_retrace",
      "e0e856f48c049caddf7469fd8c6d9820e4b45e92ea9ad8a52359e7a11955b292",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(5L, 5L),
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(5L, 5L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_right_edge",
      "ec740fb4c16d47c7a5953d64516a0cedd5267430a2df00349ce8e8a2a96d2df4",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [[@moonclip.Point64::new(10L, 9L), @moonclip.Point64::new(10L, 1L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_single",
      "bdc80f781e0aa6aac259826c4672372fa8c7882f06b6119cd88b2fa33ee15449",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [[@moonclip.Point64::new(5L, 5L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_tangent",
      "2997a9ebdda7ba531d61214c296c87feff720f010b025fe535ba52847a1f734b",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [
          [
            @moonclip.Point64::new(-5L, 5L),
            @moonclip.Point64::new(0L, 0L),
            @moonclip.Point64::new(5L, -5L),
          ],
        ],
      ),
    ),
    actual_offset_case(
      "rectclip_vertical",
      "fbe2cf3e93afd5cecf2109c5e5062479a09ac09f80fbc4f58f3fa69f40849aaf",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 10L, },
        [[@moonclip.Point64::new(5L, -5L), @moonclip.Point64::new(5L, 15L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_zero_height",
      "3b0816c078eb2c2424529729ebfd410fd20b489e9dcbf17f89c2efeb3c098bc0",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 10L, max_y: 0L, },
        [[@moonclip.Point64::new(5L, -5L), @moonclip.Point64::new(5L, 15L)]],
      ),
    ),
    actual_offset_case(
      "rectclip_zero_width",
      "bf7b01f3d7ed47504ab7dfa986b4a7b03db2516ea7380d397c33d941961c1ad2",
      @moonclip.rect_clip_lines(
        { min_x: 0L, min_y: 0L, max_x: 0L, max_y: 10L, },
        [[@moonclip.Point64::new(-5L, 5L), @moonclip.Point64::new(15L, 5L)]],
      ),
    ),
  ]
}
