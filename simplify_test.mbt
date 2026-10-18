// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn sm_path(points : Array[(Int, Int)]) -> @moonclip.Path64 {
  points.map(fn(p) { @moonclip.Point64::new(p.0.to_int64(), p.1.to_int64()) })
}

///|
fn sm_run(
  paths : @moonclip.Paths64,
  epsilon? : Double = 0.0,
  mode? : @moonclip.PathMode = @moonclip.Closed,
) -> @moonclip.SimplifyResult {
  @moonclip.simplify_paths(
    paths,
    options=@moonclip.SimplifyOptions::new(epsilon~, mode~),
  ).unwrap()
}

///|
fn sm_report(
  value : @moonclip.SimplifyResult,
  paths : @moonclip.Paths64,
  counts : Array[Int],
  before : Array[Int],
  after : Array[Int],
  collapsed : Array[Int],
) -> Unit raise {
  assert_eq(value.paths(), paths)
  assert_eq(value.removed_per_path(), counts)
  let mut sum = 0
  for n in counts {
    sum += n
  }
  assert_eq(value.removed_vertices(), sum)
  assert_eq(value.input_degenerate_indices(), before)
  assert_eq(value.degenerate_indices(), after)
  assert_eq(value.collapsed_indices(), collapsed)
}

///|
test "simplify API default" {
  let v : @moonclip.SimplifyOptions = Default::default()
  assert_eq(v.epsilon, 0.0)
  assert_eq(v.mode, @moonclip.Closed)
  assert_eq(v, @moonclip.SimplifyOptions::new())
}

///|
test "simplify API explicit options" {
  let v = @moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open)
  assert_eq(v.epsilon, 0.5)
  assert_eq(v.mode, @moonclip.Open)
}

///|
test "simplify API negative epsilon" {
  assert_true(
    @moonclip.simplify_paths(
      [],
      options=@moonclip.SimplifyOptions::new(epsilon=-1.0),
    )
    is Err(
      @moonclip.InvalidInput({ stage: @moonclip.SimplifyParameters, .. }, _)
    ),
  )
}

///|
test "simplify API nonfinite epsilon" {
  for e in [@double.infinity, -@double.infinity, @double.not_a_number] {
    assert_true(
      @moonclip.simplify_paths(
        [],
        options=@moonclip.SimplifyOptions::new(epsilon=e),
      )
      is Err(@moonclip.InvalidInput(_, _)),
    )
  }
}

///|
test "simplify API negative zero" {
  let v = @moonclip.SimplifyOptions::new(epsilon=-0.0)
  assert_true(1.0 / v.epsilon > 0.0)
  assert_eq(sm_run([], epsilon=-0.0).removed_vertices(), 0)
}

///|
test "simplify API zero preserves collinear" {
  let p = sm_path([(0, 0), (1, 0), (2, 0), (3, 0)])
  sm_report(sm_run([p]), [p], [0], [0], [0], [])
}

///|
test "simplify API zero closed cleanup" {
  let p = sm_path([(0, 0), (0, 0), (10, 0), (0, 10), (0, 0), (0, 0)])
  sm_report(sm_run([p]), [sm_path([(0, 0), (10, 0), (0, 10)])], [3], [], [], [])
}

///|
test "simplify API zero open return" {
  let p = sm_path([(0, 0), (0, 0), (10, 0), (0, 0)])
  sm_report(
    sm_run([p], mode=@moonclip.Open),
    [sm_path([(0, 0), (10, 0), (0, 0)])],
    [1],
    [],
    [],
    [],
  )
}

///|
test "simplify API raw quota before dedup" {
  let p = sm_path([(0, 0), (0, 0), (0, 0)])
  assert_true(
    @moonclip.simplify_paths([p], limits={
      max_input_paths: 1,
      max_input_vertices: 2,
    })
    is Err(
      @moonclip.ResourceLimitExceeded(
        { path_index: Some(0), vertex_index: Some(2), .. },
        @moonclip.InputVertices,
        2
      )
    ),
  )
  assert_eq(p.length(), 3)
}

