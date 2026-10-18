# MoonClip

MoonClip 是用 MoonBit 实现的整数多边形几何库，目前处于开发初期。目标版本为 `0.1.0`，尚未发布到 Mooncakes，模块名称的可用性将在发布前确认。

目前已实现：不可变 `Int64` 点、有序路径与轮廓集合、结构比较、独立复制，以及精确叉积与方向、边界框、精确两倍有向面积、EvenOdd 点包含判断和开放/闭合模式的重复点整理。另已建立内部扫描线、活动边、交点事件、水平交互及输出环连接原语，采用节点复用和共享工作量预算；公开支持 EvenOdd 下的 Intersection、Union、Difference、Xor。NonZero、孔洞树、偏移、描边、小数接口和简化仍在后续计划中。

## 数据契约

- `Point64` 的 `x`、`y` 不可变，构造时直接保存 `Int64`，不经过 `Double`。完整 Int64 存储范围不代表后续几何运算的坐标范围承诺。
- `Path64 = Array[Point64]`，`Paths64 = Array[Path64]`；直接使用数组字面量构造。赋值和组合数组可共享存储，需要隔离时显式调用复制函数。
- 空路径、单点、两点、连续重复点和重复首点均原样保存；空集合 `[]` 与 `[[]]` 不相等。
- 闭合轮廓的规范表示不重复存储首点；闭合边由后续算法解释。容器不自动去重、闭合、反向或删除退化轮廓。
- `==` / `!=` 使用 `Eq`，比较坐标、长度和顺序。环起点移动、反向或交换轮廓可能不相等，不进行几何等价判断。
- `copy_path` 创建新的点数组；`copy_paths` 创建新的外层数组，并为每条路径创建独立数组，即使输入路径共享同一数组。源、副本、不同复制调用之间的修改相互隔离。不可变点可安全复用。
- `copy_path` 时间与额外空间为 O(V)；`copy_paths` 为 O(P + V)，其中 P 为轮廓数、V 为总顶点数。

## 几何计算与输入边界

几何与整理入口接受的每轴坐标范围为 **[-1_000_000_000, 1_000_000_000]**（含边界），与 Point64 的完整 Int64 存储范围不同。`COORDINATE_LIMIT` 公开这一上限。输入坐标不会被截断或钳制；叉积、方向和面积使用精确整数。扫描投影与生成交点的网格转换遵循固定参考规则，见 [数值契约](docs/numerics.md)。

所有新增入口返回 `Result`，错误分为 `InvalidInput`、`CoordinateOutOfRange`、`ExecutionFailure`、`NumericFailure`、`ResourceLimitExceeded`，附阶段、原始路径/顶点索引、轴与坐标或资源类别及限制值；`message()` 给出英文说明。不适用的索引为 None。

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

## 内部扫描线状态

扫描事件沿数值 y 从大到小调度。内部组件已接通稳定归并交点生成、相邻事件交换、水平穿越与重叠候选，以及输出环创建、两端延伸、闭合、拆分、合并和独立提取。几何事件通过显式决策入口连接输出；未提供贡献决策或未消费水平连接时保留待处理状态。公开 boolean_op 已自动生成四种操作的 EvenOdd 决策，调用方不需要提供内部动作。公开 Limits 的两个字段保持不变。架构、阶段边界与验证范围见 [内部引擎说明](docs/engine.md)。

## 固定上游参考与离线检查

已建立固定 Clipper2 2.0.1 C++ 参考适配器，生成 136 个闭合路径布尔参考案例，并建立保留绕向、顶点数量和孔洞归属的轮廓/PolyTree 比较器。其中预先锁定的 60 条 EvenOdd 平铺轮廓已实际比较通过；其余 76 条填充规则及全部 136 条孔洞树仍为 reference_only。能力状态分别记录，不能把平铺通过当作整例拓扑树通过。

普通检查使用 Python 3.11+ 标准库读取已提交数据，不下载上游、不构建或调用 C++：

```bash
python -m unittest discover -s tools/conformance -p "test_*.py"
python scripts/check_reference.py --manifest testdata/manifest.json --strict
```

两项已接入 `bash scripts/check.sh` 与普通 CI。参考重建通过独立脚本和手动 `rebuild-reference` workflow 完成；操作方法、协议、固定依赖与实际构建环境见 [参考工具说明](tools/oracle/README.md)，覆盖和计数见 [参考案例记录](docs/reference-cases.md)。参考生成数与工具测试数不计作 MoonClip 布尔兼容性通过数。

## 来源与许可

固定参考 [Clipper2 2.0.1](https://github.com/AngusJohnson/Clipper2/tree/21ebba05db8894f0c7217ad35ea518080f324946)，使用 BSL-1.0 许可。参考范围、版权和移植状态见 [来源记录](docs/upstream.md)；完整许可见 [LICENSE](LICENSE)。运行库由 MoonBit 实现，固定版本 C++ 实现已用于独立参考数据生成。当前平铺结果与目标覆盖见 [兼容性报告](docs/compatibility.md)。


## EvenOdd 布尔运算

公开入口为 `boolean_op(subject, clip, operation, fill_rule=EvenOdd, limits=...)`，返回 `Result[Paths64, ClipError]`。操作类型为 Intersection、Union、Difference、Xor；Difference 固定为 Subject 减 Clip。使用方法与逐点结果断言见 [可运行示例](cmd/example/main.mbt)，本地直接执行 `moon run --target native cmd/example`。

Subject、Clip 各自计算奇偶填充，再应用操作。同组重复两次的轮廓抵消，三次保留；两组各含一条相同轮廓时，Union 保留、Xor 为空。绕向不改变 EvenOdd 填充。`Union(A, [])` 会构造 A 的 EvenOdd 填充边界，不是简单复制原始轮廓。

空路径、单点、两点及全共线闭合轮廓不产生面域；自交轮廓不能按总有向面积为零删除。原始总路径数、顶点数和坐标检查先于所有空结果处理。两组输入共享 Limits；内部固定使用累计 500,000 个逻辑节点、5,000,000 个工作步骤，覆盖输入准备、扫描、交点、连接、整理和提取。耗尽时返回 ResourceLimitExceeded，不返回截断结果；独立调用重新建立状态。ExecutionFailure 表示内部执行契约失败，区别于参数错误。

结果是平铺闭合轮廓，不重复首点，固定 preserve_collinear=false、reverse_solution=false；不保证环起点和轮廓顺序。外部边界与孔洞按固定配置的绕向保留，不提供已证明的父子关系。返回数组与两组输入、其他调用、内部节点完全隔离。PolyTree 在 Commit 8 接入，NonZero 在 Commit 7 接入。

示例完整检查面积为 50、150、50、100 的四种操作结果，Xor 验证两条分离条带，另检查凹轮廓。面积只作辅助，完整轮廓才是对照依据。

```bash
python tools/conformance/generate_evenodd.py --check
moon run --target native cmd/conformance -- --manifest testdata/manifest.json --report-json _build/conformance/report.json --report-md docs/compatibility.md --strict
```

原生报告命令通过公开接口运行 60 条已生成的固定输入，不链接预期结果。Python 3.11+ 仅处理清单、内容哈希、已有严格比较器和报告 IO；cmd/conformance 的小型 C 桥只负责原生进程传输，根库没有文件 IO 或外部几何运行时。退出码 0 表示成功/帮助，1 表示轮廓差异，2 表示参数、完整性或执行错误。JS 独立执行同一批 60 项生成测试，不能用 native 报告替代 JS 证据。生成一致性、完整报告与双目标测试已纳入 scripts/check.sh。
