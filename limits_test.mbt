///|
test "coordinate constant and conservative defaults" {
  assert_eq(@moonclip.COORDINATE_LIMIT, 1000000000L)
  let defaults : @moonclip.Limits = Default::default()
  assert_eq(defaults.max_input_paths, 10000)
  assert_eq(defaults.max_input_vertices, 100000)
}

///|
test "both inclusive coordinate boundaries pass on both axes" {
  assert_eq(
    @moonclip.validate_paths([
      [p(-1000000000L, 1000000000L), p(1000000000L, -1000000000L)],
    ]),
    Ok(()),
  )
}

///|
test "each axis rejects both one unit violations with original location and value" {
  for
    point in [
      p(1000000001L, 0L),
      p(-1000000001L, 0L),
      p(0L, 1000000001L),
      p(0L, -1000000001L),
    ] {
    match @moonclip.validate_paths([[], [p(0L, 0L), point]]) {
      Err(CoordinateOutOfRange(loc, axis, value)) => {
        assert_true(loc.stage is ValidateInputs)
        assert_eq(loc.path_index, Some(1))
        assert_eq(loc.vertex_index, Some(1))
        if point.x != 0L {
          assert_true(axis is X)
          assert_eq(value, point.x)
        } else {
          assert_true(axis is Y)
          assert_eq(value, point.y)
        }
      }
      _ => fail("Expected coordinate error")
    }
  }
}

///|
test "Int64 extremes are rejected before any arithmetic" {
  for value in [-9223372036854775808L, 9223372036854775807L] {
    assert_true(
      @moonclip.cross(p(value, 0L), p(0L, 0L), p(1L, 1L))
      is Err(CoordinateOutOfRange(_, X, _)),
    )
    assert_true(
      @moonclip.orientation(p(0L, 0L), p(0L, value), p(1L, 1L))
      is Err(CoordinateOutOfRange(_, Y, _)),
    )
    assert_true(
      @moonclip.bounds([p(0L, value)]) is Err(CoordinateOutOfRange(_, Y, _)),
    )
    assert_true(
      @moonclip.area2([p(value, 0L)]) is Err(CoordinateOutOfRange(_, X, _)),
    )
    assert_true(
      @moonclip.point_on_segment(p(value, 0L), p(0L, 0L), p(1L, 1L))
      is Err(CoordinateOutOfRange(_, X, _)),
    )
    assert_true(
      @moonclip.point_in_polygon(p(value, 0L), [])
      is Err(CoordinateOutOfRange(_, X, _)),
    )
    assert_true(
      @moonclip.normalize_path([p(value, 0L)], @moonclip.Open)
      is Err(CoordinateOutOfRange(_, X, _)),
    )
  }
}

///|
test "every geometric entry validates entire input before early return" {
  let invalid = [p(0L, 0L), p(1L, 1L), p(1000000001L, 0L)]
  assert_true(
    @moonclip.point_in_polygon(p(0L, 0L), invalid)
    is Err(CoordinateOutOfRange(_, X, _)),
  )
  assert_true(
    @moonclip.point_on_segment(p(0L, 0L), p(0L, 0L), p(0L, 1000000001L))
    is Err(CoordinateOutOfRange(_, Y, _)),
  )
  assert_true(
    @moonclip.normalize_paths([[], invalid], @moonclip.Closed)
    is Err(CoordinateOutOfRange(_, X, _)),
  )
}

///|
test "path and raw vertex counts exactly at limit succeed" {
  assert_eq(
    @moonclip.validate_paths(
      [[p(0L, 0L)], [], [p(1L, 1L), p(2L, 2L)]],
      limits=budget(3, 3),
    ),
    Ok(()),
  )
  assert_true(
    @moonclip.normalize_path(
      [p(0L, 0L), p(0L, 0L)],
      @moonclip.Closed,
      limits=budget(1, 2),
    )
    is Ok(_),
  )
}

///|
test "path limit counts empty contours and locates first excess path" {
  match @moonclip.validate_paths([[], [], []], limits=budget(2, 0)) {
    Err(ResourceLimitExceeded(loc, InputPaths, limit)) => {
      assert_eq(limit, 2)
      assert_eq(loc.path_index, Some(2))
      assert_eq(loc.vertex_index, None)
    }
    _ => fail("Expected path resource error")
  }
  let empty_paths : @moonclip.Paths64 = Array::makei(10001, fn(_) { [] })
  assert_true(
    @moonclip.validate_paths(empty_paths)
    is Err(ResourceLimitExceeded(_, InputPaths, 10000)),
  )
}

///|
test "collection vertex budget is shared and reports first exceeding original vertex" {
  let paths = [[p(0L, 0L), p(0L, 0L)], [], [p(1L, 1L), p(1L, 1L)]]
  match
    @moonclip.normalize_paths(paths, @moonclip.Closed, limits=budget(3, 3)) {
    Err(ResourceLimitExceeded(loc, InputVertices, limit)) => {
      assert_true(loc.stage is NormalizePaths)
      assert_eq(limit, 3)
      assert_eq(loc.path_index, Some(2))
      assert_eq(loc.vertex_index, Some(1))
    }
    _ => fail("Expected shared raw vertex budget error")
  }
  assert_eq(paths[0].length(), 2)
  assert_eq(paths[2].length(), 2)
}

