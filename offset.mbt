// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Normal, corner and Square fallback formulas adapted from Clipper2 2.0.1,
// Copyright (c) Angus Johnson 2010-2025. Container and budget plumbing is MoonClip.

///|
pub(all) enum JoinType {
  Miter
  Bevel
} derive(Eq, Debug)

///|
pub struct OffsetOptions {
  join : JoinType
  miter_limit : Double
} derive(Eq, Debug)

///|
pub fn OffsetOptions::new(
  join? : JoinType = Miter,
  miter_limit? : Double = 2.0,
) -> OffsetOptions {
  { join, miter_limit, }
}

///|
pub impl Default for OffsetOptions with fn default() {
  OffsetOptions::new()
}

///|
priv struct OffsetVector {
  x : Double
  y : Double
}

///|
fn offset_spend(
  budget : CallBudget,
  nodes : Int,
  work : Int,
) -> Unit raise ScanAbort {
  let loc = location(OffsetGenerate, None, None)
  if nodes > budget.limits.max_nodes - budget.stats.nodes {
    raise ScanAbort(
      ResourceLimitExceeded(loc, InternalNodes, budget.limits.max_nodes),
    )
  }
  if work > budget.limits.max_work - budget.stats.work {
    raise ScanAbort(
      ResourceLimitExceeded(loc, ScanWork, budget.limits.max_work),
    )
  }
  budget.stats.nodes += nodes
  budget.stats.work += work
}

///|
fn offset_finite(value : Double) -> Double raise ScanAbort {
  if value.is_nan() || value.is_inf() {
    raise ScanAbort(
      NumericFailure(
        location(OffsetGenerate, None, None),
        "Non-finite offset intermediate",
      ),
    )
  }
  value
}

///|
// std::round semantics, deliberately separate from scan ties-to-even projection.
fn offset_coordinate(value : Double, axis : Axis) -> Int64 raise ScanAbort {
  let value = offset_finite(value)
  let loc = location(OffsetGenerate, None, None)
  // Check before conversion; this strict interior of Int64 also handles huge finite delta.
  if value < -9.0e18 || value > 9.0e18 {
    raise ScanAbort(
      NumericFailure(loc, "Offset coordinate cannot be represented as Int64"),
    )
  }
  let rounded = if value < 0.0 {
    @double.ceil(value - 0.5)
  } else {
    @double.floor(value + 0.5)
  }
  let coordinate = rounded.to_int64()
  if coordinate < -COORDINATE_LIMIT || coordinate > COORDINATE_LIMIT {
    raise ScanAbort(CoordinateOutOfRange(loc, axis, coordinate))
  }
  coordinate
}

///|
fn offset_push(
  path : Path64,
  x : Double,
  y : Double,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  let x = offset_coordinate(x, X)
  let y = offset_coordinate(y, Y)
  offset_spend(budget, 1, 1)
  path.push(Point64::new(x, y))
}

///|
fn offset_unit(a : Point64, b : Point64) -> OffsetVector raise ScanAbort {
  let dx = (b.x - a.x).to_double()
  let dy = (b.y - a.y).to_double()
  if dx == 0.0 && dy == 0.0 {
    return { x: 0.0, y: 0.0, }
  }
  let inverse = offset_finite(1.0 / (dx * dx + dy * dy).sqrt())
  { x: dy * inverse, y: -(dx * inverse), }
}

///|
fn offset_miter(
  path : Path64,
  p : Point64,
  a : OffsetVector,
  b : OffsetVector,
  delta : Double,
  cosine : Double,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  let q = offset_finite(delta / (cosine + 1.0))
  offset_push(
    path,
    p.x.to_double() + (a.x + b.x) * q,
    p.y.to_double() + (a.y + b.y) * q,
    budget,
  )
}

///|
// Source's segment-clamped line intersection, including its parallel fallback.
fn offset_intersect(
  a : OffsetVector,
  b : OffsetVector,
  c : OffsetVector,
  d : OffsetVector,
  fallback : OffsetVector,
) -> OffsetVector raise ScanAbort {
  let dx1 = b.x - a.x
  let dy1 = b.y - a.y
  let dx2 = d.x - c.x
  let dy2 = d.y - c.y
  let determinant = offset_finite(dy1 * dx2 - dy2 * dx1)
  if determinant == 0.0 {
    return fallback
  }
  let t = offset_finite(((a.x - c.x) * dy2 - (a.y - c.y) * dx2) / determinant)
  if t <= 0.0 {
    a
  } else if t >= 1.0 {
    b
  } else {
    { x: a.x + t * dx1, y: a.y + t * dy1, }
  }
}

