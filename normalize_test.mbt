///|
test "normalization preserves empty paths and contour indices" {
  assert_eq(@moonclip.normalize_path([], @moonclip.Closed), Ok([]))
  assert_eq(@moonclip.normalize_paths([], @moonclip.Open), Ok([]))
  assert_eq(
    @moonclip.normalize_paths([[], [p(1L, 2L)], []], @moonclip.Closed),
    Ok([[], [p(1L, 2L)], []]),
  )
}

///|
test "all identical vertices normalize to a real singleton" {
  let a = p(-1L, 2L)
  assert_eq(@moonclip.normalize_path([a, a, a, a], @moonclip.Closed), Ok([a]))
  assert_eq(@moonclip.normalize_path([a, a, a, a], @moonclip.Open), Ok([a]))
}

///|
test "closed normalization removes runs and multiple closing copies" {
  let a = p(0L, 0L)
  let b = p(2L, 0L)
  let c = p(0L, 2L)
  assert_eq(
    @moonclip.normalize_path([a, a, b, c, a, a], @moonclip.Closed),
    Ok([a, b, c]),
  )
  assert_eq(
    @moonclip.normalize_path([a, b, c, a], @moonclip.Closed),
    Ok([a, b, c]),
  )
}

///|
test "open normalization preserves meaningful return endpoint" {
  let a = p(0L, 0L)
  let b = p(2L, 0L)
  assert_eq(
    @moonclip.normalize_path([a, a, b, a], @moonclip.Open),
    Ok([a, b, a]),
  )
  assert_eq(
    @moonclip.normalize_path([a, a, b, a, a], @moonclip.Open),
    Ok([a, b, a]),
  )
  assert_eq(@moonclip.normalize_path([a, b, a], @moonclip.Closed), Ok([a, b]))
}

///|
test "nonconsecutive repeats collinear vertices and contour order are preserved" {
  let a = p(0L, 0L)
  let b = p(1L, 0L)
  let c = p(2L, 0L)
  let d = p(1L, 2L)
  let path = [a, b, c, b, d]
  assert_eq(
    @moonclip.normalize_paths([path, [], [d, c, b, a]], @moonclip.Closed),
    Ok([path, [], [d, c, b, a]]),
  )
}

///|
test "zero area self intersecting contour is not deleted" {
  let bowtie = [p(-4L, -4L), p(4L, 4L), p(-4L, 4L), p(4L, -4L)]
  assert_eq(take(@moonclip.area2(bowtie)), 0N)
  assert_eq(@moonclip.normalize_path(bowtie, @moonclip.Closed), Ok(bowtie))
  assert_eq(@moonclip.normalize_paths([bowtie], @moonclip.Closed), Ok([bowtie]))
}

///|
test "normalization is idempotent in both modes" {
  let a = p(0L, 0L)
  let b = p(1L, 0L)
  let c = p(0L, 1L)
  for mode in [@moonclip.Open, @moonclip.Closed] {
    for path in [[], [a], [a, a, a], [a, a, b, c, a, a], [a, b, a, c, a]] {
      let once = take(@moonclip.normalize_path(path, mode))
      assert_eq(@moonclip.normalize_path(once, mode), Ok(once))
    }
  }
}

///|
test "normalization isolates edits and resizing in both directions" {
  let a = p(1L, 2L)
  let b = p(-3L, -4L)
  let source = [a, a, b]
  let result = take(@moonclip.normalize_path(source, @moonclip.Open))
  source[0] = b
  source.push(a)
  assert_eq(result, [a, b])
  result[1] = a
  result.push(b)
  assert_eq(source, [b, a, b, a])
  result.clear()
  assert_eq(source.length(), 4)
}

///|
test "normalization allocates independent storage even without removed vertices" {
  let source = [p(1L, 2L), p(3L, 4L)]
  let first = take(@moonclip.normalize_path(source, @moonclip.Closed))
  let second = take(@moonclip.normalize_path(source, @moonclip.Closed))
  first[0] = p(-1L, -2L)
  assert_eq(second[0], p(1L, 2L))
  assert_eq(source[0], p(1L, 2L))
  second.clear()
  assert_eq(first.length(), 2)
  assert_eq(source.length(), 2)
}

///|
test "collection normalization separates aliased paths and outer arrays" {
  let a = p(1L, 2L)
  let b = p(-1L, -2L)
  let shared = [a, a, b]
  let source = [shared, shared, []]
  let result = take(@moonclip.normalize_paths(source, @moonclip.Closed))
  result[0][0] = b
  result[0].push(a)
  assert_eq(result[1], [a, b])
  assert_eq(shared, [a, a, b])
  shared[0] = b
  assert_eq(result[1], [a, b])
  result[2].push(a)
  assert_eq(source[2], [])
  result.push([])
  assert_eq(source.length(), 3)
  source[0] = []
  source.clear()
  assert_eq(result.length(), 4)
  assert_eq(result[1], [a, b])
}

///|
test "normalization error is atomic and leaves source untouched" {
  let invalid = p(1000000001L, 0L)
  let source = [[p(1L, 2L), p(1L, 2L)], [], [invalid]]
  let saved = @moonclip.copy_paths(source)
  match @moonclip.normalize_paths(source, @moonclip.Closed) {
    Err(CoordinateOutOfRange(loc, X, value)) => {
      assert_true(loc.stage is NormalizePaths)
      assert_eq(loc.path_index, Some(2))
      assert_eq(loc.vertex_index, Some(0))
      assert_eq(value, 1000000001L)
    }
    _ => fail("Expected coordinate error before output allocation")
  }
  assert_eq(source, saved)
  assert_true(
    @moonclip.normalize_paths(source, @moonclip.Closed, limits=budget(3, 2))
    is Err(ResourceLimitExceeded(_, InputVertices, 2)),
  )
  assert_eq(source, saved)
}

///|
test "empty normalization results never share mutable arrays" {
  let empty : @moonclip.Path64 = []
  let result = take(@moonclip.normalize_paths([empty, empty], @moonclip.Closed))
  result[0].push(p(1L, 2L))
  assert_eq(result[1], [])
  assert_eq(empty, [])
  let next = take(@moonclip.normalize_paths([empty], @moonclip.Closed))
  next[0].push(p(-1L, -2L))
  assert_eq(result[0], [p(1L, 2L)])
}
