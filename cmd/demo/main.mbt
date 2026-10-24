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
// One breadth-first traversal assigns both contour and node indices. No geometry
// or relationship is inferred from coordinates or from a separate flat output.
fn[T] encode_tree_nodes(
  roots : Array[T],
  contour : (T) -> Json,
  children : (T) -> Array[T],
  depth : (T) -> Int,
  is_hole : (T) -> Bool,
) -> (Json, Json) {
  let queue = roots.copy()
  let parents : Array[Int?] = Array::make(roots.length(), None)
  let root_indices = Array::makei(roots.length(), fn(i) { i })
  let paths = []
  let nodes = []
  for i = 0; i < queue.length(); i = i + 1 {
    let node = queue[i]
    let child_indices = []
    for child in children(node) {
      child_indices.push(queue.length())
      queue.push(child)
      parents.push(Some(i))
    }
    paths.push(contour(node))
    nodes.push(
      Json::object({
        "parent": index_json(parents[i]),
        "children": child_indices.to_json(),
        "depth": depth(node).to_json(),
        "is_hole": is_hole(node).to_json(),
      }),
    )
  }
  (
    Json::array(paths),
    Json::object({
      "roots": root_indices.to_json(),
      "nodes": Json::array(nodes),
    }),
  )
}

///|
fn encode_tree(tree : @moonclip.PolyTree64) -> (Json, Json) {
  encode_tree_nodes(
    tree.roots(),
    fn(n) { n.contour().map(fn(p) { [p.x.to_int(), p.y.to_int()] }).to_json() },
    fn(n) { n.children() },
    fn(n) { n.depth() },
    fn(n) { n.is_hole() },
  )
}

///|
fn encode_tree_d(tree : @moonclip.PolyTreeD) -> (Json, Json) {
  encode_tree_nodes(
    tree.roots(),
    fn(n) { n.contour().map(fn(p) { [p.x, p.y] }).to_json() },
    fn(n) { n.children() },
    fn(n) { n.depth() },
    fn(n) { n.is_hole() },
  )
}

///|
// Match public snapshots to this response's breadth-first display indices.
// These indices are never interpreted as kernel node IDs.
fn encode_tree_query(
  point : @moonclip.Point64,
  located : @moonclip.TreePointLocation64,
  encoded : (Json, Json),
) -> Json raise DemoError {
  guard encoded.0 is Array(paths) else {
    raise Input("Missing encoded contours", None, None)
  }
  guard object(encoded.1).get("nodes") is Some(Array(nodes)) else {
    raise Input("Missing encoded nodes", None, None)
  }
  if paths.length() != nodes.length() {
    raise Input("Unaligned encoded nodes", None, None)
  }
  let (status, hits) : (String, Array[@moonclip.PolyNode64]) = match located {
    @moonclip.Outside => ("Outside", [])
    @moonclip.Inside(node) => ("Inside", [node])
    @moonclip.InHole(node) => ("InHole", [node])
    @moonclip.OnBoundary(nodes) => ("OnBoundary", nodes)
  }
  let indices : Array[Int] = []
  for hit in hits {
    let contour = hit
      .contour()
      .map(fn(p) { [p.x.to_int(), p.y.to_int()] })
      .to_json()
    let mut found : Int? = None
    for i = 0; i < paths.length(); i = i + 1 {
      let node = object(nodes[i])
      if paths[i] == contour &&
        node.get("depth") == Some(hit.depth().to_json()) &&
        node.get("is_hole") == Some(hit.is_hole().to_json()) {
        if found is Some(_) {
          raise Input("Ambiguous query node snapshot", None, None)
        }
        found = Some(i)
      }
    }
    guard found is Some(index) else {
      raise Input("Query node snapshot not found", None, None)
    }
    if indices.contains(index) {
      raise Input("Duplicate query node snapshot", None, None)
    }
    indices.push(index)
  }
  Json::object({
    "point": [point.x.to_int(), point.y.to_int()].to_json(),
    "status": status.to_json(),
    "node_indices": indices.to_json(),
  })
}

///|
priv enum TreeQuery {
  QueryPoint(@moonclip.Point64)
  QueryPoints(Array[@moonclip.Point64])
}

