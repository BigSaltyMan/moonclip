// Copyright (c) 2026 BigSaltyMan. BSL-1.0
// see LICENSE.
// JSON transport only: every geometry operation calls the public MoonBit library.

///|
priv suberror DemoError {
  Input(String, Int?, Int?)
  Core(@moonclip.ClipError)
  Degenerate(Json)
}

///|
fn[T] value(result : Result[T, @moonclip.ClipError]) -> T raise DemoError {
  match result {
    Ok(v) => v
    Err(e) => raise Core(e)
  }
}

///|
fn object(j : Json) -> Map[String, Json] raise DemoError {
  match j {
    Object(v) => v
    _ => raise Input("Expected JSON object", None, None)
  }
}

///|
fn text(
  m : Map[String, Json],
  key : String,
  fallback : String,
) -> String raise DemoError {
  match m.get(key) {
    None => fallback
    Some(String(v)) => v
    _ => raise Input("Expected string: " + key, None, None)
  }
}

///|
fn number(
  m : Map[String, Json],
  key : String,
  fallback : Double,
) -> Double raise DemoError {
  let n = match m.get(key) {
    None => fallback
    Some(Number(v, ..)) => v
    _ => raise Input("Expected number: " + key, None, None)
  }
  if n != n || n - n != 0.0 {
    raise Input("Expected finite number: " + key, None, None)
  }
  n
}

///|
fn flag(
  m : Map[String, Json],
  key : String,
  fallback : Bool,
) -> Bool raise DemoError {
  match m.get(key) {
    None => fallback
    Some(True) => true
    Some(False) => false
    _ => raise Input("Expected boolean: " + key, None, None)
  }
}

///|
fn coordinates(j : Json) -> @moonclip.PathsD raise DemoError {
  guard j is Array(paths) else {
    raise Input("Expected array of paths", None, None)
  }
  let result = []
  for i = 0; i < paths.length(); i = i + 1 {
    guard paths[i] is Array(points) else {
      raise Input("Expected point array", Some(i), None)
    }
    let ring = []
    for k = 0; k < points.length(); k = k + 1 {
      guard points[k] is Array([Number(x, ..), Number(y, ..)]) else {
        raise Input("Expected [x,y]", Some(i), Some(k))
      }
      if x - x != 0.0 || y - y != 0.0 {
        raise Input("Coordinates must be finite", Some(i), Some(k))
      }
      ring.push(@moonclip.PointD::new(x, y))
    }
    result.push(ring)
  }
  result
}

///|
fn integer_paths(paths : @moonclip.PathsD) -> @moonclip.Paths64 raise DemoError {
  let result = []
  for i = 0; i < paths.length(); i = i + 1 {
    let ring = []
    for k = 0; k < paths[i].length(); k = k + 1 {
      let p = paths[i][k]
      if p.x < -9007199254740991.0 ||
        p.x > 9007199254740991.0 ||
        p.y < -9007199254740991.0 ||
        p.y > 9007199254740991.0 {
        raise Input(
          "Integer coordinates must be exact JSON safe integers",
          Some(i),
          Some(k),
        )
      }
      let x = p.x.to_int64()
      let y = p.y.to_int64()
      if x.to_double() != p.x || y.to_double() != p.y {
        raise Input(
          "Integer mode requires integer coordinates",
          Some(i),
          Some(k),
        )
      }
      ring.push(@moonclip.Point64::new(x, y))
    }
    result.push(ring)
  }
  result
}

///|
fn encode_paths(paths : @moonclip.Paths64) -> Json {
  paths.map(fn(p) { p.map(fn(q) { [q.x.to_int(), q.y.to_int()] }) }).to_json()
}

///|
fn encode_decimal(paths : @moonclip.PathsD) -> Json {
  paths.map(fn(p) { p.map(fn(q) { [q.x, q.y] }) }).to_json()
}

///|
fn stats(
  removed : Int,
  per_path : Array[Int],
  input : Array[Int],
  degenerate : Array[Int],
  collapsed : Array[Int],
) -> Json {
  Json::object({
    "removed_vertices": removed.to_json(),
    "removed_per_path": per_path.to_json(),
    "input_degenerate_indices": input.to_json(),
    "degenerate_indices": degenerate.to_json(),
    "collapsed_indices": collapsed.to_json(),
  })
}

///|
fn checked_stats(report : Json) -> Unit raise DemoError {
  let m = object(report)
  for
    key in [
      "input_degenerate_indices", "degenerate_indices", "collapsed_indices",
    ] {
    if m.get(key) is Some(Array(indices)) && !indices.is_empty() {
      raise Degenerate(report)
    }
  }
}

///|
fn loc_fields(loc : @moonclip.ErrorLocation) -> Map[String, Json] {
  {
    "stage": @debug.to_string(loc.stage).to_json(),
    "path_index": index_json(loc.path_index),
    "vertex_index": index_json(loc.vertex_index),
  }
}

