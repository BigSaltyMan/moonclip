///|
fn p(x : Int64, y : Int64) -> @moonclip.Point64 {
  @moonclip.Point64::new(x, y)
}

///|
fn[T] take(value : Result[T, @moonclip.ClipError]) -> T raise {
  match value {
    Ok(result) => result
    Err(error) => fail(error.message())
  }
}

///|
fn budget(paths : Int, vertices : Int) -> @moonclip.Limits {
  { max_input_paths: paths, max_input_vertices: vertices, }
}

///|
fn square() -> @moonclip.Path64 {
  [p(-10L, -10L), p(10L, -10L), p(10L, 10L), p(-10L, 10L)]
}

///|
fn reversed(path : @moonclip.Path64) -> @moonclip.Path64 {
  Array::makei(path.length(), fn(i) { path[path.length() - i - 1] })
}

///|
fn big_loops(count : Int, clockwise : Bool) -> @moonclip.Path64 {
  let corners = [
    p(-1000000000L, -1000000000L),
    p(1000000000L, -1000000000L),
    p(1000000000L, 1000000000L),
    p(-1000000000L, 1000000000L),
  ]
  let result : @moonclip.Path64 = []
  for i = 0; i < count; i = i + 1 {
    for j = 0; j < 4; j = j + 1 {
      result.push(corners[if clockwise { (4 - j) % 4 } else { j }])
    }
  }
  result
}

///|
test "cross and orientation use mathematical axes" {
  let a = p(0L, 0L)
  let b = p(10L, 0L)
  let c = p(0L, 10L)
  assert_eq(@moonclip.cross(a, b, c), Ok(100L))
  assert_eq(@moonclip.orientation(a, b, c), Ok(@moonclip.CounterClockwise))
  assert_eq(@moonclip.cross(a, c, b), Ok(-100L))
  assert_eq(@moonclip.orientation(a, c, b), Ok(@moonclip.Clockwise))
  assert_eq(@moonclip.orientation(a, b, p(20L, 0L)), Ok(@moonclip.Collinear))
  assert_eq(@moonclip.cross(a, b, b), Ok(0L))
  assert_eq(@moonclip.cross(a, p(0L, 10L), p(0L, -10L)), Ok(0L))
}

///|
test "cross is exact for extreme coordinates and translated points" {
  let m = 1000000000L
  assert_eq(
    @moonclip.cross(p(-m, -m), p(m, -m), p(-m, m)),
    Ok(4000000000000000000L),
  )
  assert_eq(
    @moonclip.cross(p(-m, -m), p(-m, m), p(m, -m)),
    Ok(-4000000000000000000L),
  )
  assert_eq(
    @moonclip.orientation(p(-10L, -9L), p(10L, -9L), p(-10L, 11L)),
    @moonclip.orientation(p(90L, 91L), p(110L, 91L), p(90L, 111L)),
  )
}

///|
test "integer determinant distinguishes one unit from exact collinearity" {
  assert_eq(
    @moonclip.cross(
      p(0L, 0L),
      p(999999999L, 999999998L),
      p(1000000000L, 999999999L),
    ),
    Ok(1L),
  )
  assert_eq(
    @moonclip.orientation(
      p(0L, 0L),
      p(1000000000L, 1000000000L),
      p(999999999L, 999999999L),
    ),
    Ok(@moonclip.Collinear),
  )
}

///|
test "bounds has no sentinel for empty input" {
  assert_eq(@moonclip.bounds([]), Ok(None))
  assert_eq(
    take(@moonclip.bounds([p(-7L, 3L)])),
    Some({ min_x: -7L, min_y: 3L, max_x: -7L, max_y: 3L, }),
  )
}

///|
test "bounds handles horizontal vertical and signed extents" {
  assert_eq(
    take(@moonclip.bounds([p(-5L, -3L), p(-1L, -3L)])),
    Some({ min_x: -5L, min_y: -3L, max_x: -1L, max_y: -3L, }),
  )
  assert_eq(
    take(@moonclip.bounds([p(-2L, -9L), p(-2L, 7L)])),
    Some({ min_x: -2L, min_y: -9L, max_x: -2L, max_y: 7L, }),
  )
  assert_eq(
    take(@moonclip.bounds(square())),
    Some({ min_x: -10L, min_y: -10L, max_x: 10L, max_y: 10L, }),
  )
}

