// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Ownership concepts from Clipper2, Copyright (c) Angus Johnson 2010-2025.
// Exact segment subdivision and immutable index views are MoonClip implementations.

///|
priv struct TreeNode {
  contour : Path64
  parent : Int?
  children : Array[Int]
  mut depth : Int
}

///|
priv struct TreeData {
  nodes : Array[TreeNode]
  roots : Array[Int]
}

///|
pub struct PolyTree64 {
  priv data : TreeData
}

///|
pub struct PolyNode64 {
  priv data : TreeData
  priv index : Int
}

///|
/// A new array of immutable node views; virtual root has no contour.
pub fn PolyTree64::roots(self : PolyTree64) -> Array[PolyNode64] {
  self.data.roots.map(fn(index) { { data: self.data, index, } })
}

///|
/// Copies every contour and both array levels. Ordering is unspecified.
pub fn PolyTree64::to_paths(self : PolyTree64) -> Paths64 {
  self.data.nodes.map(fn(node) { copy_path(node.contour) })
}

///|
pub fn PolyNode64::contour(self : PolyNode64) -> Path64 {
  copy_path(self.data.nodes[self.index].contour)
}

///|
pub fn PolyNode64::children(self : PolyNode64) -> Array[PolyNode64] {
  self.data.nodes[self.index].children.map(fn(index) {
    { data: self.data, index, }
  })
}

///|
pub fn PolyNode64::depth(self : PolyNode64) -> Int {
  self.data.nodes[self.index].depth
}

///|
pub fn PolyNode64::is_hole(self : PolyNode64) -> Bool {
  self.depth() % 2 == 0
}

///|
fn[T] tree_error(state : ScanState, message : String) -> T raise ScanAbort {
  scan_abort(state, ExecutionFailure(location(PolyTree, None, None), message))
}

///|
fn tree_spend(
  state : ScanState,
  nodes : Int,
  work : Int,
) -> Unit raise ScanAbort {
  output_spend(state, nodes, work, loc=location(PolyTree, None, None))
}