///|
fn library_error(error : @moonclip.ClipError) -> Json {
  let (kind, loc) = match error {
    @moonclip.InvalidInput(l, _) => ("InvalidInput", l)
    @moonclip.CoordinateOutOfRange(l, _, _) => ("CoordinateOutOfRange", l)
    @moonclip.ExecutionFailure(l, _) => ("ExecutionFailure", l)
    @moonclip.NumericFailure(l, _) => ("NumericFailure", l)
    @moonclip.ResourceLimitExceeded(l, _, _) => ("ResourceLimitExceeded", l)
    @moonclip.QuantizationFailure(l, _, _, _) => ("QuantizationFailure", l)
    @moonclip.DecimalCoordinateOutOfRange(l, _, _, _) =>
      ("DecimalCoordinateOutOfRange", l)
  }
  let m = loc_fields(loc)
  m["kind"] = kind.to_json()
  m["message"] = error.message().to_json()
  match error {
    @moonclip.CoordinateOutOfRange(_, axis, v) => {
      m["axis"] = @debug.to_string(axis).to_json()
      m["value"] = v.to_double().to_json()
    }
    @moonclip.DecimalCoordinateOutOfRange(_, axis, v, digits) => {
      m["axis"] = @debug.to_string(axis).to_json()
      m["value"] = v.to_json()
      m["precision"] = digits.to_json()
    }
    @moonclip.ResourceLimitExceeded(_, resource, limit) => {
      m["resource"] = @debug.to_string(resource).to_json()
      m["limit"] = limit.to_json()
    }
    @moonclip.QuantizationFailure(_, axis, related, _) => {
      m["axis"] = match axis {
        Some(a) => @debug.to_string(a).to_json()
        None => Json::null()
      }
      m["related"] = match related {
        Some(l) => Json::object(loc_fields(l))
        None => Json::null()
      }
    }
    _ => ()
  }
  Json::object(m)
}

