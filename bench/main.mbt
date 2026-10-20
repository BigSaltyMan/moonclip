// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
fn metadata(case : Case) -> Map[String, Json] {
  {
    "case": case.id.to_json(),
    "parameters": case.parameters,
    "input_paths": case.input_paths.to_json(),
    "input_vertices": case.input_vertices.to_json(),
    "pattern_vertices": case.pattern_vertices.to_json(),
    "route_vertices": case.route_vertices.to_json(),
    "stress": case.stress.to_json(),
    "batch": case.batch.to_json(),
  }
}

///|
fn error_json(error : @moonclip.ClipError) -> Json {
  let (kind, loc, resource, limit) = match error {
    ResourceLimitExceeded(loc, resource, limit) =>
      (
        "ResourceLimitExceeded",
        loc,
        @debug.to_string(resource).to_json(),
        limit.to_json(),
      )
    InvalidInput(loc, _) => ("InvalidInput", loc, Json::null(), Json::null())
    CoordinateOutOfRange(loc, _, _) =>
      ("CoordinateOutOfRange", loc, Json::null(), Json::null())
    NumericFailure(loc, _) =>
      ("NumericFailure", loc, Json::null(), Json::null())
    ExecutionFailure(loc, _) =>
      ("ExecutionFailure", loc, Json::null(), Json::null())
    QuantizationFailure(loc, _, _, _) =>
      ("QuantizationFailure", loc, Json::null(), Json::null())
    DecimalCoordinateOutOfRange(loc, _, _, _) =>
      ("DecimalCoordinateOutOfRange", loc, Json::null(), Json::null())
  }
  {
    "kind": kind.to_json(),
    "stage": @debug.to_string(loc.stage).to_json(),
    "path_index": match loc.path_index {
      Some(i) => i.to_json()
      None => Json::null()
    },
    "vertex_index": match loc.vertex_index {
      Some(i) => i.to_json()
      None => Json::null()
    },
    "resource": resource,
    "limit": limit,
    "message": error.message().to_json(),
    "detail": @debug.to_string(error).to_json(),
  }
}

///|
fn failure(case : Case, error : @moonclip.ClipError, phase : String) -> Json {
  let obj = metadata(case)
  obj["status"] = (if error is ResourceLimitExceeded(_, _, _) {
    "resource_rejected"
  } else {
    "runtime_error"
  }).to_json()
  obj["error"] = error_json(error)
  obj["phase"] = phase.to_json()
  obj["statistics_us"] = Json::null()
  Json::object(obj)
}

///|
fn invalid_result(case : Case, phase : String) -> Json {
  let obj = metadata(case)
  obj["status"] = "runtime_error".to_json()
  obj["phase"] = phase.to_json()
  obj["error"] = {
    "kind": "ResultValidationFailure",
    "message": "Output failed the case's independent expectations",
  }
  obj["statistics_us"] = Json::null()
  Json::object(obj)
}

///|
fn output_info(value : Output) -> (Int, Int, Int) {
  match value {
    Integer(paths) => (paths.length(), vertices(paths), 0)
    Decimal(paths) =>
      (paths.length(), paths.fold(init=0, fn(n, p) { n + p.length() }), 0)
    Simplified(result) => {
      let paths = result.paths()
      (paths.length(), vertices(paths), result.removed_vertices())
    }
  }
}

///|
fn measure(case : Case, smoke : Bool) -> Json {
  // Generation, checking, output traversal and serialization are never timed.
  let warmups = if smoke { 1 } else { 2 }
  let samples = if smoke { 1 } else { 5 }
  let batch = if smoke { 1 } else { case.batch }
  for _ in 0..<warmups {
    match (case.run)() {
      Err(error) => return failure(case, error, "warmup")
      Ok(value) =>
        if !(case.check)(value) {
          return invalid_result(case, "warmup")
        }
    }
  }
  let elapsed : Array[Double] = []
  let mut info = (0, 0, 0)
  for _ in 0..<samples {
    // Keep every result alive until after the clock stops; no dead-code call.
    let results : Array[Result[Output, @moonclip.ClipError]?] = Array::make(
      batch,
      None,
    )
    let stamp = @clock.monotonic_clock_start()
    for i = 0; i < batch; i = i + 1 {
      results[i] = Some((case.run)())
    }
    let us = @clock.monotonic_clock_end(stamp)
    if us < 0.0 || us.is_nan() || us.is_inf() {
      return invalid_result(case, "clock")
    }
    for result in results {
      match result {
        Some(Err(error)) => return failure(case, error, "sample")
        Some(Ok(value)) => {
          if !(case.check)(value) {
            return invalid_result(case, "sample")
          }
          info = output_info(value)
        }
        None => return invalid_result(case, "missing_result")
      }
    }
    elapsed.push(us / batch.to_double())
  }
  let ordered = elapsed.copy()
  ordered.sort()
  let obj = metadata(case)
  obj["status"] = "success".to_json()
  obj["warmups"] = warmups.to_json()
  obj["samples"] = samples.to_json()
  obj["batch"] = batch.to_json()
  obj["output_paths"] = info.0.to_json()
  obj["output_vertices"] = info.1.to_json()
  obj["removed_vertices"] = info.2.to_json()
  obj["sample_us_per_call"] = elapsed.to_json()
  obj["statistics_us"] = {
    "min": ordered[0].to_json(),
    "median": ordered[ordered.length() / 2].to_json(),
    "max": ordered[ordered.length() - 1].to_json(),
  }
  Json::object(obj)
}

///|
fn main {
  let args = @env.args()
  let all = cases()
  if args.contains("--list") {
    println(all.map(fn(c) { Json::object(metadata(c)) }).to_json().stringify())
    return
  }
  for case in all {
    if args.contains(case.id) {
      println(measure(case, args.contains("--smoke")).stringify())
      return
    }
  }
  println("{\"status\":\"runtime_error\",\"error\":{\"kind\":\"UnknownCase\"}}")
}
