# 支持范围与使用边界

Unreleased：`rect_clip_lines_d` 提供小数开放路线的矩形窗口裁剪，默认 Precision=3（0—6），输出为有序、保方向的开放片段，普通共线中间点保留，无填充规则或树结构。窗口独立量化、全部路线共同量化并共享预算，网页窗口裁剪仍仅整数；详见[矩形裁剪](rectclip.md)。

Unreleased：`rect_clip_polygons_d` 配合不可变 `BoundsD` 提供小数闭合区域窗口裁剪，Precision 默认 3（0—6），支持 EvenOdd／NonZero，仅返回平铺区域。窗口独立量化但使用同一网格，不占原始路径额度；原始空窗口与量化塌缩区别处理。不提供树包装；小数开放折线另用 `rect_clip_lines_d`。

Unreleased：`rect_clip_polygons` 将整数闭合区域与矩形窗口一次求交，支持 EvenOdd／NonZero，返回可含孔洞的平铺区域。复用 Boolean 数值与预算契约，没有矩形专用优化或树包装；详见[矩形裁剪](rectclip.md)。

Unreleased：整数 `PolyTree64::locate` 返回最深严格包含的填充／孔洞节点，或优先返回全部边界命中。最坏线性访问全部轮廓顶点，Limits 限制被查询树的轮廓和总顶点，合法树也可能被较小查询额度拒绝。空树仍验证参数；不提供小数树或批量点查询。详见[树点定位](polytree-query.md)。

Unreleased：`minkowski_sum_d` 提供小数单图案、单路线的平铺扫掠区域，默认 Precision=3（0—6）。继承整数入口锚点、路线开闭和共线点语义；不提供 MinkowskiDiff、多图案或路线、树、自动简化及演示。图案和路线同网格量化后再作整数求和，生成范围及共享预算见[扫掠契约](minkowski.md)。

Unreleased：`stroke_polylines` 提供整数多路线批量描边，只返回合并后的平铺闭合区域。width 为完整宽度，整批使用相同端点、连接及圆弧参数；不同路线不相互连接。空路线、单点和连续重复点整理后的短路线不生成区域，但全部原始路径与顶点仍计入额度。width < 1 也先检查全部输入。输出独立于输入，可含孔洞；小数批量入口 `stroke_polylines_d` 同样返回平铺区域，默认 Precision=3（0—6），整批共用量化及执行预算，小宽度按缩放后的完整宽度判断。量化可能改变可表达形状；暂不提供批量树或逐路线样式入口，尚未发布。

Unreleased 开发源码另有整数 `rect_clip_lines`，用于矩形窗口内的开放折线片段。它不是填充区域 Boolean；顺序、贴边、截断和预算契约见[矩形折线裁剪](rectclip.md)，0.2.1 不包含此入口。

当前补丁版为 **0.2.1**，仅修正文档，运行库和公开接口与 0.2.0 相同；注册表消费者和实际页面核验见[0.2.1 发布记录](release-0.2.1.md)。下文的 0.2.0 标记表示接口首次提供的版本。

0.1.0 已于 2026-10-20 发布，[注册表与 Release 验收](release-0.1.0.md)已完成。0.2.0 已于 2026-10-21 正式发布，新增小数 Boolean 树及整数／小数偏移树、描边树，见[0.2.0 发布记录](release-0.2.0.md)；这些增量均未随 0.1.0 发布。当前源码公开契约以[生成接口](../pkg.generated.mbti)及下列专题文档为准；历史发布与提交记录描述的是当时状态。

## 入口与返回值

相对首版新增的是小数 Boolean 树与整数／小数偏移树、描边树，共 5 个库入口；整数 `boolean_tree` 已在 0.1.0 中提供。选择平铺、树或 `to_paths()` 的迁移方法见[升级说明](upgrade-trees.md)，各提交的测试与消费者口径见[增量验收](acceptance-trees.md)。开发演示另提供六入口层级查看、边界高亮与 v2 JSON，属于 0.2.0。

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
| 单图案扫掠 | `minkowski_sum` / `Paths64` | 尚无 | 必须指定路线开闭；图案总是闭合；结果保留共线点 |

OffsetOptions 默认 Miter、MiterLimit=2、ArcTolerance=0。连接可选 Miter / Bevel / Square / Round；Miter 超限回退 Square。MiterLimit 必须有限且至少 2，ArcTolerance 必须有限且非负；0 为自动圆弧精度。正负 delta 分别扩张 / 收缩区域；收缩可能消灭区域。负 width、非有限参数返回错误；整数 0≤width<1、空路线、单点路线为成功空区域，仍先验证全部输入与参数。详见 [数值路线](numerics.md)与[组合流程](composition.md)。

## 坐标、精度与错误

Point64 完整保存 Int64，但计算接受每轴 ±10^9，含边界；不对任意 Int64 先取绝对值，不截断或钳制超限输入。精确叉积与方向、BigInt 面积不代表所有几何步骤都是精确有理数：扫描投影、交点网格转换和偏移生成各有固定数值路线。

PointD 保存 Double，Precision 支持 0—6、默认 3，以 10^digits 为倍率；原单位坐标范围为 ±10^9 / 10^digits。输入先检查原单位范围，量化采用半整数远离零，输出解码回 Double。不同原始位置合并到同一网格点会报错，非空闭合退化输入会报错（简化入口另有报告契约）。半格的局部舍入界不等于整个运算的误差或拓扑保证。距离、完整宽度、正容差随倍率缩放，MiterLimit 不缩放。详细表格、严格合并诊断及与 ClipperD 的差异仅维护于 [decimal.md](decimal.md)。

