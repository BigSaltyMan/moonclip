# MoonClip

MoonClip 是用 MoonBit 实现的二维多边形几何库，提供整数与统一十进制网格的小数入口。**0.1.0 已于 2026-10-20 发布到 Mooncakes**，并完成仓库外 native / JS 注册表消费者验证。运行库不依赖 C++ 或其他几何运行时。

首版内容见 [CHANGELOG](CHANGELOG.md)，下载与校验和见 [GitHub Release v0.1.0](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.1.0)。[正式发布记录](docs/release-0.1.0.md)区分候选验收、注册表安装与既有 CI；[成果说明](docs/submission.md)保留来源、贡献和申报边界。

## 从 Mooncakes 使用

在自己的 MoonBit 模块中运行：

```bash
moon add BigSaltyMan/moonclip@0.1.0
```

在包的 moon.pkg 中导入 `BigSaltyMan/moonclip`，配置见下文。该版本从注册表获取后已在独立项目运行 native、JS；数值与预算边界仍按 [scope.md](docs/scope.md) 解释。

## 已发布 0.1.0 的能力

| 用途 | 公开入口 | 成功结果 |
| --- | --- | --- |
| 区域布尔 | `boolean_op` / `boolean_op_d` | 整数 / 小数平铺轮廓 |
| 孔洞层级 | `boolean_tree` | 整数 `PolyTree64` |
| 闭合区域偏移 | `offset_polygons` / `offset_polygons_d` | 整数 / 小数平铺轮廓 |
| 开放路线加宽 | `stroke_polyline` / `stroke_polyline_d` | 整数 / 小数多边形区域 |
| 显式简化 | `simplify_paths` / `simplify_paths_d` | 轮廓、删点数及三类退化索引 |
| 单图案扫掠 | `minkowski_sum` | 整数平铺轮廓 |

Boolean 支持 Intersection、Union、Difference（Subject 减 Clip）、Xor，以及公开 EvenOdd / NonZero；Positive / Negative 仍是内部能力。Offset 和 Stroke 支持 Miter、Bevel、Square、Round 四种连接；Stroke 提供 Butt、Square、Round 三种端点。方向、边界框、精确两倍有向面积、点包含及无损重复点整理也已实现。完整接口见 [`pkg.generated.mbti`](pkg.generated.mbti)，入口默认值与限制见 [支持范围](docs/scope.md)。

## 开发源码中的 Unreleased 能力

