// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Translation/quad traversal adapted from fixed Clipper2 clipper.minkowski.h,
// Copyright Angus Johnson 2010-2023. BSL-1.0; see docs/upstream.md.
// Checked products, exact winding and cumulative-budget integration are MoonClip code.

///|
fn minkowski_product(
  a : Int,
  b : Int,
  budget : CallBudget,
) -> Int raise ScanAbort {
  let loc = location(MinkowskiGenerate, None, None)
  if a < 0 || b < 0 {
    raise ScanAbort(InvalidInput(loc, "Dimensions must be non-negative"))
  }
  if a != 0 && b > 2147483647 / a {
    raise ScanAbort(
      ResourceLimitExceeded(loc, InternalNodes, budget.limits.max_nodes),
    )
  }
  a * b
}

///|
// Pure associated-allocation preflight, never spends and never allocates a matrix.
fn minkowski_plan(
  m : Int,
  n : Int,
  closed : Bool,
  budget : CallBudget,
) -> (Int, Int) raise ScanAbort {
  let loc = location(MinkowskiGenerate, None, None)
  if m < 0 || n < 0 {
    raise ScanAbort(InvalidInput(loc, "Dimensions must be non-negative"))
  }
  if m == 0 || n == 0 {
    return (0, 0)
  }
  let points = minkowski_product(m, n, budget)
  let quads = minkowski_product(m, if closed { n } else { n - 1 }, budget)
  ignore(minkowski_product(quads, 4, budget))
  let mut remaining = budget.limits.max_nodes - budget.stats.nodes
  // outer arrays; row arrays/slots; translated immutable points/slots; quad arrays/slots/references.
  for
    cost in [
      2,
      minkowski_product(n, 2, budget),
      minkowski_product(points, 2, budget),
      minkowski_product(quads, 6, budget),
    ] {
    if cost > remaining {
      raise ScanAbort(
        ResourceLimitExceeded(loc, InternalNodes, budget.limits.max_nodes),
      )
    }
    remaining -= cost
  }
  let mut work = budget.limits.max_work - budget.stats.work
  for cost in [n, points, minkowski_product(quads, 2, budget)] {
    if cost > work {
      raise ScanAbort(
        ResourceLimitExceeded(loc, ScanWork, budget.limits.max_work),
      )
    }
    work -= cost
  }
  (points, quads)
}

///|
fn minkowski_translate(
  a : Point64,
  b : Point64,
  index : Int,
) -> Point64 raise ScanAbort {
  // Inputs were validated before addition, so each sum is within +/-2e9 in Int64.
  let point = Point64::new(a.x + b.x, a.y + b.y)
  if check_point(point, location(MinkowskiGenerate, Some(1), Some(index)))
    is Some(error) {
    raise ScanAbort(error)
  }
  point
}

///|
fn minkowski_generate(
  pattern : Path64,
  path : Path64,
  closed : Bool,
  budget : CallBudget,
) -> Paths64 raise ScanAbort {
  ignore(minkowski_plan(pattern.length(), path.length(), closed, budget))
  if pattern.is_empty() || path.is_empty() {
    budget_spend(budget, 2, 0, location(MinkowskiGenerate, None, None))
    return []
  }
  let translated = minkowski_matrix(pattern, path, budget)
  minkowski_quads(translated, pattern.length(), closed, budget)
}

///|
fn minkowski_matrix(
  pattern : Path64,
  path : Path64,
  budget : CallBudget,
) -> Paths64 raise ScanAbort {
  let loc = location(MinkowskiGenerate, None, None)
  budget_spend(budget, 1, 0, loc)
  let translated : Paths64 = []
  for i = 0; i < path.length(); i = i + 1 {
    budget_spend(budget, 2, 1, loc)
    let row : Path64 = []
    for j = 0; j < pattern.length(); j = j + 1 {
      budget_spend(budget, 2, 1, location(MinkowskiGenerate, Some(1), Some(i)))
      row.push(minkowski_translate(path[i], pattern[j], i))
    }
    translated.push(row)
  }
  translated
}

///|
fn minkowski_quads(
  translated : Paths64,
  m : Int,
  closed : Bool,
  budget : CallBudget,
) -> Paths64 raise ScanAbort {
  let loc = location(MinkowskiGenerate, None, None)
  budget_spend(budget, 1, 0, loc)
  let result : Paths64 = []
  if m == 0 || translated.is_empty() {
    return result
  }
  let mut previous = if closed { translated.length() - 1 } else { 0 }
  let mut h = m - 1
  for i = (if closed { 0 } else { 1 }); i < translated.length(); i = i + 1 {
    for j = 0; j < m; j = j + 1 {
      budget_spend(budget, 6, 2, loc)
      let a = translated[previous][h]
      let b = translated[i][h]
      let c = translated[i][j]
      let d = translated[previous][j]
      // Parallel quad sign is cross(a,b,c); do not overflow by doubling it.
      result.push(
        if cross_validated(a, b, c) < 0L {
          [d, c, b, a]
        } else {
          [a, b, c, d]
        },
      )
      h = j
    }
    previous = i
  }
  result
}

///|
fn minkowski_execute(
  pattern : Path64,
  path : Path64,
  closed : Bool,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Paths64, ClipError] {
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
    if budget.limits.max_nodes < 0 || budget.limits.max_work < 0 {
      raise ScanAbort(
        InvalidInput(
          location(MinkowskiParameters, None, None),
          "Limits must be non-negative",
        ),
      )
    }
    if check_paths([pattern, path], budget.limits.input, MinkowskiParameters)
      is Some(error) {
      raise ScanAbort(error)
    }
    for p in [pattern, path] {
      budget_spend(budget, 0, 1, location(MinkowskiParameters, None, None))
      for _ in p {
        budget_spend(budget, 0, 1, location(MinkowskiParameters, None, None))
      }
    }
    let quads = minkowski_generate(pattern, path, closed, budget)
    boolean_compute(
      quads,
      [],
      Union,
      budget.limits,
      SignedNonZero,
      fn(state) raise ScanAbort {
        output_extract(state, preserve_collinear=true)
      },
      budget~,
      internal_input=true,
      preserve_collinear=true,
    )
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
/// Fixed single-pattern path sweep. No endpoint pattern fill; preserves output collinearity.
pub fn minkowski_sum(
  pattern : Path64,
  path : Path64,
  path_is_closed : Bool,
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  minkowski_execute(pattern, path, path_is_closed, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}