///|
test "area of rectangle triangle and concave contour is exact" {
  assert_eq(take(@moonclip.area2(square())), 800N)
  assert_eq(take(@moonclip.area2([p(0L, 0L), p(7L, 0L), p(0L, 3L)])), 21N)
  let concave = [p(0L, 0L), p(4L, 0L), p(4L, 4L), p(2L, 2L), p(0L, 4L)]
  assert_eq(take(@moonclip.area2(concave)), 24N)
  assert_eq(take(@moonclip.area2(reversed(concave))), -24N)
}

///|
test "area of degenerate paths is zero" {
  assert_eq(take(@moonclip.area2([])), 0N)
  assert_eq(take(@moonclip.area2([p(1L, 2L)])), 0N)
  assert_eq(
    take(
      @moonclip.area2([
        p(-1000000000L, 1000000000L),
        p(1000000000L, -1000000000L),
      ]),
    ),
    0N,
  )
}

///|
test "area ignores duplicate edge endpoints without changing input" {
  let a = p(-10L, -10L)
  let b = p(10L, -10L)
  let c = p(10L, 10L)
  let d = p(-10L, 10L)
  let path = [a, a, b, c, c, d, a, a]
  assert_eq(take(@moonclip.area2(path)), 800N)
  assert_eq(path.length(), 8)
}

///|
test "area actually exceeds both signed Int64 limits" {
  // Three squares, each with twice area 8 * 10^18. Expected by integer arithmetic.
  let expected = 3N * 8N * 1000000000N * 1000000000N
  assert_eq(take(@moonclip.area2(big_loops(3, false))), expected)
  assert_eq(take(@moonclip.area2(big_loops(3, true))), -expected)
}

///|
test "area preserves cancellation after an overflowing intermediate sum" {
  let path = big_loops(3, false)
  for point in big_loops(3, true) {
    path.push(point)
  }
  assert_eq(take(@moonclip.area2(path)), 0N)
  assert_eq(take(@moonclip.area2(reversed(path))), 0N)
}

///|
test "segment predicate handles all directions endpoints and outside collinear points" {
  assert_eq(
    @moonclip.point_on_segment(p(0L, 0L), p(-2L, 0L), p(2L, 0L)),
    Ok(true),
  )
  assert_eq(
    @moonclip.point_on_segment(p(0L, -2L), p(0L, -2L), p(0L, 2L)),
    Ok(true),
  )
  assert_eq(
    @moonclip.point_on_segment(p(1L, 1L), p(2L, 2L), p(-2L, -2L)),
    Ok(true),
  )
  assert_eq(
    @moonclip.point_on_segment(p(3L, 3L), p(-2L, -2L), p(2L, 2L)),
    Ok(false),
  )
  assert_eq(
    @moonclip.point_on_segment(p(1L, 2L), p(-2L, -2L), p(2L, 2L)),
    Ok(false),
  )
}

///|
test "zero length segment contains exactly its endpoint" {
  let a = p(3L, -4L)
  assert_eq(@moonclip.point_on_segment(a, a, a), Ok(true))
  assert_eq(@moonclip.point_on_segment(p(3L, -3L), a, a), Ok(false))
}

///|
test "convex containment distinguishes inside outside every edge and vertices" {
  let path = square()
  assert_eq(@moonclip.point_in_polygon(p(0L, 0L), path), Ok(@moonclip.Inside))
  assert_eq(@moonclip.point_in_polygon(p(11L, 0L), path), Ok(@moonclip.Outside))
  for point in [p(-10L, -10L), p(0L, -10L), p(0L, 10L), p(-10L, 0L), p(10L, 0L)] {
    assert_eq(@moonclip.point_in_polygon(point, path), Ok(@moonclip.OnBoundary))
  }
}

///|
test "concave contour and diagonal boundaries" {
  let path = [p(0L, 0L), p(6L, 0L), p(6L, 6L), p(3L, 3L), p(0L, 6L)]
  assert_eq(@moonclip.point_in_polygon(p(3L, 2L), path), Ok(@moonclip.Inside))
  assert_eq(@moonclip.point_in_polygon(p(3L, 5L), path), Ok(@moonclip.Outside))
  assert_eq(
    @moonclip.point_in_polygon(p(4L, 4L), path),
    Ok(@moonclip.OnBoundary),
  )
}

