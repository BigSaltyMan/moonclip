// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// SimplifyPath traversal / perpendicular distance adapted from Clipper2 2.0.1.
// Copyright Angus Johnson 2010-2025. BSL-1.0; see docs/upstream.md.
// Normalization, reports, budget integration and decimal wrapper are MoonClip code.

///|
pub(all) struct SimplifyOptions {
  epsilon : Double
  mode : PathMode
} derive(Eq, Debug)

///|
pub fn SimplifyOptions::new(
  epsilon? : Double = 0.0,
  mode? : PathMode = Closed,
) -> SimplifyOptions {
  { epsilon: if epsilon == 0.0 { 0.0 } else { epsilon }, mode, }
}

///|
pub impl Default for SimplifyOptions with fn default() {
  SimplifyOptions::new()
}

///|
priv struct SimplifyReport {
  removed : Int
  per_path : Array[Int]
  before : Array[Int]
  after : Array[Int]
  collapsed : Array[Int]
} derive(Debug)

///|
pub struct SimplifyResult {
  priv stored_paths : Paths64
  priv report : SimplifyReport
} derive(Debug)

///|
pub fn SimplifyResult::paths(self : SimplifyResult) -> Paths64 {
  copy_paths(self.stored_paths)
}

///|
pub fn SimplifyResult::removed_vertices(self : SimplifyResult) -> Int {
  self.report.removed
}

///|
pub fn SimplifyResult::removed_per_path(self : SimplifyResult) -> Array[Int] {
  self.report.per_path.copy()
}

///|
pub fn SimplifyResult::input_degenerate_indices(
  self : SimplifyResult,
) -> Array[Int] {
  self.report.before.copy()
}

///|
pub fn SimplifyResult::degenerate_indices(self : SimplifyResult) -> Array[Int] {
  self.report.after.copy()
}

///|
pub fn SimplifyResult::collapsed_indices(self : SimplifyResult) -> Array[Int] {
  self.report.collapsed.copy()
}

///|
pub struct SimplifyResultD {
  priv stored_paths : PathsD
  priv report : SimplifyReport
} derive(Debug)

///|
pub fn SimplifyResultD::paths(self : SimplifyResultD) -> PathsD {
  copy_paths_d(self.stored_paths)
}

///|
pub fn SimplifyResultD::removed_vertices(self : SimplifyResultD) -> Int {
  self.report.removed
}

///|
pub fn SimplifyResultD::removed_per_path(self : SimplifyResultD) -> Array[Int] {
  self.report.per_path.copy()
}

///|
pub fn SimplifyResultD::input_degenerate_indices(
  self : SimplifyResultD,
) -> Array[Int] {
  self.report.before.copy()
}

///|
pub fn SimplifyResultD::degenerate_indices(
  self : SimplifyResultD,
) -> Array[Int] {
  self.report.after.copy()
}

///|
pub fn SimplifyResultD::collapsed_indices(self : SimplifyResultD) -> Array[Int] {
  self.report.collapsed.copy()
}

///|
fn simplify_epsilon(epsilon : Double) -> Double raise ScanAbort {
  let loc = location(SimplifyParameters, None, None)
  if epsilon.is_nan() || epsilon.is_inf() || epsilon < 0.0 {
    raise ScanAbort(
      InvalidInput(loc, "Epsilon must be finite and non-negative"),
    )
  }
  let square = epsilon * epsilon
  if square.is_inf() || square.is_nan() {
    raise ScanAbort(NumericFailure(loc, "Epsilon squared must be finite"))
  }
  square
}

///|
fn simplify_charge(
  budget : CallBudget,
  nodes : Int,
  work : Int,
  stage : Stage,
  index : Int,
  vertex? : Int,
) -> Unit raise ScanAbort {
  budget_spend(budget, nodes, work, location(stage, Some(index), vertex))
}

///|
fn simplify_normalize(
  path : Path64,
  mode : PathMode,
  budget : CallBudget,
  index : Int,
  stage : Stage,
) -> Path64 raise ScanAbort {
  simplify_charge(budget, 1, 0, stage, index)
  let result : Path64 = []
  for i = 0; i < path.length(); i = i + 1 {
    simplify_charge(budget, 0, 1, stage, index, vertex=i)
    if result.is_empty() || result[result.length() - 1] != path[i] {
      simplify_charge(budget, 1, 0, stage, index, vertex=i)
      result.push(path[i])
    }
  }
  if mode == Closed &&
    result.length() > 1 &&
    result[0] == result[result.length() - 1] {
    ignore(result.pop())
  }
  result
}

