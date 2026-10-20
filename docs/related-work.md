# 固定上游、参考证据与 MoonClip 契约

## 固定来源

MoonClip 参考 [Clipper2 2.0.1](https://github.com/AngusJohnson/Clipper2/tree/21ebba05db8894f0c7217ad35ea518080f324946)，标签 Clipper2_2.0.1，完整 SHA `21ebba05db8894f0c7217ad35ea518080f324946`，BSL-1.0。本次核对了[锁文件](../tools/oracle/upstream-lock.json)、[许可证](../LICENSE)、实际改写文件及[逐文件来源表](upstream.md)，未更换版本、归档或适配器。

C# 源码是主要引擎阅读与移植参考，偏移、简化、扫掠等实际来源以逐文件表为准。固定 C++ 引擎独立编译成测试参考程序，生成完整轮廓 / 树及其他预期；运行库由 MoonBit 实现。适配器的 nlohmann/json 3.12.0（MIT）仅用于工具解析，既不是 MoonClip 运行依赖，也不参与几何求值。许可记录见 [THIRD_PARTY_NOTICES.md](../tools/oracle/THIRD_PARTY_NOTICES.md)。

## 相同设计与公开差异

| 项目 | MoonClip 当前行为 | 证据或差异 |
| --- | --- | --- |
| 闭合区域 Boolean | 四种操作、公开 EvenOdd / NonZero，整数平铺及树 | 固定 C++ 轮廓和树分别实际执行；Positive / Negative 仅内部对照，不算公开支持 |
| 偏移及开放描边 | 四种连接、三种端点、ArcTolerance；公开完整 width | 偏移参考先共同规范化区域；描边按开放路线生成；单点及整数 0≤width<1 的空结果属于 MoonClip 契约，未据此承诺所有上游特殊分支兼容 |
| 小数入口 | 固定 10^precision 网格，0—6 | ClipperD 使用二进制倍率；DecimalGrid 与 ClipperDCommonGrid 是不同参考路线，不能互相替代 |
| 简化 | 显式入口、完整报告，epsilon=0 只去约定重复点 | 正 epsilon 的有序轮廓与独立统计有严格参考；零阈值及三类退化报告属于 MoonClip 契约 |
| Minkowski Sum | 单个整数图案、单路线、显式开闭、保留共线点 | 真实调用固定 C++ MinkowskiSum 对照；没有小数 / Diff / 带孔图案集合入口 |
| 精确基础及边界 | ±10^9、统一精确行列式、BigInt 面积、Result 和累计预算 | MoonClip 自行实现或加强的契约；不是照搬上游全部类型和值域 |
| 容器及层级所有权 | 不可变点、数组显式复制、树访问器副本 | MoonBit 所有权与隔离设计，自有行为测试验证 |

扫描投影 ties-to-even、普通交点截断、生成坐标半整数远离零均有各自固定路线；“精确方向和面积”不能扩大为所有几何输出无限精度。详细规则只维护于 [numerics.md](numerics.md)与 [decimal.md](decimal.md)。尚未提供的接口见 [scope.md](scope.md)。

## 严格比较能说明什么

[兼容报告](compatibility.md)从八类清单提取覆盖：Boolean 200、Offset 272、Stroke 276、Composition 24、Decimal 220、Simplify 224、Minkowski 144、Random 24，合计 **1384 个独立输入案例**。

这些案例对应 **2276 项被选择的能力检查**。例如一个 Boolean 输入分别求平铺与树，组合流程还检查中间结果和最终结果；同一输入仍只有一个案例。字段出现次数描述覆盖，不代表每种参数的笛卡尔积都被执行。native 与 JS 对同一批输入分别执行，也不能将两目标相加为独立案例数。

比较器只在相应面域输出契约允许时规范环起点与同级顺序，保留完整坐标、绕向、顶点数、重数及父子关系；简化采用更严格的有序路径和报告比较。Decimal 路线还验证解码后的每个 Double 值，不把近似数重新量化后视为通过。Minkowski 保留共线点，不能沿用普通 Boolean 的删共线规则掩盖差异。

固定种子 v1 的 24 条随机案例只检验公开 Boolean 平铺，不增加随机树、偏移、描边或小数证据。工具测试故障用于验证缩减流程，与真实库缺陷分开；方法见 [random-regression.md](random-regression.md)。

普通 CI 离线读取锁定预期并执行 MoonClip，参考程序的实际重建和运行由独立工作流证明。本次没有重建旧 1384 条参考；沿用既有参考来源证据。严格参考通过只适用于这些锁定输入与参数，不证明全部上游功能或所有合法输入兼容。

## 性能结论的边界

[性能基线](benchmarks.md)只测 MoonClip native 的完整公开调用，没有配对测量 C++ 或其他库，也未测 JS 性能。因此不作“接近 Clipper2”、跨库快慢或“纯量化开销”的结论。本次不扩展同类项目调研。
