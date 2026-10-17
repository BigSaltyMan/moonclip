// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
/// Inclusive coordinate limit for geometry, not Point64 storage.
pub const COORDINATE_LIMIT : Int64 = 1_000_000_000L

///|
pub(all) enum Stage {
  ValidateInputs
  Cross
  Orientation
  Bounds
  Area2
  PointOnSegment
  PointInPolygon
  NormalizePath
  NormalizePaths
  EnginePrepare
  ScanEvents
  ActiveEdges
  ScanBand
  ScanTop
} derive(Eq, Debug)

///|
pub(all) enum Axis {
  X
  Y
} derive(Eq, Debug)

///|
pub(all) enum ResourceKind {
  InputPaths
  InputVertices
  InternalNodes
  ScanWork
} derive(Eq, Debug)

///|
/// Indices are zero-based in the original input, before normalization.
pub(all) struct ErrorLocation {
  stage : Stage
  path_index : Int?
  vertex_index : Int?
} derive(Eq, Debug)

///|
/// Errors are returned as values; messages are English.
pub(all) enum ClipError {
  InvalidInput(ErrorLocation, String)
  CoordinateOutOfRange(ErrorLocation, Axis, Int64)
  NumericFailure(ErrorLocation, String)
  ResourceLimitExceeded(ErrorLocation, ResourceKind, Int)
} derive(Eq, Debug)

///|
pub fn ClipError::message(self : ClipError) -> String {
  match self {
    InvalidInput(_, message) | NumericFailure(_, message) => message
    CoordinateOutOfRange(_, axis, value) => {
      let name = match axis {
        X => "x"
        Y => "y"
      }
      "Coordinate \{name}=\{value} is outside [-1000000000, 1000000000]"
    }
    ResourceLimitExceeded(_, resource, limit) => {
      let name = match resource {
        InputPaths => "input paths"
        InputVertices => "input vertices"
        InternalNodes => "internal nodes"
        ScanWork => "scan work"
      }
      "Resource limit exceeded for \{name} (limit \{limit})"
    }
  }
}

///|
pub(all) struct Limits {
  max_input_paths : Int
  max_input_vertices : Int
} derive(Eq, Debug)

///|
pub impl Default for Limits with fn default() {
  { max_input_paths: 10_000, max_input_vertices: 100_000, }
}

///|
fn location(stage : Stage, path : Int?, vertex : Int?) -> ErrorLocation {
  { stage, path_index: path, vertex_index: vertex, }
}

///|
fn check_limits(limits : Limits, stage : Stage, paths : Int) -> ClipError? {
  let loc = location(stage, None, None)
  if limits.max_input_paths < 0 || limits.max_input_vertices < 0 {
    return Some(InvalidInput(loc, "Input limits must be non-negative"))
  }
  if paths > limits.max_input_paths {
    return Some(
      ResourceLimitExceeded(
        location(stage, Some(limits.max_input_paths), None),
        InputPaths,
        limits.max_input_paths,
      ),
    )
  }
  None
}

///|
fn check_point(point : Point64, loc : ErrorLocation) -> ClipError? {
  // Compare before any subtraction or abs: even Int64::MIN_VALUE is safe here.
  if point.x < -COORDINATE_LIMIT || point.x > COORDINATE_LIMIT {
    return Some(CoordinateOutOfRange(loc, X, point.x))
  }
  if point.y < -COORDINATE_LIMIT || point.y > COORDINATE_LIMIT {
    return Some(CoordinateOutOfRange(loc, Y, point.y))
  }
  None
}

///|
/// Preflight completes before allocating output arrays. Subtract from a remaining
/// allowance instead of summing counts, so count arithmetic cannot overflow Int.
fn check_paths(paths : Paths64, limits : Limits, stage : Stage) -> ClipError? {
  if check_limits(limits, stage, paths.length()) is Some(e) {
    return Some(e)
  }
  let mut remaining = limits.max_input_vertices
  for i = 0; i < paths.length(); i = i + 1 {
    let count = paths[i].length()
    if count > remaining {
      return Some(
        ResourceLimitExceeded(
          location(stage, Some(i), Some(remaining)),
          InputVertices,
          limits.max_input_vertices,
        ),
      )
    }
    remaining = remaining - count
  }
  for i = 0; i < paths.length(); i = i + 1 {
    for j = 0; j < paths[i].length(); j = j + 1 {
      if check_point(paths[i][j], location(stage, Some(i), Some(j))) is Some(e) {
        return Some(e)
      }
    }
  }
  None
}

///|
/// A single path consumes one path slot, even if empty. A query point, when
/// present, consumes one further vertex slot and has no path/vertex index.
fn check_path(
  path : Path64,
  limits : Limits,
  stage : Stage,
  query : Point64?,
) -> ClipError? {
  if check_limits(limits, stage, 1) is Some(e) {
    return Some(e)
  }
  if path.length() > limits.max_input_vertices {
    return Some(
      ResourceLimitExceeded(
        location(stage, Some(0), Some(limits.max_input_vertices)),
        InputVertices,
        limits.max_input_vertices,
      ),
    )
  }
  if query is Some(_) && path.length() == limits.max_input_vertices {
    return Some(
      ResourceLimitExceeded(
        location(stage, None, None),
        InputVertices,
        limits.max_input_vertices,
      ),
    )
  }
  for j = 0; j < path.length(); j = j + 1 {
    if check_point(path[j], location(stage, Some(0), Some(j))) is Some(e) {
      return Some(e)
    }
  }
  if query is Some(point) {
    return check_point(point, location(stage, None, None))
  }
  None
}

///|
/// Fixed-arity predicates treat their three arguments as one logical path.
fn check_three(
  a : Point64,
  b : Point64,
  c : Point64,
  limits : Limits,
  stage : Stage,
) -> ClipError? {
  if check_limits(limits, stage, 1) is Some(e) {
    return Some(e)
  }
  if limits.max_input_vertices < 3 {
    return Some(
      ResourceLimitExceeded(
        location(stage, Some(0), Some(limits.max_input_vertices)),
        InputVertices,
        limits.max_input_vertices,
      ),
    )
  }
  if check_point(a, location(stage, Some(0), Some(0))) is Some(e) {
    return Some(e)
  }
  if check_point(b, location(stage, Some(0), Some(1))) is Some(e) {
    return Some(e)
  }
  check_point(c, location(stage, Some(0), Some(2)))
}

///|
/// Validate raw inputs without copying or normalizing them.
pub fn validate_paths(
  paths : Paths64,
  limits? : Limits = Default::default(),
) -> Result[Unit, ClipError] {
  match check_paths(paths, limits, ValidateInputs) {
    Some(e) => Err(e)
    None => Ok(())
  }
}
