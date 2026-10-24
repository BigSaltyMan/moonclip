# 支持范围与使用边界

当前已发布版为 **0.3.0**，本文所列增量均已随该版本交付，独立 registry 消费者 native／JS 验证通过，见[0.3.0 发布记录](release-0.3.0.md)。发布源码和标签固定在 `d21baf6687b5d890392f87574aac48f22cd3d5f0`；当前页面为单独的发布状态更新，注册表包内文字保留冻结候选快照。旧版本事实见 [0.1.0](release-0.1.0.md)、[0.2.0](release-0.2.0.md)及 [0.2.1](release-0.2.1.md)。

| 0.3.0 能力 | 整数／小数 | 输出与查询范围 |
| --- | --- | --- |
| 开放折线窗口裁剪 | 均支持 | 有序开放片段，无填充或树查询 |
| 闭合区域窗口裁剪 | 均支持 | 平铺／孔洞树 |
| 多路线批量描边 | 均支持 | 共享样式，统一覆盖区域的平铺／树 |
| Minkowski Sum | 均支持 | 单图案、单路线，平铺／树；整数平铺为既有发布能力 |
| 树单点／批量定位 | 均支持 | 最深填充／孔洞节点，或全部边界命中 |

上述树能力均已接入开发网页。Boolean、Offset、单路线 Stroke、批量 Stroke、闭合窗口、Minkowski 六类区域树可在整数／小数模式查询；平铺与开放片段不能查询。小数查询使用原建树 Precision，批量核心不限 32 点，演示最多 32 点。查询线性访问顶点，没有空间索引。详细迁移边界见[增量升级说明](upgrade-incremental.md)，接口以[生成接口](../pkg.generated.mbti)为准。

## 入口与返回值

0.2.0 相对首版新增的是小数 Boolean 树与整数／小数偏移树、描边树，共 5 个库入口；整数 `boolean_tree` 已在 0.1.0 中提供。选择平铺、树或 `to_paths()` 的迁移方法见[升级说明](upgrade-trees.md)，各提交的测试与消费者口径见[增量验收](acceptance-trees.md)。开发演示另提供六入口层级查看、边界高亮与 v2 JSON，属于 0.2.0。

所有计算入口返回 `Result[成功类型, ClipError]`。`Ok([])` 可表示真实的空区域；`Err` 不能替换为空区域。Point 构造、复制与只读访问器不属于计算错误入口。

| 能力 | 整数入口 / 成功类型 | 小数入口 / 成功类型 | 默认值及边界 |
| --- | --- | --- | --- |
| Boolean | `boolean_op` / `Paths64` | `boolean_op_d` / `PathsD` | 四种操作；EvenOdd 默认，NonZero 可选；两个操作数都是闭合填充区域 |
| 孔洞树 | `boolean_tree` / `PolyTree64` | **0.2.0**：`boolean_tree_d` / `PolyTreeD` | 同样四种操作、两种公开填充；小数树保留量化区域的真实归属 |
| 闭合偏移 | `offset_polygons` / `Paths64` | `offset_polygons_d` / `PathsD` | NonZero 默认；delta 为单侧有符号距离；共同 Union 后偏移及清理 |
| 偏移孔洞树 | **0.2.0**：`offset_tree` / `PolyTree64` | **0.2.0**：`offset_tree_d` / `PolyTreeD` | 与平铺偏移相同的参数、四种连接；最终区域的层级，所有内部阶段共用预算 |
| 开放描边 | `stroke_polyline` / `Paths64` | `stroke_polyline_d` / `PathsD` | width 是完整宽度，两侧各半；Butt 默认，另有 Square / Round 端点 |
| 描边孔洞树 | **0.2.0**：`stroke_tree` / `PolyTree64` | **0.2.0**：`stroke_tree_d` / `PolyTreeD` | 同样的完整宽度、三种端点和四种连接；单条开放路线，无填充规则参数，返回最终区域层级 |
| 显式简化 | `simplify_paths` / `SimplifyResult` | `simplify_paths_d` / `SimplifyResultD` | 默认 Closed、epsilon=0；报告保留退化路径，不自行过滤 |
| 单图案扫掠 | `minkowski_sum` / `Paths64` | **0.3.0**：`minkowski_sum_d` / `PathsD` | 必须指定路线开闭；图案总是闭合；平铺与树均保留共线点，树另用 `minkowski_sum_tree`／`minkowski_sum_tree_d` |

