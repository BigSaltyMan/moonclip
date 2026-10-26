// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Closed traversal and budget adaptation reuse the existing periodic corner
// generator and Boolean cleanup; no new upstream geometry formulas are copied.

///|
fn stroke_closed_prepare(
  path : Path64,
  budget : CallBudget,
) -> Path64 raise ScanAbort {
  // Check the original single route before allocating wrappers or copies.
  let loc = location(StrokeGenerate, Some(0), None)
  if check_limits(budget.limits.input, StrokeGenerate, 1) is Some(error) {
    raise ScanAbort(error)
  }
  if path.length() > budget.limits.input.max_input_vertices {
    raise ScanAbort(
      ResourceLimitExceeded(
        location(
          StrokeGenerate,
          Some(0),
          Some(budget.limits.input.max_input_vertices),
        ),
        InputVertices,
        budget.limits.input.max_input_vertices,
      ),
    )
  }
  // Separate charges avoid overflowing a sum of path and vertex counts.
  budget_spend(budget, 0, 2, loc)
  for i = 0; i < path.length(); i = i + 1 {
    let loc = location(StrokeGenerate, Some(0), Some(i))
    budget_spend(budget, 0, 1, loc)
    if check_point(path[i], loc) is Some(error) {
      raise ScanAbort(error)
    }
  }
  // This existing helper only removes consecutive repeats; it charges its
  // independent array, every visit and every retained slot before allocation.
  let prepared = stroke_batch_prepare(path, budget)
  while prepared.length() > 1 {
    offset_spend(budget, 0, 1)
    if prepared[prepared.length() - 1] != prepared[0] {
      break
    }
    ignore(prepared.pop())
  }
  prepared
}

///|
fn[T] stroke_closed_compute(
  path : Path64,
  width : Double,
  options : OffsetOptions,
  limits : ScanLimits,
  extract : (ScanState) -> T raise ScanAbort,
  empty : (CallBudget) -> T raise ScanAbort,
  budget? : CallBudget,
) -> Result[T, ClipError] {
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
  try {
    let prepared = stroke_closed_prepare(path, budget)
    if width < 1.0 || prepared.length() < 3 {
      return Ok(empty(budget))
    }
    offset_spend(budget, 1, 0)
    let reversed : Path64 = []
    for i = prepared.length() - 1; i >= 0; i = i - 1 {
      offset_spend(budget, 1, 1)
      reversed.push(prepared[i])
    }
    // Array plus two slots. Preserve the directed rings, including the negative
    // inner traversal; forcing both positive would fill the central hole.
    offset_spend(budget, 3, 2)
    let traversals = [prepared, reversed]
    let generated = offset_generate(traversals, width / 2.0, options, budget)
    offset_spend(budget, 1, 0)
    let empty : Paths64 = []
    boolean_compute(
      generated,
      empty,
      Union,
      budget.limits,
      Positive,
      extract,
      budget~,
      internal_input=true,
    )
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
fn stroke_closed_execute(
  path : Path64,
  width : Double,
  options : OffsetOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Paths64, ClipError] {
  stroke_closed_compute(
    path,
    width,
    options,
    limits,
    fn(state) raise ScanAbort {
      output_extract(state, preserve_collinear=false)
    },
    fn(budget) raise ScanAbort {
      // Preserve the original flat shortcut: one array, no extra work unit.
      offset_spend(budget, 1, 0)
      []
    },
    budget?,
  )
}

///|
fn stroke_closed_tree_execute(
  path : Path64,
  width : Double,
  options : OffsetOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PolyTree64, ClipError] {
  stroke_closed_compute(
    path,
    width,
    options,
    limits,
    tree_build,
    tree_empty,
    budget?,
  )
}

///|
/// Since 0.4.0: hierarchy of closed-centerline coverage, built during final cleanup.
/// Width is full width; there are joins but no caps. Roots and holes describe coverage.
pub fn stroke_closed_tree(
  path : Path64,
  width : Double,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PolyTree64, ClipError] {
  stroke_closed_tree_execute(path, width, options, {
    ..Default::default(),
    input: limits,
  })
}

///|
/// Since 0.4.0: widen one implicitly closed integer centerline, with no end caps.
/// Width is full width; all vertices, including the seam, use the chosen join.
/// Returns cleaned coverage, possibly with holes; does not fill the centerline interior.
pub fn stroke_closed_polyline(
  path : Path64,
  width : Double,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  stroke_closed_execute(path, width, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}