///|
// Exact structural classification, independent of signed area and local Double distance.
fn simplify_degenerate(
  path : Path64,
  mode : PathMode,
  budget : CallBudget,
  index : Int,
) -> Bool raise ScanAbort {
  if path.is_empty() {
    return true
  }
  let a = path[0]
  let mut b : Point64? = None
  for i = 1; i < path.length(); i = i + 1 {
    simplify_charge(budget, 0, 1, SimplifyReport, index, vertex=i)
    if path[i] != a {
      b = Some(path[i])
      break
    }
  }
  guard b is Some(second) else { return true }
  if mode == Open {
    return false
  }
  for i = 0; i < path.length(); i = i + 1 {
    simplify_charge(budget, 0, 1, SimplifyReport, index, vertex=i)
    if cross_validated(a, second, path[i]) != 0L {
      return false
    }
  }
  true
}

///|
fn simplify_distance(
  point : Point64,
  line1 : Point64,
  line2 : Point64,
  budget : CallBudget,
  index : Int,
  vertex : Int,
) -> Double raise ScanAbort {
  let loc = location(SimplifyEvaluate, Some(index), Some(vertex))
  budget_spend(budget, 0, 1, loc)
  // Convert the bounded integer differences, then retain upstream operation order.
  let a = (point.x - line1.x).to_double()
  let b = (point.y - line1.y).to_double()
  let c = (line2.x - line1.x).to_double()
  let d = (line2.y - line1.y).to_double()
  if c == 0.0 && d == 0.0 {
    return 0.0
  }
  let ad = a * d
  let cb = c * b
  let determinant = ad - cb
  let numerator = determinant * determinant
  let cc = c * c
  let dd = d * d
  let denominator = cc + dd
  let result = numerator / denominator
  if ad.is_inf() ||
    cb.is_inf() ||
    determinant.is_inf() ||
    numerator.is_inf() ||
    cc.is_inf() ||
    dd.is_inf() ||
    denominator.is_inf() ||
    result.is_inf() ||
    result.is_nan() {
    raise ScanAbort(
      NumericFailure(loc, "Perpendicular distance must remain finite"),
    )
  }
  result
}

///|
fn simplify_neighbor(
  flags : Array[Bool],
  start : Int,
  forward : Bool,
  budget : CallBudget,
  index : Int,
) -> Int raise ScanAbort {
  let high = flags.length() - 1
  let mut current = start
  while true {
    current = if forward {
      if current == high {
        0
      } else {
        current + 1
      }
    } else if current == 0 {
      high
    } else {
      current - 1
    }
    // Charge every visited marker, including each deleted position skipped.
    simplify_charge(budget, 0, 1, SimplifyEvaluate, index, vertex=current)
    if !flags[current] {
      break
    }
  }
  current
}

///|
fn simplify_local(
  path : Path64,
  square : Double,
  mode : PathMode,
  budget : CallBudget,
  index : Int,
) -> Path64 raise ScanAbort {
  let len = path.length()
  if len < 4 {
    return path
  }
  // Both fixed-size work arrays are charged atomically before allocation.
  simplify_charge(budget, 2 + 2 * len, 0, SimplifyEvaluate, index)
  let flags = Array::make(len, false)
  let distances = Array::make(len, 0.0)
  let high = len - 1
  if mode == Closed {
    distances[0] = simplify_distance(
      path[0],
      path[high],
      path[1],
      budget,
      index,
      0,
    )
    distances[high] = simplify_distance(
      path[high],
      path[0],
      path[high - 1],
      budget,
      index,
      high,
    )
  } else {
    distances[0] = 1.7976931348623157e308
    distances[high] = 1.7976931348623157e308
  }
  for i = 1; i < high; i = i + 1 {
    distances[i] = simplify_distance(
      path[i],
      path[i - 1],
      path[i + 1],
      budget,
      index,
      i,
    )
  }
  let mut current = 0
  while true {
    simplify_charge(budget, 0, 1, SimplifyEvaluate, index, vertex=current)
    if distances[current] > square {
      let start = current
      while true {
        current = simplify_neighbor(flags, current, true, budget, index)
        simplify_charge(budget, 0, 1, SimplifyEvaluate, index, vertex=current)
        if current == start || distances[current] <= square {
          break
        }
      }
      if current == start {
        break
      }
    }
    let mut prior = simplify_neighbor(flags, current, false, budget, index)
    let mut next = simplify_neighbor(flags, current, true, budget, index)
    if next == prior {
      break
    }
    let prior2 = if distances[next] < distances[current] {
      let previous = prior
      prior = current
      current = next
      next = simplify_neighbor(flags, next, true, budget, index)
      previous
    } else {
      simplify_neighbor(flags, prior, false, budget, index)
    }
    flags[current] = true
    current = next
    next = simplify_neighbor(flags, next, true, budget, index)
    if mode == Closed || (current != high && current != 0) {
      distances[current] = simplify_distance(
        path[current],
        path[prior],
        path[next],
        budget,
        index,
        current,
      )
    }
    if mode == Closed || (prior != 0 && prior != high) {
      distances[prior] = simplify_distance(
        path[prior],
        path[prior2],
        path[current],
        budget,
        index,
        prior,
      )
    }
  }
  simplify_charge(budget, 1, 0, SimplifyOutput, index)
  let output : Path64 = []
  for i = 0; i < len; i = i + 1 {
    simplify_charge(budget, 0, 1, SimplifyOutput, index, vertex=i)
    if !flags[i] {
      simplify_charge(budget, 1, 0, SimplifyOutput, index, vertex=i)
      output.push(path[i])
    }
  }
  output
}