///|
fn parse_tree_query(query : Json) -> TreeQuery raise DemoError {
  let q = object(query)
  match (q.get("point"), q.get("points")) {
    (Some(point), None) =>
      QueryPoint(
        integer_paths(coordinates(Json::array([Json::array([point])])))[0][0],
      )
    (None, Some(Array(points))) => {
      if points.length() > 32 {
        raise Input("Demo batch query accepts at most 32 points", None, None)
      }
      QueryPoints(
        integer_paths(coordinates(Json::array([Json::array(points)])))[0],
      )
    }
    _ =>
      raise Input(
        "Query requires exactly one of point or points; points must be an array",
        None,
        None,
      )
  }
}

///|
// Locate and encode the same immutable tree. Query failure publishes no response.
fn encode_integer_tree_result(
  tree : @moonclip.PolyTree64,
  request : TreeQuery?,
) -> (Json, Json, Json?) raise DemoError {
  let located = match request {
    Some(QueryPoint(point)) => Some([value(tree.locate(point))])
    Some(QueryPoints(points)) => Some(value(tree.locate_many(points)))
    None => None
  }
  let encoded = encode_tree(tree)
  let query = match (request, located) {
    (Some(QueryPoint(point)), Some([result])) =>
      Some(encode_tree_query(point, result, encoded))
    (Some(QueryPoints(points)), Some(results)) => {
      if points.length() != results.length() {
        raise Input("Unaligned batch query results", None, None)
      }
      let encoded_results = []
      for i = 0; i < points.length(); i = i + 1 {
        encoded_results.push(encode_tree_query(points[i], results[i], encoded))
      }
      Some(
        Json::object({
          "mode": "batch".to_json(),
          "points": points.map(fn(p) { [p.x.to_int(), p.y.to_int()] }).to_json(),
          "results": Json::array(encoded_results),
        }),
      )
    }
    (None, None) => None
    _ => raise Input("Missing query results", None, None)
  }
  (encoded.0, encoded.1, query)
}

///|
// Match public snapshots to this response's breadth-first display indices.
// These indices are never interpreted as kernel node IDs.
fn encode_tree_query_d(
  point : @moonclip.PointD,
  located : @moonclip.TreePointLocationD,
  encoded : (Json, Json),
) -> Json raise DemoError {
  guard encoded.0 is Array(paths) else {
    raise Input("Missing encoded contours", None, None)
  }
  guard object(encoded.1).get("nodes") is Some(Array(nodes)) else {
    raise Input("Missing encoded nodes", None, None)
  }
  if paths.length() != nodes.length() {
    raise Input("Unaligned encoded nodes", None, None)
  }
  let (status, hits) : (String, Array[@moonclip.PolyNodeD]) = match located {
    @moonclip.Outside => ("Outside", [])
    @moonclip.Inside(node) => ("Inside", [node])
    @moonclip.InHole(node) => ("InHole", [node])
    @moonclip.OnBoundary(nodes) => ("OnBoundary", nodes)
  }
  let indices : Array[Int] = []
  for hit in hits {
    let contour = hit.contour().map(fn(p) { [p.x, p.y] }).to_json()
    let mut found : Int? = None
    for i = 0; i < paths.length(); i = i + 1 {
      let node = object(nodes[i])
      if paths[i] == contour &&
        node.get("depth") == Some(hit.depth().to_json()) &&
        node.get("is_hole") == Some(hit.is_hole().to_json()) {
        if found is Some(_) {
          raise Input("Ambiguous query node snapshot", None, None)
        }
        found = Some(i)
      }
    }
    guard found is Some(index) else {
      raise Input("Query node snapshot not found", None, None)
    }
    if indices.contains(index) {
      raise Input("Duplicate query node snapshot", None, None)
    }
    indices.push(index)
  }
  Json::object({
    "point": [point.x, point.y].to_json(),
    "status": status.to_json(),
    "node_indices": indices.to_json(),
  })
}

///|
priv enum DecimalTreeQuery {
  DecimalQueryPoint(@moonclip.PointD)
  DecimalQueryPoints(Array[@moonclip.PointD])
}

