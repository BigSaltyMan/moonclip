// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Query orchestration is MoonClip code using existing exact geometry predicates.

///|
pub(all) enum TreePointLocation64 {
  Outside
  Inside(PolyNode64)
  InHole(PolyNode64)
  OnBoundary(Array[PolyNode64])
}

///|
fn tree_query_point(
  point : Point64,
  path : Path64,
  budget : CallBudget,
  loc : ErrorLocation,
) -> PointLocation raise ScanAbort {
  if path.is_empty() {
    return Outside
  }
  let mut inside = false
  let mut a = path[path.length() - 1]
  for b in path {
    budget_spend(budget, 0, 1, loc) // One exact boundary/ray edge visit.
    if point_on_segment_validated(point, a, b) {
      return OnBoundary
    }
    if (a.y > point.y) != (b.y > point.y) {
      let side = cross_validated(a, b, point)
      if (b.y > a.y && side > 0L) || (b.y < a.y && side < 0L) {
        inside = !inside
      }
    }
    a = b
  }
  if inside {
    Inside
  } else {
    Outside
  }
}

///|
fn tree_query_limits(
  budget : CallBudget,
  loc : ErrorLocation,
) -> Unit raise ScanAbort {
  let limits = budget.limits
  if limits.input.max_input_paths < 0 ||
    limits.input.max_input_vertices < 0 ||
    limits.max_nodes < 0 ||
    limits.max_work < 0 {
    raise ScanAbort(InvalidInput(loc, "Query limits must be non-negative"))
  }
}

///|
fn tree_query_size(
  tree : PolyTree64,
  budget : CallBudget,
  loc : ErrorLocation,
) -> Unit raise ScanAbort {
  let limits = budget.limits
  if tree.data.nodes.length() > limits.input.max_input_paths {
    raise ScanAbort(
      ResourceLimitExceeded(loc, InputPaths, limits.input.max_input_paths),
    )
  }
  let mut remaining = limits.input.max_input_vertices
  for node in tree.data.nodes {
    budget_spend(budget, 0, 1, loc) // Count each trusted contour without copying.
    if node.contour.length() > remaining {
      raise ScanAbort(
        ResourceLimitExceeded(
          loc,
          InputVertices,
          limits.input.max_input_vertices,
        ),
      )
    }
    remaining -= node.contour.length()
  }
}

///|
// Point and tree size are already validated; all temporary state is per point.
fn tree_locate_validated(
  tree : PolyTree64,
  point : Point64,
  budget : CallBudget,
  loc : ErrorLocation,
) -> TreePointLocation64 raise ScanAbort {
  // Boundary array and depth map containers. Depth entries cost two nodes below.
  budget_spend(budget, 2, 0, loc)
  let boundaries : Array[PolyNode64] = []
  let depths : Map[Int, Bool] = Map([])
  let mut deepest : Int? = None
  let mut deepest_depth = 0
  let mut ambiguous = false
  for i = 0; i < tree.data.nodes.length(); i = i + 1 {
    budget_spend(budget, 0, 1, loc)
    let node = tree.data.nodes[i]
    match tree_query_point(point, node.contour, budget, loc) {
      Outside => ()
      OnBoundary => {
        // One immutable node view and one result slot; each node visited once.
        budget_spend(budget, 2, 1, loc)
        boundaries.push({ data: tree.data, index: i, })
      }
      Inside => {
        budget_spend(budget, 0, 1, loc)
        if depths.contains(node.depth) {
          ambiguous = true
        } else {
          budget_spend(budget, 2, 0, loc)
          depths[node.depth] = true
        }
        if node.depth > deepest_depth {
          deepest = Some(i)
          deepest_depth = node.depth
        }
      }
    }
  }
  if !boundaries.is_empty() {
    budget_spend(budget, 1, 0, loc) // Result variant; array/views already paid.
    return OnBoundary(boundaries)
  }
  if ambiguous {
    raise ScanAbort(
      ExecutionFailure(
        loc, "Multiple contours at the same depth strictly contain the query point",
      ),
    )
  }
  match deepest {
    None => {
      budget_spend(budget, 1, 0, loc)
      Outside
    }
    Some(index) => {
      budget_spend(budget, 2, 0, loc) // Result variant and immutable node view.
      let node : PolyNode64 = { data: tree.data, index, }
      if deepest_depth % 2 == 0 {
        InHole(node)
      } else {
        Inside(node)
      }
    }
  }
}

///|
fn tree_locate_execute(
  tree : PolyTree64,
  point : Point64,
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[TreePointLocation64, ClipError] {
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
    if check_point(point, loc) is Some(error) {
      raise ScanAbort(error)
    }
    tree_query_size(tree, budget, loc)
    Ok(tree_locate_validated(tree, point, budget, loc))
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
/// Since 0.3.0: locate an integer point using existing contour depths.
/// Limits count tree contours/vertices; worst-case linear in all contour vertices.
pub fn PolyTree64::locate(
  self : PolyTree64,
  point : Point64,
  limits? : Limits = Default::default(),
) -> Result[TreePointLocation64, ClipError] {
  tree_locate_execute(self, point, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}

///|
fn tree_locate_many_execute(
  tree : PolyTree64,
  points : Array[Point64],
  limits : ScanLimits,
  budget? : CallBudget,
) -> Result[Array[TreePointLocation64], ClipError] {
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
    tree_query_size(tree, budget, loc)
    for i = 0; i < points.length(); i = i + 1 {
      let point_loc = location(PolyTreeQuery, None, Some(i))
      budget_spend(budget, 0, 2, point_loc) // Two coordinate-axis checks, even on an empty tree.
      if check_point(points[i], point_loc) is Some(error) {
        raise ScanAbort(error)
      }
    }
    // One batch container after all validation. Incremental charges avoid length arithmetic overflow.
    budget_spend(budget, 1, 0, loc)
    let results : Array[TreePointLocation64] = []
    for i = 0; i < points.length(); i = i + 1 {
      let point_loc = location(PolyTreeQuery, None, Some(i))
      let result = tree_locate_validated(tree, points[i], budget, point_loc)
      budget_spend(budget, 1, 1, point_loc) // Result slot and append; variant/views paid by locator.
      results.push(result)
    }
    Ok(results)
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
/// Since 0.3.0: locate integer points in input order with one shared query budget.
/// Limits count tree contours/vertices; error vertex_index identifies the query point.
pub fn PolyTree64::locate_many(
  self : PolyTree64,
  points : Array[Point64],
  limits? : Limits = Default::default(),
) -> Result[Array[TreePointLocation64], ClipError] {
  tree_locate_many_execute(self, points, {
    input: limits,
    max_nodes: 500000,
    max_work: 5000000,
  })
}
