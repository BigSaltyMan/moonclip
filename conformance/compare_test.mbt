///|
fn compare_path(a : @moonclip.Path64, b : @moonclip.Path64) -> Int {
  for i = 0; i < a.length() && i < b.length(); i = i + 1 {
    if a[i].x != b[i].x {
      return if a[i].x < b[i].x { -1 } else { 1 }
    }
    if a[i].y != b[i].y {
      return if a[i].y < b[i].y { -1 } else { 1 }
    }
  }
  a.length() - b.length()
}

///|
fn canonical_paths(paths : @moonclip.Paths64) -> @moonclip.Paths64 {
  let result = paths.map(fn(path) {
    let mut best = path.copy()
    for start = 1; start < path.length(); start = start + 1 {
      let candidate = Array::makei(path.length(), fn(i) {
        path[(start + i) % path.length()]
      })
      if compare_path(candidate, best) < 0 {
        best = candidate
      }
    }
    best
  })
  for i = 1; i < result.length(); i = i + 1 {
    let mut j = i
    while j > 0 && compare_path(result[j], result[j - 1]) < 0 {
      let tmp = result[j]
      result[j] = result[j - 1]
      result[j - 1] = tmp
      j -= 1
    }
  }
  result
}