///|
// Query coordinates have denominator two. Sums stay in +/-2e9, differences
// in +/-4e9; a conservative determinant bound is 3.2e19, so multiply
// as BigInt, never Int64.
fn tree_point(
  state : ScanState,
  x2 : Int64,
  y2 : Int64,
  path : Path64,
) -> PointLocation raise ScanAbort {
  let mut inside = false
  let mut a = path[path.length() - 1]
  for b in path {
    tree_spend(state, 0, 1)
    let cross = BigInt::from_int64(b.x - a.x) *
      BigInt::from_int64(y2 - 2L * a.y) -
      BigInt::from_int64(b.y - a.y) * BigInt::from_int64(x2 - 2L * a.x)
    if cross == 0N &&
      x2 >= 2L * min64(a.x, b.x) &&
      x2 <= 2L * max64(a.x, b.x) &&
      y2 >= 2L * min64(a.y, b.y) &&
      y2 <= 2L * max64(a.y, b.y) {
      return OnBoundary
    }
    if (2L * a.y > y2) != (2L * b.y > y2) &&
      ((b.y > a.y && cross > 0N) || (b.y < a.y && cross < 0N)) {
      inside = !inside
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
// Test all vertices AND every open subsegment between boundary contacts.
// Proper crossings disprove containment. Parent vertices on the tested edge
// partition all remaining possible interior/exterior transitions exactly.
fn tree_contains(
  state : ScanState,
  outer : Path64,
  inner : Path64,
) -> Bool raise ScanAbort {
  let mut has_inside = false
  for i = 0; i < inner.length(); i = i + 1 {
    let a = inner[i]
    let b = inner[(i + 1) % inner.length()]
    match tree_point(state, 2L * a.x, 2L * a.y, outer) {
      Outside => return false
      Inside => has_inside = true
      OnBoundary => ()
    }
    tree_spend(state, 3, 1)
    let cuts = [a, b]
    let mut p = outer[outer.length() - 1]
    for q in outer {
      tree_spend(state, 0, 1)
      if strict_segment_cross(a, b, p, q) {
        return false
      }
      if point_on_segment_validated(q, a, b) {
        tree_spend(state, 1, 1)
        cuts.push(q)
      }
      p = q
    }
    let x_axis = a.x != b.x
    for j = 1; j < cuts.length(); j = j + 1 {
      let mut k = j
      while k > 0 {
        tree_spend(state, 0, 1)
        let previous = if x_axis { cuts[k - 1].x } else { cuts[k - 1].y }
        let current = if x_axis { cuts[k].x } else { cuts[k].y }
        if previous <= current {
          break
        }
        let temp = cuts[k - 1]
        cuts[k - 1] = cuts[k]
        cuts[k] = temp
        k -= 1
      }
    }
    for j = 1; j < cuts.length(); j = j + 1 {
      if cuts[j - 1] == cuts[j] {
        continue
      }
      match
        tree_point(
          state,
          cuts[j - 1].x + cuts[j].x,
          cuts[j - 1].y + cuts[j].y,
          outer,
        ) {
        Outside => return false
        Inside => has_inside = true
        OnBoundary => ()
      }
    }
  }
  // Identical boundaries alone are not strict geometric ownership.
  has_inside
}

///|
fn tree_bounds(
  state : ScanState,
  id : OutRecId,
  path : Path64,
) -> Bounds64 raise ScanAbort {
  let rec = state.output.records[id]
  if rec.bounds_cache is Some((revision, bounds)) && revision == rec.revision {
    return bounds
  }
  tree_spend(state, 1, path.length())
  let mut min_x = path[0].x
  let mut max_x = min_x
  let mut min_y = path[0].y
  let mut max_y = min_y
  for p in path {
    min_x = min64(min_x, p.x)
    max_x = max64(max_x, p.x)
    min_y = min64(min_y, p.y)
    max_y = max64(max_y, p.y)
  }
  let bounds : Bounds64 = { min_x, min_y, max_x, max_y, }
  rec.bounds_cache = Some((rec.revision, bounds))
  bounds
}

///|
fn tree_box_contains(a : Bounds64, b : Bounds64) -> Bool {
  a.min_x <= b.min_x &&
  a.min_y <= b.min_y &&
  a.max_x >= b.max_x &&
  a.max_y >= b.max_y
}

///|
fn tree_hint(state : ScanState, hint : OutRecId?) -> OutRecId? raise ScanAbort {
  let mut current = hint
  for steps = 0; steps <= state.output.records.length(); steps = steps + 1 {
    tree_spend(state, 0, 1)
    guard current is Some(id) else { return None }
    if id < 0 || id >= state.output.records.length() {
      tree_error(state, "Invalid ownership hint record")
    }
    let rec = state.output.records[id]
    match rec.status {
      Redirect(next) => current = Some(next)
      Invalid => current = rec.owner_hint
      _ => return Some(id)
    }
  }
  tree_error(state, "Cyclic ownership hints")
}

///|
// Iterative validation also works on synthetic corrupt data in whitebox tests.
fn tree_invariants(data : TreeData) -> Result[Unit, String] {
  let n = data.nodes.length()
  let seen = Array::make(n, false)
  let stack = data.roots.copy()
  for root in data.roots {
    if root < 0 ||
      root >= n ||
      data.nodes[root].parent is Some(_) ||
      data.nodes[root].depth != 1 {
      return Err("Invalid root")
    }
  }
  while stack.pop() is Some(index) {
    if index < 0 || index >= n || seen[index] {
      return Err("Duplicate cyclic or invalid tree node")
    }
    seen[index] = true
    let node = data.nodes[index]
    if node.contour.length() < 3 {
      return Err("Invalid tree contour")
    }
    for child in node.children {
      if child < 0 ||
        child >= n ||
        child == index ||
        data.nodes[child].parent != Some(index) ||
        data.nodes[child].depth != node.depth + 1 {
        return Err("Inconsistent parent child or depth")
      }
      stack.push(child)
    }
  }
  for value in seen {
    if !value {
      return Err("Unreachable tree node or parent cycle")
    }
  }
  Ok(())
}

///|
fn tree_build(state : ScanState) -> PolyTree64 raise ScanAbort {
  // Finalization may append split records. Only now create geometry caches.
  let ids = output_finalize(state, false)
  let paths = output_snapshot(state, ids)
  let n = ids.length()
  tree_spend(state, 4, 0)
  for _round = 0; _round < 3; _round = _round + 1 {
    tree_spend(state, n, n)
  }
  let boxes = ids.mapi(fn(i, id) raise ScanAbort {
    tree_bounds(state, id, paths[i])
  })
  let parents : Array[Int?] = Array::make(n, None)
  let nodes : Array[TreeNode] = []
  let roots = []
  for i = 0; i < n; i = i + 1 {
    let rec = state.output.records[ids[i]]
    let hint = tree_hint(state, rec.owner_hint)
    let mut start = 0
    for j = 0; j < n; j = j + 1 {
      tree_spend(state, 0, 1)
      if hint == Some(ids[j]) && rec.hint_inside {
        start = j
        break
      }
    }
    for step = 0; step < n; step = step + 1 {
      tree_spend(state, 0, 1)
      let j = (start + step) % n
      if i == j || !tree_box_contains(boxes[j], boxes[i]) {
        continue
      }
      if !tree_contains(state, paths[j], paths[i]) {
        continue
      }
      match parents[i] {
        None => parents[i] = Some(j)
        Some(old) =>
          if tree_box_contains(boxes[old], boxes[j]) &&
            tree_contains(state, paths[old], paths[j]) {
            parents[i] = Some(j)
          } else if !tree_box_contains(boxes[j], boxes[old]) ||
            !tree_contains(state, paths[j], paths[old]) {
            tree_error(state, "Ambiguous output containers")
          }
      }
    }
    state.output.records[ids[i]].geometric_parent = parents[i].map(fn(index) {
      ids[index]
    })
    tree_spend(state, 2, 1)
    nodes.push({
      contour: paths[i],
      parent: parents[i],
      children: [],
      depth: 0,
    })
  }
  for i = 0; i < n; i = i + 1 {
    tree_spend(state, 1, 1)
    match nodes[i].parent {
      None => roots.push(i)
      Some(parent) => nodes[parent].children.push(i)
    }
  }
  tree_spend(state, n + 1, n)
  let stack = roots.copy()
  for root in roots {
    nodes[root].depth = 1
  }
  let mut visited = 0
  while stack.pop() is Some(i) {
    tree_spend(state, 0, 1)
    visited += 1
    if visited > n {
      tree_error(state, "Cyclic geometric parents")
    }
    for child in nodes[i].children {
      nodes[child].depth = nodes[i].depth + 1
      stack.push(child)
    }
  }
  if visited != n {
    tree_error(state, "Unreachable geometric parent cycle")
  }
  let data : TreeData = { nodes, roots, }
  // Pay diagnostics and snapshots from the same remaining call budget.
  tree_spend(state, 2, 0)
  for _round = 0; _round < 2; _round = _round + 1 {
    tree_spend(state, n, n)
  }
  tree_spend(state, 0, n)
  match tree_invariants(data) {
    Ok(_) => ()
    Err(message) => tree_error(state, message)
  }
  for i = 0; i < n; i = i + 1 {
    tree_spend(state, 0, paths[i].length() + 1)
    if state.output.records[ids[i]].geometric_parent !=
      nodes[i].parent.map(fn(index) { ids[index] }) {
      tree_error(state, "Geometric parent snapshot differs")
    }
    let sum = exact_area(accumulate_area(paths[i], Small(0L)))
    if sum == 0N || (sum > 0N) != (nodes[i].depth % 2 == 1) {
      tree_error(
        state,
        "Output record \{ids[i]} winding disagrees with geometric depth",
      )
    }
  }
  let tree : PolyTree64 = { data, }
  match tree_verify_output(state, ids, tree) {
    Ok(_) => ()
    Err(message) => tree_error(state, message)
  }
  tree
}

///|
fn tree_verify_output(
  state : ScanState,
  ids : Array[OutRecId],
  tree : PolyTree64,
) -> Result[Unit, String] raise ScanAbort {
  if ids.length() != tree.data.nodes.length() {
    return Err("Tree output count mismatch")
  }
  tree_spend(
    state,
    1 + state.output.records.length(),
    state.output.records.length(),
  )
  let seen = Array::make(state.output.records.length(), false)
  for i = 0; i < ids.length(); i = i + 1 {
    tree_spend(state, 0, 1)
    let id = ids[i]
    if id < 0 || id >= seen.length() || seen[id] {
      return Err("Invalid repeated output identity")
    }
    seen[id] = true
    let rec = state.output.records[id]
    if rec.status != Closed || rec.anchor is None {
      return Err("Invalid final output record")
    }
    if rec.bounds_cache is Some((revision, _)) && revision != rec.revision {
      return Err("Stale final output geometry")
    }
    let ring = output_ring(state, rec.anchor.unwrap())
    let node = tree.data.nodes[i]
    if node.contour.length() != ring.length() {
      return Err("Tree contour vertex count mismatch")
    }
    for j = 0; j < ring.length(); j = j + 1 {
      tree_spend(state, 0, 1)
      if node.contour[j] != state.output.points[ring[j]].point {
        return Err("Tree contour differs from final output")
      }
    }
    let parent = match node.parent {
      None => None
      Some(index) => {
        if index < 0 || index >= ids.length() {
          return Err("Invalid tree parent index")
        }
        Some(ids[index])
      }
    }
    if parent != rec.geometric_parent {
      return Err("Tree parent differs from final output")
    }
  }
  for i = 0; i < seen.length(); i = i + 1 {
    tree_spend(state, 0, 1)
    if (
        state.output.records[i].status == Closed &&
        state.output.records[i].anchor is Some(_)
      ) !=
      seen[i] {
      return Err("Final output missing from tree")
    }
  }
  Ok(())
}

///|
// Empty normalization needs no extra scan. Charge both array containers and
// the data/tree wrappers before allocation, including one unit of build work.
fn tree_empty(budget : CallBudget) -> PolyTree64 raise ScanAbort {
  budget_spend(budget, 4, 1, location(PolyTree, None, None))
  { data: { nodes: [], roots: [], }, }
}

///|
fn boolean_tree_execute(
  subject : Paths64,
  clip : Paths64,
  operation : ClipType,
  limits : ScanLimits,
  rule? : WindingRule = Parity,
) -> Result[PolyTree64, ClipError] {
  boolean_compute(subject, clip, operation, limits, rule, tree_build)
}

///|
/// Closed integer Boolean result with geometric parentage. Empty is Ok(empty).
pub fn boolean_tree(
  subject : Paths64,
  clip : Paths64,
  operation : ClipType,
  fill_rule? : FillRule = EvenOdd,
  limits? : Limits = Default::default(),
) -> Result[PolyTree64, ClipError] {
  boolean_tree_execute(
    subject,
    clip,
    operation,
    { input: limits, max_nodes: 500000, max_work: 5000000, },
    rule=match fill_rule {
      EvenOdd => Parity
      NonZero => SignedNonZero
    },
  )
}
