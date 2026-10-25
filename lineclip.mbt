// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// MoonClip exact open-segment adaptation; region evaluation reuses Boolean.

///|
priv struct LineRatio {
  n : BigInt
  d : BigInt // Strictly positive. No reduction is needed for bounded events.
}

///|
priv struct LinePoint {
  x : BigInt
  y : BigInt
  d : BigInt
}

///|
// Every BigInt conversion/arithmetic result costs 1 logical node / 1 work.
// Operands are immutable aliases, not copies. Comparisons cost 1 work.
// These are logical allocations, not byte counts or backend limb allocations.
fn line_big(
  v : Int64,
  b : CallBudget,
  l : ErrorLocation,
) -> BigInt raise ScanAbort {
  budget_spend(b, 1, 1, l)
  BigInt::from_int64(v)
}

///|
fn line_add(
  a : BigInt,
  c : BigInt,
  b : CallBudget,
  l : ErrorLocation,
) -> BigInt raise ScanAbort {
  budget_spend(b, 1, 1, l)
  a + c
}

///|
fn line_sub(
  a : BigInt,
  c : BigInt,
  b : CallBudget,
  l : ErrorLocation,
) -> BigInt raise ScanAbort {
  budget_spend(b, 1, 1, l)
  a - c
}

///|
fn line_mul(
  a : BigInt,
  c : BigInt,
  b : CallBudget,
  l : ErrorLocation,
) -> BigInt raise ScanAbort {
  budget_spend(b, 1, 1, l)
  a * c
}

///|
fn line_cmp(
  a : BigInt,
  c : BigInt,
  b : CallBudget,
  l : ErrorLocation,
) -> Int raise ScanAbort {
  budget_spend(b, 0, 1, l)
  a.compare(c)
}

///|
fn line_sign(
  a : BigInt,
  b : CallBudget,
  l : ErrorLocation,
) -> Int raise ScanAbort {
  budget_spend(b, 0, 1, l)
  a.compare_int64(0L)
}

///|
fn line_ratio_compare(
  a : LineRatio,
  c : LineRatio,
  b : CallBudget,
  l : ErrorLocation,
) -> Int raise ScanAbort {
  line_cmp(line_mul(a.n, c.d, b, l), line_mul(c.n, a.d, b, l), b, l)
}

///|
// Insert in exact order, coalescing equal parameters, including shared vertices.
// Ratio object: 1 node. New event slot/append: 1 node/1 work. Each move: 1 work.
fn line_event(
  events : Array[LineRatio],
  numerator : Int64,
  denominator : Int64,
  b : CallBudget,
  l : ErrorLocation,
) -> Unit raise ScanAbort {
  budget_spend(b, 0, 1, l)
  let n = if denominator < 0L { -numerator } else { numerator }
  let d = if denominator < 0L { -denominator } else { denominator }
  if n < 0L || n > d {
    return
  }
  budget_spend(b, 1, 0, l)
  let event = { n: line_big(n, b, l), d: line_big(d, b, l), }
  let mut index = events.length()
  for i = 0; i < events.length(); i = i + 1 {
    let cmp = line_ratio_compare(event, events[i], b, l)
    if cmp == 0 {
      return
    }
    if cmp < 0 {
      index = i
      break
    }
  }
  budget_spend(b, 1, 1, l)
  events.push(event)
  for i = events.length() - 1; i > index; i = i - 1 {
    budget_spend(b, 0, 1, l)
    events[i] = events[i - 1]
  }
  events[index] = event
}

///|
fn line_events(
  a : Point64,
  z : Point64,
  region : Paths64,
  b : CallBudget,
  l : ErrorLocation,
) -> Array[LineRatio] raise ScanAbort {
  budget_spend(b, 1, 0, l) // Event container before construction.
  let events = []
  line_event(events, 0L, 1L, b, l)
  line_event(events, 1L, 1L, b, l)
  let rx = z.x - a.x
  let ry = z.y - a.y
  for contour in region {
    budget_spend(b, 0, 1, l)
    let mut c = contour[contour.length() - 1]
    for d in contour {
      budget_spend(b, 0, 1, l) // Edge access and bounded Int64 predicates.
      let sx = d.x - c.x
      let sy = d.y - c.y
      let den = cross_components(rx, ry, sx, sy)
      if den != 0L {
        let tn = cross_components(c.x - a.x, c.y - a.y, sx, sy)
        let un = cross_components(c.x - a.x, c.y - a.y, rx, ry)
        if (den > 0L && un >= 0L && un <= den) ||
          (den < 0L && un <= 0L && un >= den) {
          line_event(events, tn, den, b, l)
        }
      } else if cross_validated(a, z, c) == 0L {
        if rx != 0L {
          line_event(events, c.x - a.x, rx, b, l)
          line_event(events, d.x - a.x, rx, b, l)
        } else {
          line_event(events, c.y - a.y, ry, b, l)
          line_event(events, d.y - a.y, ry, b, l)
        }
      }
      c = d
    }
  }
  events
}

