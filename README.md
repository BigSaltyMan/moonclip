# MoonClip

MoonClip 是用 MoonBit 实现的二维多边形几何库，提供整数与统一十进制网格的小数入口。当前为开发中的目标版本 **0.1.0**，尚未发布到 Mooncakes；发布前仍需确认模块名称可用性。运行库不依赖 C++ 或其他几何运行时，支持 native 和 JS。

首版内容见 [CHANGELOG](CHANGELOG.md)。[发布清单](docs/release-checklist.md)、[验收证据](docs/acceptance.md)和[成果说明](docs/submission.md)区分准备、实际候选消费者验证与正式发布；当前没有注册表安装成功的声明。

## 已实现的能力

| 用途 | 公开入口 | 成功结果 |
| --- | --- | --- |
| 区域布尔 | `boolean_op` / `boolean_op_d` | 整数 / 小数平铺轮廓 |
| 孔洞层级 | `boolean_tree` | 整数 `PolyTree64` |
| 闭合区域偏移 | `offset_polygons` / `offset_polygons_d` | 整数 / 小数平铺轮廓 |
| 开放路线加宽 | `stroke_polyline` / `stroke_polyline_d` | 整数 / 小数多边形区域 |
| 显式简化 | `simplify_paths` / `simplify_paths_d` | 轮廓、删点数及三类退化索引 |
| 单图案扫掠 | `minkowski_sum` | 整数平铺轮廓 |

Boolean 支持 Intersection、Union、Difference（Subject 减 Clip）、Xor，以及公开 EvenOdd / NonZero；Positive / Negative 仍是内部能力。Offset 和 Stroke 支持 Miter、Bevel、Square、Round 四种连接；Stroke 提供 Butt、Square、Round 三种端点。方向、边界框、精确两倍有向面积、点包含及无损重复点整理也已实现。完整接口见 [`pkg.generated.mbti`](pkg.generated.mbti)，入口默认值与限制见 [支持范围](docs/scope.md)。

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
Simplify vertices: 9 -> 8; input_degenerate=[2]; degenerate=[2]; collapsed=[]; offset/tree OK
Minkowski: rectangle/polyline, offcenter/diagonal and closed route/hole OK
MoonClip geometry, Boolean, PolyTree, offset, stroke, composition, decimal, simplify and Minkowski OK
```

该包的 `moon.pkg` 导入根模块 `BigSaltyMan/moonclip`。开发阶段从源码运行，Mooncakes 安装命令待实际发布并验证后补充。

导入配置与随包示例相同（`cmd/example/moon.pkg`）：

```moonbit
import {
  "BigSaltyMan/moonclip",
}

pkgtype(kind: "executable")
```

包导入配置与 [`cmd/example/main.mbt`](cmd/example/main.mbt) 是受检的使用起点，各类 API 按上表进入 [scope.md](docs/scope.md)。候选 ZIP 包含运行库、接口、该示例和文字文档；演示、测试、参考工具与基准从 Git 仓库使用。在仓库运行 `python scripts/check_release.py --report _build/release/report.json`，可审计正式归档，并对解压内容执行仓库外 native / JS 消费者。这不代表已从 Mooncakes 安装。

## 浏览器交互演示

```bash
cd demo
npm run dev
```

打开 **http://127.0.0.1:4173**。区域 Boolean、带孔偏移、路线加宽三个场景可切换整数 / 小数及 Precision；路线页签另有**仅整数**的图案扫掠。显式简化默认关闭，出现退化时显示报告并停止后续计算。计算调用 MoonBit 核心，JS 处理交互、绘制和下载。

演示无 npm 依赖，无需先安装包。在 demo 目录运行 `npm test` 复用已构建产物做 7 项桥接冒烟；`npm run build` 生成可静态托管的 `demo/dist`，`npm run build -- --reuse` 可只打包已有产物。SVG 独立打开并保留孔洞；JSON 保存原输入、参数、精度、真实结果及简化统计。输入变更或错误会禁用导出。

操作说明见 [demo.md](docs/demo.md)，三张主要场景截图及实际操作记录见 [浏览器验收](docs/demo-acceptance.md)。

## 检查与性能基线

```bash
bash scripts/check.sh
bash scripts/bench.sh --target native --report _build/bench/report.json
```

统一检查执行格式、接口、native / JS 回归、构建、CLI 示例和离线参考工具；普通 CI 另构建演示、执行桥接冒烟及一个极小基准入口。修改代码后运行 `moon info && moon fmt` 并审查接口变化。

正确性基线为**同一批 2234 项库测试**，native、JS 分别执行；**1384 条独立参考案例**对应 2276 项能力检查，不能重复相加为案例数。固定种子只覆盖公开 Boolean 平铺结果。覆盖矩阵及真实执行证据见 [兼容报告](docs/compatibility.md)，失败缩减见 [随机回归说明](docs/random-regression.md)。

native release 的 11 个固定基准（含三个有上限的压力探针）已测量，环境、输入输出规模、中位数及最小 / 最大值见 [性能基线](docs/benchmarks.md)。没有测上游速度，不作跨库性能结论；CI 不设耗时阈值。

## 来源与许可

固定参考 **Clipper2 2.0.1 / `Clipper2_2.0.1` / `21ebba05db8894f0c7217ad35ea518080f324946`**，BSL-1.0。C# 是主要引擎阅读和移植参考；固定 C++ 实现作为测试参考适配器，仅用于生成和复核数据。普通 CI 读取已提交参考，不下载、构建或执行 C++。

[来源与逐文件映射](docs/upstream.md) · [与固定上游的关系及差异](docs/related-work.md) · [参考适配器说明](https://github.com/BigSaltyMan/moonclip/blob/6a116b45600cbe8ecd577664a71b50fdfa8ce5c0/tools/oracle/README.md) · [完整许可证](LICENSE)
