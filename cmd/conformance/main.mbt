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
fn main {
  let envelope = Json::object({
    "args": @env.args().to_json(),
    "results": run_cases().to_json(),
  })
  exit_code(report(@utf8.encode(envelope.stringify())))
}
