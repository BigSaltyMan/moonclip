// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Decimal grid, strict input diagnostics and cumulative adapter are MoonClip code.

///|
/// Immutable decimal digits. Construction validates the supported 0..6 range.
pub struct Precision {
  priv digits_value : Int
} derive(Eq, Debug)

///|
pub fn Precision::new(digits : Int) -> Result[Precision, ClipError] {
  if digits < 0 || digits > 6 {
    return Err(
      InvalidInput(
        location(DecimalParameters, None, None),
        "Precision must be between 0 and 6",
      ),
    )
  }
  Ok({ digits_value: digits, })
}

///|
pub fn Precision::digits(self : Precision) -> Int {
  self.digits_value
}

///|
pub impl Default for Precision with fn default() {
  { digits_value: 3, }
}

///|
fn decimal_scale(precision : Precision) -> Double {
  match precision.digits_value {
    0 => 1.0
    1 => 10.0
    2 => 100.0
    3 => 1000.0
    4 => 10000.0
    5 => 100000.0
    _ => 1000000.0
  }
}

///|
fn decimal_spend(
  budget : CallBudget,
  nodes : Int,
  work : Int,
  loc : ErrorLocation,
) -> Unit raise ScanAbort {
  budget_spend(budget, nodes, work, loc)
}

///|
// Compare fractional parts, never floor(x+0.5): that addition can round across a tie.
fn decimal_round(value : Double) -> Int64 {
  if value >= 0.0 {
    let whole = @double.floor(value)
    (whole + (if value - whole >= 0.5 { 1.0 } else { 0.0 })).to_int64()
  } else {
    let whole = @double.ceil(value)
    (whole - (if whole - value >= 0.5 { 1.0 } else { 0.0 })).to_int64()
  }
}

///|
fn decimal_coordinate(
  value : Double,
  axis : Axis,
  precision : Precision,
  loc : ErrorLocation,
) -> Int64 raise ScanAbort {
  if value.is_nan() || value.is_inf() {
    raise ScanAbort(
      QuantizationFailure(loc, Some(axis), None, "Coordinate must be finite"),
    )
  }
  let scale = decimal_scale(precision)
  let bound = COORDINATE_LIMIT.to_double() / scale
  if value < -bound || value > bound {
    raise ScanAbort(
      DecimalCoordinateOutOfRange(loc, axis, value, precision.digits_value),
    )
  }
  let scaled = value * scale
  if scaled.is_nan() || scaled.is_inf() {
    raise ScanAbort(
      NumericFailure(loc, "Coordinate scaling produced a non-finite value"),
    )
  }
  if scaled < -1000000000.0 || scaled > 1000000000.0 {
    raise ScanAbort(
      DecimalCoordinateOutOfRange(loc, axis, value, precision.digits_value),
    )
  }
  decimal_round(scaled)
}

///|
fn decimal_parameter(
  value : Double,
  precision : Precision,
) -> Double raise ScanAbort {
  let scaled = value * decimal_scale(precision)
  if scaled.is_nan() || scaled.is_inf() {
    raise ScanAbort(
      NumericFailure(
        location(DecimalParameters, None, None),
        "Distance scaling produced a non-finite value",
      ),
    )
  }
  scaled
}

///|
fn decimal_precheck(
  subject : PathsD,
  clip : PathsD,
  precision : Precision,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  let limits = budget.limits
  if limits.input.max_input_paths < 0 ||
    limits.input.max_input_vertices < 0 ||
    limits.max_nodes < 0 ||
    limits.max_work < 0 {
    raise ScanAbort(
      InvalidInput(
        location(DecimalParameters, None, None),
        "Limits must be non-negative",
      ),
    )
  }
  let maximum = limits.input.max_input_paths
  if subject.length() > maximum || clip.length() > maximum - subject.length() {
    raise ScanAbort(
      ResourceLimitExceeded(
        location(DecimalQuantize, Some(maximum), None),
        InputPaths,
        maximum,
      ),
    )
  }
  let mut vertices = 0
  for i = 0; i < subject.length() + clip.length(); i = i + 1 {
    let path = if i < subject.length() {
      subject[i]
    } else {
      clip[i - subject.length()]
    }
    let loc = location(DecimalQuantize, Some(i), None)
    decimal_spend(budget, 0, 1, loc)
    if path.length() > limits.input.max_input_vertices - vertices {
      raise ScanAbort(
        ResourceLimitExceeded(
          location(
            DecimalQuantize,
            Some(i),
            Some(limits.input.max_input_vertices - vertices),
          ),
          InputVertices,
          limits.input.max_input_vertices,
        ),
      )
    }
    vertices += path.length()
  }
  for i = 0; i < subject.length() + clip.length(); i = i + 1 {
    let path = if i < subject.length() {
      subject[i]
    } else {
      clip[i - subject.length()]
    }
    for j = 0; j < path.length(); j = j + 1 {
      let loc = location(DecimalQuantize, Some(i), Some(j))
      decimal_spend(budget, 0, 1, loc)
      ignore(decimal_coordinate(path[j].x, X, precision, loc))
      ignore(decimal_coordinate(path[j].y, Y, precision, loc))
    }
  }
}