///|
fn parse_decimal_tree_query(query : Json) -> DecimalTreeQuery raise DemoError {
  let q = object(query)
  match (q.get("point"), q.get("points")) {
    (Some(point), None) =>
      DecimalQueryPoint(coordinates(Json::array([Json::array([point])]))[0][0])
    (None, Some(Array(points))) => {
      if points.length() > 32 {
        raise Input("Demo batch query accepts at most 32 points", None, None)
      }
      DecimalQueryPoints(coordinates(Json::array([Json::array(points)]))[0])
    }
    _ =>
      raise Input(
        "Query requires exactly one of point or points; points must be an array",
        None,
        None,
      )
  }
}

///|
// Raw query coordinates are preserved; only the kernel applies the tree's Precision.
fn encode_decimal_tree_result(
  tree : @moonclip.PolyTreeD,
  request : DecimalTreeQuery?,
) -> (Json, Json, Json?) raise DemoError {
  let located = match request {
    Some(DecimalQueryPoint(point)) => Some([value(tree.locate(point))])
    Some(DecimalQueryPoints(points)) => Some(value(tree.locate_many(points)))
    None => None
  }
  let encoded = encode_tree_d(tree)
  let query = match (request, located) {
    (Some(DecimalQueryPoint(point)), Some([result])) =>
      Some(encode_tree_query_d(point, result, encoded))
    (Some(DecimalQueryPoints(points)), Some(results)) => {
      if points.length() != results.length() {
        raise Input("Unaligned batch query results", None, None)
      }
      let encoded_results = []
      for i = 0; i < points.length(); i = i + 1 {
        encoded_results.push(
          encode_tree_query_d(points[i], results[i], encoded),
        )
      }
      Some(
        Json::object({
          "mode": "batch".to_json(),
          "points": points.map(fn(p) { [p.x, p.y] }).to_json(),
          "results": Json::array(encoded_results),
        }),
      )
    }
    (None, None) => None
    _ => raise Input("Missing query results", None, None)
  }
  (encoded.0, encoded.1, query)
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
fn execute_rectclip(
  r : Map[String, Json],
  query_request : TreeQuery?,
  decimal_query_request : DecimalTreeQuery?,
) -> Json raise DemoError {
  let kind = text(r, "input_kind", "lines")
  if kind != "lines" && kind != "polygons" {
    raise Input("Unknown RectClip input kind", None, None)
  }
  let rule = if kind == "polygons" {
    let params = object(r.get("params").unwrap_or(Json::object({})))
    match text(params, "fill_rule", "EvenOdd") {
      "EvenOdd" => @moonclip.EvenOdd
      "NonZero" => @moonclip.NonZero
      _ => raise Input("Unknown fill rule", None, None)
    }
  } else {
    @moonclip.EvenOdd
  }
  let mode = text(r, "mode", "integer")
  if mode != "integer" && mode != "decimal" {
    raise Input("Unknown coordinate mode", None, None)
  }
  let output = text(r, "output", "paths")
  if output != "paths" && output != "tree" {
    raise Input("Unknown output mode", None, None)
  }
  if kind == "lines" && output != "paths" {
    raise Input("Open RectClip supports paths output only", None, None)
  }
  let simplify = object(r.get("simplify").unwrap_or(Json::object({})))
  if flag(simplify, "enabled", false) {
    raise Input("RectClip does not apply simplification", None, None)
  }
  let digits = number(r, "precision", 3.0)
  if digits < 0.0 || digits > 6.0 || digits.to_int().to_double() != digits {
    raise Input("Precision must be an integer from 0 to 6", None, None)
  }
  let precision = value(@moonclip.Precision::new(digits.to_int()))
  let fields = object(r.get("rect").unwrap_or(Json::null()))
  for key in ["min_x", "min_y", "max_x", "max_y"] {
    if fields.get(key) is None {
      raise Input("Missing window field: " + key, None, None)
    }
  }
  let rect : @moonclip.BoundsD = {
    min_x: number(fields, "min_x", 0.0),
    min_y: number(fields, "min_y", 0.0),
    max_x: number(fields, "max_x", 0.0),
    max_y: number(fields, "max_y", 0.0),
  }
  let paths = coordinates(r.get("paths").unwrap_or(Json::array([])))
  let mut tree = Json::null()
  let mut query_result : Json? = None
  let result = if mode == "decimal" {
    if output == "tree" {
      let encoded = encode_decimal_tree_result(
        value(
          @moonclip.rect_clip_polygons_tree_d(
            rect,
            paths,
            precision~,
            fill_rule=rule,
          ),
        ),
        decimal_query_request,
      )
      tree = encoded.1
      query_result = encoded.2
      encoded.0
    } else if kind == "polygons" {
      encode_decimal(
        value(
          @moonclip.rect_clip_polygons_d(
            rect,
            paths,
            precision~,
            fill_rule=rule,
          ),
        ),
      )
    } else {
      encode_decimal(
        value(@moonclip.rect_clip_lines_d(rect, paths, precision~)),
      )
    }
  } else {
    let corners = integer_paths([
        [
          @moonclip.PointD::new(rect.min_x, rect.min_y),
          @moonclip.PointD::new(rect.max_x, rect.max_y),
        ],
      ])[0]
    let window : @moonclip.Bounds64 = {
      min_x: corners[0].x,
      min_y: corners[0].y,
      max_x: corners[1].x,
      max_y: corners[1].y,
    }
    let grid = integer_paths(paths)
    if output == "tree" {
      let encoded = encode_integer_tree_result(
        value(@moonclip.rect_clip_polygons_tree(window, grid, fill_rule=rule)),
        query_request,
      )
      tree = encoded.1
      query_result = encoded.2
      encoded.0
    } else if kind == "polygons" {
      encode_paths(
        value(@moonclip.rect_clip_polygons(window, grid, fill_rule=rule)),
      )
    } else {
      encode_paths(value(@moonclip.rect_clip_lines(window, grid)))
    }
  }
  let response = {
    "ok": true.to_json(),
    "kernel": "MoonBit".to_json(),
    "scene": "rectclip".to_json(),
    "mode": mode.to_json(),
    "output": output.to_json(),
    "precision": if mode == "decimal" {
      digits.to_json()
    } else {
      Json::null()
    },
    "geometry": (if kind == "polygons" {
      "closed-regions"
    } else {
      "open-paths"
    }).to_json(),
    "paths": result,
    "simplification": Json::null(),
  }
  if output == "tree" {
    response["tree"] = tree
  }
  if query_result is Some(query) {
    response["query"] = query
  }
  Json::object(response)
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
  if r.get("query") is Some(_) &&
    (
      !(scene == "boolean" ||
      scene == "offset" ||
      scene == "stroke" ||
      scene == "stroke-batch" ||
      scene == "minkowski" ||
      (scene == "rectclip" && text(r, "input_kind", "lines") == "polygons")) ||
      text(r, "output", "paths") != "tree"
    ) {
    raise Input("Point query requires supported region tree output", None, None)
  }
  let query_request = if mode == "integer" {
    match r.get("query") {
      None => None
      Some(query) => Some(parse_tree_query(query))
    }
  } else {
    None
  }
  let decimal_query_request = if mode == "decimal" {
    match r.get("query") {
      None => None
      Some(query) => Some(parse_decimal_tree_query(query))
    }
  } else {
    None
  }
  // Open paths must bypass closed-region preparation and all unrelated parameters.
  if scene == "rectclip" {
    return execute_rectclip(r, query_request, decimal_query_request)
  }
  let output = text(r, "output", "paths")
  if output != "paths" && output != "tree" {
    raise Input("Unknown output mode", None, None)
  }
  if mode != "integer" && mode != "decimal" {
    raise Input("Unknown coordinate mode", None, None)
  }
  let params = object(r.get("params").unwrap_or(Json::object({})))
  let simplify = object(r.get("simplify").unwrap_or(Json::object({})))
  let enabled = flag(simplify, "enabled", false)
  if enabled && scene == "stroke-batch" {
    raise Input("Batch stroke does not apply simplification", None, None)
  }
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
  if scene == "stroke-batch" {
    let paths = coordinates(r.get("paths").unwrap_or(Json::array([])))
    let width = number(params, "width", 8.0)
    let mut tree = Json::null()
    let mut query_result : Json? = None
    let result = if output == "tree" {
      let (encoded_paths, encoded_tree) = if mode == "decimal" {
        let encoded = encode_decimal_tree_result(
          value(
            @moonclip.stroke_polylines_tree_d(
              paths,
              width,
              precision~,
              cap~,
              options~,
            ),
          ),
          decimal_query_request,
        )
        query_result = encoded.2
        (encoded.0, encoded.1)
      } else {
        let encoded = encode_integer_tree_result(
          value(
            @moonclip.stroke_polylines_tree(
              integer_paths(paths),
              width,
              cap~,
              options~,
            ),
          ),
          query_request,
        )
        query_result = encoded.2
        (encoded.0, encoded.1)
      }
      tree = encoded_tree
      encoded_paths
    } else if mode == "decimal" {
      encode_decimal(
        value(
          @moonclip.stroke_polylines_d(paths, width, precision~, cap~, options~),
        ),
      )
    } else {
      encode_paths(
        value(
          @moonclip.stroke_polylines(
            integer_paths(paths),
            width,
            cap~,
            options~,
          ),
        ),
      )
    }
    let response = {
      "ok": true.to_json(),
      "kernel": "MoonBit".to_json(),
      "scene": scene.to_json(),
      "mode": mode.to_json(),
      "output": output.to_json(),
      "precision": if mode == "decimal" {
        digits.to_json()
      } else {
        Json::null()
      },
      "paths": result,
      "simplification": Json::null(),
    }
    if output == "tree" {
      response["tree"] = tree
    }
    if query_result is Some(query) {
      response["query"] = query
    }
    return Json::object(response)
  }

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
  let mut tree = Json::null()
  let mut query_result : Json? = None
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
    if output == "tree" {
      let encoded = encode_decimal_tree_result(
        match scene {
          "boolean" =>
            value(
              @moonclip.boolean_tree_d(
                a,
                b,
                operation,
                precision~,
                fill_rule=rule,
              ),
            )
          "offset" =>
            value(
              @moonclip.offset_tree_d(
                a,
                number(params, "delta", 4.0),
                precision~,
                fill_rule=rule,
                options~,
              ),
            )
          "stroke" =>
            value(
              @moonclip.stroke_tree_d(
                a[0],
                number(params, "width", 8.0),
                precision~,
                cap~,
                options~,
              ),
            )
          "minkowski" => {
            let pattern = coordinates(
              Json::array([r.get("pattern").unwrap_or(empty)]),
            )
            value(
              @moonclip.minkowski_sum_tree_d(
                pattern[0],
                a[0],
                flag(params, "path_is_closed", false),
                precision~,
              ),
            )
          }
          _ => raise Input("Unknown decimal scene", None, None)
        },
        decimal_query_request,
      )
      query_result = encoded.2
      tree = encoded.1
      encoded.0
    } else {
      encode_decimal(
        match scene {
          "boolean" =>
            value(
              @moonclip.boolean_op_d(
                a,
                b,
                operation,
                precision~,
                fill_rule=rule,
              ),
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
          "minkowski" => {
            let pattern = coordinates(
              Json::array([r.get("pattern").unwrap_or(empty)]),
            )
            value(
              @moonclip.minkowski_sum_d(
                pattern[0],
                a[0],
                flag(params, "path_is_closed", false),
                precision~,
              ),
            )
          }
          _ => raise Input("Unknown decimal scene", None, None)
        },
      )
    }
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
    if output == "tree" {
      let computed = match scene {
        "boolean" =>
          value(@moonclip.boolean_tree(a, b, operation, fill_rule=rule))
        "offset" =>
          value(
            @moonclip.offset_tree(
              a,
              number(params, "delta", 4.0),
              fill_rule=rule,
              options~,
            ),
          )
        "stroke" =>
          value(
            @moonclip.stroke_tree(
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
            @moonclip.minkowski_sum_tree(
              pattern[0],
              a[0],
              flag(params, "path_is_closed", false),
            ),
          )
        }
        _ => raise Input("Unknown integer scene", None, None)
      }
      let encoded = encode_integer_tree_result(computed, query_request)
      query_result = encoded.2
      tree = encoded.1
      encoded.0
    } else {
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
  }
  let response = {
    "ok": true.to_json(),
    "kernel": "MoonBit".to_json(),
    "scene": scene.to_json(),
    "mode": mode.to_json(),
    "output": output.to_json(),
    "precision": if mode == "decimal" {
      digits.to_json()
    } else {
      Json::null()
    },
    "paths": paths,
    "simplification": report,
  }
  if output == "tree" {
    response["tree"] = tree
  }
  if query_result is Some(query) {
    response["query"] = query
  }
  Json::object(response)
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
