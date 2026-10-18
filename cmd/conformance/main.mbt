///|
#borrow(payload)
extern "C" fn report(payload : Bytes) -> Int = "moonclip_report"

///|
extern "C" fn exit_code(code : Int) -> Unit = "moonclip_exit"

///|
fn actual_case(
  case_id : String,
  digest : String,
  result : Result[@moonclip.Paths64, @moonclip.ClipError],
  tree : Result[@moonclip.PolyTree64, @moonclip.ClipError],
) -> Json {
  let tree_result = match tree {
    Ok(value) =>
      Json::object({ "status": "success".to_json(), "tree": actual_tree(value) })
    Err(error) =>
      Json::object({
        "status": "error".to_json(),
        "error": error.message().to_json(),
      })
  }
  match result {
    Ok(paths) =>
      Json::object({
        "tree_result": tree_result,
        "case_id": case_id.to_json(),
        "input_sha256": digest.to_json(),
        "status": "success".to_json(),
        "paths": paths
        .map(fn(path) { path.map(fn(p) { [p.x.to_int(), p.y.to_int()] }) })
        .to_json(),
      })
    Err(error) =>
      Json::object({
        "tree_result": tree_result,
        "case_id": case_id.to_json(),
        "input_sha256": digest.to_json(),
        "status": "error".to_json(),
        "error": error.message().to_json(),
      })
  }
}

///|
fn main {
  let envelope = Json::object({
    "args": @env.args().to_json(),
    "results": run_cases().to_json(),
  })
  exit_code(report(@utf8.encode(envelope.stringify())))
}

///|
priv struct JsonFrame {
  path : @moonclip.Path64?
  pending : Array[@moonclip.PolyNode64]
  built : Array[Json]
}

///|
fn actual_tree(tree : @moonclip.PolyTree64) -> Json {
  let stack : Array[JsonFrame] = [
    { path: None, pending: tree.roots(), built: [], },
  ]
  while !stack.is_empty() {
    let frame = stack[stack.length() - 1]
    if frame.pending.pop() is Some(node) {
      stack.push({
        path: Some(node.contour()),
        pending: node.children(),
        built: [],
      })
    } else {
      ignore(stack.pop())
      let value = match frame.path {
        None => Json::object({ "children": frame.built.to_json() })
        Some(path) =>
          Json::object({
            "path": path.map(fn(p) { [p.x.to_int(), p.y.to_int()] }).to_json(),
            "children": frame.built.to_json(),
          })
      }
      if stack.is_empty() {
        return value
      }
      stack[stack.length() - 1].built.push(value)
    }
  }
  Json::object({ "children": Json::array([]) })
}
