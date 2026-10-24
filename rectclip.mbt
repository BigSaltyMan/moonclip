// Copyright (c) Angus Johnson 2010-2025. BSL-1.0; see LICENSE.
// RectClipLines64, GetLocation/GetNextLocation/GetIntersection and
// GetSegmentIntersection adapted from Clipper2 2.0.1 / 21ebba05db8894f0c7217ad35ea518080f324946.
// Checked containers and cumulative budgets: Copyright (c) 2026 BigSaltyMan.

///|
// Location order matches upstream: Left, Top(min_y), Right, Bottom(max_y), Inside.
fn rect_location(r : Bounds64, p : Point64) -> (Int, Bool) {
  if p.x == r.min_x && p.y >= r.min_y && p.y <= r.max_y {
    (0, false)
  } else if p.x == r.max_x && p.y >= r.min_y && p.y <= r.max_y {
    (2, false)
  } else if p.y == r.min_y && p.x >= r.min_x && p.x <= r.max_x {
    (1, false)
  } else if p.y == r.max_y && p.x >= r.min_x && p.x <= r.max_x {
    (3, false)
  } else if p.x < r.min_x {
    (0, true)
  } else if p.x > r.max_x {
    (2, true)
  } else if p.y < r.min_y {
    (1, true)
  } else if p.y > r.max_y {
    (3, true)
  } else {
    (4, true)
  }
}

///|
fn rect_add(
  pieces : Paths64,
  p : Point64,
  fresh : Bool,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  let loc = location(RectClipOutput, None, None)
  budget_spend(budget, 0, 1, loc)
  if fresh || pieces.is_empty() {
    // Path container, result slot and its first point slot; Point64 is immutable.
    budget_spend(budget, 3, 1, loc)
    pieces.push([p])
  } else {
    let last = pieces[pieces.length() - 1]
    if last[last.length() - 1] != p {
      budget_spend(budget, 1, 1, loc)
      last.push(p)
    }
  }
}

///|
fn rect_segment(
  a : Point64,
  b : Point64,
  c : Point64,
  d : Point64,
  budget : CallBudget,
  loc : ErrorLocation,
) -> Point64? raise ScanAbort {
  budget_spend(budget, 0, 1, loc)
  let r1 = cross_validated(a, c, d)
  let r2 = cross_validated(b, c, d)
  if r1 == 0L {
    if r2 == 0L {
      return None
    }
    return if a == c ||
      a == d ||
      (if c.y == d.y {
        (a.x > c.x) == (a.x < d.x)
      } else {
        (a.y > c.y) == (a.y < d.y)
      }) {
      Some(a)
    } else {
      None
    }
  }
  if r2 == 0L {
    return if b == c ||
      b == d ||
      (if c.y == d.y {
        (b.x > c.x) == (b.x < d.x)
      } else {
        (b.y > c.y) == (b.y < d.y)
      }) {
      Some(b)
    } else {
      None
    }
  }
  if (r1 > 0L) == (r2 > 0L) {
    return None
  }
  let r3 = cross_validated(c, a, b)
  let r4 = cross_validated(d, a, b)
  if r3 == 0L {
    return if c == a ||
      c == b ||
      (if a.y == b.y {
        (c.x > a.x) == (c.x < b.x)
      } else {
        (c.y > a.y) == (c.y < b.y)
      }) {
      Some(c)
    } else {
      None
    }
  }
  if r4 == 0L {
    return if d == a ||
      d == b ||
      (if a.y == b.y {
        (d.x > a.x) == (d.x < b.x)
      } else {
        (d.y > a.y) == (d.y < b.y)
      }) {
      Some(d)
    } else {
      None
    }
  }
  if (r3 > 0L) == (r4 > 0L) {
    return None
  }
  budget_spend(budget, 0, 1, loc)
  let dx1 = (b.x - a.x).to_double()
  let dy1 = (b.y - a.y).to_double()
  let dx2 = (d.x - c.x).to_double()
  let dy2 = (d.y - c.y).to_double()
  let det = dy1 * dx2 - dy2 * dx1
  if det == 0.0 {
    return None
  }
  let t = ((a.x - c.x).to_double() * dy2 - (a.y - c.y).to_double() * dx2) / det
  if t <= 0.0 {
    return Some(a)
  }
  if t >= 1.0 {
    return Some(b)
  }
  // Same arithmetic order and truncation as CLIPPER2_HI_PRECISION=0.
  // Do not snap to a rectangle side or reuse half-away-from-zero projection.
  budget_spend(budget, 1, 1, loc)
  Some(
    Point64::new(
      (a.x.to_double() + t * dx1).to_int64(),
      (a.y.to_double() + t * dy1).to_int64(),
    ),
  )
}

