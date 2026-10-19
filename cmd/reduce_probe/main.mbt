// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.
// Internal v1 flat probe. Python validates the full request before invocation.

///|
extern "C" fn read_request() -> Bytes = "moonclip_probe_stdin"

///|
fn points(value : Json) -> @moonclip.Paths64 raise {
  guard value is Array(paths) else { fail("Expected paths") }
  paths.map(fn(path) raise {
    guard path is Array(vertices) else { fail("Expected path") }
    vertices.map(fn(point) raise {
      guard point is Array([Number(x, ..), Number(y, ..)]) else {
        fail("Expected integer point")
      }
      assert_true(x >= -1000000000.0 && x <= 1000000000.0)
      assert_true(y >= -1000000000.0 && y <= 1000000000.0)
      let ix = x.to_int64()
      let iy = y.to_int64()
      assert_eq(ix.to_double(), x)
      assert_eq(iy.to_double(), y)
      @moonclip.Point64::new(ix, iy)
    })
  })
}

///|
fn main raise {
  guard @json.parse(@utf8.decode(read_request())) is Object(request) else {
    fail("Expected request")
  }
  let operation = match request.get("operation") {
    Some(String("Intersection")) => @moonclip.Intersection
    Some(String("Union")) => @moonclip.Union
    Some(String("Difference")) => @moonclip.Difference
    Some(String("Xor")) => @moonclip.Xor
    _ => fail("Expected public Boolean operation")
  }
  let rule = match request.get("fill_rule") {
    Some(String("EvenOdd")) => @moonclip.EvenOdd
    Some(String("NonZero")) => @moonclip.NonZero
    _ => fail("Expected public fill rule")
  }
  let result = @moonclip.boolean_op(
    points(request.get("subject").unwrap()),
    points(request.get("clip").unwrap()),
    operation,
    fill_rule=rule,
  )
  let output = match result {
    Ok(paths) =>
      Json::object({
        "status": "success".to_json(),
        "paths": paths
        .map(fn(p) { p.map(fn(q) { [q.x.to_int(), q.y.to_int()] }) })
        .to_json(),
      })
    Err(error) =>
      Json::object({
        "status": "error".to_json(),
        "error": error.message().to_json(),
        "error_kind": (match error {
          @moonclip.InvalidInput(_, _) => "InvalidInput"
          @moonclip.ExecutionFailure(_, _) => "ExecutionFailure"
          @moonclip.NumericFailure(_, _) => "NumericFailure"
          @moonclip.ResourceLimitExceeded(_, _, _) => "ResourceLimitExceeded"
          _ => "Other"
        }).to_json(),
      })
  }
  println(output.stringify())
}