///|
priv struct DecimalOrigin {
  point : PointD
  loc : ErrorLocation
}

///|
fn decimal_closed(
  path : Path64,
  index : Int,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  if path.is_empty() {
    return
  }
  let loc = location(DecimalQuantize, Some(index), None)
  let a = path[0]
  let mut second : Point64? = None
  for p in path {
    decimal_spend(budget, 0, 1, loc)
    if p != a {
      second = Some(p)
      break
    }
  }
  if second is Some(b) {
    for p in path {
      decimal_spend(budget, 0, 1, loc)
      if cross_validated(a, b, p) != 0L {
        return
      }
    }
  }
  raise ScanAbort(
    QuantizationFailure(
      loc,
      None,
      None,
      "Closed contour needs at least three distinct noncollinear grid points",
    ),
  )
}

///|
fn decimal_quantize(
  subject : PathsD,
  clip : PathsD,
  precision : Precision,
  closed : Bool,
  budget : CallBudget,
) -> (Paths64, Paths64) raise ScanAbort {
  decimal_spend(budget, 3, 0, location(DecimalQuantize, None, None))
  let left : Paths64 = []
  let right : Paths64 = []
  let seen : Map[(Int64, Int64), DecimalOrigin] = Map([])
  for i = 0; i < subject.length() + clip.length(); i = i + 1 {
    let path = if i < subject.length() {
      subject[i]
    } else {
      clip[i - subject.length()]
    }
    decimal_spend(budget, 2, 0, location(DecimalQuantize, Some(i), None))
    let points : Path64 = []
    for j = 0; j < path.length(); j = j + 1 {
      let p = path[j]
      let loc = location(DecimalQuantize, Some(i), Some(j))
      let x = decimal_coordinate(p.x, X, precision, loc)
      let y = decimal_coordinate(p.y, Y, precision, loc)
      decimal_spend(budget, 1, 1, loc)
      let key = (x, y)
      match seen.get(key) {
        Some(origin) =>
          if origin.point != p {
            raise ScanAbort(
              QuantizationFailure(
                loc,
                None,
                Some(origin.loc),
                "Distinct input positions merge at this grid point",
              ),
            )
          }
        None => {
          decimal_spend(budget, 2, 0, loc)
          seen[key] = { point: p, loc, }
        }
      }
      decimal_spend(budget, 2, 0, loc)
      points.push(Point64::new(x, y))
    }
    if closed {
      decimal_closed(points, i, budget)
    }
    if i < subject.length() {
      left.push(points)
    } else {
      right.push(points)
    }
  }
  (left, right)
}

///|
fn decimal_value(value : Int64, precision : Precision) -> Double {
  if value == 0L {
    0.0
  } else {
    value.to_double() / decimal_scale(precision)
  }
}

///|
fn decimal_output(
  paths : Paths64,
  precision : Precision,
  budget : CallBudget,
) -> PathsD raise ScanAbort {
  let loc = location(DecimalOutput, None, None)
  decimal_spend(budget, 1, 0, loc)
  let result : PathsD = []
  for path in paths {
    decimal_spend(budget, 2, 0, loc)
    let output : PathD = []
    for p in path {
      decimal_spend(budget, 2, 1, loc)
      output.push(
        PointD::new(
          decimal_value(p.x, precision),
          decimal_value(p.y, precision),
        ),
      )
    }
    result.push(output)
  }
  result
}

