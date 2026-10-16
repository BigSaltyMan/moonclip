///|
test "point construction preserves signed coordinates" {
  let zero = @moonclip.Point64::new(0L, 0L)
  assert_eq(zero.x, 0L)
  assert_eq(zero.y, 0L)
  let p = @moonclip.Point64::new(-17L, 42L)
  assert_eq(p.x, -17L)
  assert_eq(p.y, 42L)
  let literal : @moonclip.Point64 = { x: 7L, y: -3L, }
  assert_eq(literal.x, 7L)
  assert_eq(literal.y, -3L)
}

///|
test "point construction preserves integers beyond Double precision and Int64 endpoints" {
  let p = @moonclip.Point64::new(9007199254740993L, -9007199254740993L)
  assert_eq(p.x, 9007199254740993L)
  assert_eq(p.y, -9007199254740993L)
  let endpoints = @moonclip.Point64::new(
    -9223372036854775808L, 9223372036854775807L,
  )
  assert_eq(endpoints.x, -9223372036854775808L)
  assert_eq(endpoints.y, 9223372036854775807L)
}

///|
test "point equality compares both coordinates" {
  let p = @moonclip.Point64::new(-2L, 3L)
  assert_true(p == @moonclip.Point64::new(-2L, 3L))
  assert_true(p != @moonclip.Point64::new(2L, 3L))
  assert_true(p != @moonclip.Point64::new(-2L, -3L))
}

///|
test "empty singleton and two point paths preserve order" {
  let empty : @moonclip.Path64 = []
  assert_eq(empty.length(), 0)
  let a = @moonclip.Point64::new(-1L, 2L)
  let b = @moonclip.Point64::new(3L, -4L)
  let single : @moonclip.Path64 = [a]
  let pair : @moonclip.Path64 = [a, b]
  assert_eq(single.length(), 1)
  assert_eq(single[0], a)
  assert_eq(pair.length(), 2)
  assert_eq(pair[0], a)
  assert_eq(pair[1], b)
}

///|
test "canonical closed triangle does not add a closing vertex" {
  let path : @moonclip.Path64 = [
    @moonclip.Point64::new(0L, 0L),
    @moonclip.Point64::new(10L, 0L),
    @moonclip.Point64::new(0L, 10L),
  ]
  let copied = @moonclip.copy_path(path)
  assert_eq(copied.length(), 3)
  assert_eq(copied[0].x, 0L)
  assert_eq(copied[1].x, 10L)
  assert_eq(copied[2].y, 10L)
  assert_true(copied == path)
}

///|
test "construction and copying preserve consecutive and closing duplicates" {
  let a = @moonclip.Point64::new(1L, -2L)
  let b = @moonclip.Point64::new(3L, 4L)
  let path : @moonclip.Path64 = [a, a, b, a]
  let copied = @moonclip.copy_path(path)
  assert_eq(path.length(), 4)
  assert_eq(copied.length(), 4)
  assert_eq(copied[0], a)
  assert_eq(copied[1], a)
  assert_eq(copied[2], b)
  assert_eq(copied[3], a)
  let paths = @moonclip.copy_paths([path, []])
  assert_true(paths == [path, []])
}

///|
test "path equality compares length coordinates and order" {
  let a = @moonclip.Point64::new(0L, 0L)
  let b = @moonclip.Point64::new(10L, 0L)
  let c = @moonclip.Point64::new(0L, 10L)
  let path : @moonclip.Path64 = [a, b, c]
  assert_true(path == [a, b, c])
  assert_true(path != [a, b])
  assert_true(path != [a, b, @moonclip.Point64::new(0L, 11L)])
  assert_true(path != [b, c, a])
  assert_true(path != [a, c, b])
  assert_true(path != [a, b, c, a])
}

///|
test "collection equality distinguishes empty paths and contour order" {
  let empty : @moonclip.Paths64 = []
  let one_empty : @moonclip.Paths64 = [[]]
  assert_true(empty == [])
  assert_true(empty != one_empty)
  assert_true(one_empty == [[]])
  assert_true(one_empty != [[], []])
  let a : @moonclip.Path64 = [@moonclip.Point64::new(1L, 2L)]
  let b : @moonclip.Path64 = [@moonclip.Point64::new(3L, 4L)]
  let paths : @moonclip.Paths64 = [a, [], b]
  assert_true(paths == [a, [], b])
  assert_true(paths != [b, [], a])
  assert_true(paths != [a, b])
}

///|
test "copy_path isolates edits in both directions" {
  let a = @moonclip.Point64::new(-5L, 7L)
  let b = @moonclip.Point64::new(8L, -9L)
  let source : @moonclip.Path64 = [a, b]
  let copied = @moonclip.copy_path(source)
  source[0] = b
  assert_eq(copied[0].x, -5L)
  assert_eq(copied[0].y, 7L)
  copied[1] = a
  assert_eq(source[1].x, 8L)
  assert_eq(source[1].y, -9L)
}