///|
test "simplify API empty paths consume quota" {
  assert_true(
    @moonclip.simplify_paths([[], []], limits={
      max_input_paths: 1,
      max_input_vertices: 0,
    })
    is Err(@moonclip.ResourceLimitExceeded(_, @moonclip.InputPaths, 1)),
  )
}

///|
test "simplify API negative and zero limits" {
  assert_true(
    @moonclip.simplify_paths([], limits={
      max_input_paths: -1,
      max_input_vertices: 0,
    })
    is Err(@moonclip.InvalidInput(_, _)),
  )
  assert_eq(
    @moonclip.simplify_paths([], limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    })
    .unwrap()
    .paths(),
    [],
  )
}

///|
test "simplify API coordinate precheck" {
  let p = [@moonclip.Point64::new(-9223372036854775808L, 0L)]
  assert_true(
    @moonclip.simplify_paths([p])
    is Err(
      @moonclip.CoordinateOutOfRange(
        { path_index: Some(0), vertex_index: Some(0), .. },
        @moonclip.X,
        -9223372036854775808L
      )
    ),
  )
}

///|
test "simplify algorithm distance below" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(2L, 1L),
      @moonclip.Point64::new(4L, 0L),
      @moonclip.Point64::new(6L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=1.1, mode=@moonclip.Open),
    [[@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(6L, 0L)]],
    [2],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm distance equal" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(2L, 1L),
      @moonclip.Point64::new(4L, 0L),
      @moonclip.Point64::new(6L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=1.0, mode=@moonclip.Open),
    [[@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(6L, 0L)]],
    [2],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm distance above" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(2L, 1L),
      @moonclip.Point64::new(4L, 0L),
      @moonclip.Point64::new(6L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=0.9, mode=@moonclip.Open),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(2L, 1L),
        @moonclip.Point64::new(6L, 0L),
      ],
    ],
    [1],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm equal adjacent tie" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(1L, 1L),
      @moonclip.Point64::new(2L, 0L),
      @moonclip.Point64::new(3L, 1L),
      @moonclip.Point64::new(4L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=1.0, mode=@moonclip.Open),
    [[@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(4L, 0L)]],
    [3],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm neighbor distance recomputed" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(1L, 0L),
      @moonclip.Point64::new(2L, 1L),
      @moonclip.Point64::new(3L, 0L),
      @moonclip.Point64::new(4L, 0L),
      @moonclip.Point64::new(5L, 3L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=1.0, mode=@moonclip.Open),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(4L, 0L),
        @moonclip.Point64::new(5L, 3L),
      ],
    ],
    [3],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm short empty" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [[]]
  sm_report(
    sm_run(input, epsilon=3.0, mode=@moonclip.Closed),
    [[]],
    [0],
    [0],
    [0],
    [],
  )
}

///|
test "simplify algorithm short singleton" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [[@moonclip.Point64::new(1L, 2L)]]
  sm_report(
    sm_run(input, epsilon=3.0, mode=@moonclip.Open),
    [[@moonclip.Point64::new(1L, 2L)]],
    [0],
    [0],
    [0],
    [],
  )
}

///|
test "simplify algorithm short two" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [[@moonclip.Point64::new(1L, 2L), @moonclip.Point64::new(4L, 5L)]]
  sm_report(
    sm_run(input, epsilon=3.0, mode=@moonclip.Closed),
    [[@moonclip.Point64::new(1L, 2L), @moonclip.Point64::new(4L, 5L)]],
    [0],
    [0],
    [0],
    [],
  )
}

