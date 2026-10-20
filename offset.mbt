// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Normal, corner and arc formulas adapted from Clipper2 2.0.1,
// Copyright (c) Angus Johnson 2010-2025. Container and budget plumbing is MoonClip.

///|
pub(all) enum JoinType {
  Miter
  Bevel
  Square
  Round
} derive(Eq, Debug)

///|
pub struct OffsetOptions {
  join : JoinType
  miter_limit : Double
  arc_tolerance : Double
} derive(Eq, Debug)

///|
pub fn OffsetOptions::new(
  join? : JoinType = Miter,
  miter_limit? : Double = 2.0,
  arc_tolerance? : Double = 0.0,
) -> OffsetOptions {
  { join, miter_limit, arc_tolerance, }
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
  budget_spend(budget, nodes, work, location(budget.generate_stage, None, None))
}

///|
fn offset_finite(
  value : Double,
  stage? : Stage = OffsetGenerate,
) -> Double raise ScanAbort {
  if value.is_nan() || value.is_inf() {
    raise ScanAbort(
      NumericFailure(
        location(stage, None, None),
        "Non-finite offset intermediate",
      ),
    )
  }
  value
}

///|
// std::round semantics, deliberately separate from scan ties-to-even projection.
fn offset_coordinate(
  value : Double,
  axis : Axis,
  stage? : Stage = OffsetGenerate,
) -> Int64 raise ScanAbort {
  let value = offset_finite(value, stage~)
  let loc = location(stage, None, None)
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
  let x = offset_coordinate(x, X, stage=budget.generate_stage)
  let y = offset_coordinate(y, Y, stage=budget.generate_stage)
  offset_spend(budget, 1, 1)
  path.push(Point64::new(x, y))
}