`stroke_tree(path, width, cap=, options=, limits=)` 返回 `Result[PolyTree64, ClipError]`，`stroke_tree_d(path, width, precision=, cap=, options=, limits=)` 返回 `Result[PolyTreeD, ClipError]`。width 是完整宽度，默认 Butt，支持三种端点和四种连接。输入是一条开放路线，返回清理后填充区域的层级；首尾重合仍保留开放端点语义。输入整理、生成、清理、树构建和解码共用预算。**两个描边树入口均未随 0.1.0 发布**，示例见 [组合说明](docs/composition.md#unreleasedstroke-trees)。

`offset_tree(paths, delta, fill_rule=, options=, limits=)` 返回 `Result[PolyTree64, ClipError]`；`offset_tree_d(paths, delta, precision=, fill_rule=, options=, limits=)` 返回 `Result[PolyTreeD, ClipError]`。默认 NonZero，沿用四种连接与现有偏移参数。树表达最终偏移区域，扩张、收缩可能合并区域、分裂轮廓或消灭孔洞。规范化、生成、清理、树构建及小数解码共用一份累计预算。**两个偏移树入口均未随 Mooncakes 0.1.0 发布**。示例见 [组合说明](docs/composition.md#unreleasedoffset-trees)。

`boolean_tree_d(subject, clip, operation, precision=, fill_rule=, limits=)` 返回 `Result[PolyTreeD, ClipError]`，默认 Precision=3、EvenOdd。`PolyTreeD` 提供 `roots()` / `to_paths()`；节点提供 `contour()` / `children()` / `depth()` / `is_hole()`，访问器数组均独立复制。

该入口只在当前开发源码中可用，**Mooncakes 0.1.0 不包含此接口**。层级沿用量化后整数区域已验证的拓扑，Precision 变化可能影响可表达关系；坐标解码为 Double，`to_paths()` 会丢失显式父子关系。用法及预算见 [小数树说明](docs/decimal.md#unreleased小数孔洞树)，可运行的完整断言见下文 CLI 示例。当前源码接口见 `.mbti`，不能据此推定已发布包具备新能力。

## 数据与使用边界

- `Point64` 保存不可变的完整 Int64；`Path64` / `Paths64` 是有序可变数组。几何运算的每轴范围为 **±1,000,000,000**，包含边界。存储范围与运算范围不同。
- 构造原样保存空路径、单点、两点及重复点；闭合轮廓通常不重复存储首点，由算法解释闭合边。结构比较严格保留坐标、长度和顺序。
- 数组赋值可以共享存储。需要隔离时用 `copy_path` / `copy_paths`（小数有 `_d` 版本）；集合复制同时隔离内外数组和输入别名。
- `Precision::new` 支持 **0—6**，默认 3。小数公开调用先检查并量化到十进制网格，再执行整数核心；范围随精度缩小。量化可能报合并或退化错误，不能把它当成任意精度浮点几何。
- 计算入口返回 `Result`，失败不修改输入、不发布部分结果。默认原始输入预算为 10,000 条路径、100,000 个点；内部另有累计节点和工作预算，合法坐标及数量不保证复杂输入一定完成。
- `simplify_paths` 需要显式调用，不保证拓扑保持。面积为零不能直接判断自交输入没有区域；`point_in_polygon` 仅解释单轮廓 EvenOdd。

数值、舍入、错误和预算详见 [numerics.md](docs/numerics.md)、[decimal.md](docs/decimal.md)、[composition.md](docs/composition.md)。孔洞方向、简化报告、扫掠闭合语义及尚未提供的能力集中列在 [scope.md](docs/scope.md)。

## 从本地源码运行

使用 [固定工具链](docs/toolchain.md)。Windows 使用 Git Bash；Linux 使用 Bash：

```bash
git clone https://github.com/BigSaltyMan/moonclip.git
cd moonclip
moon run --target native cmd/example
```

[`cmd/example/main.mbt`](cmd/example/main.mbt) 是受检的公开调用示例，包含复制隔离、精确几何、Boolean / PolyTree、带孔偏移、路线描边、小数组合、显式简化和图案扫掠。它检查完整轮廓与错误，成功输出：

```text
Decimal tree: outer/hole/island OK
Simplify vertices: 9 -> 8; input_degenerate=[2]; degenerate=[2]; collapsed=[]; offset/tree OK
Minkowski: rectangle/polyline, offcenter/diagonal and closed route/hole OK
MoonClip geometry, Boolean, PolyTree, offset, stroke, composition, decimal, simplify and Minkowski OK
```

该包的 `moon.pkg` 导入根模块 `BigSaltyMan/moonclip`。当前源码示例还检查 Unreleased 小数树；已发布包中的旧示例和注册表消费者仍以 0.1.0 的接口为准。

导入配置与随包示例相同（`cmd/example/moon.pkg`）：

```moonbit
import {
  "BigSaltyMan/moonclip",
}

pkgtype(kind: "executable")
```

包导入配置与 [`cmd/example/main.mbt`](cmd/example/main.mbt) 是受检的使用起点，各类 API 按上表进入 [scope.md](docs/scope.md)。发布 ZIP 包含运行库、接口、该示例和文字文档；演示、测试、参考工具与基准从 Git 仓库使用。`scripts/check_release.py` 只审计源码候选及解压消费者，不执行发布；本次真正的注册表安装验证另见 [发布记录](docs/release-0.1.0.md)。

## 浏览器交互演示

```bash
cd demo
npm run dev
```

打开 **http://127.0.0.1:4173**。区域 Boolean、带孔偏移、路线加宽三个场景可切换整数 / 小数及 Precision；路线页签另有**仅整数**的图案扫掠。显式简化默认关闭，出现退化时显示报告并停止后续计算。计算调用 MoonBit 核心，JS 处理交互、绘制和下载。

演示无 npm 依赖，无需先安装包。在 demo 目录运行 `npm test` 复用已构建产物做 20 项桥接／导出冒烟；`npm run build` 生成可静态托管的 `demo/dist`，`npm run build -- --reuse` 可只打包已有产物。SVG 独立打开并保留孔洞；JSON 保存原输入、参数、精度、真实结果及简化统计。输入变更或错误会禁用导出。

开发演示还提供 **Unreleased 孔洞层级查看**：Boolean、Offset、Stroke 的整数／小数六个树入口可展开父子节点、选择边界高亮；SVG 仍只导出填充区域，树 JSON 使用版本 2 保存层级与可复现请求。平铺模式默认行为和版本 1 JSON 保持兼容，Minkowski 只支持平铺。

操作说明见 [demo.md](docs/demo.md)，三张主要场景截图及实际操作记录见 [浏览器验收](docs/demo-acceptance.md)。

## 检查与性能基线

```bash
bash scripts/check.sh
bash scripts/bench.sh --target native --report _build/bench/report.json
```

统一检查执行格式、接口、native / JS 回归、构建、CLI 示例和离线参考工具；普通 CI 另构建演示、执行桥接冒烟及一个极小基准入口。修改代码后运行 `moon info && moon fmt` 并审查接口变化。

已发布 0.1.0 的正确性基线为**同一批 2234 项库测试**。Unreleased 树入口累计新增 89 项定向测试（小数 Boolean 33、偏移 27、描边 29），当前源码完整回归计数为 **2323**；演示的 20 项桥接测试独立统计，native、JS 分别执行，不相加。**1384 条独立参考案例**对应 2276 项能力检查，旧数据未改，也不宣称覆盖新增入口。固定种子只覆盖公开 Boolean 平铺结果。覆盖矩阵及既有执行证据见 [兼容报告](docs/compatibility.md)，失败缩减见 [随机回归说明](docs/random-regression.md)。

native release 的 11 个固定基准（含三个有上限的压力探针）已测量，环境、输入输出规模、中位数及最小 / 最大值见 [性能基线](docs/benchmarks.md)。没有测上游速度，不作跨库性能结论；CI 不设耗时阈值。

## 来源与许可

固定参考 **Clipper2 2.0.1 / `Clipper2_2.0.1` / `21ebba05db8894f0c7217ad35ea518080f324946`**，BSL-1.0。C# 是主要引擎阅读和移植参考；固定 C++ 实现作为测试参考适配器，仅用于生成和复核数据。普通 CI 读取已提交参考，不下载、构建或执行 C++。

[来源与逐文件映射](docs/upstream.md) · [与固定上游的关系及差异](docs/related-work.md) · [参考适配器说明](https://github.com/BigSaltyMan/moonclip/blob/6a116b45600cbe8ecd577664a71b50fdfa8ce5c0/tools/oracle/README.md) · [完整许可证](LICENSE)
