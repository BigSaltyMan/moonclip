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
) -> PointLocation raise ScanAbort {
  let loc = location(PolyTreeQuery, None, None)
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
    let limits = budget.limits
    if limits.input.max_input_paths < 0 ||
      limits.input.max_input_vertices < 0 ||
      limits.max_nodes < 0 ||
      limits.max_work < 0 {
      raise ScanAbort(InvalidInput(loc, "Query limits must be non-negative"))
    }
    if check_point(point, loc) is Some(error) {
      raise ScanAbort(error)
    }
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
      match tree_query_point(point, node.contour, budget) {
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
      return Ok(OnBoundary(boundaries))
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
        Ok(Outside)
      }
      Some(index) => {
        budget_spend(budget, 2, 0, loc) // Result variant and immutable node view.
        let node : PolyNode64 = { data: tree.data, index, }
        Ok(if deepest_depth % 2 == 0 { InHole(node) } else { Inside(node) })
      }
    }
  } catch {
    ScanAbort(error) => Err(error)
  }
}

///|
/// Unreleased: locate an integer point using existing contour depths.
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
