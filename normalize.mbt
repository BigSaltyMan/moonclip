// Copyright (c) 2026 BigSaltyMan. BSL-1.0; see LICENSE.

///|
pub(all) enum PathMode {
  Open
  Closed
} derive(Eq, Debug)

///|
/// Only remove consecutive duplicates and, for closed paths, the repeated
/// closing vertex. Preserve all other vertices, order and degeneracy.
fn normalize_validated(path : Path64, mode : PathMode) -> Path64 {
  let result : Path64 = []
  for p in path {
    if result.is_empty() || result[result.length() - 1] != p {
      result.push(p)
    }
  }
  if mode == Closed &&
    result.length() > 1 &&
    result[0] == result[result.length() - 1] {
    ignore(result.pop())
  }
  result
}

///|
pub fn normalize_path(
  path : Path64,
  mode : PathMode,
  limits? : Limits = Default::default(),
) -> Result[Path64, ClipError] {
  if check_path(path, limits, NormalizePath, None) is Some(e) {
    return Err(e)
  }
  Ok(normalize_validated(path, mode))
}

///|
/// Validate all original paths and vertices before allocating any output.
/// Empty contours and original contour indices are retained.
pub fn normalize_paths(
  paths : Paths64,
  mode : PathMode,
  limits? : Limits = Default::default(),
) -> Result[Paths64, ClipError] {
  if check_paths(paths, limits, NormalizePaths) is Some(e) {
    return Err(e)
  }
  Ok(paths.map(fn(path) { normalize_validated(path, mode) }))
}