///|
fn offset_unit(
  a : Point64,
  b : Point64,
  stage? : Stage = OffsetGenerate,
) -> OffsetVector raise ScanAbort {
  let dx = (b.x - a.x).to_double()
  let dy = (b.y - a.y).to_double()
  if dx == 0.0 && dy == 0.0 {
    return { x: 0.0, y: 0.0, }
  }
  let inverse = offset_finite(1.0 / (dx * dx + dy * dy).sqrt(), stage~)
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
  let q = offset_finite(delta / (cosine + 1.0), stage=budget.generate_stage)
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
  stage? : Stage = OffsetGenerate,
) -> OffsetVector raise ScanAbort {
  let dx1 = b.x - a.x
  let dy1 = b.y - a.y
  let dx2 = d.x - c.x
  let dy2 = d.y - c.y
  let determinant = offset_finite(dy1 * dx2 - dy2 * dx1, stage~)
  if determinant == 0.0 {
    return fallback
  }
  let t = offset_finite(
    ((a.x - c.x) * dy2 - (a.y - c.y) * dx2) / determinant,
    stage~,
  )
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
  is_cap? : Bool = false,
) -> Unit raise ScanAbort {
  let vx = -a.y + b.y
  let vy = a.x - b.x
  let h = (vx * vx + vy * vy).sqrt()
  let v : OffsetVector = if is_cap {
    { x: b.y, y: -b.x, }
  } else if h.abs() < 0.001 {
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
  let fourth : OffsetVector = if is_cap {
    { x: third.x + v.x * delta, y: third.y + v.y * delta, }
  } else {
    { x: p.x.to_double() + a.x * delta, y: p.y.to_double() + a.y * delta, }
  }
  let ip = offset_intersect(
    first,
    second,
    third,
    fourth,
    q,
    stage=budget.generate_stage,
  )
  if is_cap {
    offset_push(path, q.x + (q.x - ip.x), q.y + (q.y - ip.y), budget)
    offset_push(path, ip.x, ip.y, budget)
  } else {
    offset_push(path, ip.x, ip.y, budget)
    offset_push(path, q.x + (q.x - ip.x), q.y + (q.y - ip.y), budget)
  }
}

///|
priv struct OffsetArc {
  step_sin : Double
  step_cos : Double
  steps_per_rad : Double
}

///|
// Fixed Clipper2 automatic tolerance, radius cap and global rotation step.
fn offset_arc_parameters(
  delta : Double,
  tolerance : Double,
  stage? : Stage = OffsetGenerate,
) -> OffsetArc raise ScanAbort {
  let radius = offset_finite(delta.abs(), stage~)
  if radius < 0.5 {
    raise ScanAbort(
      NumericFailure(
        location(stage, None, None),
        "Arc parameters require radius at least 0.5",
      ),
    )
  }
  let effective = if tolerance > 1.0e-12 {
    if tolerance < radius {
      tolerance
    } else {
      radius
    }
  } else {
    radius * 0.002
  }
  let cap = offset_finite(radius * @math.PI, stage~)
  let argument = 1.0 - effective / radius
  // With sub-ULP tolerance acos(1)==0: source min(+Infinity, cap) selects cap.
  // Express that branch explicitly, without creating a non-finite intermediate.
  let steps = if argument == 1.0 {
    cap
  } else {
    let requested = offset_finite(@math.PI / @math.acos(argument), stage~)
    if requested < cap {
      requested
    } else {
      cap
    }
  }
  let step = offset_finite(2.0 * @math.PI / steps, stage~)
  let sine = offset_finite(@math.sin(step), stage~)
  {
    step_sin: if delta < 0.0 {
      -sine
    } else {
      sine
    },
    step_cos: offset_finite(@math.cos(step), stage~),
    steps_per_rad: steps / (2.0 * @math.PI),
  }
}

///|
// No charge here: offset_push charges every attempted sample, even equal grid points.
// Preflight the complete corner before any point allocation or integer conversion.
fn offset_arc_steps(
  arc : OffsetArc,
  angle : Double,
  budget : CallBudget,
) -> Int raise ScanAbort {
  let steps = offset_finite(
    @double.ceil(
      arc.steps_per_rad *
      offset_finite(angle, stage=budget.generate_stage).abs(),
    ),
    stage=budget.generate_stage,
  )
  if steps < 0.0 {
    raise ScanAbort(
      NumericFailure(
        location(budget.generate_stage, None, None),
        "Negative arc step count",
      ),
    )
  }
  let points = if steps < 1.0 { 2.0 } else { steps + 1.0 }
  let loc = location(budget.generate_stage, None, None)
  if points > (budget.limits.max_nodes - budget.stats.nodes).to_double() {
    raise ScanAbort(
      ResourceLimitExceeded(loc, InternalNodes, budget.limits.max_nodes),
    )
  }
  if points > (budget.limits.max_work - budget.stats.work).to_double() {
    raise ScanAbort(
      ResourceLimitExceeded(loc, ScanWork, budget.limits.max_work),
    )
  }
  if steps > 2147483646.0 {
    raise ScanAbort(
      NumericFailure(loc, "Arc step count cannot be represented as Int"),
    )
  }
  steps.to_int()
}

///|
fn offset_round(
  path : Path64,
  p : Point64,
  a : OffsetVector,
  b : OffsetVector,
  delta : Double,
  angle : Double,
  arc : OffsetArc,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  let steps = offset_arc_steps(arc, angle, budget)
  let mut x = a.x * delta
  let mut y = a.y * delta
  offset_push(path, p.x.to_double() + x, p.y.to_double() + y, budget)
  for i = 1; i < steps; i = i + 1 {
    // Both components use the old vector, exactly as PointD's source constructor.
    let next_x = x * arc.step_cos - arc.step_sin * y
    y = x * arc.step_sin + y * arc.step_cos
    x = next_x
    offset_push(path, p.x.to_double() + x, p.y.to_double() + y, budget)
  }
  // Direct endpoint; do not accumulate rotations into the terminal normal.
  offset_push(
    path,
    p.x.to_double() + b.x * delta,
    p.y.to_double() + b.y * delta,
    budget,
  )
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
  arc? : OffsetArc,
) -> Unit raise ScanAbort {
  offset_spend(budget, 0, 1)
  let raw_sine = offset_finite(
    b.y * a.x - a.y * b.x,
    stage=budget.generate_stage,
  )
  let sine = if raw_sine < -1.0 {
    -1.0
  } else if raw_sine > 1.0 {
    1.0
  } else {
    raw_sine
  }
  let cosine = offset_finite(b.x * a.x + b.y * a.y, stage=budget.generate_stage)
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
  } else if cosine > 0.999 && options.join != Round {
    offset_miter(path, p, a, b, delta, cosine, budget)
  } else {
    match options.join {
      Square => offset_square(path, p, previous, a, b, delta, budget)
      Round => {
        let arc = match arc {
          Some(value) => value
          None =>
            offset_arc_parameters(
              delta,
              options.arc_tolerance,
              stage=budget.generate_stage,
            )
        }
        offset_round(
          path,
          p,
          a,
          b,
          delta,
          offset_finite(@math.atan2(sine, cosine), stage=budget.generate_stage),
          arc,
          budget,
        )
      }
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
    Miter =>
      2.0 /
      offset_finite(
        options.miter_limit * options.miter_limit,
        stage=budget.generate_stage,
      )
    Bevel | Square | Round => 0.0
  }
  let arc = if options.join == Round {
    Some(
      offset_arc_parameters(
        delta,
        options.arc_tolerance,
        stage=budget.generate_stage,
      ),
    )
  } else {
    None
  }
  offset_spend(budget, 1, 1)
  offset_spend(budget, paths.length(), paths.length())
  let result : Paths64 = []
  for path in paths {
    offset_spend(budget, path.length() + 2, path.length())
    let normals = Array::makei(path.length(), fn(i) raise ScanAbort {
      offset_unit(
        path[i],
        path[(i + 1) % path.length()],
        stage=budget.generate_stage,
      )
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
        arc?,
      )
    }
    result.push(output)
  }
  result
}

///|
fn offset_options_error(options : OffsetOptions, stage : Stage) -> ClipError? {
  let loc = location(stage, None, None)
  if options.miter_limit.is_nan() ||
    options.miter_limit.is_inf() ||
    options.miter_limit < 2.0 {
    return Some(InvalidInput(loc, "Miter limit must be finite and at least 2"))
  }
  if options.arc_tolerance.is_nan() ||
    options.arc_tolerance.is_inf() ||
    options.arc_tolerance < 0.0 {
    return Some(
      InvalidInput(loc, "Arc tolerance must be finite and non-negative"),
    )
  }
  None
}

///|
// Only the result extraction differs between flat and tree outputs. The empty
// callback reuses the normalization result for flat output without extra fees.
fn[T] offset_compute(
  paths : Paths64,
  delta : Double,
  fill_rule : FillRule,
  options : OffsetOptions,
  limits : ScanLimits,
  extract : (ScanState) -> T raise ScanAbort,
  empty : (Paths64, CallBudget) -> T raise ScanAbort,
  budget? : CallBudget,
) -> Result[T, ClipError] {
  let loc = location(OffsetParameters, None, None)
  if delta.is_nan() || delta.is_inf() {
    return Err(InvalidInput(loc, "Offset delta must be finite"))
  }
  if offset_options_error(options, OffsetParameters) is Some(error) {
    return Err(error)
  }
  let budget = match budget {
    Some(value) => value
    None => new_call_budget(limits)
  }
  let limits = budget.limits
  let rule = match fill_rule {
    EvenOdd => Parity
    NonZero => SignedNonZero
  }
  // A small distance still normalizes all operands. Extract the final tree
  // here, while this scan owns cleanup; no second scan or flat snapshot.
  if delta.abs() < 0.5 {
    return boolean_compute(paths, [], Union, limits, rule, extract, budget~)
  }
  let normalized = match
    boolean_compute(
      paths,
      [],
      Union,
      limits,
      rule,
      fn(state) raise ScanAbort {
        output_extract(state, preserve_collinear=false)
      },
      budget~,
    ) {
    Ok(value) => value
    Err(error) => return Err(error)
  }
  // Normalization already produced independent, positive outer / negative hole rings.
  if normalized.is_empty() {
    return Ok(empty(normalized, budget)) catch {
      ScanAbort(error) => Err(error)
    }
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
    extract,
    budget~,
    internal_input=true,
  )
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
  offset_compute(
    paths,
    delta,
    fill_rule,
    options,
    limits,
    fn(state) raise ScanAbort {
      output_extract(state, preserve_collinear=false)
    },
    fn(paths, _) { paths },
    budget?,
  )
}

///|
fn offset_tree_execute(
  paths : Paths64,
  delta : Double,
  fill_rule : FillRule,
  options : OffsetOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PolyTree64, ClipError] {
  offset_compute(
    paths,
    delta,
    fill_rule,
    options,
    limits,
    tree_build,
    fn(_, budget) raise ScanAbort { tree_empty(budget) },
    budget?,
  )
}

///|
/// Final offset region with geometric parentage. Introduced in 0.2.0.
pub fn offset_tree(
  paths : Paths64,
  delta : Double,
  fill_rule? : FillRule = NonZero,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PolyTree64, ClipError] {
  offset_tree_execute(paths, delta, fill_rule, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
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
