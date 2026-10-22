// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn rect_clip_polygons_execute(
  rect : Bounds64,
  paths : Paths64,
  fill_rule : FillRule,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Paths64, ClipError] {
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
      // One empty result container; no window or scan allocation.
      budget_spend(budget, 1, 1, location(RectClipOutput, None, None))
      return Ok([])
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
      fn(state) raise ScanAbort {
        output_extract(state, preserve_collinear=false)
      },
      budget~,
      internal_input=true,
    )
  } catch {
    ScanAbort(error) => Err(error)
  }
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
