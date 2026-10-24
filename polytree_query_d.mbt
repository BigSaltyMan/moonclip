// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Grid recovery and decimal query adaptation are MoonClip implementations.

///|
pub(all) enum TreePointLocationD {
  Outside
  Inside(PolyNodeD)
  InHole(PolyNodeD)
  OnBoundary(Array[PolyNodeD])
}

///|
// k and s=10^digits are exact Doubles. For u=2^-53, division then
// multiplication has error <= |k|*(2*u+u*u) < 2.23e-7 < 0.5.
// All nonzero quotients here are normal. Re-decoding also verifies the snapshot.
fn decimal_tree_grid_value(
  value : Double,
  precision : Precision,
) -> Int64 raise ScanAbort {
  let loc = location(PolyTreeQuery, None, None)
  let scaled = value * decimal_scale(precision)
  if scaled.is_nan() ||
    scaled.is_inf() ||
    scaled <= -1000000000.5 ||
    scaled >= 1000000000.5 {
    raise ScanAbort(
      ExecutionFailure(
        loc, "Decimal tree coordinate cannot recover its integer grid",
      ),
    )
  }
  let grid = decimal_round(scaled)
  if decimal_value(grid, precision) != value {
    raise ScanAbort(
      ExecutionFailure(
        loc, "Decimal tree coordinate does not round-trip on its original grid",
      ),
    )
  }
  grid
}

///|
fn decimal_tree_query_size(
  tree : PolyTreeD,
  budget : CallBudget,
) -> Unit raise ScanAbort {
  let loc = location(PolyTreeQuery, None, None)
  let limits = budget.limits.input
  if tree.data.nodes.length() > limits.max_input_paths {
    raise ScanAbort(
      ResourceLimitExceeded(loc, InputPaths, limits.max_input_paths),
    )
  }
  let mut remaining = limits.max_input_vertices
  for node in tree.data.nodes {
    budget_spend(budget, 0, 1, loc)
    if node.contour.length() > remaining {
      raise ScanAbort(
        ResourceLimitExceeded(loc, InputVertices, limits.max_input_vertices),
      )
    }
    remaining -= node.contour.length()
  }
}

///|
// Deep-copy coordinates and index arrays once per call, without topology evaluation.
// Like decimal_tree_output: 4+5*N+2*V nodes, 1+2*N+V work. No retained grid cache.
fn decimal_tree_query_grid(
  tree : PolyTreeD,
  budget : CallBudget,
) -> PolyTree64 raise ScanAbort {
  let loc = location(PolyTreeQuery, None, None)
  budget_spend(budget, 1, 0, loc)
  let nodes : Array[TreeNode] = []
  budget_spend(budget, 1, 0, loc)
  let roots : Array[Int] = []
  for node in tree.data.nodes {
    budget_spend(budget, 4, 1, loc) // Node, slot, contour container, children container.
    let contour : Path64 = []
    let children : Array[Int] = []
    for point in node.contour {
      // Point and slot; both axis recoveries and round-trip checks are one vertex work.
      budget_spend(budget, 2, 1, loc)
      contour.push(
        Point64::new(
          decimal_tree_grid_value(point.x, tree.data.precision),
          decimal_tree_grid_value(point.y, tree.data.precision),
        ),
      )
    }
    for index in node.children {
      budget_spend(budget, 1, 1, loc)
      children.push(index)
    }
    nodes.push({ contour, parent: node.parent, children, depth: node.depth, })
  }
  for index in tree.data.roots {
    budget_spend(budget, 1, 1, loc)
    roots.push(index)
  }
  budget_spend(budget, 2, 1, loc) // Data and tree wrappers.
  { data: { nodes, roots, }, }
}

///|
fn decimal_tree_query_point(
  point : PointD,
  precision : Precision,
  budget : CallBudget,
  loc : ErrorLocation,
) -> Point64 raise ScanAbort {
  budget_spend(budget, 1, 2, loc) // Quantized point, two axis validations; no collision table.
  Point64::new(
    decimal_coordinate(point.x, X, precision, loc),
    decimal_coordinate(point.y, Y, precision, loc),
  )
}

