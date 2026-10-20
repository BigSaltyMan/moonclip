// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
priv enum Output {
  Integer(@moonclip.Paths64)
  Decimal(@moonclip.PathsD)
  Simplified(@moonclip.SimplifyResult)
}

///|
priv struct Case {
  id : String
  parameters : Json
  input_paths : Int
  input_vertices : Int
  pattern_vertices : Int
  route_vertices : Int
  stress : Bool
  batch : Int
  run : () -> Result[Output, @moonclip.ClipError]
  check : (Output) -> Bool
}

///|
fn point(x : Int, y : Int) -> @moonclip.Point64 {
  @moonclip.Point64::new(x.to_int64(), y.to_int64())
}

///|
fn rectangle(x : Int, y : Int, w : Int, h : Int) -> @moonclip.Path64 {
  [point(x, y), point(x + w, y), point(x + w, y + h), point(x, y + h)]
}

///|
fn vertices(paths : @moonclip.Paths64) -> Int {
  paths.fold(init=0, fn(n, p) { n + p.length() })
}

///|
// Exact full contours: only cyclic starts and sibling ordering are ignored.
// Neither winding nor collinear vertices may be changed by this checker.
fn same_paths(actual : @moonclip.Paths64, expected : @moonclip.Paths64) -> Bool {
  if actual.length() != expected.length() {
    return false
  }
  let used = Array::make(expected.length(), false)
  for path in actual {
    let mut found = false
    for j = 0; j < expected.length(); j = j + 1 {
      let other = expected[j]
      if used[j] || path.length() != other.length() {
        continue
      }
      for start = 0; start < path.length(); start = start + 1 {
        let mut equal = true
        for k = 0; k < path.length(); k = k + 1 {
          if path[k] != other[(start + k) % other.length()] {
            equal = false
            break
          }
        }
        if equal {
          found = true
          used[j] = true
          break
        }
      }
      if found {
        break
      }
    }
    if !found {
      return false
    }
  }
  true
}

///|
fn exact(expected : @moonclip.Paths64) -> (Output) -> Bool {
  fn(value) {
    match value {
      Integer(paths) => same_paths(paths, expected)
      _ => false
    }
  }
}

///|
fn boolean_case(n : Int) -> Case {
  let a = Array::makei(n, fn(i) { rectangle(i * 40, 0, 20, 20) })
  let b = Array::makei(n, fn(i) { rectangle(i * 40 + 10, -5, 20, 20) })
  let expected = Array::makei(n, fn(i) { rectangle(i * 40 + 10, 0, 10, 15) })
  {
    id: "boolean_\{n}",
    parameters: {
      "operation": "Intersection",
      "fill_rule": "NonZero",
      "pairs": n.to_json(),
    },
    input_paths: 2 * n,
    input_vertices: 8 * n,
    pattern_vertices: 0,
    route_vertices: 0,
    stress: false,
    batch: 5,
    run: fn() {
      @moonclip.boolean_op(a, b, Intersection, fill_rule=NonZero).map(fn(
        value,
      ) {
        Integer(value)
      })
    },
    check: exact(expected),
  }
}