///|
test "simplify algorithm short triangle" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(0L, 10L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=100.0, mode=@moonclip.Closed),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(10L, 0L),
        @moonclip.Point64::new(0L, 10L),
      ],
    ],
    [0],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm endpoints protected" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(1L, 0L),
      @moonclip.Point64::new(2L, 0L),
      @moonclip.Point64::new(3L, 0L),
      @moonclip.Point64::new(4L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=100.0, mode=@moonclip.Open),
    [[@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(4L, 0L)]],
    [3],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm closed seam" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(5L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(10L, 10L),
      @moonclip.Point64::new(0L, 10L),
      @moonclip.Point64::new(0L, 5L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=0.25, mode=@moonclip.Closed),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(10L, 0L),
        @moonclip.Point64::new(10L, 10L),
        @moonclip.Point64::new(0L, 10L),
      ],
    ],
    [2],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm consecutive repeats" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(5L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(10L, 10L),
      @moonclip.Point64::new(0L, 10L),
      @moonclip.Point64::new(0L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=0.25, mode=@moonclip.Closed),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(10L, 0L),
        @moonclip.Point64::new(10L, 10L),
        @moonclip.Point64::new(0L, 10L),
      ],
    ],
    [3],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm nonconsecutive repeats" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(5L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(0L, 10L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=0.5, mode=@moonclip.Open),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(10L, 0L),
        @moonclip.Point64::new(0L, 10L),
      ],
    ],
    [2],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm complete retrace" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(5L, 0L),
      @moonclip.Point64::new(10L, 0L),
      @moonclip.Point64::new(0L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=1.0, mode=@moonclip.Open),
    [[@moonclip.Point64::new(0L, 0L), @moonclip.Point64::new(0L, 0L)]],
    [3],
    [],
    [0],
    [0],
  )
}

///|
test "simplify algorithm near collinear" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(1000L, 1L),
      @moonclip.Point64::new(2000L, 0L),
      @moonclip.Point64::new(3000L, 1L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=0.5, mode=@moonclip.Open),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(1000L, 1L),
        @moonclip.Point64::new(2000L, 0L),
        @moonclip.Point64::new(3000L, 1L),
      ],
    ],
    [0],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm acute" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(20L, 0L),
      @moonclip.Point64::new(21L, 10L),
      @moonclip.Point64::new(20L, 1L),
      @moonclip.Point64::new(0L, 10L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=1.0, mode=@moonclip.Closed),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(20L, 0L),
        @moonclip.Point64::new(0L, 10L),
      ],
    ],
    [2],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm narrow notch" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
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
  ]
  sm_report(
    sm_run(input, epsilon=4.0, mode=@moonclip.Closed),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(12L, 0L),
        @moonclip.Point64::new(12L, 12L),
        @moonclip.Point64::new(7L, 12L),
        @moonclip.Point64::new(5L, 2L),
        @moonclip.Point64::new(5L, 12L),
        @moonclip.Point64::new(0L, 12L),
      ],
    ],
    [1],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm narrow channel" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
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
  ]
  sm_report(
    sm_run(input, epsilon=2.0, mode=@moonclip.Closed),
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
    [0],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm bowtie preserved" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 0L),
      @moonclip.Point64::new(10L, 10L),
      @moonclip.Point64::new(0L, 10L),
      @moonclip.Point64::new(10L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=0.5, mode=@moonclip.Closed),
    [
      [
        @moonclip.Point64::new(0L, 0L),
        @moonclip.Point64::new(10L, 10L),
        @moonclip.Point64::new(0L, 10L),
        @moonclip.Point64::new(10L, 0L),
      ],
    ],
    [0],
    [],
    [],
    [],
  )
}

///|
test "simplify algorithm reverse own order" {
  // Expected complete ordered result independently evaluated by locked C++ SimplifyPaths.
  let input = [
    [
      @moonclip.Point64::new(0L, 10L),
      @moonclip.Point64::new(20L, 1L),
      @moonclip.Point64::new(21L, 10L),
      @moonclip.Point64::new(20L, 0L),
      @moonclip.Point64::new(0L, 0L),
    ],
  ]
  sm_report(
    sm_run(input, epsilon=1.0, mode=@moonclip.Closed),
    [
      [
        @moonclip.Point64::new(0L, 10L),
        @moonclip.Point64::new(20L, 1L),
        @moonclip.Point64::new(0L, 0L),
      ],
    ],
    [2],
    [],
    [],
    [],
  )
}

