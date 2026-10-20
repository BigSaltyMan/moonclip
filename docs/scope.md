# 支持范围与使用边界

本文描述已于 2026-10-20 发布的 0.1.0，[注册表与 Release 验收](release-0.1.0.md)已完成。公开契约以[生成接口](../pkg.generated.mbti)及下列专题文档为准；历史提交记录描述的是当时状态。

## 入口与返回值

所有计算入口返回 `Result[成功类型, ClipError]`。`Ok([])` 可表示真实的空区域；`Err` 不能替换为空区域。Point 构造、复制与只读访问器不属于计算错误入口。

| 能力 | 整数入口 / 成功类型 | 小数入口 / 成功类型 | 默认值及边界 |
| --- | --- | --- | --- |
| Boolean | `boolean_op` / `Paths64` | `boolean_op_d` / `PathsD` | 四种操作；EvenOdd 默认，NonZero 可选；两个操作数都是闭合填充区域 |
| 孔洞树 | `boolean_tree` / `PolyTree64` | 尚无 | 同样四种操作、两种公开填充；真实包含归属 |
| 闭合偏移 | `offset_polygons` / `Paths64` | `offset_polygons_d` / `PathsD` | NonZero 默认；delta 为单侧有符号距离；共同 Union 后偏移及清理 |
| 开放描边 | `stroke_polyline` / `Paths64` | `stroke_polyline_d` / `PathsD` | width 是完整宽度，两侧各半；Butt 默认，另有 Square / Round 端点 |
| 显式简化 | `simplify_paths` / `SimplifyResult` | `simplify_paths_d` / `SimplifyResultD` | 默认 Closed、epsilon=0；报告保留退化路径，不自行过滤 |
| 单图案扫掠 | `minkowski_sum` / `Paths64` | 尚无 | 必须指定路线开闭；图案总是闭合；结果保留共线点 |

OffsetOptions 默认 Miter、MiterLimit=2、ArcTolerance=0。连接可选 Miter / Bevel / Square / Round；Miter 超限回退 Square。MiterLimit 必须有限且至少 2，ArcTolerance 必须有限且非负；0 为自动圆弧精度。正负 delta 分别扩张 / 收缩区域；收缩可能消灭区域。负 width、非有限参数返回错误；整数 0≤width<1、空路线、单点路线为成功空区域，仍先验证全部输入与参数。详见 [数值路线](numerics.md)与[组合流程](composition.md)。

## 坐标、精度与错误

Point64 完整保存 Int64，但计算接受每轴 ±10^9，含边界；不对任意 Int64 先取绝对值，不截断或钳制超限输入。精确叉积与方向、BigInt 面积不代表所有几何步骤都是精确有理数：扫描投影、交点网格转换和偏移生成各有固定数值路线。

PointD 保存 Double，Precision 支持 0—6、默认 3，以 10^digits 为倍率；原单位坐标范围为 ±10^9 / 10^digits。输入先检查原单位范围，量化采用半整数远离零，输出解码回 Double。不同原始位置合并到同一网格点会报错，非空闭合退化输入会报错（简化入口另有报告契约）。半格的局部舍入界不等于整个运算的误差或拓扑保证。距离、完整宽度、正容差随倍率缩放，MiterLimit 不缩放。详细表格、严格合并诊断及与 ClipperD 的差异仅维护于 [decimal.md](decimal.md)。

错误包括 InvalidInput、CoordinateOutOfRange、DecimalCoordinateOutOfRange、QuantizationFailure、NumericFailure、ResourceLimitExceeded、ExecutionFailure。携带英文说明、真实阶段及可用的原始路径 / 顶点索引；坐标错误有轴和值，资源错误有类别和限制。无法唯一映射到原始位置时索引为 None，不伪造定位。失败不修改输入，不返回部分结果，下一次独立调用重新建账。

## 填充、方向与所有权

