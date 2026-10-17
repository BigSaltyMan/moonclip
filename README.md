# MoonClip

MoonClip 是用 MoonBit 实现的整数多边形几何库，目前处于开发初期。目标版本为 `0.1.0`，尚未发布到 Mooncakes，模块名称的可用性将在发布前确认。

目前已实现：不可变 `Int64` 点、有序路径与轮廓集合、结构比较、独立复制，以及精确叉积与方向、边界框、精确两倍有向面积、EvenOdd 点包含判断和开放/闭合模式的重复点整理。布尔裁剪、孔洞层级、偏移、描边、小数接口和简化仍在后续计划中。

## 数据契约

- `Point64` 的 `x`、`y` 不可变，构造时直接保存 `Int64`，不经过 `Double`。完整 Int64 存储范围不代表后续几何运算的坐标范围承诺。
- `Path64 = Array[Point64]`，`Paths64 = Array[Path64]`；直接使用数组字面量构造。赋值和组合数组可共享存储，需要隔离时显式调用复制函数。
- 空路径、单点、两点、连续重复点和重复首点均原样保存；空集合 `[]` 与 `[[]]` 不相等。
- 闭合轮廓的规范表示不重复存储首点；闭合边由后续算法解释。容器不自动去重、闭合、反向或删除退化轮廓。
- `==` / `!=` 使用 `Eq`，比较坐标、长度和顺序。环起点移动、反向或交换轮廓可能不相等，不进行几何等价判断。
- `copy_path` 创建新的点数组；`copy_paths` 创建新的外层数组，并为每条路径创建独立数组，即使输入路径共享同一数组。源、副本、不同复制调用之间的修改相互隔离。不可变点可安全复用。
- `copy_path` 时间与额外空间为 O(V)；`copy_paths` 为 O(P + V)，其中 P 为轮廓数、V 为总顶点数。

## 几何计算与输入边界

几何与整理入口接受的每轴坐标范围为 **[-1_000_000_000, 1_000_000_000]**（含边界），与 Point64 的完整 Int64 存储范围不同。`COORDINATE_LIMIT` 公开这一上限。坐标不会转换成浮点或被截断。

所有新增入口返回 `Result`，错误分为 `InvalidInput`、`CoordinateOutOfRange`、`NumericFailure`、`ResourceLimitExceeded`，附阶段、原始路径/顶点索引、轴与坐标或资源类别及限制值；`message()` 给出英文说明。不适用的索引为 None。

`Limits` 默认允许 10,000 条输入路径、100,000 个原始顶点，可通过 `limits=` 调整。空路径计入路径数，重复点计入顶点数，多轮廓共享同一次额度；零额度合法，负额度报参数错误。预检完成后才计算或分配结果。点谓词的三个实参计为一条路径、三个顶点；包含判断的查询点额外占一个顶点额度，错误位置不属于轮廓。

- `cross` / `orientation` 使用数学坐标系（x 向右、y 向上），正叉积为逆时针，不用 epsilon。
- `bounds` 返回 `Result[Bounds64?, ClipError]`，空路径为 `Ok(None)`，零宽或零高合法。
- `area2` 返回精确 BigInt 两倍有向面积，自动隐式闭合；内部在 Int64 累加溢出前回退到精确整数。面积为零不等于自交轮廓没有有效区域。
- `point_on_segment` 使用精确共线与闭区间判断。`point_in_polygon` 是**单轮廓 EvenOdd** 判定，区分 Inside、Outside、OnBoundary，尚不提供 NonZero、多轮廓布尔运算或孔洞树。
- `normalize_path` / `normalize_paths` 显式接收 Open 或 Closed；删除连续重复点，Closed 额外删除重复闭合点。保留非连续重复点、共线点、轮廓顺序、空轮廓和退化结果，不按零面积删除轮廓。整理不是有损简化或拓扑修复。
- 整理输出独立拥有内外数组，任何输入出错都不返回部分成功结果，也不修改输入。

数值安全推导、预算计数、精确整数依赖与几何语义见 [整数几何说明](docs/numerics.md)。固定工具链已自带 BigInt，无新增第三方依赖。

## 从本地源码运行

使用 [固定工具链](docs/toolchain.md)。Windows 使用 Git Bash，Linux 使用 Bash：

```bash
bash scripts/check.sh
moon run --target native cmd/example
```