///|
test "simplify report empty collection" {
  sm_report(sm_run([]), [], [], [], [], [])
}

///|
test "simplify report empty paths retained" {
  sm_report(sm_run([[], []]), [[], []], [0, 0], [0, 1], [0, 1], [])
}

///|
test "simplify report singleton" {
  let p = sm_path([(2, 3)])
  sm_report(sm_run([p]), [p], [0], [0], [0], [])
}

///|
test "simplify report two closed" {
  let p = sm_path([(0, 0), (2, 0)])
  sm_report(sm_run([p]), [p], [0], [0], [0], [])
}

///|
test "simplify report collinear not new collapse" {
  let p = sm_path([(0, 0), (1, 0), (2, 0), (3, 0)])
  sm_report(
    sm_run([p], epsilon=1.0),
    [sm_path([(2, 0), (3, 0)])],
    [2],
    [0],
    [0],
    [],
  )
}

///|
test "simplify report zero area self crossing valid" {
  let p = sm_path([(0, 0), (10, 10), (0, 10), (10, 0)])
  sm_report(sm_run([p]), [p], [0], [], [], [])
}

///|
test "simplify report new collapse preserved" {
  let p = cp_rect(0L, 0L, 10L, 10L)
  sm_report(
    sm_run([p], epsilon=100.0),
    [sm_path([(10, 0), (0, 10)])],
    [2],
    [],
    [0],
    [0],
  )
}

///|
test "simplify report mixed original indices" {
  let p = cp_rect(0L, 0L, 10L, 10L)
  sm_report(
    sm_run([[], p, sm_path([(1, 1)]), p], epsilon=100.0),
    [
      [],
      sm_path([(10, 0), (0, 10)]),
      sm_path([(1, 1)]),
      sm_path([(10, 0), (0, 10)]),
    ],
    [0, 2, 0, 2],
    [0, 2],
    [0, 1, 2, 3],
    [1, 3],
  )
}

///|
test "simplify report open return valid" {
  let p = sm_path([(0, 0), (2, 0), (0, 0)])
  sm_report(sm_run([p], mode=@moonclip.Open), [p], [0], [], [], [])
}

///|
test "simplify report open all same" {
  sm_report(
    sm_run([sm_path([(1, 1), (1, 1), (1, 1)])], mode=@moonclip.Open),
    [sm_path([(1, 1)])],
    [2],
    [0],
    [0],
    [],
  )
}

///|
test "simplify report all cleanup counted" {
  let p = sm_path([
    (0, 0),
    (0, 0),
    (5, 0),
    (10, 0),
    (10, 10),
    (0, 10),
    (0, 0),
    (0, 0),
  ])
  sm_report(
    sm_run([p], epsilon=0.5),
    [cp_rect(0L, 0L, 10L, 10L)],
    [4],
    [],
    [],
    [],
  )
}

///|
test "simplify report nonconsecutive zero preserved" {
  let p = sm_path([(0, 0), (10, 0), (0, 0), (0, 10)])
  sm_report(sm_run([p]), [p], [0], [], [], [])
}

///|
test "simplify decimal isolation composition all precisions and quantized zero" {
  for p in [0, 3, 6] {
    let v = @moonclip.simplify_paths_d(
      [[@moonclip.PointD::new(-0.25, 0.25), @moonclip.PointD::new(2.25, 0.25)]],
      precision=dd_precision(p),
    ).unwrap()
    let expected = if p == 0 {
      [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(2.0, 0.0)]
    } else {
      [@moonclip.PointD::new(-0.25, 0.25), @moonclip.PointD::new(2.25, 0.25)]
    }
    assert_eq(v.paths(), [expected])
    assert_eq(v.input_degenerate_indices(), [0])
    assert_eq(v.collapsed_indices(), [])
    assert_eq(v.removed_per_path(), [0])
  }
}