///|
fn rect_intersect(
  corners : Path64,
  a : Point64,
  b : Point64,
  side : Int,
  budget : CallBudget,
  loc : ErrorLocation,
) -> Point64? raise ScanAbort {
  // Try the nearest side first. This priority is part of the upstream contract.
  if side == 4 {
    if rect_segment(a, b, corners[0], corners[3], budget, loc) is Some(p) {
      return Some(p)
    }
    if rect_segment(a, b, corners[0], corners[1], budget, loc) is Some(p) {
      return Some(p)
    }
    if rect_segment(a, b, corners[1], corners[2], budget, loc) is Some(p) {
      return Some(p)
    }
    return rect_segment(a, b, corners[2], corners[3], budget, loc)
  }
  let (u, v) = match side {
    0 => (0, 3)
    1 => (0, 1)
    2 => (1, 2)
    _ => (2, 3)
  }
  if rect_segment(a, b, corners[u], corners[v], budget, loc) is Some(p) {
    return Some(p)
  }
  if side == 0 || side == 2 {
    if a.y < corners[0].y {
      if rect_segment(a, b, corners[0], corners[1], budget, loc) is Some(p) {
        return Some(p)
      }
    }
    return rect_segment(a, b, corners[2], corners[3], budget, loc)
  }
  if side == 1 || side == 3 {
    if a.x < corners[0].x {
      if rect_segment(a, b, corners[0], corners[3], budget, loc) is Some(p) {
        return Some(p)
      }
    }
    return rect_segment(a, b, corners[1], corners[2], budget, loc)
  }
  None
}

///|
fn rect_next(
  r : Bounds64,
  path : Path64,
  pieces : Paths64,
  side : Int,
  start : Int,
  pi : Int,
  budget : CallBudget,
) -> (Int, Int) raise ScanAbort {
  let mut i = start
  while i < path.length() {
    budget_spend(budget, 0, 1, location(RectClipEvaluate, Some(pi), Some(i)))
    let p = path[i]
    if side == 4 {
      if p.x < r.min_x {
        return (0, i)
      }
      if p.x > r.max_x {
        return (2, i)
      }
      if p.y > r.max_y {
        return (3, i)
      }
      if p.y < r.min_y {
        return (1, i)
      }
      rect_add(pieces, p, false, budget)
      i += 1
      continue
    }
    let skip = match side {
      0 => p.x <= r.min_x
      1 => p.y <= r.min_y
      2 => p.x >= r.max_x
      _ => p.y >= r.max_y
    }
    if skip {
      i += 1
      continue
    }
    let next = match side {
      0 =>
        if p.x >= r.max_x {
          2
        } else if p.y <= r.min_y {
          1
        } else if p.y >= r.max_y {
          3
        } else {
          4
        }
      1 =>
        if p.y >= r.max_y {
          3
        } else if p.x <= r.min_x {
          0
        } else if p.x >= r.max_x {
          2
        } else {
          4
        }
      2 =>
        if p.x <= r.min_x {
          0
        } else if p.y <= r.min_y {
          1
        } else if p.y >= r.max_y {
          3
        } else {
          4
        }
      _ =>
        if p.y <= r.min_y {
          1
        } else if p.x <= r.min_x {
          0
        } else if p.x >= r.max_x {
          2
        } else {
          4
        }
    }
    return (next, i)
  }
  (side, i)
}

