# 上游来源与移植记录

当前范围：整数 / 小数 Boolean、整数 PolyTree 及 Unreleased 小数 PolyTree、闭合偏移、开放描边及 Unreleased 整数／小数偏移树和描边树、显式简化、整数单图案 Minkowski Sum 已实现。下面按提交保留实际来源历史；“本笔未实现”等描述仅指对应历史阶段。当前公开差异与证据计数见 [related-work.md](related-work.md)，支持范围见 [scope.md](scope.md)。

## 固定参考

- 仓库：https://github.com/AngusJohnson/Clipper2
- 版本：Clipper2 2.0.1
- 标签：`Clipper2_2.0.1`
- 完整提交：`21ebba05db8894f0c7217ad35ea518080f324946`
- 许可证：BSL-1.0；[固定提交的 LICENSE](https://github.com/AngusJohnson/Clipper2/blob/21ebba05db8894f0c7217ad35ea518080f324946/LICENSE)

2026-10-16 核验：`git ls-remote` 返回该标签指向上述完整 SHA；发布页显示 `Clipper2_2.0.1` / `21ebba0`。已读取该提交的完整 LICENSE，并将原文（前置 MoonClip 版权行）写入根目录 LICENSE。另已读取该提交的 C# `Clipper.Core.cs`，核对 Point64 构造、坐标比较和 Path64 / Paths64 声明。该源码头部版权为 `Angus Johnson 2010-2025`，许可指向 Boost Software License 1.0。

## Commit 1 已发生的参考

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
| 上述固定 C++ 参考程序的实际输出 | `testdata/upstream/expected/` | 保存分别执行的平铺轮廓与孔洞树，关联输入哈希，并由 Python 整数计算诊断指标；生成时全部 reference_only；当前能力状态见兼容性报告。 |
| MoonClip 自行实现 | `tools/conformance/compare.py`、工具测试与比较器反例 | 只规范循环起点与同级排列，保留所有顶点、绕向、重复数量和父子层级；不使用 MoonClip 待实现算法作证。 |

上游 C++ 文件保留 Angus Johnson 2010-2025 的版权与 BSL-1.0 许可头。上游源码与编译产物不提交；工具及自行构造数据为 BigSaltyMan 2026，BSL-1.0。构建源身份、依赖和许可核验见 [参考工具说明](https://github.com/BigSaltyMan/moonclip/blob/6a116b45600cbe8ecd577664a71b50fdfa8ce5c0/tools/oracle/README.md)。C# 继续是主要阅读与后续移植参考，C++ 是独立预期结果的生成实现。

## Commit 4 内部扫描结构与投影（2026-10-17）

本笔首次将固定引擎的部分结构与函数路线改写到 MoonBit。实际读取固定提交的 C++ `clipper.engine.h`、`clipper.engine.cpp` 及 C# `Clipper.Engine.cs`；所有参考仍固定到同一个完整 SHA。

| 上游文件 / 结构或函数 | MoonBit 文件 | 实际改写与范围 |
| --- | --- | --- |
| C++ `clipper.engine.h` 的 Vertex、LocalMinima、Active、PathType、AEL/SEL 字段 | `engine_types.mbt` | 沿用结构分工与角色，指针改成数组索引/None；增加原始来源、slot+generation 句柄、集中池和独立成员标记。没有引入 OutPt/OutRec 或布尔输出结构。 |
| C++ / C# `TopX` | `geometry.mbt` 的 `scan_project` | 沿用先舍入相对位移再加 bot.x、端点和垂直直接返回的顺序；以明确 floor/奇偶规则实现 ties-to-even，补充有限性、转换和加法检查。水平状态不使用无穷哨兵。 |
| C++ / C# `IsValidAelOrder` 的闭合路径规则 | `scanbeam.mbt` 的 `resident_before_new` | 改用精确整数谓词；保留后续转向、左右边界及另一侧边界判断，扩展连续共线点查找，最后用输入来源稳定区分。只用于状态插入，不作通用排序。开放路径规则与输出连接未接入。 |
| C# `ExecuteInternal` 的阶段组织 | `scanbeam.mbt` 的 `scan_step` | 改为显式阶段与 Await 边界；真实完成事件准备、水平链/边段推进和配对生命周期，未接入的交点、水平交叉与输出消费必须明确等待，不能假装已执行。 |
| MoonClip 自行实现 | `engine_types.mbt`、`scanbeam.mbt` | 原始索引快照、平台分组、堆/集合高度队列、代次池、共享预算、不变量诊断和错误终止；复用 Commit 2 的校验及 Closed 整理契约。 |

实际改写部分保留 Angus Johnson 2010-2025 版权与 BSL-1.0，MoonClip 新增部分版权为 BigSaltyMan 2026；对应源码和根 LICENSE 均有声明。几何符号继续由统一精确行列式实现。没有改变 C++ 适配器、协议或参考数据，136 例仍为 reference_only，本笔不新增布尔兼容性通过数。

## 计划范围（尚未移植或实现）

| 上游参考文件 | 计划用途与目标 |
| --- | --- |
| `CSharp/Clipper2Lib/Clipper.Engine.cs` / C++ 引擎的其余部分 | 开放路径参与 Boolean 仍未接入；孔洞树、四种闭合操作及私有正负规则已实现，具体见后续来源表。 |
| `CSharp/Clipper2Lib/Clipper.Offset.cs` / `CPP/Clipper2Lib/src/clipper.offset.cpp` 的其他能力 | 闭合偏移、四种连接和开放描边已在 Commit 9—11 接入 offset.mbt / stroke.mbt；尚无 Joined / Polygon 端点或可变宽度回调等额外接口。 |

已提供 C++ 参考适配器；Commit 3 时 MoonClip 算法兼容性尚未运行。后续引擎、偏移等按实际实现继续补充逐文件来源记录。


## Commit 5 交点、水平交互与输出（2026-10-17）

继续固定同一完整 SHA，实际读取 C++ `clipper.core.h` / `clipper.engine.cpp` 的以下函数。MoonBit 改写文件保留 Angus Johnson 2010-2025、BigSaltyMan 2026 与 BSL-1.0 声明。

| 上游函数/结构 | MoonBit 文件 | 实际改写与差异 |
| --- | --- | --- |
| GetLineIntersectPt 普通分支、GetClosestPointOnSegment、AddNewIntersectNode | geometry.mbt、intersections.mbt | 固定普通分支的运算顺序、向零截断及分支式带外修正；最近点复用统一位移舍入，补充有限性与范围错误。 |
| BuildIntersectList、IntersectListSort、ProcessIntersectList | intersections.mbt | 稳定数组归并配合独立 SEL；事件带代次、边段与带身份；有预算的相邻搜索，找不到合法事件明确失败。额外保留非交换的带顶网格接触候选。 |
| DoHorizontal、ResetHorzDirection | horizontals.mbt、engine.mbt | 按水平运动方向处理真实相邻交互和端点后续转向；输出动作由显式回调提供，不移植四种操作的贡献策略。 |
| OutPt/OutRec、AddOutPt、SwapOutrecs、JoinOutrecPaths、ProcessHorzJoins | output.mbt、horizontals.mbt | 索引环、独立节点身份、活动端双向关联、完成环的拆分/合并和单独重定向；候选保存节点而非坐标。无需指针所有权及物理释放，alive 与错误检查控制生命周期。 |
| CleanCollinear、IsVerySmallTriangle、FixSelfIntersects、DoSplitOp | output.mbt | 独立输出整理，沿用尖刺、小三角形及局部自交/微交叉条件。严格相交预判与面积阈值改用精确整数，缩放及与上游浮点累加的差异见 numerics.md。 |
| MoonClip 自行实现 | engine.mbt、其余新增文件 | 显式贡献决策队列、跨组件累计预算、输出环诊断、错误终止、来源和拆分记录；没有孔洞归属推断或公开 Boolean API。 |

参考 CMake 现显式指定 `CLIPPER2_HI_PRECISION=0`，原来未定义该宏时选择的也是普通分支；构建报告增加 compile_definitions。因固定影响结果的编译选项，重新验证实际适配器和全部参考重建。未改动 136 例预期与 reference_only 状态；内部事件组合测试不计为上游布尔兼容性通过。


## Commit 6 EvenOdd 贡献与四种操作（2026-10-18）

实际读取同一固定提交 CSharp/Clipper2Lib/Clipper.Engine.cs 的 IsContributingClosed、SetWindCountForClosedPathEdge、InsertLocalMinimaIntoAEL、IntersectEdges、AddLocalMinPoly、AddLocalMaxPoly、JoinOutrecPaths。

| 上游路线 | MoonBit 文件 | 改写说明 |
| --- | --- | --- |
| 闭合 EvenOdd 绕数初始化与 IsContributingClosed | boolean.mbt、engine_types.mbt | 仅实现闭合 EvenOdd；wind_other 保存另一操作数的区域奇偶，ClipType 组合独立操作数区域；四种操作和 FillRule 正式公开。 |
| InsertLocalMinimaIntoAEL / IntersectEdges | boolean.mbt、engine.mbt、intersections.mbt | 成对插入后逐条执行右边界跨越，自动贡献回调复用真实交点与水平事件；不使用测试决策或直接排序跳过连接。 |
| AddLocalMinPoly / JoinOutrecPaths 的输出端与方向 | boolean.mbt、output.mbt | 按前一个已贡献活动边决定输出两侧；合并时维护原记录方向和剩余活动端，保持索引环与重定向。 |
| MoonClip 自行实现 | boolean.mbt | 公开 Result 入口、ExecutionFailure 分类、共享预算收尾；完成环一般共线共享边的预算内节点连接。没有正式几何父子关系。 |

所有运行几何仍为 MoonBit；cmd/conformance 的 C 代码只将 JSON 传给 Python 报告脚本，不含几何实现。参考适配器、编译定义、上游输入与参考预期均未改动。60 条 EvenOdd 平铺对照已启动真实比较，树及其余规则保持待验证；不将此笔记为全部 136 例完整兼容。


## Commit 7 完整闭合绕数（2026-10-18）

实际读取同一固定 C# Clipper.Engine.cs 完整 SetWindCountForClosedPathEdge、IsContributingClosed、IntersectEdges 闭合分支，以及 C++ clipper.engine.cpp 的 AddPaths_、CheckJoinLeft/Right、Split、UpdateEdgeIntoAEL。定位案例时只在独立临时副本中加入诊断，固定源、适配器和编译配置未变。

| 上游函数 | MoonBit 文件 | 实际改写与区别 |
| --- | --- | --- |
| 完整绕数初始化、贡献和交点更新 | boolean.mbt、engine_types.mbt | 保留较大幅度相邻区域语义和原链方向；私有四规则、公有两规则；有界检查及符号比较替代 abs/乘积。 |
| AddPaths_ 平台标记 | scanbeam.mbt | 实际布尔执行采用原遍历平台末端，保留低层调试首端契约、原始索引和输入方向。 |
| CheckJoinLeft/Right、Split | boolean.mbt、engine.mbt、horizontals.mbt | 用代次句柄双向关联活动共边，事件/边段改变前分离；精确判断，累计预算和显式错误。 |
| MoonClip 自行实现 | selection.py、generate_boolean.py、evidence.py | 输入字段选择、公开/私有分流、实际过滤记录校验，不是上游几何移植。 |

运行几何仍完全由 MoonBit 实现。新增 64 条自行构造参考，原有 136 条输入及预期字节不变。公开 EO/NZ 各 76 和私有正负各 24 分开记录；全部树仍 reference_only。


## Commit 8 几何归属与 PolyTree（2026-10-18）

继续固定同一完整 SHA。实际读取 C# Clipper.Engine.cs 的 SetOwner、AddLocalMinPoly、CheckBounds、CheckSplitOwner、RecursiveCheckOwners、BuildTree、GetCleanPath、Path1InsidePath2，以及 Clipper.Core.cs 的 Path2ContainsPath1；公开容器语义同时核对 [PolyTree64 官方说明](https://www.angusj.com/clipper2/Docs/Units/Clipper.Engine/Classes/PolyTree64/_Body.htm)。

| 实际参考 | MoonBit 文件 | 改写与自主实现 |
| --- | --- | --- |
| 输出创建及拆分归属线索 | boolean.mbt、output.mbt | 合并别名、拆分来源、邻近边线索和最终几何父节点分开保存；不将别名/来源当作父节点。 |
| BuildTree 动态记录队列、CheckBounds | output.mbt、polytree.mbt | 先对所有旧/新增拆分记录完成清理和修复，再冻结有效记录；revision 标记边界框缓存。平铺与树共享同一计算核心和整理。 |
| CheckSplitOwner、RecursiveCheckOwners 的归属目标 | polytree.mbt | 保留身份并解析线索，以包围盒筛选和精确包含确认全部候选；直接父节点由容器关系确认，显式迭代取代递归。 |
| Path1InsidePath2、GetCleanPath、Core.Path2ContainsPath1 | polytree.mbt | 实际核对连续两次分类、On 忽略、清理及整数包围盒中点回退；自主改为全边接触分段和分母二中点、BigInt 精确谓词，未沿用宽松量化猜测。数值范围和差异见 engine.md。 |
| PolyTree 根/孔洞/岛层级 | polytree.mbt | 自行实现不可变索引视图、复制访问器、共享预算和诊断，不移植上游可变对象树。 |
| MoonClip 自行实现 | conformance 生成器/运行器/报告 | 两个公开入口独立执行，分别传输路径/树协议；公开/私有分流及专属过滤日志。 |

所有运行几何与树归属由 MoonBit 实现，没有新增依赖。参考适配器、固定构建、参考协议、200 份输入/预期和选择文件未改；本笔只迁移清单能力状态和消费已有树预期。公开规则仍为两种，内部正负规则不公开。版权及 BSL-1.0 声明沿用。


## Commit 9 闭合偏移（2026-10-18）

继续固定 Clipper2_2.0.1 / `21ebba05db8894f0c7217ad35ea518080f324946`。本笔实际逐项核对 C++ `CPP/Clipper2Lib/src/clipper.offset.cpp` 及 `clipper.core.h`；C# 仍为整体引擎主要阅读来源，这次偏移数值顺序以固定 C++ 普通精度作为独立对照。官方 [ClipperOffset](https://www.angusj.com/clipper2/Docs/Units/Clipper.Offset/Classes/ClipperOffset/_Body.htm) / [MiterLimit](https://www.angusj.com/clipper2/Docs/Units/Clipper.Offset/Classes/ClipperOffset/Properties/MiterLimit.htm) 仅用于语义核对。

| 实际参考 | MoonBit 文件 | 本笔改写与区别 |
| --- | --- | --- |
| offset.cpp GetUnitNormal、BuildNormals、OffsetPoint | offset.mbt | 按法线、正负距离、凹连接三点、近直线分类改写；入口先共同 Union，不使用单点/开放轮廓分支。 |
| DoMiter、DoBevel、DoSquare、GetAvgUnitVector、ReflectPoint | offset.mbt | Miter 阈值严格大于、超限内部 Square 回退；Bevel 独立；Square 用固定线交点/反射次序；Round 未移植。 |
| core.h Double CrossProduct、GetLineIntersectPt、Point 浮点构造 | offset.mbt | 核对向量叉积符号、线参数钳制及 std::round；MoonBit 自行增加有限性、Int64 转换与坐标边界错误。 |
| ExecuteInternal 的方向相关 Union 目标 | offset.mbt、boolean.mbt | 正外负孔规范化后固定 Positive 清理；abs(delta)<0.5 返回已规范化独立结果。 |
| MoonClip 自行实现 | engine_types.mbt、scanbeam.mbt、offset.mbt | 跨阶段累计预算、原始/生成输入区分、Result 及参数校验、来源隔离、纯 MoonBit 容器。 |
| 参考工具，自主实现 | tools/oracle、tools/conformance | C++ 参考适配器 v2 与原 v1 分开；116 份预锁定自构造输入、严格数据/报告及独立测试。 |

实际改写文件保留 Angus Johnson 2010–2025 版权及 BSL-1.0 声明，项目代码版权 BigSaltyMan 2026。运行库全部几何由 MoonBit 实现，无新依赖。C++ 仅用于独立预期生成；固定源完整归档及原始许可仍由原锁校验。新增编译输入 offset.cpp 与协议 v2 写入锁；原 Boolean v1、200 份输入/预期和两个选择文件字节未动。公开 Square、Round、ArcTolerance、开放描边引擎仍为后续范围。


## Commit 10 方角、圆角与精度（2026-10-18）

实际核对同一固定提交 CPP/Clipper2Lib/src/clipper.offset.cpp 的 DoRound、DoGroupOffset、OffsetPoint 与 arc_const/floating_point_tolerance；未改变固定上游SHA、编译选项及依赖。offset.mbt 保留 Angus Johnson 2010–2025 的 BSL-1.0 声明，MoonClip 自主逻辑版权 BigSaltyMan 2026。

| 实际来源 | MoonBit 文件 | 本笔改写 |
| --- | --- | --- |
| DoSquare / OffsetPoint | offset.mbt | 公开 Square 复用已移植方角，Round 排除近共线 Miter 快速路径，凹角仍优先。 |
| DoGroupOffset 圆弧参数 | offset.mbt | 同一有效容差、采样上限和旋转参数；显式处理 acos(1) 的采样上限分支，并增加有限性检查。 |
| DoRound | offset.mbt | 保留 atan2 转角、ceil 步数、固定旋转次序及直接终点；无开放路径 j==k 分支。 |
| MoonClip 自行实现 | offset.mbt、参考工具与测试 | 可选参数校验、实际点数预算预检、共享账本、v2兼容字段、两批选择和独立参考；参考适配器仅增加保守采样安全检查，不生成替代几何。 |

运行库仍为纯 MoonBit；新增使用固定工具链 core/math，未新增第三方包。40项功能和156条独立参考分别验证，旧316对参考保持字节不变。开放折线、端点样式仍计划由Commit 11接入。


## Commit 11 开放描边（2026-10-18）

固定版本继续为Clipper2_2.0.1 / 21ebba05db8894f0c7217ad35ea518080f324946。本笔实际读取CPP/Clipper2Lib/src/clipper.offset.cpp的Group::Group/StripDuplicates、BuildNormals、OffsetOpenPath、DoBevel(j==k)、DoSquare(j==k)、DoRound(j==k)及DoGroupOffset。端点语义另核对[官方EndType说明](https://www.angusj.com/clipper2/Docs/Units/Clipper/Types/EndType.htm)。

| 实际来源 | MoonBit文件 | 改写与自有契约 |
| --- | --- | --- |
| Group的开放重复点整理、OffsetOpenPath | stroke.mbt | 不删重复末端，不先Union；正向/反向边界和法线次序对应固定实现。预检和Open独立副本由MoonClip实现。 |
| DoBevel端点分支 | stroke.mbt | Butt端点横向截平，生成前检查坐标与计费。 |
| DoSquare端点分支 | offset.mbt、stroke.mbt | 复用已有截线/反射公式，端点取外向切线，先反射点再交点；闭合方角顺序不变。 |
| DoRound端点分支 | stroke.mbt、offset.mbt | 半圆π，起点负法线、终点正法线，共用圆弧参数/预算/直接终点。 |
| MoonClip自有 | stroke.mbt、engine_types.mbt、scanbeam.mbt | 完整宽度、width<1/单点空区域契约、私有阶段上下文、累计预算及Result；不移植上游单点特殊面域。 |
| 自有参考工具 | stroke_compare/generate/adapter/report | 独立v3、276输入、严格目录分派及报告；Cpp仍只用于数据生成。 |

实际移植文件保留Angus Johnson2010–2025及BSL-1.0声明，自有实现版权BigSaltyMan2026。运行几何全部MoonBit，无新增运行库依赖；原上游/归档/许可/编译选项保持固定，锁仅新增描边协议标识。小数接口和缩放尚在Commit13范围。


## Commit 13 小数参考与自有转换（2026-10-18）

固定版本、SHA及许可不变。本笔实际核对CPP/Clipper2Lib/include/clipper2/clipper.engine.h的ClipperD构造、AddSubject/AddClip/Execute，以及clipper.h的InflatePaths(PathsD)。前者使用2的幂倍率，后者使用10的幂；MoonClip统一十进制，不移植ClipperD倍率，也不直接用便捷InflatePaths改变已有规范化和小距离语义。

| 实际来源/设计 | MoonBit或参考文件 | 修改与归属 |
| --- | --- | --- |
| ClipperD二进制倍率与Execute | tools/oracle/adapter.cpp | 24条共同网格路线真正调用固定实现，先验证原始结果网格成员；仅测试工具。 |
| InflatePaths(PathsD)十进制单位概念 | decimal.mbt | 沿用坐标、距离和容差同尺度的设计；固定0—6倍率表及统一网格为MoonClip契约。未直接改写此便捷函数。 |
| MoonClip自有 | types.mbt、decimal.mbt、limits.mbt | PointD/复制、不可变Precision、尾数舍入、原单位检查、跨输入合并索引、精确退化诊断、预算适配和Result错误。 |
| MoonClip自有参考工具 | decimal_compare/generate/construct、adapter、report | v5双表示、196十进制参考、24真正ClipperD参考、完整网格与精确解码比较及独立目录。 |

本笔新增运行代码均为MoonBit自有实现，版权BigSaltyMan2026、BSL-1.0，无新增运行库依赖；已有移植的整数引擎仍保留Angus Johnson版权。C++只用于独立生成和重建参考。未提前实现简化、删点统计或其他后续引擎。


## Commit 14 实际简化移植（2026-10-19）

固定 Clipper2_2.0.1 / 21ebba05db8894f0c7217ad35ea518080f324946 / BSL-1.0 不变。实际读取并核对 clipper.h 的 SimplifyPath、SimplifyPaths、details::GetNext/GetPrior，以及 clipper.core.h 的 PerpendicDistFromLineSqrd。虽然主要引擎参考 C#，本次泛型简化直接对应固定 C++ 模板，保留不足四点分支、候选扫描、严格比较、邻距更新和原索引收集。

| 上游/来源 | MoonBit/工具文件 | 修改说明 |
| --- | --- | --- |
| CPP/Clipper2Lib/include/clipper2/clipper.h SimplifyPath/GetNext/GetPrior | simplify.mbt | 直接改写局部选择顺序；增加累计预算、有限性与 Result 错误，保留上游版权。 |
| CPP/Clipper2Lib/include/clipper2/clipper.core.h PerpendicDistFromLineSqrd | simplify.mbt | 直接改写浮点直线距离公式，重合邻点零距离，不改成整数判符号。 |
| 同一固定 SimplifyPaths 模板 | tools/oracle/adapter.cpp | 真实调用整数模板；小数先独立十进制量化。适配器自行整理和统计，不宣称上游提供 MoonClip 报告。 |
| MoonClip 自有 | simplify.mbt、decimal.mbt | 零阈值仅整理、结构退化三类索引、全部删点统计、独立访问器、原始额度、同账本包装及最终 Closed 清理。 |
| MoonClip 自有 | simplify_compare/construct/generate、test_simplify、report | 协议v6、有序逐点与精确解码比较、224条锁定输入，不复用面域有效性校验。 |

移植块保留 Angus Johnson 2010–2025 / BSL-1.0，自有辅助为 BigSaltyMan 2026 / BSL-1.0。运行库仍纯 MoonBit，没有新增依赖；C++仅用于独立测试参考。锁只增加 simplify_protocol_version=6，上游归档、依赖及编译输入保持原样。

## Commit 15 实际扫掠移植（2026-10-19）

固定标签Clipper2_2.0.1、SHA 21ebba05db8894f0c7217ad35ea518080f324946、归档校验和及BSL-1.0不变。核对固定CPP头clipper.minkowski.h的Minkowski/MinkowskiSum及clipper.engine.cpp的局部极值排序、IsValidAelOrder、DoHorizontal、DoMaxima、水平转换和相邻连接。

| 上游/来源 | MoonBit/工具文件 | 修改说明 |
| --- | --- | --- |
| clipper.minkowski.h Minkowski/MinkowskiSum | minkowski.mbt | 直接改写平移及连接面遍历；保留Angus Johnson 2010–2023，精确叉积替代浮点面积绕向。 |
| clipper.engine.cpp 扫描及连接 | scanbeam.mbt、engine.mbt、boolean.mbt、intersections.mbt、horizontals.mbt、output.mbt | 对齐保留共线点时的事件/节点顺序，保留Angus Johnson 2010–2025，预算与暂停状态自行适配。 |
| 固定MinkowskiSum | tools/oracle/adapter.cpp | 真实调用，仅独立测试工具。 |
| MoonClip自有 | minkowski.mbt、limits.mbt及v7构造/比较/报告 | 乘积预检、生成坐标诊断、累计账本、Result及完整轮廓证据。 |

自有代码版权BigSaltyMan2026、BSL-1.0。运行库纯MoonBit，无新增依赖；C++仅独立参考。锁只增加minkowski_protocol_version=7；未实现MinkowskiDiff、小数扫掠或带孔图案集合。

## Commit 18 来源核对与基准（2026-10-20）

核对现有锁文件、LICENSE、生成公开接口及实际 MoonBit 文件，固定标签、完整 SHA、BSL-1.0 和原有文件映射保持不变；修正了早期计划表中偏移 / 描边尚未实现的过时描述。未下载或重建参考程序，也未修改参考、选择文件或适配器。

新增 bench/ 和 scripts/bench.py 为 MoonClip 自行编写的确定性输入、公开调用、校验与报告逻辑，不复制上游基准。计时调用固定工具链自带 moonbitlang/core/bench 的单调时钟（Apache-2.0，作为标准库依赖，未复制源码），没有新增第三方依赖。几何运行库仍由 MoonBit 实现，本次未修改核心算法。结果与适用范围见 [benchmarks.md](benchmarks.md)。


## Commit 20 小数孔洞树适配（Unreleased）

固定 Clipper2 2.0.1、标签 Clipper2_2.0.1、SHA 21ebba05db8894f0c7217ad35ea518080f324946 及 BSL-1.0 均未变化。本笔没有新增上游算法移植，也未读取新的上游引擎作为实现来源。

| 已有来源 / 自有适配 | MoonBit 文件 | 实际改动 |
| --- | --- | --- |
| 复用既有 Clipper2 参考移植的 Boolean 引擎及已验证整数树 | boolean.mbt、polytree.mbt（均未修改） | 通过现有提取回调调用 tree_build，拓扑、绕向验证仍由整数阶段完成。 |
| MoonClip 自有十进制执行适配 | decimal.mbt | 新私有执行入口及 boolean_tree_d；共用预检、量化、错误映射与同一累计账本，不改旧小数执行器。 |
| MoonClip 自有树存储与输出转换 | polytree_d.mbt | 直接迭代复制索引、深度及解码坐标；独立访问器与 DecimalOutput 计费，不重新计算包含关系。 |

新增适配版权 BigSaltyMan 2026、BSL-1.0；运行库仍纯 MoonBit，无新增依赖。C++ 仍仅用于既有参考工具，本笔未运行参考重建。旧 1384 个独立参考案例、2276 项能力检查及选择文件保持原样，不宣称覆盖新小数树接口。新增定向测试另行记录。已发布 0.1.0 与 46 文件归档记录保持历史事实；CI 临时候选会包含新增根源码，不是重新发布 0.1.0。

## Commit 21 闭合偏移树适配（Unreleased）

复用既有固定 Clipper2 2.0.1 偏移移植和整数树构建，本笔没有新移植上游算法、下载来源或重建参考。新增 `offset_tree` / `offset_tree_d`，通过私有 `offset_compute` 共用参数检查、输入规范化、偏移生成及最终 Positive 清理，选择平铺或树提取。小距离在规范化回调内结束；规范化为空时用 `tree_empty` 计费构造，不增加扫描。旧平铺空结果不增加树费用。

新增泛型结果适配、空树构造、小数输出衔接和预算／隔离测试为 MoonClip 自有实现，版权 BigSaltyMan 2026、BSL-1.0。`decimal_offset_tree_execute` 沿用量化和 `decimal_tree_output`，层级仅由最终整数区域确定，解码失败经过所属扫描清理。没有增加依赖，填充规则、舍入、默认限制及旧公开签名不变。

27 项新库测试另计，原 1384 个参考案例、2276 项能力检查和参考文件不变；候选消费者从实际 ZIP 验证两个新入口，仍属 Unreleased，不覆盖已发布 0.1.0 或其标签。描边树未在本笔接入。

## Commit 22 开放描边树适配（Unreleased）

复用已记录的固定 Clipper2 2.0.1 开放描边移植、整数树构建及 MoonClip 小数转换，没有新移植上游算法、引入依赖或重建参考。新增 `stroke_tree` / `stroke_tree_d` 与私有 `stroke_compute`，共用开放整理、端点／连接生成和最终 Positive 清理，在扫描提取回调中构建树并解码。快捷空结果使用既有计费空树辅助，不另开扫描，不改变旧平铺费用。

泛型结果适配、小数执行衔接、预算和隔离测试为 MoonClip 自有实现，版权 BigSaltyMan 2026、BSL-1.0。完整宽度、开放端点、舍入、默认资源限制及旧公开签名不变，首尾重合不自动切换闭合偏移。29 项新库测试及候选消费者单独计数，不扩大旧 1384 案例／2276 能力检查的兼容声明。新入口保持 Unreleased，0.1.0 的包、标签及历史证据保持不变。