OffsetOptions 默认 Miter、MiterLimit=2、ArcTolerance=0。连接可选 Miter / Bevel / Square / Round；Miter 超限回退 Square。MiterLimit 必须有限且至少 2，ArcTolerance 必须有限且非负；0 为自动圆弧精度。正负 delta 分别扩张 / 收缩区域；收缩可能消灭区域。负 width、非有限参数返回错误；整数 0≤width<1、空路线、单点路线为成功空区域，仍先验证全部输入与参数。详见 [数值路线](numerics.md)与[组合流程](composition.md)。

## 坐标、精度与错误

Point64 完整保存 Int64，但计算接受每轴 ±10^9，含边界；不对任意 Int64 先取绝对值，不截断或钳制超限输入。精确叉积与方向、BigInt 面积不代表所有几何步骤都是精确有理数：扫描投影、交点网格转换和偏移生成各有固定数值路线。

PointD 保存 Double，Precision 支持 0—6、默认 3，以 10^digits 为倍率；原单位坐标范围为 ±10^9 / 10^digits。输入先检查原单位范围，量化采用半整数远离零，输出解码回 Double。几何输入的不同原始位置合并到同一网格点会报错；查询点量化重合允许发生。非空闭合退化输入会报错（简化入口另有报告契约）。半格的局部舍入界不等于整个运算的误差或拓扑保证。距离、完整宽度、正容差随倍率缩放，MiterLimit 不缩放。详细表格、严格合并诊断及与 ClipperD 的差异仅维护于 [decimal.md](decimal.md)。

错误包括 InvalidInput、CoordinateOutOfRange、DecimalCoordinateOutOfRange、QuantizationFailure、NumericFailure、ResourceLimitExceeded、ExecutionFailure。携带英文说明、真实阶段及可用的原始路径 / 顶点索引；坐标错误有轴和值，资源错误有类别和限制。无法唯一映射到原始位置时索引为 None，不伪造定位。失败不修改输入，不返回部分结果，下一次独立调用重新建账。

## 填充、方向与所有权

数学坐标系 x 向右、y 向上，正面积为逆时针。EvenOdd 与 NonZero 公开支持；Positive / Negative 只有私有引擎和白盒证据。EvenOdd 与方向无关；NonZero 累计有向绕数，孔洞通常以相反方向输入。只反转部分路径可能改变区域。

Boolean / Offset / Stroke 的平铺输出采用外轮廓正向、孔洞负向，不保证轮廓顺序或环起点。平铺数组本身不记录父子关系，勿将排序当作孔洞归属。树的根外轮廓深度 1，孔洞 2，孔中岛 3，之后交替。0.2.0 的 boolean_tree_d 保留量化区域的整数归属，再解码为 Double；Precision 会影响区域。offset_tree / offset_tree_d 返回最终偏移区域的树，stroke_tree / stroke_tree_d 返回开放路线加宽并清理后的区域层级；路线本身没有可直接沿用的孔洞关系，首尾重合不自动改变开放端点语义。这些新入口内部共享预算，小数转换不重新判断包含。0.1.0 没有小数树或直接偏移／描边树。将平铺结果传入另一个公开调用会重新建账。两种树的 to_paths() 都丢失显式父子信息。

树内部独立拥有数据，根 / 孩子 / contour / to_paths 访问器返回副本；按需复制属于访问器成本。路径数组赋值则可能共享存储；需要独立容器时显式 copy_path(s)，小数用对应 `_d`。结构 Eq 逐点比较，不是忽略绕向、起点或共线点的几何等价判定。