///|
test "simplify decimal isolation composition epsilon physical units" {
  let p = [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(2.0, 0.5),
    @moonclip.PointD::new(4.0, 0.0),
    @moonclip.PointD::new(6.0, 0.0),
  ]
  for digits in [0, 3, 6] {
    let v = @moonclip.simplify_paths_d(
      [p],
      precision=dd_precision(digits),
      options=@moonclip.SimplifyOptions::new(epsilon=0.5, mode=@moonclip.Open),
    ).unwrap()
    if digits == 0 {
      assert_eq(v.paths(), [[p[0], @moonclip.PointD::new(2.0, 1.0), p[3]]])
    } else {
      assert_eq(v.paths(), [[p[0], p[3]]])
    }
  }
}

///|
test "simplify decimal isolation composition strict new merging" {
  let p = [@moonclip.PointD::new(0.0, 0.0), @moonclip.PointD::new(0.0001, 0.0)]
  assert_true(
    @moonclip.simplify_paths_d([p])
    is Err(
      @moonclip.QuantizationFailure(
        { path_index: Some(0), vertex_index: Some(1), .. },
        None,
        Some({ path_index: Some(0), vertex_index: Some(0), .. }),
        _
      )
    ),
  )
}

///|
test "simplify decimal isolation composition strict coordinates" {
  for x in [@double.infinity, @double.not_a_number] {
    assert_true(
      @moonclip.simplify_paths_d([[@moonclip.PointD::new(x, 0.0)]])
      is Err(@moonclip.QuantizationFailure(_, Some(@moonclip.X), None, _)),
    )
  }
  assert_true(
    @moonclip.simplify_paths_d(
      [[@moonclip.PointD::new(1000.000001, 0.0)]],
      precision=dd_precision(6),
    )
    is Err(@moonclip.DecimalCoordinateOutOfRange(_, @moonclip.X, _, 6)),
  )
}

///|
test "simplify decimal isolation composition grid structural report only" {
  let p = [
    @moonclip.PointD::new(0.0, 0.0),
    @moonclip.PointD::new(1.0, 0.1),
    @moonclip.PointD::new(2.0, 0.0),
  ]
  let v = @moonclip.simplify_paths_d([p], precision=dd_precision(0)).unwrap()
  assert_eq(v.input_degenerate_indices(), [0])
  assert_eq(v.degenerate_indices(), [0])
  assert_eq(v.paths(), [
    [
      @moonclip.PointD::new(0.0, 0.0),
      @moonclip.PointD::new(1.0, 0.0),
      @moonclip.PointD::new(2.0, 0.0),
    ],
  ])
  assert_true(
    @moonclip.offset_polygons_d([p], 1.0, precision=dd_precision(0))
    is Err(@moonclip.QuantizationFailure(_, None, None, _)),
  )
}

///|
test "simplify decimal isolation composition decimal copies and reports" {
  let p = dd_box(0.0, 0.0, 10.0, 10.0)
  let v = @moonclip.simplify_paths_d([p, []]).unwrap()
  p.clear()
  let a = v.paths()
  a[0].clear()
  a.clear()
  let counts = v.removed_per_path()
  counts[0] = 99
  let before = v.input_degenerate_indices()
  before.clear()
  let after = v.degenerate_indices()
  after.clear()
  let collapsed = v.collapsed_indices()
  collapsed.push(1)
  assert_eq(v.paths(), [dd_box(0.0, 0.0, 10.0, 10.0), []])
  assert_eq(v.removed_per_path(), [0, 0])
  assert_eq(v.input_degenerate_indices(), [1])
  assert_eq(v.degenerate_indices(), [1])
  assert_eq(v.collapsed_indices(), [])
}