///|
fn cases() -> Array[Case] {
  let concave = [
    point(0, 0),
    point(40, 0),
    point(40, 10),
    point(10, 10),
    point(10, 40),
    point(0, 40),
  ]
  let route = [point(0, 0), point(20, 0), point(20, 20)]
  let decimal_a = [
    [
      @moonclip.PointD::new(-1.25, -0.25),
      @moonclip.PointD::new(1.25, -0.25),
      @moonclip.PointD::new(1.25, 1.25),
      @moonclip.PointD::new(-1.25, 1.25),
    ],
  ]
  let decimal_b = [
    [
      @moonclip.PointD::new(0.25, -0.25),
      @moonclip.PointD::new(2.25, -0.25),
      @moonclip.PointD::new(2.25, 1.25),
      @moonclip.PointD::new(0.25, 1.25),
    ],
  ]
  let simple = [
    [point(0, 0), point(10, 0), point(20, 0), point(20, 20), point(0, 20)],
  ]
  let pattern = rectangle(-2, -1, 4, 2)
  let n = 12
  let horizontal = Array::makei(n, fn(i) { rectangle(0, i * 10 + 2, n * 10, 4) })
  let vertical = Array::makei(n, fn(i) { rectangle(i * 10 + 2, 0, 4, n * 10) })
  let grid : @moonclip.Paths64 = []
  for i = 0; i < n; i = i + 1 {
    for j = 0; j < n; j = j + 1 {
      grid.push(rectangle(j * 10 + 2, i * 10 + 2, 4, 4))
    }
  }
  let teeth = [point(0, 0), point(240, 0), point(240, 100)]
  for i = 12; i > 0; i = i - 1 {
    teeth.push(point(i * 20 - 10, 300))
    teeth.push(point(i * 20 - 20, 100))
  }
  let concave_paths = [concave]
  let teeth_paths = [teeth]
  let round_input = [rectangle(0, 0, 100, 100)]
  let round_options = @moonclip.OffsetOptions::new(
    join=Round,
    arc_tolerance=0.001,
  )
  let simplify_options = @moonclip.SimplifyOptions::new(epsilon=0.25)
  [
    boolean_case(1),
    boolean_case(8),
    boolean_case(32),
    {
      id: "offset_concave",
      parameters: {
        "operation": "Offset",
        "delta": 2,
        "join": "Miter",
        "miter_limit": 2,
        "fill_rule": "NonZero",
        "arc_tolerance": 0,
      },
      input_paths: 1,
      input_vertices: 6,
      pattern_vertices: 0,
      route_vertices: 0,
      stress: false,
      batch: 5,
      run: fn() {
        @moonclip.offset_polygons(concave_paths, 2.0).map(fn(value) {
          Integer(value)
        })
      },
      check: exact([
        [
          point(-2, -2),
          point(42, -2),
          point(42, 12),
          point(12, 12),
          point(12, 42),
          point(-2, 42),
        ],
      ]),
    },
    {
      id: "stroke_route",
      parameters: {
        "operation": "Stroke",
        "width": 4,
        "join": "Miter",
        "cap": "Butt",
        "miter_limit": 2,
        "arc_tolerance": 0,
      },
      input_paths: 1,
      input_vertices: 3,
      pattern_vertices: 0,
      route_vertices: 3,
      stress: false,
      batch: 5,
      run: fn() {
        @moonclip.stroke_polyline(route, 4.0).map(fn(value) { Integer(value) })
      },
      check: exact([
        [
          point(0, -2),
          point(22, -2),
          point(22, 20),
          point(18, 20),
          point(18, 2),
          point(0, 2),
        ],
      ]),
    },
    {
      id: "decimal_union",
      parameters: {
        "operation": "BooleanD/Union",
        "precision": 3,
        "fill_rule": "NonZero",
      },
      input_paths: 2,
      input_vertices: 8,
      pattern_vertices: 0,
      route_vertices: 0,
      stress: false,
      batch: 5,
      run: fn() {
        @moonclip.boolean_op_d(decimal_a, decimal_b, Union, fill_rule=NonZero).map(fn(
            value,
          ) {
            Decimal(value)
          },
        )
      },
      check: fn(value) {
        match value {
          Decimal(paths) => {
            // All expected values are exact binary fractions; no epsilon comparison.
            let expected = [
              @moonclip.PointD::new(-1.25, -0.25),
              @moonclip.PointD::new(2.25, -0.25),
              @moonclip.PointD::new(2.25, 1.25),
              @moonclip.PointD::new(-1.25, 1.25),
            ]
            paths.length() == 1 &&
            paths[0].length() == 4 &&
            expected.all(fn(p) { paths[0].contains(p) })
          }
          _ => false
        }
      },
    },
    {
      id: "simplify_collinear",
      parameters: { "operation": "Simplify", "mode": "Closed", "epsilon": 0.25 },
      input_paths: 1,
      input_vertices: 5,
      pattern_vertices: 0,
      route_vertices: 0,
      stress: false,
      batch: 20,
      run: fn() {
        @moonclip.simplify_paths(simple, options=simplify_options).map(fn(
          value,
        ) {
          Simplified(value)
        })
      },
      check: fn(value) {
        match value {
          Simplified(result) =>
            same_paths(result.paths(), [rectangle(0, 0, 20, 20)]) &&
            result.removed_vertices() == 1 &&
            result.removed_per_path() == [1] &&
            result.input_degenerate_indices().is_empty() &&
            result.degenerate_indices().is_empty() &&
            result.collapsed_indices().is_empty()
          _ => false
        }
      },
    },
    {
      id: "minkowski_route",
      parameters: {
        "operation": "MinkowskiSum",
        "path_is_closed": false,
        "pattern_anchor": [0, 0],
        "preserve_collinear": true,
      },
      input_paths: 2,
      input_vertices: 7,
      pattern_vertices: 4,
      route_vertices: 3,
      stress: false,
      batch: 3,
      run: fn() {
        @moonclip.minkowski_sum(pattern, route, false).map(fn(value) {
          Integer(value)
        })
      },
      check: exact([
        [
          point(18, -1),
          point(22, -1),
          point(22, 1),
          point(22, 21),
          point(18, 21),
          point(18, 19),
          point(18, 1),
          point(2, 1),
          point(-2, 1),
          point(-2, -1),
        ],
      ]),
    },
    {
      id: "stress_intersections",
      parameters: {
        "operation": "Intersection",
        "fill_rule": "NonZero",
        "horizontal_bars": 12,
        "vertical_bars": 12,
      },
      input_paths: 24,
      input_vertices: 96,
      pattern_vertices: 0,
      route_vertices: 0,
      stress: true,
      batch: 1,
      run: fn() {
        @moonclip.boolean_op(
          horizontal,
          vertical,
          Intersection,
          fill_rule=NonZero,
        ).map(fn(value) { Integer(value) })
      },
      check: exact(grid),
    },
    {
      id: "stress_sharp_offset",
      parameters: {
        "operation": "Offset",
        "teeth": 12,
        "delta": 5,
        "join": "Miter",
        "miter_limit": 2,
        "arc_tolerance": 0,
        "fill_rule": "NonZero",
      },
      input_paths: 1,
      input_vertices: teeth.length(),
      pattern_vertices: 0,
      route_vertices: 0,
      stress: true,
      batch: 1,
      run: fn() {
        @moonclip.offset_polygons(teeth_paths, 5.0).map(fn(value) {
          Integer(value)
        })
      },
      check: fn(value) {
        match value {
          Integer([path]) =>
            @moonclip.area2(path) is Ok(area) &&
            area > 96000N &&
            @moonclip.bounds(path) is Ok(Some(box)) &&
            box.min_y == -5L &&
            box.max_y > 300L &&
            path.length() > 24
          _ => false
        }
      },
    },
    {
      id: "stress_round_tolerance",
      parameters: {
        "operation": "Offset",
        "delta": 100,
        "join": "Round",
        "miter_limit": 2,
        "arc_tolerance": 0.001,
        "fill_rule": "NonZero",
      },
      input_paths: 1,
      input_vertices: 4,
      pattern_vertices: 0,
      route_vertices: 0,
      stress: true,
      batch: 1,
      run: fn() {
        @moonclip.offset_polygons(round_input, 100.0, options=round_options).map(fn(
            value,
          ) {
            Integer(value)
          },
        )
      },
      check: fn(value) {
        match value {
          Integer([path]) =>
            @moonclip.area2(path) is Ok(area) &&
            area > 140000N &&
            area < 180000N &&
            path.length() > 100 &&
            @moonclip.bounds(path) is Ok(Some(box)) &&
            box.min_x == -100L &&
            box.min_y == -100L &&
            box.max_x == 200L &&
            box.max_y == 200L
          _ => false
        }
      },
    },
  ]
}
