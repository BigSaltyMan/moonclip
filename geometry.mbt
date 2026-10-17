// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
pub(all) enum Orientation {
  CounterClockwise
  Clockwise
  Collinear
} derive(Eq, Debug)

///|
pub(all) enum PointLocation {
  Outside
  Inside
  OnBoundary
} derive(Eq, Debug)

///|
pub(all) struct Bounds64 {
  min_x : Int64
  min_y : Int64
  max_x : Int64
  max_y : Int64
} derive(Eq, Debug)

///|
/// Validated coordinates: |difference| <= 2e9, |product| <= 4e18;
/// |cross| <= 8e18 < 9223372036854775807. Re-audit before raising the limit.
fn cross_validated(a : Point64, b : Point64, c : Point64) -> Int64 {
  (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
}

///|
pub fn cross(
  a : Point64,
  b : Point64,
  c : Point64,
  limits? : Limits = Default::default(),
) -> Result[Int64, ClipError] {
  if check_three(a, b, c, limits, Cross) is Some(e) {
    return Err(e)
  }
  Ok(cross_validated(a, b, c))
}

///|
/// Mathematical axes: x right, y up; positive cross is counterclockwise.
pub fn orientation(
  a : Point64,
  b : Point64,
  c : Point64,
  limits? : Limits = Default::default(),
) -> Result[Orientation, ClipError] {
  if check_three(a, b, c, limits, Orientation) is Some(e) {
    return Err(e)
  }
  let value = cross_validated(a, b, c)
  Ok(
    if value > 0L {
      CounterClockwise
    } else if value < 0L {
      Clockwise
    } else {
      Collinear
    },
  )
}

///|
pub fn bounds(
  path : Path64,
  limits? : Limits = Default::default(),
) -> Result[Bounds64?, ClipError] {
  if check_path(path, limits, Bounds, None) is Some(e) {
    return Err(e)
  }
  if path.is_empty() {
    return Ok(None)
  }
  let mut min_x = path[0].x
  let mut min_y = path[0].y
  let mut max_x = min_x
  let mut max_y = min_y
  for p in path {
    min_x = if p.x < min_x { p.x } else { min_x }
    min_y = if p.y < min_y { p.y } else { min_y }
    max_x = if p.x > max_x { p.x } else { max_x }
    max_y = if p.y > max_y { p.y } else { max_y }
  }
  Ok(Some({ min_x, min_y, max_x, max_y, }))
}

///|
priv enum AreaAccumulator {
  Small(Int64)
  Large(BigInt)
}

///|
/// Each shoelace term is in [-2e18, 2e18]. Test against safe thresholds
/// before adding; once promoted, all remaining operations stay exact BigInt.
fn add_area_term(sum : AreaAccumulator, term : Int64) -> AreaAccumulator {
  match sum {
    Large(value) => Large(value + BigInt::from_int64(term))
    Small(value) =>
      if (term > 0L && value > 9223372036854775807L - term) ||
        (term < 0L && value < -9223372036854775808L - term) {
        Large(BigInt::from_int64(value) + BigInt::from_int64(term))
      } else {
        Small(value + term)
      }
  }
}

///|
fn accumulate_area(path : Path64, initial : AreaAccumulator) -> AreaAccumulator {
  let mut sum = initial
  if path.length() < 3 {
    return sum
  }
  let mut previous = path[path.length() - 1]
  for current in path {
    sum = add_area_term(sum, previous.x * current.y - previous.y * current.x)
    previous = current
  }
  sum
}

///|
fn exact_area(sum : AreaAccumulator) -> BigInt {
  match sum {
    Small(value) => BigInt::from_int64(value)
    Large(value) => value
  }
}

///|
/// Exact twice signed area; closes the last edge implicitly. Zero area is
/// not a validity test for self-intersecting or degenerate contours.
pub fn area2(
  path : Path64,
  limits? : Limits = Default::default(),
) -> Result[BigInt, ClipError] {
  if check_path(path, limits, Area2, None) is Some(e) {
    return Err(e)
  }
  Ok(exact_area(accumulate_area(path, Small(0L))))
}

///|
fn point_on_segment_validated(
  point : Point64,
  a : Point64,
  b : Point64,
) -> Bool {
  cross_validated(a, b, point) == 0L &&
  point.x >= (if a.x < b.x { a.x } else { b.x }) &&
  point.x <= (if a.x > b.x { a.x } else { b.x }) &&
  point.y >= (if a.y < b.y { a.y } else { b.y }) &&
  point.y <= (if a.y > b.y { a.y } else { b.y })
}

///|
pub fn point_on_segment(
  point : Point64,
  a : Point64,
  b : Point64,
  limits? : Limits = Default::default(),
) -> Result[Bool, ClipError] {
  if check_three(point, a, b, limits, PointOnSegment) is Some(e) {
    return Err(e)
  }
  Ok(point_on_segment_validated(point, a, b))
}

///|
/// Single closed contour, EvenOdd rule. Half-open y intervals count a shared
/// vertex once; horizontal edges participate only in the boundary check.
pub fn point_in_polygon(
  point : Point64,
  path : Path64,
  limits? : Limits = Default::default(),
) -> Result[PointLocation, ClipError] {
  if check_path(path, limits, PointInPolygon, Some(point)) is Some(e) {
    return Err(e)
  }
  if path.is_empty() {
    return Ok(Outside)
  }
  let mut inside = false
  let mut a = path[path.length() - 1]
  for b in path {
    if point_on_segment_validated(point, a, b) {
      return Ok(OnBoundary)
    }
    if (a.y > point.y) != (b.y > point.y) {
      let side = cross_validated(a, b, point)
      if (b.y > a.y && side > 0L) || (b.y < a.y && side < 0L) {
        inside = !inside
      }
    }
    a = b
  }
  Ok(if inside { Inside } else { Outside })
}
