// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Open traversal/caps adapted from Clipper2 2.0.1,
// Copyright (c) Angus Johnson 2010-2025. Checked containers/budgets are MoonClip.

///|
pub(all) enum CapType {
  Butt
  Square
  Round
} derive(Eq, Debug)

///|
fn stroke_cap(
  output : Path64,
  p : Point64,
  normal : OffsetVector,
  radius : Double,
  cap : CapType,
  arc : OffsetArc?,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  offset_spend(budget, 0, 1)
  match cap {
    Butt => {
      offset_push(
        output,
        p.x.to_double() - radius * normal.x,
        p.y.to_double() - radius * normal.y,
        budget,
      )
      offset_push(
        output,
        p.x.to_double() + radius * normal.x,
        p.y.to_double() + radius * normal.y,
        budget,
      )
    }
    Square =>
      offset_square(output, p, p, normal, normal, radius, budget, is_cap=true)
    Round => {
      guard arc is Some(arc) else {
        raise ScanAbort(
          NumericFailure(
            location(StrokeGenerate, None, None),
            "Missing round cap parameters",
          ),
        )
      }
      offset_round(
        output,
        p,
        { x: -normal.x, y: -normal.y, },
        normal,
        radius,
        @math.PI,
        arc,
        budget,
      )
    }
  }
}

///|
fn stroke_prepare(path : Path64, budget : CallBudget) -> Path64 raise ScanAbort {
  let work = match
    scan_check_inputs(
      [path],
      [],
      budget.limits,
      spent_work=budget.stats.work,
      raw_stage=StrokeGenerate,
    ) {
    Ok(work) => work
    Err(error) => raise ScanAbort(error)
  }
  offset_spend(budget, 1, work)
  let output : Path64 = []
  for point in path {
    offset_spend(budget, 0, 1)
    if output.is_empty() || output[output.length() - 1] != point {
      offset_spend(budget, 1, 1)
      output.push(point)
    }
  }
  output
}

///|
fn stroke_generate(
  path : Path64,
  radius : Double,
  cap : CapType,
  options : OffsetOptions,
  budget : CallBudget,
) -> Paths64 raise ScanAbort {
  let n = path.length()
  let threshold = if n > 2 && options.join == Miter {
    2.0 /
    offset_finite(
      options.miter_limit * options.miter_limit,
      stage=budget.generate_stage,
    )
  } else {
    0.0
  }
  let arc = if cap == Round || (n > 2 && options.join == Round) {
    Some(
      offset_arc_parameters(
        radius,
        options.arc_tolerance,
        stage=budget.generate_stage,
      ),
    )
  } else {
    None
  }
  offset_spend(budget, n, n)
  let normals : Array[OffsetVector] = Array::makei(n, fn(i) raise ScanAbort {
    if i == n - 1 {
      { x: 0.0, y: 0.0, }
    } else {
      offset_unit(path[i], path[i + 1], stage=budget.generate_stage)
    }
  })
  offset_spend(budget, 2, 1)
  let output : Path64 = []
  stroke_cap(output, path[0], normals[0], radius, cap, arc, budget)
  for j = 1; j < n - 1; j = j + 1 {
    offset_corner(
      output,
      path[j],
      path[j - 1],
      normals[j - 1],
      normals[j],
      radius,
      options,
      threshold,
      budget,
      arc?,
    )
  }
  // Reverse each directed edge normal without reversing or closing the route.
  for i = n - 1; i > 0; i = i - 1 {
    offset_spend(budget, 0, 1)
    normals[i] = { x: -normals[i - 1].x, y: -normals[i - 1].y, }
  }
  normals[0] = normals[n - 1]
  stroke_cap(output, path[n - 1], normals[n - 1], radius, cap, arc, budget)
  for j = n - 2; j > 0; j = j - 1 {
    offset_corner(
      output,
      path[j],
      path[j + 1],
      normals[j + 1],
      normals[j],
      radius,
      options,
      threshold,
      budget,
      arc?,
    )
  }
  [output]
}

///|
fn stroke_execute(
  path : Path64,
  width : Double,
  cap : CapType,
  options : OffsetOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Paths64, ClipError] {
  if width.is_nan() || width.is_inf() || width < 0.0 {
    return Err(
      InvalidInput(
        location(StrokeParameters, None, None),
        "Stroke width must be finite and non-negative",
      ),
    )
  }
  if offset_options_error(options, StrokeParameters) is Some(error) {
    return Err(error)
  }
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=StrokeGenerate,
        cleanup_stage=StrokeCleanup,
      )
  }
  if budget.limits.input.max_input_paths < 0 ||
    budget.limits.input.max_input_vertices < 0 ||
    budget.limits.max_nodes < 0 ||
    budget.limits.max_work < 0 {
    return Err(
      InvalidInput(
        location(StrokeParameters, None, None),
        "Stroke limits must be non-negative",
      ),
    )
  }
  let prepared = stroke_prepare(path, budget) catch {
    ScanAbort(error) => return Err(error)
  }
  if width < 1.0 || prepared.length() < 2 {
    return Ok([])
  }
  let generated = stroke_generate(prepared, width / 2.0, cap, options, budget) catch {
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
/// Stroke a single open route with full width, two sides at width / 2.
/// Width below 1 and routes with fewer than two effective points produce no area.
pub fn stroke_polyline(
  path : Path64,
  width : Double,
  cap? : CapType = Butt,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  stroke_execute(path, width, cap, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}