///|
fn line_mid(
  a : LineRatio,
  c : LineRatio,
  b : CallBudget,
  l : ErrorLocation,
) -> LineRatio raise ScanAbort {
  budget_spend(b, 1, 0, l)
  {
    n: line_add(line_mul(a.n, c.d, b, l), line_mul(c.n, a.d, b, l), b, l),
    d: line_mul(line_big(2L, b, l), line_mul(a.d, c.d, b, l), b, l),
  }
}

///|
fn line_at(
  a : Point64,
  z : Point64,
  t : LineRatio,
  b : CallBudget,
  l : ErrorLocation,
) -> LinePoint raise ScanAbort {
  budget_spend(b, 1, 0, l)
  {
    x: line_add(
      line_mul(line_big(a.x, b, l), t.d, b, l),
      line_mul(line_big(z.x - a.x, b, l), t.n, b, l),
      b,
      l,
    ),
    y: line_add(
      line_mul(line_big(a.y, b, l), t.d, b, l),
      line_mul(line_big(z.y - a.y, b, l), t.n, b, l),
      b,
      l,
    ),
    d: t.d,
  }
}

///|
fn line_between(
  v : BigInt,
  a : BigInt,
  c : BigInt,
  b : CallBudget,
  l : ErrorLocation,
) -> Bool raise ScanAbort {
  if line_cmp(a, c, b, l) <= 0 {
    line_cmp(v, a, b, l) >= 0 && line_cmp(v, c, b, l) <= 0
  } else {
    line_cmp(v, c, b, l) >= 0 && line_cmp(v, a, b, l) <= 0
  }
}

///|
// The normalized Boolean contours represent a non-overlapping filled region.
// Parity over their rational half-open rays handles both outer rings and holes.
fn line_inside(
  q : LinePoint,
  region : Paths64,
  b : CallBudget,
  l : ErrorLocation,
) -> Bool raise ScanAbort {
  let mut inside = false
  for contour in region {
    budget_spend(b, 0, 1, l)
    let mut a = contour[contour.length() - 1]
    for c in contour {
      budget_spend(b, 0, 1, l)
      let ax = line_mul(line_big(a.x, b, l), q.d, b, l)
      let ay = line_mul(line_big(a.y, b, l), q.d, b, l)
      let cx = line_mul(line_big(c.x, b, l), q.d, b, l)
      let cy = line_mul(line_big(c.y, b, l), q.d, b, l)
      let cross = line_sub(
        line_mul(line_big(c.x - a.x, b, l), line_sub(q.y, ay, b, l), b, l),
        line_mul(line_big(c.y - a.y, b, l), line_sub(q.x, ax, b, l), b, l),
        b,
        l,
      )
      let sign = line_sign(cross, b, l)
      if sign == 0 &&
        line_between(q.x, ax, cx, b, l) &&
        line_between(q.y, ay, cy, b, l) {
        return true
      }
      if (line_cmp(ay, q.y, b, l) > 0) != (line_cmp(cy, q.y, b, l) > 0) &&
        ((c.y > a.y && sign > 0) || (c.y < a.y && sign < 0)) {
        inside = !inside
      }
      a = c
    }
  }
  inside
}

///|
// Positive denominator, exact quotient/remainder; ties round away from zero.
fn line_round(
  n : BigInt,
  d : BigInt,
  b : CallBudget,
  l : ErrorLocation,
) -> Int64 raise ScanAbort {
  let negative = line_sign(n, b, l) < 0
  let magnitude = if negative {
    budget_spend(b, 1, 1, l)
    -n
  } else {
    n
  }
  budget_spend(b, 2, 2, l) // Quotient and remainder before either arithmetic operation.
  let mut result = magnitude / d
  let remainder = magnitude % d
  if line_cmp(line_add(remainder, remainder, b, l), d, b, l) >= 0 {
    result = line_add(result, line_big(1L, b, l), b, l)
  }
  if negative {
    budget_spend(b, 1, 1, l)
    result = -result
  }
  budget_spend(b, 0, 3, l) // Two bounds comparisons and checked-range conversion.
  if result.compare_int64(-COORDINATE_LIMIT) < 0 ||
    result.compare_int64(COORDINATE_LIMIT) > 0 {
    raise ScanAbort(
      NumericFailure(
        l, "Rounded line intersection is outside the coordinate range",
      ),
    )
  }
  result.to_int64()
}

