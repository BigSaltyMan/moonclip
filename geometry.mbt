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
  cross_components(b.x - a.x, b.y - a.y, c.x - a.x, c.y - a.y)
}

///|
/// All components are validated coordinate differences, bounded by +/-2e9.
fn cross_components(ax : Int64, ay : Int64, bx : Int64, by : Int64) -> Int64 {
  ax * by - ay * bx
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

///|
/// Internal grid displacement rounding. Explicit ties-to-even on both targets.
fn scan_round_displacement(value : Double) -> Int64 raise ScanAbort {
  let loc = location(ScanBand, None, None)
  if value.is_nan() ||
    value.is_inf() ||
    value < -2000000001.0 ||
    value > 2000000001.0 {
    raise ScanAbort(
      NumericFailure(loc, "Non-finite or out-of-range scan displacement"),
    )
  }
  let floor_value = @double.floor(value)
  let lower = floor_value.to_int64()
  let fraction = value - floor_value
  let result = if fraction > 0.5 || (fraction == 0.5 && lower % 2L != 0L) {
    lower + 1L
  } else {
    lower
  }
  if result < -2000000000L || result > 2000000000L {
    raise ScanAbort(
      NumericFailure(loc, "Rounded scan displacement is out of range"),
    )
  }
  result
}

// Clipper2-derived projection: Copyright (c) Angus Johnson 2010-2025.
// Distributed under BSL-1.0; see LICENSE.

///|
/// Adapted from fixed Clipper2 TopX. Round the displacement, never bot.x+delta.
/// Coordinates have already passed the integer-core input check.
fn scan_project(
  bot : Point64,
  top : Point64,
  y : Int64,
) -> Int64 raise ScanAbort {
  let loc = location(ScanBand, None, None)
  if bot.y <= top.y || y > bot.y || y < top.y {
    raise ScanAbort(
      InvalidInput(
        loc, "Projection requires a descending nonhorizontal segment and an in-range height",
      ),
    )
  }
  if y == top.y || bot.x == top.x {
    return top.x
  }
  if y == bot.y {
    return bot.x
  }
  let dx = (top.x - bot.x).to_double() / (top.y - bot.y).to_double()
  if dx.is_nan() || dx.is_inf() {
    raise ScanAbort(NumericFailure(loc, "Non-finite scan slope"))
  }
  let displacement = scan_round_displacement(dx * (y - bot.y).to_double())
  if (displacement > 0L && bot.x > 9223372036854775807L - displacement) ||
    (displacement < 0L && bot.x < -9223372036854775808L - displacement) {
    raise ScanAbort(NumericFailure(loc, "Scan projection addition overflow"))
  }
  let result = bot.x + displacement
  if result < -COORDINATE_LIMIT || result > COORDINATE_LIMIT {
    raise ScanAbort(
      NumericFailure(loc, "Scan projection exceeds the coordinate limit"),
    )
  }
  result
}

///|
/// C++ ordinary GetLineIntersectPt branch: truncate final coordinates to zero.
fn intersection_integer(value : Double) -> Int64 raise ScanAbort {
  if value.is_nan() ||
    value.is_inf() ||
    value < -1000000000.0 ||
    value > 1000000000.0 {
    raise ScanAbort(
      NumericFailure(
        location(Intersections, None, None),
        "Intersection coordinate is not finite or in range",
      ),
    )
  }
  value.to_int64()
}

///|
/// Inputs are validated; all differences <=2e9, Double products <=4e18.
/// Deliberately follows the fixed ordinary C++ operation order, not TopX rounding.
fn line_intersection(
  a : Point64,
  b : Point64,
  c : Point64,
  d : Point64,
) -> Point64? raise ScanAbort {
  let dx1 = (b.x - a.x).to_double()
  let dy1 = (b.y - a.y).to_double()
  let dx2 = (d.x - c.x).to_double()
  let dy2 = (d.y - c.y).to_double()
  let det = dy1 * dx2 - dy2 * dx1
  if det == 0.0 {
    return None
  }
  let t = ((a.x - c.x).to_double() * dy2 - (a.y - c.y).to_double() * dx2) / det
  if t.is_nan() || t.is_inf() {
    raise ScanAbort(
      NumericFailure(
        location(Intersections, None, None),
        "Non-finite line parameter",
      ),
    )
  }
  if t <= 0.0 {
    Some(a)
  } else if t >= 1.0 {
    Some(b)
  } else {
    Some(
      Point64::new(
        intersection_integer(a.x.to_double() + t * dx1),
        intersection_integer(a.y.to_double() + t * dy1),
      ),
    )
  }
}

///|
/// Clipper2 GetClosestPointOnSegment: ties-even displacement, not truncation.
fn closest_on_segment(
  p : Point64,
  a : Point64,
  b : Point64,
) -> Point64 raise ScanAbort {
  if a == b {
    return a
  }
  let dx = (b.x - a.x).to_double()
  let dy = (b.y - a.y).to_double()
  let q0 = ((p.x - a.x).to_double() * dx + (p.y - a.y).to_double() * dy) /
    (dx * dx + dy * dy)
  if q0.is_nan() || q0.is_inf() {
    raise ScanAbort(
      NumericFailure(
        location(Intersections, None, None),
        "Non-finite closest-point parameter",
      ),
    )
  }
  let q = if q0 < 0.0 { 0.0 } else if q0 > 1.0 { 1.0 } else { q0 }
  let x = a.x + scan_round_displacement(q * dx)
  let y = a.y + scan_round_displacement(q * dy)
  if x < -COORDINATE_LIMIT ||
    x > COORDINATE_LIMIT ||
    y < -COORDINATE_LIMIT ||
    y > COORDINATE_LIMIT {
    raise ScanAbort(
      NumericFailure(
        location(Intersections, None, None),
        "Closest point is out of range",
      ),
    )
  }
  Point64::new(x, y)
}

///|
/// TopX endpoint look-ahead may extrapolate beyond the other edge's segment.
/// Compare without casting a possibly huge projection (|delta|<=4e18).
fn scan_outgoing_compare(
  bot : Point64,
  top : Point64,
  point : Point64,
) -> Int raise ScanAbort {
  if bot.y == top.y {
    raise ScanAbort(
      InvalidInput(
        location(HorizontalEvents, None, None),
        "Horizontal outgoing comparison",
      ),
    )
  }
  let delta = (top.x - bot.x).to_double() /
    (top.y - bot.y).to_double() *
    (point.y - bot.y).to_double()
  if delta.is_nan() || delta.is_inf() {
    raise ScanAbort(
      NumericFailure(
        location(HorizontalEvents, None, None),
        "Non-finite outgoing projection",
      ),
    )
  }
  if delta > 2000000000.5 {
    return 1
  }
  if delta < -2000000000.5 {
    return -1
  }
  let rounded = scan_round_displacement(delta)
  let x = bot.x + rounded
  if x < point.x {
    -1
  } else if x > point.x {
    1
  } else {
    0
  }
}