错误包括 InvalidInput、CoordinateOutOfRange、DecimalCoordinateOutOfRange、QuantizationFailure、NumericFailure、ResourceLimitExceeded、ExecutionFailure。携带英文说明、真实阶段及可用的原始路径 / 顶点索引；坐标错误有轴和值，资源错误有类别和限制。无法唯一映射到原始位置时索引为 None，不伪造定位。失败不修改输入，不返回部分结果，下一次独立调用重新建账。

## 填充、方向与所有权

数学坐标系 x 向右、y 向上，正面积为逆时针。EvenOdd 与 NonZero 公开支持；Positive / Negative 只有私有引擎和白盒证据。EvenOdd 与方向无关；NonZero 累计有向绕数，孔洞通常以相反方向输入。只反转部分路径可能改变区域。

Boolean / Offset / Stroke 的平铺输出采用外轮廓正向、孔洞负向，不保证轮廓顺序或环起点。平铺数组本身不记录父子关系，勿将排序当作孔洞归属。树的根外轮廓深度 1，孔洞 2，孔中岛 3，之后交替。0.2.0 的 boolean_tree_d 保留量化区域的整数归属，再解码为 Double；Precision 会影响区域。offset_tree / offset_tree_d 返回最终偏移区域的树，stroke_tree / stroke_tree_d 返回开放路线加宽并清理后的区域层级；路线本身没有可直接沿用的孔洞关系，首尾重合不自动改变开放端点语义。这些新入口内部共享预算，小数转换不重新判断包含。0.1.0 没有小数树或直接偏移／描边树。将平铺结果传入另一个公开调用会重新建账。两种树的 to_paths() 都丢失显式父子信息。

树内部独立拥有数据，根 / 孩子 / contour / to_paths 访问器返回副本；按需复制属于访问器成本。路径数组赋值则可能共享存储；需要独立容器时显式 copy_path(s)，小数用对应 `_d`。结构 Eq 逐点比较，不是忽略绕向、起点或共线点的几何等价判定。

容器保留空、短路径及重复点。整数 Boolean 中的空、单点、两点及全共线轮廓不产生面域，面积为零的自交轮廓仍可能产生区域。normalize 只按 Open / Closed 去连续重复点及闭合重复首点，不简化、不修复拓扑。point_in_polygon 只有单轮廓 EvenOdd 语义，不解释整个孔洞集合。

## 简化与图案扫掠

简化必须显式调用，Boolean / Offset / Stroke 不自动简化。epsilon=0 仅进行约定的无损重复点整理；正阈值使用局部直线距离选择。Open 保留两个端点，Closed 处理接缝。结果报告删点总数、每路径删点和原有退化 / 最终退化 / 新塌缩索引。调用方检查报告后决定下一步，不沿用旧孔洞树。简化不保证拓扑保持，epsilon 不是全局 Hausdorff 距离或面积变化上限，详见 [simplify.md](simplify.md)。

Minkowski 图案坐标直接与路线坐标相加，原点就是锚点，不自动居中。图案末首始终相连；路线仅由 path_is_closed 控制闭合，重复首点不能代替参数。保留原始重复点；连接面作 NonZero Union，结果保留共线点。它不额外插入完整端点图案，因此短路线可能留缝，闭合边界扫掠可留下孔洞。只有单个整数图案与单条路线，不等同于任意带孔面域的集合 Minkowski 运算，详见 [minkowski.md](minkowski.md)。

## 预算与复杂输入

树构建和解码也消耗本次账本，同一输入的平铺调用成功不保证树调用有足够额度。独立公开调用分别建账，不能把两次调用当作一次共享预算。

公开 Limits 默认 10,000 条原始路径、100,000 个原始顶点；空路径占路径额度，重复点在整理前计数，两个操作数共享总量。零额度合法，负额度无效。调整输入额度不会提高内部固定的 500,000 累计逻辑节点、5,000,000 工作步骤上限。

同一次调用的规范化、量化、生成、扫描、交点、连接、树构建或清理与输出共用账本；临时存储释放不退款。输入合法也可能因交点密度、轮廓归属比较、圆弧采样或图案×路线连接面增长而资源拒绝。预算是保护机制，不是内存字节数、最大时延或任意同规模输入可完成的承诺。[composition.md](composition.md)记录计费细则，[benchmarks.md](benchmarks.md)记录少量实际规模与耗时，不能从案例趋势推导普遍复杂度。

## 当前范围以外

没有公开 Positive / Negative、开放路径参与 Boolean、多路线或闭合模式描边、小数 Minkowski、MinkowskiDiff、带孔图案集合、三角剖分、SVG 输入解析、GIS 投影、三维几何、可变宽度回调或一般拓扑修复。演示 SVG 是结果导出，不意味着库能解析任意 SVG。

0.1.0 的 native 与 JS 正确性证据为同一批 2234 项测试。0.2.0 新增 33 项小数 Boolean 树、27 项偏移树和 29 项描边树定向测试，矩形裁剪另新增 47 项后，源码完整回归为 2370 项，两目标分别记录。旧 1384 条参考在[兼容报告](compatibility.md)中按 2276 项能力检查分开记录；新增矩形裁剪 32 个案例后合计 1416 个案例、2308 项能力检查；旧参考没有扩展到新树入口，也不是对任意输入兼容全部 Clipper2 的证明。性能仍为原测量提交的指定 Windows native 基线，本笔未重测，JS 性能未测量。
