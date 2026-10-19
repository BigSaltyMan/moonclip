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
    "offset_results": run_offset_cases().to_json(),
    "stroke_results": run_stroke_cases().to_json(),
    "composition_results": run_composition_cases().to_json(),
    "decimal_results": run_decimal_cases().to_json(),
    "simplify_results": run_simplify_cases().to_json(),
    "minkowski_results": run_minkowski_cases().to_json(),
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

///|
fn actual_offset_case(
  case_id : String,
  digest : String,
  result : Result[@moonclip.Paths64, @moonclip.ClipError],
) -> Json {
  match result {
    Ok(paths) =>
      Json::object({
        "case_id": case_id.to_json(),
        "input_sha256": digest.to_json(),
        "status": "success".to_json(),
        "paths": paths
        .map(fn(path) { path.map(fn(p) { [p.x.to_int(), p.y.to_int()] }) })
        .to_json(),
      })
    Err(error) =>
      Json::object({
        "case_id": case_id.to_json(),
        "input_sha256": digest.to_json(),
        "status": "error".to_json(),
        "error": error.message().to_json(),
      })
  }
}

///|
fn composition_failure(
  id : String,
  digest : String,
  step : Int,
  error : @moonclip.ClipError,
  intermediate? : @moonclip.Paths64,
) -> Json {
  let fields : Map[String, Json] = {
    "case_id": id.to_json(),
    "input_sha256": digest.to_json(),
    "status": "error".to_json(),
    "failure_step": step.to_json(),
    "error": error.message().to_json(),
  }
  if intermediate is Some(value) {
    fields["intermediate"] = Json::object({ "paths": composition_paths(value) })
  }
  Json::object(fields)
}

///|
fn composition_paths(value : @moonclip.Paths64) -> Json {
  value
  .map(fn(path) { path.map(fn(p) { [p.x.to_int(), p.y.to_int()] }) })
  .to_json()
}

///|
fn composition_success(
  id : String,
  digest : String,
  recipe : String,
  intermediate : @moonclip.Paths64,
  outcome : @moonclip.Paths64,
  tree? : Json,
) -> Json {
  let result : Map[String, Json] = { "paths": composition_paths(outcome) }
  if tree is Some(value) {
    result["tree"] = value
  }
  Json::object({
    "case_id": id.to_json(),
    "input_sha256": digest.to_json(),
    "status": "success".to_json(),
    "format_version": (4).to_json(),
    "recipe": recipe.to_json(),
    "intermediate": Json::object({ "paths": composition_paths(intermediate) }),
    "final": Json::object(result),
  })
}

///|
fn decimal_json_integer(value : Double) -> Int {
  let whole = value.to_int64()
  let fraction = value - whole.to_double()
  (if fraction >= 0.5 {
    whole + 1L
  } else if fraction <= -0.5 {
    whole - 1L
  } else {
    whole
  }).to_int()
}

///|
fn actual_decimal_case(
  id : String,
  digest : String,
  operation : String,
  route : String,
  digits : Int,
  result : Result[@moonclip.PathsD, @moonclip.ClipError],
) -> Json {
  match result {
    Err(error) =>
      Json::object({
        "case_id": id.to_json(),
        "input_sha256": digest.to_json(),
        "status": "error".to_json(),
        "error": error.message().to_json(),
      })
    Ok(paths) => {
      let scale = match digits {
        0 => 1.0
        1 => 10.0
        2 => 100.0
        3 => 1000.0
        4 => 10000.0
        5 => 100000.0
        _ => 1000000.0
      }
      let grids = paths.map(fn(path) {
        path.map(fn(p) {
          [decimal_json_integer(p.x * scale), decimal_json_integer(p.y * scale)]
        })
      })
      let decimals = paths.map(fn(path) { path.map(fn(p) { [p.x, p.y] }) })
      Json::object({
        "case_id": id.to_json(),
        "input_sha256": digest.to_json(),
        "status": "success".to_json(),
        "format_version": (5).to_json(),
        "operation": operation.to_json(),
        "reference_route": route.to_json(),
        "precision": digits.to_json(),
        "grid_paths": grids.to_json(),
        "paths": decimals.to_json(),
      })
    }
  }
}

///|
fn simplify_json(value : @moonclip.SimplifyResult) -> Map[String, Json] {
  let paths = value.paths()
  {
    "paths": composition_paths(paths),
    "removed_vertices": value.removed_vertices().to_json(),
    "removed_per_path": value.removed_per_path().to_json(),
    "input_degenerate_indices": value.input_degenerate_indices().to_json(),
    "degenerate_indices": value.degenerate_indices().to_json(),
    "collapsed_indices": value.collapsed_indices().to_json(),
  }
}

///|
fn simplify_json_d(
  value : @moonclip.SimplifyResultD,
  scale : Double,
) -> Map[String, Json] {
  let paths = value.paths()
  {
    "paths": paths
    .map(fn(path) {
      path.map(fn(p) {
        [decimal_json_integer(p.x * scale), decimal_json_integer(p.y * scale)]
      })
    })
    .to_json(),
    "paths_d": paths.map(fn(path) { path.map(fn(p) { [p.x, p.y] }) }).to_json(),
    "removed_vertices": value.removed_vertices().to_json(),
    "removed_per_path": value.removed_per_path().to_json(),
    "input_degenerate_indices": value.input_degenerate_indices().to_json(),
    "degenerate_indices": value.degenerate_indices().to_json(),
    "collapsed_indices": value.collapsed_indices().to_json(),
  }
}

///|
fn actual_simplify_case(
  id : String,
  digest : String,
  operation : String,
  mode : String,
  precision : Int,
  result : Result[Map[String, Json], @moonclip.ClipError],
) -> Json {
  let fields : Map[String, Json] = {
    "case_id": id.to_json(),
    "input_sha256": digest.to_json(),
  }
  match result {
    Err(error) => {
      fields["status"] = "error".to_json()
      fields["error"] = error.message().to_json()
    }
    Ok(payload) => {
      for k, v in payload {
        fields[k] = v
      }
      fields["status"] = "success".to_json()
      fields["format_version"] = (6).to_json()
      fields["operation"] = operation.to_json()
      fields["mode"] = mode.to_json()
      fields["reference_route"] = (if operation == "SimplifyD" {
        "DecimalGrid"
      } else {
        "Integer"
      }).to_json()
      if operation == "SimplifyD" {
        fields["precision"] = precision.to_json()
      }
    }
  }
  Json::object(fields)
}

///|
fn actual_minkowski_case(
  id : String,
  digest : String,
  result : Result[@moonclip.Paths64, @moonclip.ClipError],
) -> Json {
  let fields : Map[String, Json] = {
    "case_id": id.to_json(),
    "input_sha256": digest.to_json(),
  }
  match result {
    Err(error) => {
      fields["status"] = "error".to_json()
      fields["error"] = error.message().to_json()
    }
    Ok(paths) => {
      fields["status"] = "success".to_json()
      fields["format_version"] = (7).to_json()
      fields["operation"] = "MinkowskiSum".to_json()
      fields["fill_rule"] = "NonZero".to_json()
      fields["options"] = Json::object({
        "preserve_collinear": true.to_json(),
        "reverse_solution": false.to_json(),
      })
      fields["paths"] = composition_paths(paths)
    }
  }
  Json::object(fields)
}
