///|
priv enum RefTree {
  RefNode(Int, Bool, @moonclip.Path64, Array[RefTree])
} derive(Eq, Debug)

///|
fn ref_key(tree : RefTree) -> String {
  match tree {
    RefNode(depth, hole, path, children) =>
      depth.to_string() +
      hole.to_string() +
      path.map(fn(p) { p.x.to_string() + "," + p.y.to_string() }).join(";") +
      "(" +
      children.map(ref_key).join("|") +
      ")"
  }
}

///|
fn ref_sort(nodes : Array[RefTree]) -> Array[RefTree] {
  let result = nodes.map(fn(node) {
    match node {
      RefNode(d, h, p, c) => RefNode(d, h, canonical_paths([p])[0], ref_sort(c))
    }
  })
  for i = 1; i < result.length(); i = i + 1 {
    let mut j = i
    while j > 0 && ref_key(result[j]) < ref_key(result[j - 1]) {
      let tmp = result[j]
      result[j] = result[j - 1]
      result[j - 1] = tmp
      j -= 1
    }
  }
  result
}

///|
fn ref_node(node : @moonclip.PolyNode64) -> RefTree {
  RefNode(
    node.depth(),
    node.is_hole(),
    canonical_paths([node.contour()])[0],
    ref_sort(node.children().map(ref_node)),
  )
}

///|
fn reference_tree(tree : @moonclip.PolyTree64) -> Array[RefTree] {
  ref_sort(tree.roots().map(ref_node))
}