///|
fn offset_square(
  path : Path64,
  p : Point64,
  previous : Point64,
  a : OffsetVector,
  b : OffsetVector,
  delta : Double,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  let vx = -a.y + b.y
  let vy = a.x - b.x
  let h = (vx * vx + vy * vy).sqrt()
  let v : OffsetVector = if h.abs() < 0.001 {
    { x: 0.0, y: 0.0, }
  } else {
    let inverse = 1.0 / h
    { x: vx * inverse, y: vy * inverse, }
  }
  let q : OffsetVector = {
    x: p.x.to_double() + delta.abs() * v.x,
    y: p.y.to_double() + delta.abs() * v.y,
  }
  let first : OffsetVector = { x: q.x + delta * v.y, y: q.y + delta * -v.x, }
  let second : OffsetVector = { x: q.x + delta * -v.y, y: q.y + delta * v.x, }
  let third : OffsetVector = {
    x: previous.x.to_double() + a.x * delta,
    y: previous.y.to_double() + a.y * delta,
  }
  let fourth : OffsetVector = {
    x: p.x.to_double() + a.x * delta,
    y: p.y.to_double() + a.y * delta,
  }
  let ip = offset_intersect(first, second, third, fourth, q)
  offset_push(path, ip.x, ip.y, budget)
  offset_push(path, q.x + (q.x - ip.x), q.y + (q.y - ip.y), budget)
}

///|
fn offset_corner(
  path : Path64,
  p : Point64,
  previous : Point64,
  a : OffsetVector,
  b : OffsetVector,
  delta : Double,
  options : OffsetOptions,
  threshold : Double,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  offset_spend(budget, 0, 1)
  let raw_sine = offset_finite(b.y * a.x - a.y * b.x)
  let sine = if raw_sine < -1.0 {
    -1.0
  } else if raw_sine > 1.0 {
    1.0
  } else {
    raw_sine
  }
  let cosine = offset_finite(b.x * a.x + b.y * a.y)
  if cosine > -0.999 && sine * delta < 0.0 {
    offset_push(
      path,
      p.x.to_double() + a.x * delta,
      p.y.to_double() + a.y * delta,
      budget,
    )
    offset_push(path, p.x.to_double(), p.y.to_double(), budget)
    offset_push(
      path,
      p.x.to_double() + b.x * delta,
      p.y.to_double() + b.y * delta,
      budget,
    )
  } else if cosine > 0.999 {
    offset_miter(path, p, a, b, delta, cosine, budget)
  } else {
    match options.join {
      Miter =>
        if cosine > threshold - 1.0 {
          offset_miter(path, p, a, b, delta, cosine, budget)
        } else {
          offset_square(path, p, previous, a, b, delta, budget)
        }
      Bevel => {
        offset_push(
          path,
          p.x.to_double() + delta * a.x,
          p.y.to_double() + delta * a.y,
          budget,
        )
        offset_push(
          path,
          p.x.to_double() + delta * b.x,
          p.y.to_double() + delta * b.y,
          budget,
        )
      }
    }
  }
}

///|
fn offset_generate(
  paths : Paths64,
  delta : Double,
  options : OffsetOptions,
  budget : CallBudget,
) -> Paths64 raise ScanAbort {
  let threshold = match options.join {
    Miter => 2.0 / offset_finite(options.miter_limit * options.miter_limit)
    Bevel => 0.0
  }
  offset_spend(budget, 1, 1)
  offset_spend(budget, paths.length(), paths.length())
  let result : Paths64 = []
  for path in paths {
    offset_spend(budget, path.length(), path.length())
    let normals = Array::makei(path.length(), fn(i) raise ScanAbort {
      offset_unit(path[i], path[(i + 1) % path.length()])
    })
    let output : Path64 = []
    for j = 0; j < path.length(); j = j + 1 {
      let k = (j + path.length() - 1) % path.length()
      offset_corner(
        output,
        path[j],
        path[k],
        normals[k],
        normals[j],
        delta,
        options,
        threshold,
        budget,
      )
    }
    result.push(output)
  }
  result
}

///|
fn offset_execute(
  paths : Paths64,
  delta : Double,
  fill_rule : FillRule,
  options : OffsetOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Paths64, ClipError] {
  let loc = location(OffsetParameters, None, None)
  if delta.is_nan() || delta.is_inf() {
    return Err(InvalidInput(loc, "Offset delta must be finite"))
  }
  if options.miter_limit.is_nan() ||
    options.miter_limit.is_inf() ||
    options.miter_limit < 2.0 {
    return Err(InvalidInput(loc, "Miter limit must be finite and at least 2"))
  }
  let budget = match budget {
    Some(value) => value
    None => new_call_budget(limits)
  }
  let normalized = match
    boolean_compute(
      paths,
      [],
      Union,
      limits,
      match fill_rule {
        EvenOdd => Parity
        NonZero => SignedNonZero
      },
      fn(state) raise ScanAbort {
        output_extract(state, preserve_collinear=false)
      },
      budget~,
    ) {
    Ok(value) => value
    Err(error) => return Err(error)
  }
  // Normalization already produced independent, positive outer / negative hole rings.
  if delta.abs() < 0.5 || normalized.is_empty() {
    return Ok(normalized)
  }
  let generated = offset_generate(normalized, delta, options, budget) catch {
    ScanAbort(error) => return Err(error)
  }
  boolean_compute(
    generated,
    [],
    Union,
    limits,
    Positive,
    fn(state) raise ScanAbort {
      output_extract(state, preserve_collinear=false)
    },
    budget~,
    internal_input=true,
  )
}

///|
/// Closed filled-region offset. Normalize all inputs together before offsetting.
/// NonZero by default; positive delta expands outers and shrinks holes.
pub fn offset_polygons(
  paths : Paths64,
  delta : Double,
  fill_rule? : FillRule = NonZero,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  offset_execute(paths, delta, fill_rule, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}
