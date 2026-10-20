// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Decimal storage and metered adaptation of MoonClip's validated integer tree.

///|
// Retain parent indices for exact topology correspondence; no public parent view.
#warnings("-unused_field")
priv struct TreeNodeD {
  contour : PathD
  parent : Int?
  children : Array[Int]
  depth : Int
}

///|
priv struct TreeDataD {
  nodes : Array[TreeNodeD]
  roots : Array[Int]
}

///|
/// Immutable topology from the quantized integer region. Introduced in 0.2.0.
pub struct PolyTreeD {
  priv data : TreeDataD
}

///|
pub struct PolyNodeD {
  priv data : TreeDataD
  priv index : Int
}

///|
/// Returns a fresh array of immutable views. Root contours have depth one.
pub fn PolyTreeD::roots(self : PolyTreeD) -> Array[PolyNodeD] {
  self.data.roots.map(fn(index) { { data: self.data, index, } })
}

///|
/// Copies both array levels; explicit parent-child relationships are discarded.
pub fn PolyTreeD::to_paths(self : PolyTreeD) -> PathsD {
  self.data.nodes.map(fn(node) { node.contour.copy() })
}

///|
pub fn PolyNodeD::contour(self : PolyNodeD) -> PathD {
  self.data.nodes[self.index].contour.copy()
}

///|
pub fn PolyNodeD::children(self : PolyNodeD) -> Array[PolyNodeD] {
  self.data.nodes[self.index].children.map(fn(index) {
    { data: self.data, index, }
  })
}

///|
pub fn PolyNodeD::depth(self : PolyNodeD) -> Int {
  self.data.nodes[self.index].depth
}

///|
pub fn PolyNodeD::is_hole(self : PolyNodeD) -> Bool {
  self.depth() % 2 == 0
}

///|
// Logical allocation units (not bytes): 4 + 5*N + 2*V, since the total
// root/child index count equals N. Work: 1 + 2*N + V. Charge before allocating;
// no refund for the integer tree. Every failure uses output, never input indices.
fn decimal_tree_output(
  tree : PolyTree64,
  precision : Precision,
  budget : CallBudget,
) -> PolyTreeD raise ScanAbort {
  let loc = location(DecimalOutput, None, None)
  decimal_spend(budget, 1, 0, loc)
  let nodes : Array[TreeNodeD] = []
  decimal_spend(budget, 1, 0, loc)
  let roots : Array[Int] = []
  for node in tree.data.nodes {
    // Node record, node slot, contour container, child-index container.
    decimal_spend(budget, 4, 1, loc)
    let contour : PathD = []
    let children : Array[Int] = []
    for p in node.contour {
      // Immutable PointD and its array slot; both coordinate decodes are one
      // vertex work unit, matching decimal_output's existing convention.
      decimal_spend(budget, 2, 1, loc)
      contour.push(
        PointD::new(
          decimal_value(p.x, precision),
          decimal_value(p.y, precision),
        ),
      )
    }
    for index in node.children {
      decimal_spend(budget, 1, 1, loc)
      children.push(index)
    }
    nodes.push({ contour, parent: node.parent, children, depth: node.depth, })
  }
  for index in tree.data.roots {
    decimal_spend(budget, 1, 1, loc)
    roots.push(index)
  }
  decimal_spend(budget, 2, 1, loc)
  { data: { nodes, roots, }, }
}