容器保留空、短路径及重复点。整数 Boolean 中的空、单点、两点及全共线轮廓不产生面域，面积为零的自交轮廓仍可能产生区域。normalize 只按 Open / Closed 去连续重复点及闭合重复首点，不简化、不修复拓扑。point_in_polygon 只有单轮廓 EvenOdd 语义，不解释整个孔洞集合。

## 简化与图案扫掠

简化必须显式调用，Boolean / Offset / Stroke 不自动简化。epsilon=0 仅进行约定的无损重复点整理；正阈值使用局部直线距离选择。Open 保留两个端点，Closed 处理接缝。结果报告删点总数、每路径删点和原有退化 / 最终退化 / 新塌缩索引。调用方检查报告后决定下一步，不沿用旧孔洞树。简化不保证拓扑保持，epsilon 不是全局 Hausdorff 距离或面积变化上限，详见 [simplify.md](simplify.md)。

Minkowski 图案坐标直接与路线坐标相加，原点就是锚点，不自动居中。图案末首始终相连；路线仅由 path_is_closed 控制闭合，重复首点不能代替参数。保留原始重复点；连接面作 NonZero Union，结果保留共线点。它不额外插入完整端点图案，因此短路线可能留缝，闭合边界扫掠可留下孔洞。整数／小数均只处理单个图案与单条路线，不等同于任意带孔面域的集合 Minkowski 运算，详见 [minkowski.md](minkowski.md)。

## 预算与复杂输入

树构建和解码也消耗本次账本，同一输入的平铺调用成功不保证树调用有足够额度。独立公开调用分别建账，不能把两次调用当作一次共享预算。

公开 Limits 默认 10,000 条原始路径、100,000 个原始顶点；空路径占路径额度，重复点在整理前计数，两个操作数共享总量。零额度合法，负额度无效。调整输入额度不会提高内部固定的 500,000 累计逻辑节点、5,000,000 工作步骤上限。

同一次调用的规范化、量化、生成、扫描、交点、连接、树构建或清理与输出共用账本；临时存储释放不退款。输入合法也可能因交点密度、轮廓归属比较、圆弧采样或图案×路线连接面增长而资源拒绝。预算是保护机制，不是内存字节数、最大时延或任意同规模输入可完成的承诺。[composition.md](composition.md)记录计费细则，[benchmarks.md](benchmarks.md)记录少量实际规模与耗时，不能从案例趋势推导普遍复杂度。

## 当前范围以外

没有公开 Positive / Negative、开放路径参与 Boolean、闭合模式描边、每路线独立样式、MinkowskiDiff、带孔图案集合、三角剖分、SVG 输入解析、GIS 投影、三维几何、可变宽度回调或一般拓扑修复。演示 SVG 是结果导出，不意味着库能解析任意 SVG。

## 验证证据与执行范围

Commit 26 的历史完整回归为 native **2370/2370**、JS **2370/2370**。当前完整入口配置期望为 **2406**，未据此宣称当前功能基线已执行全量。后续核心按 native／JS 分别记录定向结果；演示三项检查反复扩展复用，不能累加成新增独立库测试。

参考目录为 **1416 个案例、2308 项能力检查**，其中原 1384 个案例对应 2276 项检查，整数开放矩形裁剪增加 32 个案例。它们不逐项覆盖所有增量入口，也不是任意输入兼容全部 Clipper2 的证明。性能、候选及注册表消费者保留原提交归属。

普通 CI 由 CHECK_SCOPE 选择，本笔使用 docs，仅检查指定文档本地链接与差异空白；功能轻量和 full 入口仍保留，不能把一次普通 CI 成功解释为完整验收。各提交、同 SHA CI、浏览器记录与未核实项见[增量验收索引](acceptance-incremental.md)，旧发布树证据见[历史验收](acceptance-trees.md)。