///|
fn line_output_point(
  a : Point64,
  z : Point64,
  t : LineRatio,
  b : CallBudget,
) -> Point64 raise ScanAbort {
  let l = location(LineClipOutput, None, None)
  let q = line_at(a, z, t, b, l)
  let x = line_round(q.x, q.d, b, l)
  let y = line_round(q.y, q.d, b, l)
  budget_spend(b, 1, 0, l)
  Point64::new(x, y)
}

///|
fn line_append(
  path : Path64,
  point : Point64,
  b : CallBudget,
) -> Unit raise ScanAbort {
  let l = location(LineClipOutput, None, None)
  budget_spend(b, 0, 1, l)
  if path.is_empty() || path[path.length() - 1] != point {
    budget_spend(b, 1, 1, l) // Slot and append; point storage was charged separately.
    path.push(point)
  }
}

///|
fn line_finish(
  result : Paths64,
  current : Path64?,
  b : CallBudget,
) -> Unit raise ScanAbort {
  let l = location(LineClipOutput, None, None)
  budget_spend(b, 0, 1, l)
  if current is Some(path) && path.length() >= 2 {
    budget_spend(b, 1, 1, l)
    result.push(path)
  }
}

///|
fn line_clip_execute(
  paths : Paths64,
  clip : Paths64,
  fill_rule : FillRule,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Paths64, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=LineClipEvaluate,
        cleanup_stage=LineClipEvaluate,
      )
  }
  let loc = location(LineClipParameters, None, None)
  let work = match
    scan_check_inputs(
      paths,
      clip,
      budget.limits,
      spent_work=budget.stats.work,
      raw_stage=LineClipParameters,
    ) {
    Ok(work) => work
    Err(error) => return Err(error)
  }
  try {
    budget_spend(budget, 0, work, loc)
    // No caller arrays are copied. This sole empty operand is internal storage.
    budget_spend(budget, 1, 0, location(LineClipEvaluate, None, None))
    let region = match
      boolean_compute(
        clip,
        [],
        Union,
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
      ) {
      Ok(region) => region
      // All raw locations were validated in combined order above. The internal
      // scan deliberately uses None locations, never clip-local caller indices.
      Err(error) => return Err(error)
    }
    budget_spend(budget, 1, 0, location(LineClipOutput, None, None))
    let result : Paths64 = []
    for p = 0; p < paths.length(); p = p + 1 {
      budget_spend(budget, 0, 1, location(LineClipEvaluate, Some(p), None))
      let path = paths[p]
      let mut current : Path64? = None
      for i = 1; i < path.length(); i = i + 1 {
        let l = location(LineClipEvaluate, Some(p), Some(i))
        budget_spend(budget, 0, 1, l)
        let a = path[i - 1]
        let z = path[i]
        if a == z {
          continue
        }
        let events = line_events(a, z, region, budget, l)
        for j = 1; j < events.length(); j = j + 1 {
          budget_spend(budget, 0, 1, l)
          let lo = events[j - 1]
          let hi = events[j]
          let keep = line_inside(
            line_at(a, z, line_mid(lo, hi, budget, l), budget, l),
            region,
            budget,
            l,
          )
          if keep {
            let fragment = match current {
              Some(value) => value
              None => {
                budget_spend(budget, 1, 0, location(LineClipOutput, None, None))
                let value = []
                current = Some(value)
                value
              }
            }
            line_append(fragment, line_output_point(a, z, lo, budget), budget)
            line_append(fragment, line_output_point(a, z, hi, budget), budget)
          } else {
            // Split in exact space, before rounding. Even equal rounded ends
            // must never reconnect across a discarded positive-length interval.
            line_finish(result, current, budget)
            current = None
          }
        }
      }
      line_finish(result, current, budget)
    }
    Ok(result)
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
/// Unreleased: intersect independent open integer routes with a closed filled region.
/// Includes final-region boundaries; preserves route order and ordinary input vertices.
/// Exact rational events round half away from zero, unlike rect_clip_lines truncation.
pub fn intersect_polylines(
  paths : Paths64,
  clip : Paths64,
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  line_clip_execute(paths, clip, fill_rule, {
    ..Default::default(),
    input: limits,
  })
}