///|
test "half open ray intervals handle vertices and local extrema" {
  let diamond = [p(0L, -4L), p(4L, 0L), p(0L, 4L), p(-4L, 0L)]
  for point in [p(0L, 0L), p(-1L, 0L), p(0L, 3L)] {
    assert_eq(@moonclip.point_in_polygon(point, diamond), Ok(@moonclip.Inside))
  }
  for point in [p(-5L, 0L), p(-1L, 4L), p(-1L, -4L)] {
    assert_eq(@moonclip.point_in_polygon(point, diamond), Ok(@moonclip.Outside))
  }
}

///|
test "EvenOdd containment is invariant under reversal and closing duplicates" {
  let path = [p(0L, 0L), p(6L, 0L), p(6L, 6L), p(3L, 3L), p(0L, 6L)]
  let duplicate = @moonclip.copy_path(path)
  duplicate.push(path[0])
  duplicate.push(path[0])
  for point in [p(3L, 2L), p(3L, 5L), p(4L, 4L), p(-1L, 6L), p(0L, 0L)] {
    assert_eq(
      @moonclip.point_in_polygon(point, path),
      @moonclip.point_in_polygon(point, reversed(path)),
    )
    assert_eq(
      @moonclip.point_in_polygon(point, path),
      @moonclip.point_in_polygon(point, duplicate),
    )
  }
}

///|
test "self intersecting zero area bowtie has EvenOdd filled lobes" {
  let path = [p(-4L, -4L), p(4L, 4L), p(-4L, 4L), p(4L, -4L)]
  assert_eq(take(@moonclip.area2(path)), 0N)
  assert_eq(@moonclip.point_in_polygon(p(0L, 3L), path), Ok(@moonclip.Inside))
  assert_eq(@moonclip.point_in_polygon(p(0L, -3L), path), Ok(@moonclip.Inside))
  assert_eq(@moonclip.point_in_polygon(p(3L, 0L), path), Ok(@moonclip.Outside))
  assert_eq(
    @moonclip.point_in_polygon(p(0L, 0L), path),
    Ok(@moonclip.OnBoundary),
  )
}

///|
test "EvenOdd twice traversed contour is outside away from edges" {
  let path = square()
  for point in square() {
    path.push(point)
  }
  assert_eq(@moonclip.point_in_polygon(p(0L, 0L), path), Ok(@moonclip.Outside))
  assert_eq(
    @moonclip.point_in_polygon(p(0L, 10L), path),
    Ok(@moonclip.OnBoundary),
  )
}

///|
test "degenerate contours cannot invent interior" {
  assert_eq(@moonclip.point_in_polygon(p(0L, 0L), []), Ok(@moonclip.Outside))
  assert_eq(
    @moonclip.point_in_polygon(p(1L, 2L), [p(1L, 2L)]),
    Ok(@moonclip.OnBoundary),
  )
  assert_eq(
    @moonclip.point_in_polygon(p(2L, 2L), [p(1L, 2L)]),
    Ok(@moonclip.Outside),
  )
  let line = [p(-2L, -2L), p(2L, 2L)]
  assert_eq(
    @moonclip.point_in_polygon(p(0L, 0L), line),
    Ok(@moonclip.OnBoundary),
  )
  assert_eq(@moonclip.point_in_polygon(p(1L, 0L), line), Ok(@moonclip.Outside))
  assert_eq(@moonclip.point_in_polygon(p(3L, 3L), line), Ok(@moonclip.Outside))
  assert_eq(
    @moonclip.point_in_polygon(p(0L, 1L), [p(-2L, 0L), p(0L, 0L), p(2L, 0L)]),
    Ok(@moonclip.Outside),
  )
}

///|
test "containment remains exact at extreme coordinates" {
  let path = big_loops(1, false)
  assert_eq(
    @moonclip.point_in_polygon(p(999999999L, 999999999L), path),
    Ok(@moonclip.Inside),
  )
  assert_eq(
    @moonclip.point_in_polygon(p(-1000000000L, 0L), path),
    Ok(@moonclip.OnBoundary),
  )
}