///|
test "simplify decimal isolation composition integer copies and reports" {
  let p = cp_rect(0L, 0L, 10L, 10L)
  let v = sm_run([p, []])
  p.clear()
  let a = v.paths()
  a[0].clear()
  a.clear()
  let counts = v.removed_per_path()
  counts[0] = 99
  v.input_degenerate_indices().clear()
  v.degenerate_indices().clear()
  v.collapsed_indices().push(0)
  sm_report(v, [cp_rect(0L, 0L, 10L, 10L), []], [0, 0], [1], [1], [])
}

///|
test "simplify decimal isolation composition alias outputs independent" {
  let p = cp_rect(0L, 0L, 10L, 10L)
  let v = sm_run([p, p])
  let a = v.paths()
  a[0].clear()
  assert_eq(a[1], p)
  assert_eq(v.paths(), [p, p])
  let d = dd_box(0.0, 0.0, 10.0, 10.0)
  let dv = @moonclip.simplify_paths_d([d, d]).unwrap()
  let da = dv.paths()
  da[0].clear()
  assert_eq(da[1], d)
}

///|
test "simplify decimal isolation composition fresh calls after failure" {
  let p = cp_rect(0L, 0L, 10L, 10L)
  let a = sm_run([p])
  let b = sm_run([p])
  a.paths().clear()
  assert_true(
    @moonclip.simplify_paths([p], limits={
      max_input_paths: 0,
      max_input_vertices: 0,
    })
    is Err(_),
  )
  sm_report(sm_run([p]), b.paths(), [0], [], [], [])
}

///|
test "simplify decimal isolation composition compose offset actual outline" {
  let p = sm_path([(0, 0), (5, 0), (10, 0), (10, 10), (0, 10)])
  let v = sm_run([p], epsilon=0.25)
  sm_report(v, [cp_rect(0L, 0L, 10L, 10L)], [1], [], [], [])
  cp_equal(@moonclip.offset_polygons(v.paths(), 2.0).unwrap(), [
    cp_rect(-2L, -2L, 14L, 14L),
  ])
}

///|
test "simplify decimal isolation composition compose tree actual hole hierarchy" {
  let outer = sm_path([(0, 0), (20, 0), (40, 0), (40, 40), (0, 40)])
  let hole = bb_reverse(cp_rect(10L, 10L, 20L, 20L))
  let v = sm_run([outer, hole], epsilon=0.25)
  assert_eq(v.removed_per_path(), [1, 0])
  assert_eq(v.degenerate_indices(), [])
  let t = @moonclip.boolean_tree(
    v.paths(),
    [],
    @moonclip.Union,
    fill_rule=@moonclip.NonZero,
  ).unwrap()
  assert_eq(t.roots().length(), 1)
  let root = t.roots()[0]
  assert_eq(root.depth(), 1)
  assert_eq(root.is_hole(), false)
  assert_eq(root.children().length(), 1)
  let child = root.children()[0]
  assert_eq(child.depth(), 2)
  assert_eq(child.is_hole(), true)
  assert_eq(child.children().length(), 0)
  cp_equal([root.contour()], [cp_rect(0L, 0L, 40L, 40L)])
  cp_equal([child.contour()], [hole])
}

///|
test "simplify decimal isolation composition compose decimal explicit degenerates filtering" {
  let p = dd_box(0.0, 0.0, 10.0, 10.0)
  let v = @moonclip.simplify_paths_d(
    [p, []],
    precision=dd_precision(3),
    options=@moonclip.SimplifyOptions::new(epsilon=0.25),
  ).unwrap()
  assert_eq(v.degenerate_indices(), [1])
  assert_eq(v.input_degenerate_indices(), [1])
  assert_eq(v.collapsed_indices(), [])
  let selected = [v.paths()[0]]
  let out = @moonclip.offset_polygons_d(
    selected,
    0.5,
    precision=dd_precision(3),
  ).unwrap()
  dd_equal(out, [dd_box(-0.5, -0.5, 10.5, 10.5)])
  assert_eq(v.removed_vertices(), 0)
  assert_eq(v.paths().length(), 2)
}