数学坐标系 x 向右、y 向上，正面积为逆时针。EvenOdd 与 NonZero 公开支持；Positive / Negative 只有私有引擎和白盒证据。EvenOdd 与方向无关；NonZero 累计有向绕数，孔洞通常以相反方向输入。只反转部分路径可能改变区域。

Boolean / Offset / Stroke 的平铺输出采用外轮廓正向、孔洞负向，不保证轮廓顺序或环起点。平铺数组本身不记录父子关系，勿将排序当作孔洞归属。需要归属时调用整数 boolean_tree：根外轮廓深度 1，孔洞 2，孔中岛 3，之后交替。小数、偏移和描边没有直接树入口；整数结果可再调用 boolean_tree，这会形成新的公开调用和预算。

树内部独立拥有数据，根 / 孩子 / contour / to_paths 访问器返回副本；按需复制属于访问器成本。路径数组赋值则可能共享存储；需要独立容器时显式 copy_path(s)，小数用对应 `_d`。结构 Eq 逐点比较，不是忽略绕向、起点或共线点的几何等价判定。

容器保留空、短路径及重复点。整数 Boolean 中的空、单点、两点及全共线轮廓不产生面域，面积为零的自交轮廓仍可能产生区域。normalize 只按 Open / Closed 去连续重复点及闭合重复首点，不简化、不修复拓扑。point_in_polygon 只有单轮廓 EvenOdd 语义，不解释整个孔洞集合。

## 简化与图案扫掠

简化必须显式调用，Boolean / Offset / Stroke 不自动简化。epsilon=0 仅进行约定的无损重复点整理；正阈值使用局部直线距离选择。Open 保留两个端点，Closed 处理接缝。结果报告删点总数、每路径删点和原有退化 / 最终退化 / 新塌缩索引。调用方检查报告后决定下一步，不沿用旧孔洞树。简化不保证拓扑保持，epsilon 不是全局 Hausdorff 距离或面积变化上限，详见 [simplify.md](simplify.md)。

Minkowski 图案坐标直接与路线坐标相加，原点就是锚点，不自动居中。图案末首始终相连；路线仅由 path_is_closed 控制闭合，重复首点不能代替参数。保留原始重复点；连接面作 NonZero Union，结果保留共线点。它不额外插入完整端点图案，因此短路线可能留缝，闭合边界扫掠可留下孔洞。只有单个整数图案与单条路线，不等同于任意带孔面域的集合 Minkowski 运算，详见 [minkowski.md](minkowski.md)。

## 预算与复杂输入

公开 Limits 默认 10,000 条原始路径、100,000 个原始顶点；空路径占路径额度，重复点在整理前计数，两个操作数共享总量。零额度合法，负额度无效。调整输入额度不会提高内部固定的 500,000 累计逻辑节点、5,000,000 工作步骤上限。

同一次调用的规范化、量化、生成、扫描、交点、连接、树构建或清理与输出共用账本；临时存储释放不退款。输入合法也可能因交点密度、轮廓归属比较、圆弧采样或图案×路线连接面增长而资源拒绝。预算是保护机制，不是内存字节数、最大时延或任意同规模输入可完成的承诺。[composition.md](composition.md)记录计费细则，[benchmarks.md](benchmarks.md)记录少量实际规模与耗时，不能从案例趋势推导普遍复杂度。

## 当前范围以外

没有公开 Positive / Negative、开放路径参与 Boolean、十进制 PolyTree、直接 OffsetTree / StrokeTree、小数 Minkowski、MinkowskiDiff、带孔图案集合、三角剖分、SVG 输入解析、GIS 投影、三维几何、可变宽度回调或一般拓扑修复。演示 SVG 是结果导出，不意味着库能解析任意 SVG。

当前 native 与 JS 正确性证据为同一批 2234 项测试，1384 条参考在[兼容报告](compatibility.md)中按能力分开记录；它们不是对任意输入兼容全部 Clipper2 的证明。性能仅有指定 Windows native 环境的代表性基线，JS 性能未测量。
