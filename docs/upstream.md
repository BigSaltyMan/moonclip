# 上游来源与移植记录

## 固定参考

- 仓库：https://github.com/AngusJohnson/Clipper2
- 版本：Clipper2 2.0.1
- 标签：`Clipper2_2.0.1`
- 完整提交：`21ebba05db8894f0c7217ad35ea518080f324946`
- 许可证：BSL-1.0；[固定提交的 LICENSE](https://github.com/AngusJohnson/Clipper2/blob/21ebba05db8894f0c7217ad35ea518080f324946/LICENSE)

2026-10-16 核验：`git ls-remote` 返回该标签指向上述完整 SHA；发布页显示 `Clipper2_2.0.1` / `21ebba0`。已读取该提交的完整 LICENSE，并将原文（前置 MoonClip 版权行）写入根目录 LICENSE。另已读取该提交的 C# `Clipper.Core.cs`，核对 Point64 构造、坐标比较和 Path64 / Paths64 声明。该源码头部版权为 `Angus Johnson 2010-2025`，许可指向 Boost Software License 1.0。

## 已发生的参考

| 上游文件 | MoonBit 文件 | 类型与修改说明 |
| --- | --- | --- |
| `CSharp/Clipper2Lib/Clipper.Core.cs`：Point64、Path64、Paths64 | `types.mbt` | 沿用整数点与有序轮廓容器的设计和命名；使用不可变 Int64 坐标、MoonBit Array 类型别名和派生 Eq。未直接改写上游函数体；未引入 Double 构造、Z 坐标、运算符算术或引擎。 |
| 无直接对应代码 | `types.mbt`：`copy_path`、`copy_paths` | MoonClip 自行实现的容器辅助逻辑，调用 MoonBit 标准库复制及 map；对每个输入轮廓分别复制，切断内外数组别名。 |
| 无直接对应代码 | `types_test.mbt`、`cmd/example/main.mbt` | MoonClip 自行编写的契约测试和公开接口示例。 |

本笔没有直接移植上游代码。MoonClip 原创代码版权使用实际提交作者 Git 身份 `BigSaltyMan`，年份 2026。上游源码的上述版权记录保留在此；以后直接移植代码时，必须在对应文件保留该文件实际的版权与许可声明。

C# 源码作为主要阅读与后续移植参考；固定版本的 C++ 实现作为独立对照。MoonClip 运行库由 MoonBit 实现，不依赖外部几何运行时；参考程序只用于后续测试数据生成。


## Commit 2 几何参考与实现（2026-10-17）

本次重新读取固定提交 `CSharp/Clipper2Lib/Clipper.Core.cs` 的 `CrossProductSign`、`ProductsAreEqual` / `IsCollinear` 与 `PointInPolygon`，比较上游的精确符号、边界与奇偶判定设计。没有直接改写这些函数体。

| 上游文件或设计 | MoonBit 文件 | 实际关系与修改 |
| --- | --- | --- |
| `Clipper.Core.cs` 的 `CrossProductSign`、`IsCollinear` | `geometry.mbt` | 阅读参考。MoonClip 根据限定到 ±10^9 的坐标自行实现统一三点 Int64 行列式及闭区间判断；上游使用 UInt128 乘积比较，未移植其实现。 |
| `Clipper.Core.cs` 的 `PointInPolygon` | `geometry.mbt` | 阅读边界/奇偶语义参考。MoonClip 自行实现先检查边界、半开 y 区间和叉积右射线计数；空、单点和两点按本项目契约处理，没有沿用上游少于三点一律 Outside 的行为。 |
| 无直接对应上游代码 | `geometry.mbt` 的 `bounds`、`area2` | 自行实现最值扫描和精确鞋带公式，面积在溢出前从 Int64 切换到标准库 BigInt。 |
| 无直接对应上游代码 | `limits.mbt`、`normalize.mbt` | 自行实现坐标预检、共享原始输入预算、英文结构化错误及显式开放/闭合重复点整理；不进行面积过滤或拓扑修复。 |

本笔仍未直接移植上游函数体；新增实现版权为 BigSaltyMan 2026，BSL-1.0。MoonBit 标准库 BigInt 是运行时库依赖，来自同一固定工具链的官方 core 归档（Apache-2.0），不是复制进仓库的上游几何代码。native / JS 后端与固定版本说明见 [整数几何说明](numerics.md)。

## Commit 3 C++ 参考与数据（2026-10-17）

重新核对 `Clipper2_2.0.1` 指向完整 SHA `21ebba05db8894f0c7217ad35ea518080f324946`。构建采用该 SHA 的归档并固定 SHA256 `897b7ed793b6a0565f7b1d34367f2301e08d541d82aa238b5f4042b701c811dc`，不是跟随标签或 main 的滚动下载。

| 实际上游文件或来源 | MoonClip 文件/用途 | 实际关系 |
| --- | --- | --- |
| `CPP/Clipper2Lib/src/clipper.engine.cpp` 及 `include/clipper2/` 头文件 | `tools/oracle/CMakeLists.txt`、`adapter.cpp` | 固定 C++ 源码仅下载到忽略目录，保持原样编译为参考程序；不进入 MoonBit 运行库。设置两项输出选项后分别 Execute 到 Paths64 和 PolyTree64，没有复制或自行编写裁剪逻辑。 |
| nlohmann/json 3.12.0 `json.hpp` | `tools/oracle/adapter.cpp` | 工具专用 JSON 整数解析依赖，MIT，版本、文件及许可 SHA256 固定在 upstream-lock.json；完整 MIT 声明保留在 THIRD_PARTY_NOTICES.md。 |
| BigSaltyMan 自行构造的 17 组输入 | `tools/oracle/construct_cases.py`、`testdata/upstream/inputs/` | 136 个稳定 ID 的案例，source 记录目的和分组；没有复制上游测试文件。 |
| 上述固定 C++ 参考程序的实际输出 | `testdata/upstream/expected/` | 保存分别执行的平铺轮廓与孔洞树，关联输入哈希，并由 Python 整数计算诊断指标；全部 reference_only。 |
| MoonClip 自行实现 | `tools/conformance/compare.py`、工具测试与比较器反例 | 只规范循环起点与同级排列，保留所有顶点、绕向、重复数量和父子层级；不使用 MoonClip 待实现算法作证。 |

上游 C++ 文件保留 Angus Johnson 2010-2025 的版权与 BSL-1.0 许可头。上游源码与编译产物不提交；工具及自行构造数据为 BigSaltyMan 2026，BSL-1.0。构建源身份、依赖和许可核验见 [参考工具说明](../tools/oracle/README.md)。C# 继续是主要阅读与后续移植参考，C++ 是独立预期结果的生成实现。

## 计划范围（尚未移植或实现）

| 上游参考文件 | 计划用途与目标 |
| --- | --- |
| `CSharp/Clipper2Lib/Clipper.Engine.cs` | 后续扫描线与布尔运算引擎；尚未建立 MoonBit 对应文件。 |
| `CSharp/Clipper2Lib/Clipper.Offset.cs` | 后续偏移与描边；尚未建立 MoonBit 对应文件。 |

已提供 C++ 参考适配器；MoonClip 算法兼容性尚未运行。后续引擎、偏移等按实际实现继续补充逐文件来源记录。