///|
// The caller has validated coordinates and raw quotas; all subsequent work shares its ledger.
fn simplify_validated(
  paths : Paths64,
  options : SimplifyOptions,
  square : Double,
  budget : CallBudget,
) -> SimplifyResult raise ScanAbort {
  budget_spend(budget, 5, 0, location(SimplifyReport, None, None))
  let output : Paths64 = []
  let counts : Array[Int] = []
  let before : Array[Int] = []
  let after : Array[Int] = []
  let collapsed : Array[Int] = []
  let mut total = 0
  for i = 0; i < paths.length(); i = i + 1 {
    let normalized = simplify_normalize(
      paths[i],
      options.mode,
      budget,
      i,
      SimplifyEvaluate,
    )
    let input_bad = simplify_degenerate(normalized, options.mode, budget, i)
    let simplified = if options.epsilon == 0.0 {
      normalized
    } else {
      simplify_local(normalized, square, options.mode, budget, i)
    }
    let outcome = if options.mode == Closed {
      simplify_normalize(simplified, Closed, budget, i, SimplifyOutput)
    } else {
      simplify_charge(budget, 1, 0, SimplifyOutput, i)
      let snapshot : Path64 = []
      for j = 0; j < simplified.length(); j = j + 1 {
        simplify_charge(budget, 1, 1, SimplifyOutput, i, vertex=j)
        snapshot.push(simplified[j])
      }
      snapshot
    }
    let bad = simplify_degenerate(outcome, options.mode, budget, i)
    let count = paths[i].length() - outcome.length()
    // Raw quotas cap the sum at 100000 by default; validated Int remaining arithmetic
    // guarantees total cannot exceed the original Int input allowance even with custom limits.
    total += count
    simplify_charge(budget, 2, 1, SimplifyReport, i)
    counts.push(count)
    output.push(outcome)
    if input_bad {
      simplify_charge(budget, 1, 1, SimplifyReport, i)
      before.push(i)
    }
    if bad {
      simplify_charge(budget, 1, 1, SimplifyReport, i)
      after.push(i)
    }
    if bad && !input_bad {
      simplify_charge(budget, 1, 1, SimplifyReport, i)
      collapsed.push(i)
    }
  }
  budget_spend(budget, 2, 1, location(SimplifyReport, None, None))
  {
    stored_paths: output,
    report: { removed: total, per_path: counts, before, after, collapsed, },
  }
}

///|
fn simplify_execute(
  paths : Paths64,
  options : SimplifyOptions,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[SimplifyResult, ClipError] {
  let budget = match budget {
    Some(value) => value
    None => new_call_budget(limits)
  }
  try {
    let square = simplify_epsilon(options.epsilon)
    if budget.limits.max_nodes < 0 || budget.limits.max_work < 0 {
      raise ScanAbort(
        InvalidInput(
          location(SimplifyParameters, None, None),
          "Limits must be non-negative",
        ),
      )
    }
    if check_paths(paths, budget.limits.input, SimplifyParameters)
      is Some(error) {
      raise ScanAbort(error)
    }
    for i = 0; i < paths.length(); i = i + 1 {
      simplify_charge(budget, 0, 1, SimplifyParameters, i)
      for j = 0; j < paths[i].length(); j = j + 1 {
        simplify_charge(budget, 0, 1, SimplifyParameters, i, vertex=j)
      }
    }
    Ok(simplify_validated(paths, options, square, budget))
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
pub fn simplify_paths(
  paths : Paths64,
  options? : SimplifyOptions = Default::default(),
  limits? : Limits = Default::default(),
) -> Result[SimplifyResult, ClipError] {
  simplify_execute(paths, options, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}
