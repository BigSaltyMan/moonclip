// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn[T] rect_clip_polygons_compute(
  rect : Bounds64,
  paths : Paths64,
  fill_rule : FillRule,
  limits : ScanLimits,
  extract : (ScanState) -> T raise ScanAbort,
  empty : (CallBudget) -> T raise ScanAbort,
  budget? : CallBudget,
) -> Result[T, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=RectClipEvaluate,
        cleanup_stage=RectClipEvaluate,
      )
  }
  let loc = location(RectClipParameters, None, None)
  if rect.min_x < -COORDINATE_LIMIT || rect.min_x > COORDINATE_LIMIT {
    return Err(CoordinateOutOfRange(loc, X, rect.min_x))
  }
  if rect.max_x < -COORDINATE_LIMIT || rect.max_x > COORDINATE_LIMIT {
    return Err(CoordinateOutOfRange(loc, X, rect.max_x))
  }
  if rect.min_y < -COORDINATE_LIMIT || rect.min_y > COORDINATE_LIMIT {
    return Err(CoordinateOutOfRange(loc, Y, rect.min_y))
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
    Ok(work) => work
    Err(error) => return Err(error)
  }
  try {
    budget_spend(budget, 0, work, loc)
    if paths.is_empty() || rect.min_x == rect.max_x || rect.min_y == rect.max_y {
      // Output-specific empty storage; no window or scan allocation.
      return Ok(empty(budget))
    }
    // Four immutable points + four slots + ring container + operand container/slot.
    // Four corner constructions and two container constructions: 11 nodes / 6 work.
    budget_spend(budget, 11, 6, location(RectClipEvaluate, None, None))
    let window = [
      [
        Point64::new(rect.min_x, rect.min_y),
        Point64::new(rect.max_x, rect.min_y),
        Point64::new(rect.max_x, rect.max_y),
        Point64::new(rect.min_x, rect.max_y),
      ],
    ]
    boolean_compute(
      paths,
      window,
      Intersection,
      budget.limits,
      match fill_rule {
        EvenOdd => Parity
        NonZero => SignedNonZero
      },
      extract,
      budget~,
      internal_input=true,
    )
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
fn rect_clip_polygons_execute(
  rect : Bounds64,
  paths : Paths64,
  fill_rule : FillRule,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Paths64, ClipError] {
  rect_clip_polygons_compute(
    rect,
    paths,
    fill_rule,
    limits,
    fn(state) raise ScanAbort {
      output_extract(state, preserve_collinear=false)
    },
    fn(budget) raise ScanAbort {
      // Preserve the flat shortcut's one result container and work unit.
      budget_spend(budget, 1, 1, location(RectClipOutput, None, None))
      []
    },
    budget?,
  )
}

///|
fn rect_clip_polygons_tree_execute(
  rect : Bounds64,
  paths : Paths64,
  fill_rule : FillRule,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PolyTree64, ClipError] {
  rect_clip_polygons_compute(
    rect,
    paths,
    fill_rule,
    limits,
    tree_build,
    tree_empty,
    budget?,
  )
}

///|
/// Unreleased: intersect a closed integer region with an axis-aligned window.
/// Uses Boolean filling and grid rules; only caller paths count toward input limits.
pub fn rect_clip_polygons(
  rect : Bounds64,
  paths : Paths64,
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  rect_clip_polygons_execute(rect, paths, fill_rule, {
    ..Default::default(),
    input: limits,
  })
}

///|
/// Unreleased: hierarchy of the region after window intersection, built in one scan.
/// A hole cut open by the window becomes part of the outer contour.
pub fn rect_clip_polygons_tree(
  rect : Bounds64,
  paths : Paths64,
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[PolyTree64, ClipError] {
  rect_clip_polygons_tree_execute(rect, paths, fill_rule, {
    ..Default::default(),
    input: limits,
  })
}