///|
test "copy_path isolates resizing in both directions" {
  let p = @moonclip.Point64::new(1L, 2L)
  let source : @moonclip.Path64 = [p]
  let copied = @moonclip.copy_path(source)
  source.push(p)
  assert_eq(copied.length(), 1)
  copied.clear()
  assert_eq(source.length(), 2)
  assert_eq(copied.length(), 0)
}

///|
test "copy_paths isolates outer replacement insertion and removal from source" {
  let p = @moonclip.Point64::new(-3L, 5L)
  let source : @moonclip.Paths64 = [[p], []]
  let copied = @moonclip.copy_paths(source)
  source[0] = []
  source.push([p, p])
  assert_eq(copied.length(), 2)
  assert_eq(copied[0].length(), 1)
  assert_eq(copied[0][0], p)
  source.clear()
  assert_eq(copied.length(), 2)
  assert_eq(copied[1].length(), 0)
}

///|
test "copy_paths isolates outer replacement insertion and removal from copy" {
  let p = @moonclip.Point64::new(6L, -7L)
  let source : @moonclip.Paths64 = [[p], []]
  let copied = @moonclip.copy_paths(source)
  copied[0] = []
  copied.push([p])
  assert_eq(source.length(), 2)
  assert_eq(source[0].length(), 1)
  assert_eq(source[0][0], p)
  copied.clear()
  assert_eq(source.length(), 2)
}

///|
test "copy_paths isolates inner changes in both directions" {
  let a = @moonclip.Point64::new(-1L, 2L)
  let b = @moonclip.Point64::new(3L, 4L)
  let source : @moonclip.Paths64 = [[a, b], [b], []]
  let copied = @moonclip.copy_paths(source)
  source[0][0] = b
  source[1].push(a)
  source[2].push(b)
  assert_eq(copied[0][0], a)
  assert_eq(copied[1].length(), 1)
  assert_eq(copied[2].length(), 0)
  copied[0][1] = a
  copied[1].clear()
  copied[2].push(a)
  assert_eq(source[0][1], b)
  assert_eq(source[1].length(), 2)
  assert_eq(source[2][0], b)
}

///|
test "copy_paths separates aliased input contours" {
  let a = @moonclip.Point64::new(1L, 2L)
  let b = @moonclip.Point64::new(-3L, -4L)
  let shared : @moonclip.Path64 = [a]
  let source : @moonclip.Paths64 = [shared, shared]
  let copied = @moonclip.copy_paths(source)
  assert_true(source == copied)
  copied[0][0] = b
  copied[0].push(b)
  assert_eq(copied[1].length(), 1)
  assert_eq(copied[1][0], a)
  assert_eq(shared[0], a)
  shared[0] = b
  assert_eq(copied[1][0], a)
  copied[1].clear()
  assert_eq(shared.length(), 1)
  assert_eq(copied[0].length(), 2)
}

///|
test "repeated path copies own separate arrays" {
  let p = @moonclip.Point64::new(9007199254740993L, -5L)
  let source : @moonclip.Path64 = [p]
  let first = @moonclip.copy_path(source)
  let second = @moonclip.copy_path(source)
  first.clear()
  assert_eq(second.length(), 1)
  assert_eq(second[0].x, 9007199254740993L)
  second[0] = @moonclip.Point64::new(0L, 0L)
  assert_eq(source[0], p)
}

///|
test "repeated collection copies own separate inner and outer arrays" {
  let p = @moonclip.Point64::new(1L, -2L)
  let source : @moonclip.Paths64 = [[p], []]
  let first = @moonclip.copy_paths(source)
  let second = @moonclip.copy_paths(source)
  first[0].clear()
  first[1].push(p)
  first.push([])
  assert_eq(second.length(), 2)
  assert_eq(second[0][0], p)
  assert_eq(second[1].length(), 0)
  second[0][0] = @moonclip.Point64::new(8L, 9L)
  second.clear()
  assert_eq(source.length(), 2)
  assert_eq(source[0][0], p)
  assert_eq(source[1].length(), 0)
}

///|
test "repeated empty path copies remain independent" {
  let source : @moonclip.Path64 = []
  let first = @moonclip.copy_path(source)
  let second = @moonclip.copy_path(source)
  first.push(@moonclip.Point64::new(-1L, 0L))
  assert_eq(source.length(), 0)
  assert_eq(second.length(), 0)
  second.push(@moonclip.Point64::new(2L, 0L))
  assert_eq(first[0].x, -1L)
}

///|
test "empty collections and aliased empty contours copy independently" {
  let source : @moonclip.Paths64 = []
  let first = @moonclip.copy_paths(source)
  let second = @moonclip.copy_paths(source)
  first.push([])
  assert_eq(source.length(), 0)
  assert_eq(second.length(), 0)
  let shared : @moonclip.Path64 = []
  let copied = @moonclip.copy_paths([shared, shared])
  copied[0].push(@moonclip.Point64::new(1L, 2L))
  assert_eq(copied[1].length(), 0)
  assert_eq(shared.length(), 0)
  copied[1].push(@moonclip.Point64::new(-1L, -2L))
  assert_eq(copied[0][0].x, 1L)
}