示例代码位于 [`cmd/example/main.mbt`](cmd/example/main.mbt)，通过公开接口验证复制隔离、负坐标边界框、方向、精确面积和点包含，整理重复点后检查源数据未变，并捕获坐标及预算错误。成功输出：

```text
MoonClip geometry foundation OK
```

对应示例包导入根库后，可直接调用公开接口：

```moonbit
///|
fn main raise {
  let path : @moonclip.Path64 = [
    @moonclip.Point64::new(-10L, 0L),
    @moonclip.Point64::new(10L, 0L),
    @moonclip.Point64::new(0L, 10L),
  ]
  let paths : @moonclip.Paths64 = [path, []]
  let copied = @moonclip.copy_paths(paths)
  assert_true(paths == copied)
  path[0] = @moonclip.Point64::new(-99L, 5L)
  assert_eq(copied[0][0].x, -10L)
  assert_eq(copied[0][0].y, 0L)
  assert_true(paths != copied)

  let contour : @moonclip.Path64 = [
    @moonclip.Point64::new(-4L, -3L),
    @moonclip.Point64::new(4L, -3L),
    @moonclip.Point64::new(4L, 3L),
    @moonclip.Point64::new(-4L, 3L),
  ]
  assert_eq(
    @moonclip.orientation(contour[0], contour[1], contour[2]),
    Ok(@moonclip.CounterClockwise),
  )
  match @moonclip.bounds(contour) {
    Ok(Some(box)) => {
      assert_eq(box.min_x, -4L)
      assert_eq(box.min_y, -3L)
      assert_eq(box.max_x, 4L)
      assert_eq(box.max_y, 3L)
    }
    _ => fail("Expected bounds for the rectangle")
  }
  assert_eq(@moonclip.area2(contour), Ok(96N))
  assert_eq(
    @moonclip.point_in_polygon(@moonclip.Point64::new(0L, 0L), contour),
    Ok(@moonclip.Inside),
  )
  assert_eq(
    @moonclip.point_in_polygon(@moonclip.Point64::new(4L, 0L), contour),
    Ok(@moonclip.OnBoundary),
  )
  assert_eq(
    @moonclip.point_in_polygon(@moonclip.Point64::new(5L, 0L), contour),
    Ok(@moonclip.Outside),
  )

  let raw = [
    contour[0],
    contour[0],
    contour[1],
    contour[2],
    contour[3],
    contour[0],
  ]
  let saved = @moonclip.copy_path(raw)
  match @moonclip.normalize_path(raw, @moonclip.Closed) {
    Ok(cleaned) => {
      assert_eq(cleaned, contour)
      assert_eq(raw, saved)
      cleaned[0] = @moonclip.Point64::new(0L, 0L)
      assert_eq(raw, saved)
    }
    Err(error) => fail(error.message())
  }
  let invalid = @moonclip.Point64::new(1000000001L, 0L)
  match @moonclip.bounds([invalid]) {
    Err(CoordinateOutOfRange(loc, X, value)) => {
      assert_true(loc.stage is Bounds)
      assert_eq(loc.vertex_index, Some(0))
      assert_eq(value, 1000000001L)
    }
    _ => fail("Expected coordinate range error")
  }
  let limits : @moonclip.Limits = {
    max_input_paths: 1,
    max_input_vertices: 100,
  }
  assert_true(
    @moonclip.normalize_paths([contour, []], @moonclip.Closed, limits~)
    is Err(ResourceLimitExceeded(_, InputPaths, 1)),
  )
  println("MoonClip geometry foundation OK")
}
```

示例与全部黑盒测试随统一入口编译运行。单项检查命令：

```bash
moon version --all
moon info --target native
moon fmt --check
moon check --target native --deny-warn
moon test --target native
moon build --target native
moon run --target native cmd/example
moon check --target js --deny-warn
moon test --target js
git diff --check
```

修改公开 API 后，运行 `moon info --target native` 与 `moon fmt`，审查并提交 `.mbti`。检查脚本会拒绝未提交的接口变化与格式变化。

## 来源与许可

固定参考 [Clipper2 2.0.1](https://github.com/AngusJohnson/Clipper2/tree/21ebba05db8894f0c7217ad35ea518080f324946)，使用 BSL-1.0 许可。参考范围、版权和移植状态见 [来源记录](docs/upstream.md)；完整许可见 [LICENSE](LICENSE)。运行库由 MoonBit 实现，固定版本 C++ 实现将用于后续独立对照。当前没有几何算法兼容性报告。
