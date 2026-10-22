// Copyright (c) 2026 BigSaltyMan
// Distributed under the Boost Software License, Version 1.0 (see LICENSE).

///|
/// An immutable integer point. Coordinates are stored without floating-point conversion.
pub(all) struct Point64 {
  x : Int64
  y : Int64
} derive(Eq, Debug)

///|
/// Construct a point without restricting the Int64 storage range.
pub fn Point64::new(x : Int64, y : Int64) -> Point64 {
  { x, y, }
}

///|
/// An ordered, mutable point array. No normalization is implicit.
pub type Path64 = Array[Point64]

///|
/// An ordered, mutable path array; paths may be empty or share storage.
pub type Paths64 = Array[Path64]

///|
/// Copy the point array. Immutable points may be shared safely.
/// Time and additional space are O(number of vertices).
pub fn copy_path(path : Path64) -> Path64 {
  path.copy()
}

///|
/// Copy the outer array and each path separately, even for aliased input paths.
/// Time and additional space are O(number of paths + total number of vertices).
pub fn copy_paths(paths : Paths64) -> Paths64 {
  paths.map(copy_path)
}

///|
/// Raw immutable floating-point storage; geometry entry points validate and quantize.
pub(all) struct PointD {
  x : Double
  y : Double
} derive(Eq, Debug)

///|
pub fn PointD::new(x : Double, y : Double) -> PointD {
  { x, y, }
}

///|
pub type PathD = Array[PointD]

///|
pub type PathsD = Array[PathD]

///|
pub fn copy_path_d(path : PathD) -> PathD {
  path.copy()
}

///|
pub fn copy_paths_d(paths : PathsD) -> PathsD {
  paths.map(copy_path_d)
}

///|
/// Raw immutable decimal window parameters; geometry entry points validate them.
pub(all) struct BoundsD {
  min_x : Double
  min_y : Double
  max_x : Double
  max_y : Double
} derive(Eq, Debug)