///|
test "duplicate vertices consume the original input budget" {
  let duplicates = [p(1L, 1L), p(1L, 1L), p(1L, 1L)]
  assert_true(
    @moonclip.normalize_path(duplicates, @moonclip.Closed, limits=budget(1, 2))
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
  assert_eq(duplicates.length(), 3)
}

///|
test "zero allowances distinguish collections from single path calls" {
  assert_eq(@moonclip.validate_paths([], limits=budget(0, 0)), Ok(()))
  assert_true(
    @moonclip.validate_paths([[]], limits=budget(0, 0))
    is Err(ResourceLimitExceeded(_, InputPaths, 0)),
  )
  assert_eq(
    @moonclip.normalize_path([], @moonclip.Closed, limits=budget(1, 0)),
    Ok([]),
  )
  assert_true(
    @moonclip.normalize_path([p(0L, 0L)], @moonclip.Closed, limits=budget(1, 0))
    is Err(ResourceLimitExceeded(_, InputVertices, 0)),
  )
  assert_true(
    @moonclip.bounds([], limits=budget(0, 0))
    is Err(ResourceLimitExceeded(_, InputPaths, 0)),
  )
}

///|
test "negative limits are parameter errors including on empty input" {
  for limits in [budget(-1, 0), budget(0, -1), budget(-1, -1)] {
    assert_true(
      @moonclip.validate_paths([], limits~) is Err(InvalidInput(_, _)),
    )
    assert_true(
      @moonclip.normalize_paths([], @moonclip.Open, limits~)
      is Err(InvalidInput(_, _)),
    )
    assert_true(@moonclip.area2([], limits~) is Err(InvalidInput(_, _)))
  }
}

///|
test "maximum Int budget does not overflow accounting" {
  assert_eq(
    @moonclip.validate_paths(
      [[p(1L, 2L)], [], [p(3L, 4L)]],
      limits=budget(2147483647, 2147483647),
    ),
    Ok(()),
  )
}

///|
test "default maximum raw vertex allowance and one beyond" {
  let path : @moonclip.Path64 = Array::makei(100000, fn(_) { p(0L, 0L) })
  assert_eq(@moonclip.validate_paths([path]), Ok(()))
  path.push(p(0L, 0L))
  match @moonclip.validate_paths([path]) {
    Err(ResourceLimitExceeded(loc, InputVertices, 100000)) =>
      assert_eq(loc.vertex_index, Some(100000))
    _ => fail("Expected default vertex limit")
  }
}

///|
test "all geometry entries share budgets including query vertices" {
  let a = p(0L, 0L)
  let b = p(1L, 0L)
  let c = p(0L, 1L)
  let limits = budget(1, 2)
  assert_true(
    @moonclip.cross(a, b, c, limits~)
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
  assert_true(
    @moonclip.orientation(a, b, c, limits~)
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
  assert_true(
    @moonclip.point_on_segment(a, b, c, limits~)
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
  assert_true(
    @moonclip.bounds([a, b, c], limits~)
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
  assert_true(
    @moonclip.area2([a, b, c], limits~)
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
  assert_true(
    @moonclip.point_in_polygon(a, [b, c], limits~)
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
  assert_eq(
    @moonclip.point_in_polygon(a, [], limits=budget(1, 1)),
    Ok(@moonclip.Outside),
  )
  assert_eq(@moonclip.cross(a, b, c, limits=budget(1, 3)), Ok(1L))
}

///|
test "failed validation does not leak budgets into future calls" {
  let limits = budget(1, 1)
  assert_true(
    @moonclip.normalize_paths([[p(0L, 0L), p(1L, 1L)]], @moonclip.Open, limits~)
    is Err(_),
  )
  assert_eq(
    @moonclip.normalize_paths([[p(0L, 0L)]], @moonclip.Open, limits~),
    Ok([[p(0L, 0L)]]),
  )
  assert_true(@moonclip.validate_paths([[p(1000000001L, 0L)]]) is Err(_))
  assert_eq(@moonclip.validate_paths([[p(1000000000L, 0L)]]), Ok(()))
}

///|
test "error messages and reserved numeric failure are English values" {
  let loc : @moonclip.ErrorLocation = {
    stage: @moonclip.Area2,
    path_index: None,
    vertex_index: None,
  }
  assert_eq(
    @moonclip.NumericFailure(loc, "Exact calculation failed").message(),
    "Exact calculation failed",
  )
  assert_eq(
    @moonclip.InvalidInput(loc, "Input limits must be non-negative").message(),
    "Input limits must be non-negative",
  )
  assert_eq(
    @moonclip.CoordinateOutOfRange(loc, @moonclip.X, 1000000001L).message(),
    "Coordinate x=1000000001 is outside [-1000000000, 1000000000]",
  )
  assert_eq(
    @moonclip.ResourceLimitExceeded(loc, @moonclip.InputVertices, 2).message(),
    "Resource limit exceeded for input vertices (limit 2)",
  )
}