///|
fn execute(request : Json) -> Json raise DemoError {
  let r = object(request)
  if number(r, "version", 1.0) != 1.0 {
    raise Input("Unknown demo bridge version", None, None)
  }
  let scene = text(r, "scene", "boolean")
  let mode = text(r, "mode", "integer")
  if mode != "integer" && mode != "decimal" {
    raise Input("Unknown coordinate mode", None, None)
  }
  if scene == "minkowski" && mode != "integer" {
    raise Input("Minkowski supports integer mode only", None, None)
  }
  let params = object(r.get("params").unwrap_or(Json::object({})))
  let simplify = object(r.get("simplify").unwrap_or(Json::object({})))
  let enabled = flag(simplify, "enabled", false)
  if enabled && scene == "minkowski" {
    raise Input("Minkowski does not apply implicit simplification", None, None)
  }
  let digits = number(r, "precision", 3.0)
  if digits < 0.0 || digits > 6.0 || digits.to_int().to_double() != digits {
    raise Input("Precision must be an integer from 0 to 6", None, None)
  }
  let precision = value(@moonclip.Precision::new(digits.to_int()))
  let operation = match text(params, "operation", "Intersection") {
    "Intersection" => @moonclip.Intersection
    "Union" => @moonclip.Union
    "Difference" => @moonclip.Difference
    "Xor" => @moonclip.Xor
    _ => raise Input("Unknown Boolean operation", None, None)
  }
  let rule = match text(params, "fill_rule", "EvenOdd") {
    "EvenOdd" => @moonclip.EvenOdd
    "NonZero" => @moonclip.NonZero
    _ => raise Input("Unknown fill rule", None, None)
  }
  let join = match text(params, "join", "Miter") {
    "Miter" => @moonclip.Miter
    "Bevel" => @moonclip.Bevel
    "Square" => @moonclip.Square
    "Round" => @moonclip.Round
    _ => raise Input("Unknown join type", None, None)
  }
  let cap = match text(params, "cap", "Butt") {
    "Butt" => @moonclip.Butt
    "Square" => @moonclip.Square
    "Round" => @moonclip.Round
    _ => raise Input("Unknown cap type", None, None)
  }
  let options = @moonclip.OffsetOptions::new(
    join~,
    miter_limit=number(params, "miter_limit", 2.0),
    arc_tolerance=number(params, "arc_tolerance", 0.0),
  )
  let empty = Json::array([])
  let first_json = if scene == "stroke" || scene == "minkowski" {
    Json::array([r.get("path").unwrap_or(empty)])
  } else {
    r.get("subject").unwrap_or(empty)
  }
  let first = coordinates(first_json)
  let second = coordinates(
    if scene == "boolean" {
      r.get("clip").unwrap_or(empty)
    } else {
      empty
    },
  )
  let split = first.length()
  let all = first.copy()
  for path in second {
    all.push(path)
  }
  let path_mode = if scene == "stroke" {
    @moonclip.Open
  } else {
    @moonclip.Closed
  }
  let mut report = Json::null()
  let paths = if mode == "decimal" {
    let prepared = if enabled {
      let simple = value(
        @moonclip.simplify_paths_d(
          all,
          precision~,
          options=@moonclip.SimplifyOptions::new(
            epsilon=number(simplify, "epsilon", 0.5),
            mode=path_mode,
          ),
        ),
      )
      report = stats(
        simple.removed_vertices(),
        simple.removed_per_path(),
        simple.input_degenerate_indices(),
        simple.degenerate_indices(),
        simple.collapsed_indices(),
      )
      checked_stats(report)
      simple.paths()
    } else {
      all
    }
    let a = prepared.iter().take(split).collect()
    let b = prepared.iter().drop(split).collect()
    encode_decimal(
      match scene {
        "boolean" =>
          value(
            @moonclip.boolean_op_d(a, b, operation, precision~, fill_rule=rule),
          )
        "offset" =>
          value(
            @moonclip.offset_polygons_d(
              a,
              number(params, "delta", 4.0),
              precision~,
              fill_rule=rule,
              options~,
            ),
          )
        "stroke" =>
          value(
            @moonclip.stroke_polyline_d(
              a[0],
              number(params, "width", 8.0),
              precision~,
              cap~,
              options~,
            ),
          )
        _ => raise Input("Unknown decimal scene", None, None)
      },
    )
  } else {
    let originals = integer_paths(all)
    let prepared = if enabled {
      let simple = value(
        @moonclip.simplify_paths(
          originals,
          options=@moonclip.SimplifyOptions::new(
            epsilon=number(simplify, "epsilon", 0.5),
            mode=path_mode,
          ),
        ),
      )
      report = stats(
        simple.removed_vertices(),
        simple.removed_per_path(),
        simple.input_degenerate_indices(),
        simple.degenerate_indices(),
        simple.collapsed_indices(),
      )
      checked_stats(report)
      simple.paths()
    } else {
      originals
    }
    let a = prepared.iter().take(split).collect()
    let b = prepared.iter().drop(split).collect()
    encode_paths(
      match scene {
        "boolean" =>
          value(@moonclip.boolean_op(a, b, operation, fill_rule=rule))
        "offset" =>
          value(
            @moonclip.offset_polygons(
              a,
              number(params, "delta", 4.0),
              fill_rule=rule,
              options~,
            ),
          )
        "stroke" =>
          value(
            @moonclip.stroke_polyline(
              a[0],
              number(params, "width", 8.0),
              cap~,
              options~,
            ),
          )
        "minkowski" => {
          let pattern = integer_paths(
            coordinates(Json::array([r.get("pattern").unwrap_or(empty)])),
          )
          value(
            @moonclip.minkowski_sum(
              pattern[0],
              a[0],
              flag(params, "path_is_closed", false),
            ),
          )
        }
        _ => raise Input("Unknown integer scene", None, None)
      },
    )
  }
  Json::object({
    "ok": true.to_json(),
    "kernel": "MoonBit".to_json(),
    "scene": scene.to_json(),
    "mode": mode.to_json(),
    "precision": if mode == "decimal" {
      digits.to_json()
    } else {
      Json::null()
    },
    "paths": paths,
    "simplification": report,
  })
}

///|
pub fn compute(input : String) -> String {
  let parsed = @json.parse(input) catch {
    _ =>
      return Json::object({
        "ok": false.to_json(),
        "error": Json::object({
          "kind": "InvalidJSON".to_json(),
          "stage": "BridgeInput".to_json(),
          "message": "Invalid JSON request".to_json(),
        }),
      }).stringify()
  }
  execute(parsed).stringify() catch {
    Input(message, path, vertex) =>
      Json::object({
        "ok": false.to_json(),
        "error": Json::object({
          "kind": "InvalidInput".to_json(),
          "stage": "BridgeInput".to_json(),
          "message": message.to_json(),
          "path_index": index_json(path),
          "vertex_index": index_json(vertex),
        }),
      }).stringify()
    Core(error) =>
      Json::object({ "ok": false.to_json(), "error": library_error(error) }).stringify()
    Degenerate(report) =>
      Json::object({
        "ok": false.to_json(),
        "simplification": report,
        "error": Json::object({
          "kind": "DegenerateAfterSimplification".to_json(),
          "stage": "SimplifyReport".to_json(),
          "message": "Review degenerate paths before running the geometry operation".to_json(),
        }),
      }).stringify()
  }
}

///|
fn index_json(index : Int?) -> Json {
  match index {
    Some(v) => v.to_json()
    None => Json::null()
  }
}