///|
fn rect_path(
  r : Bounds64,
  corners : Path64,
  path : Path64,
  pi : Int,
  budget : CallBudget,
) -> Paths64 raise ScanAbort {
  budget_spend(budget, 1, 1, location(RectClipOutput, None, None))
  let pieces : Paths64 = []
  if path.length() < 2 {
    return pieces
  }
  budget_spend(budget, 0, 1, location(RectClipEvaluate, Some(pi), Some(0)))
  let (initial, ordinary) = rect_location(r, path[0])
  let mut side = initial
  if !ordinary {
    let mut k = 1
    let mut next = 4
    while k < path.length() {
      budget_spend(budget, 0, 1, location(RectClipEvaluate, Some(pi), Some(k)))
      let (s, plain) = rect_location(r, path[k])
      next = s
      if plain {
        break
      }
      k += 1
    }
    if k == path.length() {
      for j = 0; j < path.length(); j = j + 1 {
        budget_spend(
          budget,
          0,
          1,
          location(RectClipEvaluate, Some(pi), Some(j)),
        )
        rect_add(pieces, path[j], false, budget)
      }
      return pieces
    }
    if next == 4 {
      side = 4
    }
  }
  if side == 4 {
    rect_add(pieces, path[0], false, budget)
  }
  let mut i = 1
  while i < path.length() {
    let previous = side
    let (next, index) = rect_next(r, path, pieces, side, i, pi, budget)
    side = next
    i = index
    if i == path.length() {
      break
    }
    let loc = location(RectClipEvaluate, Some(pi), Some(i))
    budget_spend(budget, 0, 1, loc)
    let p = path[i]
    let prev = path[i - 1]
    let ip = rect_intersect(corners, p, prev, side, budget, loc)
    match ip {
      None => i += 1
      Some(exit) =>
        if side == 4 {
          rect_add(pieces, exit, true, budget)
        } else if previous != 4 {
          guard rect_intersect(corners, prev, p, previous, budget, loc)
            is Some(entry) else {
            raise ScanAbort(NumericFailure(loc, "Missing entry intersection"))
          }
          rect_add(pieces, entry, true, budget)
          rect_add(pieces, exit, false, budget)
        } else {
          rect_add(pieces, exit, false, budget)
        }
    }
  }
  pieces
}

///|
fn rect_clip_execute(
  rect : Bounds64,
  paths : Paths64,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Paths64, ClipError] {
  let budget = match budget {
    Some(b) => b
    None =>
      new_call_budget(
        limits,
        generate_stage=RectClipEvaluate,
        cleanup_stage=RectClipOutput,
      )
  }
  let loc = location(RectClipParameters, None, None)
  if rect.min_x < -COORDINATE_LIMIT || rect.min_x > COORDINATE_LIMIT {
    return Err(CoordinateOutOfRange(loc, X, rect.min_x))
  }
  if rect.min_y < -COORDINATE_LIMIT || rect.min_y > COORDINATE_LIMIT {
    return Err(CoordinateOutOfRange(loc, Y, rect.min_y))
  }
  if rect.max_x < -COORDINATE_LIMIT || rect.max_x > COORDINATE_LIMIT {
    return Err(CoordinateOutOfRange(loc, X, rect.max_x))
  }
  if rect.max_y < -COORDINATE_LIMIT || rect.max_y > COORDINATE_LIMIT {
    return Err(CoordinateOutOfRange(loc, Y, rect.max_y))
  }
  if rect.min_x > rect.max_x || rect.min_y > rect.max_y {
    return Err(InvalidInput(loc, "Rectangle minimum exceeds maximum"))
  }
  let work = match
    scan_check_inputs(
      paths,
      [],
      budget.limits,
      spent_work=budget.stats.work,
      raw_stage=RectClipParameters,
    ) {
    Ok(n) => n
    Err(e) => return Err(e)
  }
  try {
    budget_spend(budget, 0, work, loc)
    budget_spend(budget, 1, 1, location(RectClipOutput, None, None))
    let result : Paths64 = []
    if paths.is_empty() || rect.min_x == rect.max_x || rect.min_y == rect.max_y {
      return Ok(result)
    }
    budget_spend(budget, 9, 4, location(RectClipEvaluate, None, None))
    let corners = [
      Point64::new(rect.min_x, rect.min_y),
      Point64::new(rect.max_x, rect.min_y),
      Point64::new(rect.max_x, rect.max_y),
      Point64::new(rect.min_x, rect.max_y),
    ]
    for pi = 0; pi < paths.length(); pi = pi + 1 {
      for piece in rect_path(rect, corners, paths[pi], pi, budget) {
        budget_spend(budget, 0, 1, location(RectClipOutput, None, None))
        if piece.length() >= 2 {
          budget_spend(budget, 1, 1, location(RectClipOutput, None, None))
          result.push(piece)
        }
      }
    }
    Ok(result)
  } catch {
    ScanAbort(e) => Err(e)
  }
}

///|
/// Clip open integer routes to an axis-aligned window. Preserves fragment order,
/// direction and collinear vertices; no implicit closing edge or fill semantics.
/// Since 0.3.0. Intersections follow the pinned low-precision C++ truncation rule.
pub fn rect_clip_lines(
  rect : Bounds64,
  paths : Paths64,
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  rect_clip_execute(rect, paths, { ..Default::default(), input: limits, })
}