///|
fn decimal_error(error : ClipError, precision : Precision) -> ClipError {
  match error {
    CoordinateOutOfRange(loc, axis, value) =>
      DecimalCoordinateOutOfRange(
        loc,
        axis,
        decimal_value(value, precision),
        precision.digits_value,
      )
    _ => error
  }
}

///|
priv enum DecimalOperation {
  Boolean(ClipType, FillRule)
  Offset(Double, FillRule, OffsetOptions)
  Stroke(Double, CapType, OffsetOptions)
}

///|
fn decimal_execute(
  subject : PathsD,
  clip : PathsD,
  operation : DecimalOperation,
  precision : Precision,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PathsD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      if operation is Stroke(_, _, _) {
        new_call_budget(
          limits,
          generate_stage=StrokeGenerate,
          cleanup_stage=StrokeCleanup,
        )
      } else {
        new_call_budget(limits)
      }
  }
  try {
    // Check options in original units, then build independent scaled options.
    let op = match operation {
      Boolean(kind, fill) => Boolean(kind, fill)
      Offset(delta, fill, options) => {
        if delta.is_nan() || delta.is_inf() {
          raise ScanAbort(
            InvalidInput(
              location(DecimalParameters, None, None),
              "Offset distance must be finite",
            ),
          )
        }
        Offset(
          decimal_parameter(delta, precision),
          fill,
          decimal_scaled_options(options, precision),
        )
      }
      Stroke(width, cap, options) => {
        if width.is_nan() || width.is_inf() || width < 0.0 {
          raise ScanAbort(
            InvalidInput(
              location(DecimalParameters, None, None),
              "Stroke width must be finite and non-negative",
            ),
          )
        }
        Stroke(
          decimal_parameter(width, precision),
          cap,
          decimal_scaled_options(options, precision),
        )
      }
    }
    decimal_precheck(subject, clip, precision, budget)
    let (left, right) = decimal_quantize(
      subject,
      clip,
      precision,
      !(op is Stroke(_, _, _)),
      budget,
    )
    let evaluated = match op {
      Boolean(kind, fill) =>
        boolean_compute(
          left,
          right,
          kind,
          budget.limits,
          if fill == EvenOdd {
            Parity
          } else {
            SignedNonZero
          },
          fn(state) raise ScanAbort {
            output_extract(state, preserve_collinear=false)
          },
          budget~,
        )
      Offset(delta, fill, options) =>
        offset_execute(left, delta, fill, options, budget.limits, budget~)
      Stroke(width, cap, options) =>
        stroke_execute(left[0], width, cap, options, budget.limits, budget~)
    }
    match evaluated {
      Err(error) => Err(decimal_error(error, precision))
      Ok(paths) => Ok(decimal_output(paths, precision, budget))
    }
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
pub fn boolean_op_d(
  subject : PathsD,
  clip : PathsD,
  operation : ClipType,
  precision? : Precision = Default::default(),
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[PathsD, ClipError] {
  decimal_execute(subject, clip, Boolean(operation, fill_rule), precision, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
// Keep the PathsD executor unchanged. Conversion runs inside extraction so a
// DecimalOutput failure takes boolean_compute's normal scan cleanup path.
fn decimal_tree_execute(
  subject : PathsD,
  clip : PathsD,
  operation : ClipType,
  precision : Precision,
  fill_rule : FillRule,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PolyTreeD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None => new_call_budget(limits)
  }
  try {
    decimal_precheck(subject, clip, precision, budget)
    let (left, right) = decimal_quantize(subject, clip, precision, true, budget)
    match
      boolean_compute(
        left,
        right,
        operation,
        budget.limits,
        if fill_rule == EvenOdd {
          Parity
        } else {
          SignedNonZero
        },
        fn(state) raise ScanAbort {
          decimal_tree_output(tree_build(state), precision, budget)
        },
        budget~,
      ) {
      Ok(tree) => Ok(tree)
      Err(error) => Err(decimal_error(error, precision))
    }
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
/// Boolean hierarchy of the quantized region, with decoded Double contours.
/// Introduced in 0.2.0; not included in the published 0.1.0 package.
pub fn boolean_tree_d(
  subject : PathsD,
  clip : PathsD,
  operation : ClipType,
  precision? : Precision = Default::default(),
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[PolyTreeD, ClipError] {
  decimal_tree_execute(subject, clip, operation, precision, fill_rule, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
fn decimal_offset_tree_execute(
  paths : PathsD,
  delta : Double,
  precision : Precision,
  fill_rule : FillRule,
  options : OffsetOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PolyTreeD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None => new_call_budget(limits)
  }
  try {
    if delta.is_nan() || delta.is_inf() {
      raise ScanAbort(
        InvalidInput(
          location(DecimalParameters, None, None),
          "Offset distance must be finite",
        ),
      )
    }
    let scaled_delta = decimal_parameter(delta, precision)
    let scaled_options = decimal_scaled_options(options, precision)
    decimal_precheck(paths, [], precision, budget)
    let (grid, _) = decimal_quantize(paths, [], precision, true, budget)
    match
      offset_compute(
        grid,
        scaled_delta,
        fill_rule,
        scaled_options,
        budget.limits,
        fn(state) raise ScanAbort {
          decimal_tree_output(tree_build(state), precision, budget)
        },
        fn(_, budget) raise ScanAbort {
          decimal_tree_output(tree_empty(budget), precision, budget)
        },
        budget~,
      ) {
      Ok(tree) => Ok(tree)
      Err(error) => Err(decimal_error(error, precision))
    }
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
/// Offset hierarchy on the decimal grid. Introduced in 0.2.0.
pub fn offset_tree_d(
  paths : PathsD,
  delta : Double,
  precision? : Precision = Default::default(),
  fill_rule? : FillRule = NonZero,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PolyTreeD, ClipError] {
  decimal_offset_tree_execute(paths, delta, precision, fill_rule, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
pub fn offset_polygons_d(
  paths : PathsD,
  delta : Double,
  precision? : Precision = Default::default(),
  fill_rule? : FillRule = NonZero,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PathsD, ClipError] {
  decimal_execute(paths, [], Offset(delta, fill_rule, options), precision, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
fn decimal_stroke_tree_execute(
  path : PathD,
  width : Double,
  precision : Precision,
  cap : CapType,
  options : OffsetOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PolyTreeD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=StrokeGenerate,
        cleanup_stage=StrokeCleanup,
      )
  }
  try {
    if width.is_nan() || width.is_inf() || width < 0.0 {
      raise ScanAbort(
        InvalidInput(
          location(DecimalParameters, None, None),
          "Stroke width must be finite and non-negative",
        ),
      )
    }
    let scaled_width = decimal_parameter(width, precision)
    let scaled_options = decimal_scaled_options(options, precision)
    decimal_precheck([path], [], precision, budget)
    let (grid, _) = decimal_quantize([path], [], precision, false, budget)
    match
      stroke_compute(
        grid[0],
        scaled_width,
        cap,
        scaled_options,
        budget.limits,
        fn(state) raise ScanAbort {
          decimal_tree_output(tree_build(state), precision, budget)
        },
        fn(budget) raise ScanAbort {
          decimal_tree_output(tree_empty(budget), precision, budget)
        },
        budget~,
      ) {
      Ok(tree) => Ok(tree)
      Err(error) => Err(decimal_error(error, precision))
    }
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
/// Open-route stroke hierarchy on the decimal grid. Introduced in 0.2.0.
pub fn stroke_tree_d(
  path : PathD,
  width : Double,
  precision? : Precision = Default::default(),
  cap? : CapType = Butt,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PolyTreeD, ClipError] {
  decimal_stroke_tree_execute(path, width, precision, cap, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
pub fn stroke_polyline_d(
  path : PathD,
  width : Double,
  precision? : Precision = Default::default(),
  cap? : CapType = Butt,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PathsD, ClipError] {
  decimal_execute([path], [], Stroke(width, cap, options), precision, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
fn decimal_scaled_options(
  options : OffsetOptions,
  precision : Precision,
) -> OffsetOptions raise ScanAbort {
  if offset_options_error(options, DecimalParameters) is Some(error) {
    raise ScanAbort(error)
  }
  OffsetOptions::new(
    join=options.join,
    miter_limit=options.miter_limit,
    arc_tolerance=decimal_parameter(options.arc_tolerance, precision),
  )
}

///|
// Simplification alone reports closed degeneracy, rather than applying region input rules.
fn decimal_simplify_execute(
  paths : PathsD,
  precision : Precision,
  options : SimplifyOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[SimplifyResultD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None => new_call_budget(limits)
  }
  try {
    ignore(simplify_epsilon(options.epsilon))
    let scaled = decimal_parameter(options.epsilon, precision)
    let square = simplify_epsilon(scaled)
    decimal_precheck(paths, [], precision, budget)
    // false skips only closed-region validation, never range/merge diagnostics.
    let (grid, _) = decimal_quantize(paths, [], precision, false, budget)
    let value = simplify_validated(
      grid,
      SimplifyOptions::new(epsilon=scaled, mode=options.mode),
      square,
      budget,
    )
    let decoded = decimal_output(value.stored_paths, precision, budget)
    budget_spend(budget, 1, 1, location(SimplifyReport, None, None))
    Ok({ stored_paths: decoded, report: value.report, })
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
pub fn simplify_paths_d(
  paths : PathsD,
  precision? : Precision = Default::default(),
  options? : SimplifyOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[SimplifyResultD, ClipError] {
  decimal_simplify_execute(paths, precision, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
fn decimal_minkowski_execute(
  pattern : PathD,
  path : PathD,
  closed : Bool,
  precision : Precision,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PathsD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=MinkowskiGenerate,
        cleanup_stage=MinkowskiCleanup,
      )
  }
  try {
    decimal_precheck([pattern], [path], precision, budget)
    // One shared collision map, without closed-region degeneracy validation.
    let (left, right) = decimal_quantize(
      [pattern],
      [path],
      precision,
      false,
      budget,
    )
    match minkowski_execute(left[0], right[0], closed, budget.limits, budget~) {
      Ok(paths) => Ok(decimal_output(paths, precision, budget))
      Err(error) => Err(decimal_error(error, precision))
    }
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
/// Unreleased: quantize pattern offsets and route on one grid before integer sums.
/// Preserves the integer sweep's anchor, closure and collinear-output rules.
pub fn minkowski_sum_d(
  pattern : PathD,
  path : PathD,
  path_is_closed : Bool,
  precision? : Precision = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PathsD, ClipError] {
  decimal_minkowski_execute(pattern, path, path_is_closed, precision, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
fn decimal_stroke_batch_execute(
  paths : PathsD,
  width : Double,
  precision : Precision,
  cap : CapType,
  options : OffsetOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PathsD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=StrokeGenerate,
        cleanup_stage=StrokeCleanup,
      )
  }
  try {
    if width.is_nan() || width.is_inf() || width < 0.0 {
      raise ScanAbort(
        InvalidInput(
          location(DecimalParameters, None, None),
          "Stroke width must be finite and non-negative",
        ),
      )
    }
    if offset_options_error(options, DecimalParameters) is Some(error) {
      raise ScanAbort(error)
    }
    decimal_precheck(paths, [], precision, budget)
    // All open routes share one collision map, including zero-width calls.
    let (grid, _) = decimal_quantize(paths, [], precision, false, budget)
    let scaled_width = decimal_parameter(width, precision)
    let scaled_options = decimal_scaled_options(options, precision)
    match
      stroke_batch_execute(
        grid,
        scaled_width,
        cap,
        scaled_options,
        budget.limits,
        budget~,
      ) {
      Ok(region) => Ok(decimal_output(region, precision, budget))
      Err(error) => Err(decimal_error(error, precision))
    }
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
/// Unreleased: quantize all open routes on one grid, then merge their strokes once.
/// Width and ArcTolerance use original units; every phase shares one budget.
pub fn stroke_polylines_d(
  paths : PathsD,
  width : Double,
  precision? : Precision = Default::default(),
  cap? : CapType = Butt,
  options? : OffsetOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PathsD, ClipError] {
  decimal_stroke_batch_execute(paths, width, precision, cap, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
fn decimal_rect_parameters(
  rect : BoundsD,
  precision : Precision,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  let limits = budget.limits
  if limits.input.max_input_paths < 0 ||
    limits.input.max_input_vertices < 0 ||
    limits.max_nodes < 0 ||
    limits.max_work < 0 {
    raise ScanAbort(
      InvalidInput(
        location(DecimalParameters, None, None),
        "Limits must be non-negative",
      ),
    )
  }
  // Four scalar checks and one ordering check; no temporary parameter arrays.
  budget_spend(budget, 0, 5, location(RectClipParameters, None, None))
  let loc = location(DecimalParameters, None, None)
  // The existing coordinate validator checks finite/range before any narrowing.
  ignore(decimal_coordinate(rect.min_x, X, precision, loc))
  ignore(decimal_coordinate(rect.min_y, Y, precision, loc))
  ignore(decimal_coordinate(rect.max_x, X, precision, loc))
  ignore(decimal_coordinate(rect.max_y, Y, precision, loc))
  if rect.min_x > rect.max_x || rect.min_y > rect.max_y {
    raise ScanAbort(
      InvalidInput(
        location(RectClipParameters, None, None),
        "Rectangle minimum exceeds maximum",
      ),
    )
  }
}

///|
fn decimal_rect_quantize(
  rect : BoundsD,
  precision : Precision,
  budget : CallBudget,
) -> Bounds64 raise ScanAbort {
  let loc = location(DecimalQuantize, None, None)
  // One immutable Bounds64 and four coordinate conversions, outside the path map.
  budget_spend(budget, 1, 4, loc)
  let grid : Bounds64 = {
    min_x: decimal_coordinate(rect.min_x, X, precision, loc),
    min_y: decimal_coordinate(rect.min_y, Y, precision, loc),
    max_x: decimal_coordinate(rect.max_x, X, precision, loc),
    max_y: decimal_coordinate(rect.max_y, Y, precision, loc),
  }
  if rect.min_x < rect.max_x &&
    rect.min_y < rect.max_y &&
    (grid.min_x == grid.max_x || grid.min_y == grid.max_y) {
    raise ScanAbort(
      QuantizationFailure(
        loc,
        None,
        None,
        "Nonempty rectangle collapses on the precision grid",
      ),
    )
  }
  grid
}

///|
fn decimal_rect_clip_polygons_execute(
  rect : BoundsD,
  paths : PathsD,
  precision : Precision,
  fill_rule : FillRule,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PathsD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=RectClipEvaluate,
        cleanup_stage=RectClipEvaluate,
      )
  }
  try {
    decimal_rect_parameters(rect, precision, budget)
    decimal_precheck(paths, [], precision, budget)
    let window = decimal_rect_quantize(rect, precision, budget)
    let (grid, _) = decimal_quantize(paths, [], precision, true, budget)
    match
      rect_clip_polygons_execute(
        window,
        grid,
        fill_rule,
        budget.limits,
        budget~,
      ) {
      Ok(region) => Ok(decimal_output(region, precision, budget))
      Err(error) => Err(decimal_error(error, precision))
    }
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
/// Unreleased: clip a decimal closed region using one precision grid and budget.
/// Window parameters do not consume raw path quotas or join the collision map.
pub fn rect_clip_polygons_d(
  rect : BoundsD,
  paths : PathsD,
  precision? : Precision = Default::default(),
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[PathsD, ClipError] {
  decimal_rect_clip_polygons_execute(rect, paths, precision, fill_rule, {
    ..Default::default(),
    input: limits,
  })
}

///|
fn decimal_rect_clip_lines_execute(
  rect : BoundsD,
  paths : PathsD,
  precision : Precision,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[PathsD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=RectClipEvaluate,
        cleanup_stage=RectClipOutput,
      )
  }
  try {
    decimal_rect_parameters(rect, precision, budget)
    decimal_precheck(paths, [], precision, budget)
    let window = decimal_rect_quantize(rect, precision, budget)
    // One shared path collision map, without closed-region validity requirements.
    let (grid, _) = decimal_quantize(paths, [], precision, false, budget)
    match rect_clip_execute(window, grid, budget.limits, budget~) {
      Ok(pieces) => Ok(decimal_output(pieces, precision, budget))
      Err(error) => Err(decimal_error(error, precision))
    }
  } catch {
    ScanAbort(error) => Err(decimal_error(error, precision))
  }
}

///|
/// Unreleased: clip independent decimal open routes on a common precision grid.
/// Preserves integer clipping's fragment order, direction and collinear vertices.
pub fn rect_clip_lines_d(
  rect : BoundsD,
  paths : PathsD,
  precision? : Precision = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[PathsD, ClipError] {
  decimal_rect_clip_lines_execute(rect, paths, precision, {
    ..Default::default(),
    input: limits,
  })
}