///|
fn decimal_tree_query_result(
  tree : PolyTreeD,
  located : TreePointLocation64,
  budget : CallBudget,
  loc : ErrorLocation,
) -> TreePointLocationD raise ScanAbort {
  match located {
    Outside => {
      budget_spend(budget, 1, 1, loc)
      Outside
    }
    Inside(node) => {
      budget_spend(budget, 2, 1, loc) // Result and view into original decimal storage.
      Inside({ data: tree.data, index: node.index, })
    }
    InHole(node) => {
      budget_spend(budget, 2, 1, loc)
      InHole({ data: tree.data, index: node.index, })
    }
    OnBoundary(nodes) => {
      budget_spend(budget, 2, 1, loc) // New decimal boundary array and result variant.
      let mapped : Array[PolyNodeD] = []
      for node in nodes {
        budget_spend(budget, 2, 1, loc) // Decimal view and its array slot.
        mapped.push({ data: tree.data, index: node.index, })
      }
      OnBoundary(mapped)
    }
  }
}

///|
fn decimal_tree_locate_execute(
  tree : PolyTreeD,
  point : PointD,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[TreePointLocationD, ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=PolyTreeQuery,
        cleanup_stage=PolyTreeQuery,
      )
  }
  let loc = location(PolyTreeQuery, None, None)
  try {
    tree_query_limits(budget, loc)
    let point = decimal_tree_query_point(
      point,
      tree.data.precision,
      budget,
      loc,
    )
    decimal_tree_query_size(tree, budget)
    let grid = decimal_tree_query_grid(tree, budget)
    Ok(
      decimal_tree_query_result(
        tree,
        tree_locate_validated(grid, point, budget, loc),
        budget,
        loc,
      ),
    )
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
fn decimal_tree_locate_many_execute(
  tree : PolyTreeD,
  points : Array[PointD],
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Array[TreePointLocationD], ClipError] {
  let budget = match budget {
    Some(value) => value
    None =>
      new_call_budget(
        limits,
        generate_stage=PolyTreeQuery,
        cleanup_stage=PolyTreeQuery,
      )
  }
  let loc = location(PolyTreeQuery, None, None)
  try {
    tree_query_limits(budget, loc)
    budget_spend(budget, 1, 0, loc) // Quantized query array.
    let quantized : Array[Point64] = []
    for i = 0; i < points.length(); i = i + 1 {
      let point_loc = location(PolyTreeQuery, None, Some(i))
      let point = decimal_tree_query_point(
        points[i],
        tree.data.precision,
        budget,
        point_loc,
      )
      budget_spend(budget, 1, 0, point_loc) // Quantized point slot.
      quantized.push(point)
    }
    decimal_tree_query_size(tree, budget)
    let grid = decimal_tree_query_grid(tree, budget)
    budget_spend(budget, 1, 0, loc) // Batch result array only after complete precheck/recovery.
    let results : Array[TreePointLocationD] = []
    for i = 0; i < quantized.length(); i = i + 1 {
      let point_loc = location(PolyTreeQuery, None, Some(i))
      let located = tree_locate_validated(grid, quantized[i], budget, point_loc)
      let mapped = decimal_tree_query_result(tree, located, budget, point_loc)
      budget_spend(budget, 1, 1, point_loc) // Batch result slot and append.
      results.push(mapped)
    }
    Ok(results)
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
/// Unreleased: quantize a point with this tree's original Precision, then locate exactly.
pub fn PolyTreeD::locate(
  self : PolyTreeD,
  point : PointD,
  limits? : Limits = Default::default(),
) -> Result[TreePointLocationD, ClipError] {
  decimal_tree_locate_execute(self, point, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
/// Unreleased: ordered queries share one temporary grid view and budget.
/// Query points may quantize together; error vertex_index identifies the query point.
pub fn PolyTreeD::locate_many(
  self : PolyTreeD,
  points : Array[PointD],
  limits? : Limits = Default::default(),
) -> Result[Array[TreePointLocationD], ClipError] {
  decimal_tree_locate_many_execute(self, points, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}
