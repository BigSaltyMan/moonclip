# 小数坐标与统一十进制网格

## Unreleased：小数描边树

`stroke_tree_d(path, width, precision=, cap=, options=, limits=)` 返回 `Result[PolyTreeD, ClipError]`，默认 Precision=3、Butt，支持三种端点和四种连接，没有填充规则参数。此接口尚未包含在 0.1.0。width 是原单位完整宽度，width 和 ArcTolerance 按十进制倍率缩放，MiterLimit 保持无量纲。

独立适配使用开放量化规则，不要求三点非共线；先检查原单位参数，再量化并调用共享描边执行器。零宽度也不能绕过量化合并、坐标和原始数量检查。小宽度判断针对缩放后的完整 width：Precision=3 时原单位 .001 对应网格宽度 1，并不提前返回空树。实际边界仍受生成坐标舍入影响。

新建账本使用 StrokeGenerate / StrokeCleanup，传入账本的限制及历史用量保持权威。预检、量化、开放整理、生成、清理、整数树和下文的小数转换共用预算，释放不退款。正常转换放在清理扫描的提取回调内，失败也执行清理；快捷空结果不启动扫描，先计费构造整数空树，再计费解码空树。树构建标记 PolyTree、解码标记 DecimalOutput，其他错误保留实际阶段，输出位置不冒充输入索引。坐标转换只复制整数拓扑，首尾重合仍按开放路线处理。

## Unreleased：小数孔洞树

开发源码另提供 `offset_tree_d(paths, delta, precision=, fill_rule=, options=, limits=)`，返回 `Result[PolyTreeD, ClipError]`。默认 Precision=3、NonZero，沿用平铺偏移的参数验证和缩放规则；delta 与 ArcTolerance 随十进制倍率缩放，MiterLimit 不缩放。小距离判断针对缩放后的 delta，例如 Precision=3 时原单位 .001 对应整数距离 1，不能按原单位与 .5 比较。

偏移树在共同规范化、生成与最终 Positive Union 后构建整数树，再通过下述同一转换函数解码。小距离在规范化扫描回调内构建并解码，规范化为空时用已计费的空树辅助，不追加扫描。正常及小距离回调失败均沿用所属扫描的清理路径，错误保留原有阶段。整个流程共用累计预算，不退款。小数树保存最终量化区域的层级，Precision、偏移造成的合并或孔洞消失都可能改变结果，不能沿用输入层级。该入口尚未包含在 0.1.0。

`boolean_tree_d(subject, clip, operation, precision=, fill_rule=, limits=)` 返回 `Result[PolyTreeD, ClipError]`。参数与默认值同 `boolean_op_d`：Precision 默认 3、范围 0—6，EvenOdd 默认，NonZero 可选，四种 Boolean 操作均可用。**此入口仅开发源码可用，已发布 0.1.0 不包含它**。下文原有参考数量与 Commit 13 记录仍是历史证据。

一次调用依次执行原始预检、闭合规则量化、私有 Boolean 求值、整数树构建及验证、小数树转换、扫描清理。转换在提取回调内完成，失败也经过同一清理路径，并沿用既有小数错误映射。旧 `decimal_execute`、整数树与平铺小数入口不变。

转换直接迭代整数节点数组，复制父、孩子、根索引和深度，仅用既有 `decimal_value` 解码坐标；没有递归，也不重新判断浮点包含、面积或方向。层级来自量化后的整数区域，Precision 变化可能影响可表达关系；输出仍是 Double，零解码为正零。

| 访问器 | 契约 |
| --- | --- |
| `PolyTreeD::roots()` | 新根视图数组，根深度 1，无虚构轮廓 |
| `PolyTreeD::to_paths()` | 复制外层及每条路径，丢失显式父子关系，顺序未指定 |
| `PolyNodeD::contour()` | 独立点数组，不反转、不整理 |
| `PolyNodeD::children()` | 新孩子视图数组，视图共享只读内部数据 |
| `PolyNodeD::depth()` / `is_hole()` | 外轮廓 1、孔洞 2、岛 3，偶数层为孔洞 |

没有公共构造器、可变节点或父节点访问器。不可变 PointD 可以在访问器副本间复用；修改输入、访问器数组或另一次调用结果不会影响树。空区域返回成功空树。

所有阶段共用累计账本，整数树仍标记 `PolyTree`，新增存储、解码与最终构建使用 `DecimalOutput`，位置索引均为 None。整数中间结果释放不退款。

| 新增转换分配或工作 | 节点额度 | 工作额度 |
| --- | ---: | ---: |
| 节点与根容器 | 2 | 0 |
| 每节点：记录、外层槽、轮廓与孩子容器 | 4 | 1（访问节点） |
| 每输出点：PointD 与数组槽 | 2 | 1（两轴解码） |
| 每根或孩子索引槽 | 1 | 1（复制索引） |
| 数据与树对象 | 2 | 1（最终构建） |

分配前收费。N 节点、V 点时，根槽与孩子槽合计 N，新增节点费为 `4 + 5*N + 2*V`，工作费为 `1 + 2*N + V`；空树仍需 4 节点、1 工作。这是逻辑单位，不是物理字节或数组容量。执行结束后访问器的按需复制成本沿用整数树约定。额度不足返回完整 Err，不发布部分树，也不将输出节点号当作输入位置。

受检 CLI 的 `run_decimal_tree_example` 构造边界为 ±5.25、±3.25、±1.25 的三层矩形，`run_offset_tree_example` 检查整数／小数偏移树，`run_stroke_tree_example` 检查普通路线和带孔描边的完整轮廓及层级。运行 `moon run --target native cmd/example`。33 项 `decimal tree: *`、27 项 `offset tree: *` 和 29 项 `stroke tree: *` 测试覆盖完整预期、层级、开放端点、隔离、预算边界和失败清理；源码全量为 2234+33+27+29=2323。既有 1384 个参考案例、2276 项能力检查不变，不能解释为已覆盖新树入口。

## 既有小数数据模型

PointD 保存原始 Double，字段不可变；PathD/PathsD 是有序可变数组。构造不量化、不去重，Eq 逐字段比较且没有 epsilon。copy_path_d 复制点数组，copy_paths_d 复制外层及每条内层数组，别名输入也得到独立副本。Double 存储不等于任意十进制精确计算。

## 精度与调用

Precision::new(digits) 返回 Result，支持 0—6，默认 3；digits() 读取位数，字段私有。Precision 只保存不可变位数，无账本、缓存或其他执行状态。倍率由固定表 1、10、100、1000、10000、100000、1000000 选择，不使用运行时浮点幂。

| 入口 | 默认及参数单位 |
| --- | --- |
| boolean_op_d(subject, clip, operation, precision=, fill_rule=, limits=) | EvenOdd；整数核心四种 Boolean 操作 |
| offset_polygons_d(paths, delta, precision=, fill_rule=, options=, limits=) | NonZero；delta 为原单位，四种 Join |
| stroke_polyline_d(path, width, precision=, cap=, options=, limits=) | Butt；width 为完整原单位宽度 |

[可运行示例](../cmd/example/main.mbt)的 run_decimal_example 共用一个 Precision(3)，实际执行负坐标 Union → Offset，以及 Stroke → Intersection；每步检查 Result 并断言完整矩形轮廓。Union 为 [-1.25,-.25]—[2.25,1.25]，偏移 .2 后为 [-1.45,-.45]—[2.45,1.45]；路线 (-1,0)→(3,0)、宽 .4 与遮罩求交后为 [0,-.2]—[2,.2]。失败立即停止，没有空结果回退。运行 `moon run --target native cmd/example`，示例与检查入口一同构建执行。

## 坐标量化与范围

输入先检查有限性和原单位范围，再乘 scale，复查有限性及网格范围，最后比较整数部分与尾数 .5，执行半整数远离零；不是 floor(x+.5)。例如 .49999999999999994→0、.5→1、.5000000000000001→1，负数对应 0、-1、-1。先加 .5 会让相邻值在加法舍入时跨过边界，故不采用。输入量化、既有扫描 ties-to-even 投影、固定参考偏移生成的舍入是三个不同环节，整数行为未改变。

| precision | scale | 原单位每轴范围（含边界） |
| ---: | ---: | ---: |
| 0 | 1 | ±1,000,000,000 |
| 1 | 10 | ±100,000,000 |
| 2 | 100 | ±10,000,000 |
| 3 | 1,000 | ±1,000,000 |
| 4 | 10,000 | ±100,000 |
| 5 | 100,000 | ±10,000 |
| 6 | 1,000,000 | ±1,000 |

原单位略超界也拒绝，不靠舍入拉回边界。极大有限坐标在乘法前就被范围检查拒绝；有限距离/容差的乘法溢出则为 NumericFailure。所有 Int64 转换均在检查之后。

输出只执行 coordinate64.to_double()/scale，零显式返回 +0.0；无字符串格式化、十进制截断或二次取整。网格整数本身在 Double 连续精确范围内，但除法结果仍为二进制浮点数。比较器同时验证完整整数轮廓，以及每个实际小数坐标精确等于对应整数除以倍率；不能只重新量化任意输出。

## 严格量化诊断

原本不同的位置落到同一网格点时返回 QuantizationFailure。检查跨同一路径、不同轮廓、两个 Boolean 操作数，按 subject 路径/顶点、再 clip 的顺序记录首次位置。+0.0/-0.0 是同一位置；原本完全相同的重复点允许，无 epsilon。辅助索引由同一执行预算约束。

非空闭合输入必须至少包含三个不同且不全共线的网格点；使用精确叉积检查，不按面积为零过滤自交轮廓。空轮廓允许。小数入口的严格契约不改变整数入口接受退化输入的行为。开放 Stroke 允许空路径/单点，但新出现的点合并先报错，即使宽度为零或很小也不跳过参数和输入检查。

- QuantizationFailure(location, axis?, first_location?, message)：非有限坐标携带轴；点合并携带冲突位置和首次位置，轴为 None；整个轮廓退化时顶点、轴和首次位置均为 None。说明为英文。
- DecimalCoordinateOutOfRange(location, axis, value, digits)：value 是原单位 Double，digits 表明范围，非法值不塞进旧 Int64 字段。
- DecimalParameters、DecimalQuantize、DecimalOutput 分别定位本层参数、量化和输出费用。内部生成坐标越界映射回原单位但保留 OffsetGenerate/StrokeGenerate 等原阶段；其他 NumericFailure、ResourceLimitExceeded、ExecutionFailure 保留真实类型与具体阶段。

量化数组保留每条原始路径与每个顶点的位置，不先整理、不标记为内部生成输入。下一公开调用收到小数中间结果时会重新验证并量化；不同精度下可能出现新的量化失败。

## 长度参数传播

| 参数 | 送入私有整数核心的值 |
| --- | --- |
| 坐标 | coordinate ×scale 后量化 |
| delta | delta ×scale，仍为 Double |
| 完整 width | width ×scale，核心再除以 2 |
| 正 ArcTolerance | tolerance ×scale |
| ArcTolerance=0 | 保留自动精度哨兵 |
| MiterLimit | 无量纲，保持原值 |

独立构造缩放 OffsetOptions，原选项不变。precision=3 时，delta=.2→200，width=.4→400、每侧200，ArcTolerance=.025→25，MiterLimit=4仍为4。小距离阈值为原单位 .5/scale，小宽度阈值为 1/scale；极小正容差的底层 1e-12 分支判断在网格单位进行。距离不能先转整数。

## 累计资源与所有权

每次公开小数调用建立一个账本：原始预检 → 量化副本与全局合并索引 → 私有整数求值/清理/提取 → 小数结果。直接复用 boolean_compute、offset_execute、stroke_execute，不调用会重建账本的公开整数函数。已传入账本的限制和历史计数始终权威。默认内部上限仍为500000节点、5000000工作量；原始路径/顶点限制仍为10000/100000，输入额度不是所有输入都能在执行额度内完成的保证。

| 小数阶段 | 计费内容 |
| --- | --- |
| 预检 | 每条原路径和每个原始顶点的工作；重复点也计入原始数量 |
| 量化 | 两个结果容器与合并索引；每路径容器/外层槽；逐点查找键、索引条目/来源记录、新网格点及数组槽 |
| 有效性 | 逐点寻找不同点与精确共线检查 |
| 整数核心 | 保持[原累计计费](composition.md)，包含再次扫描真实量化输入 |
| 小数输出 | 结果外层、每条内层和外层槽、每个 PointD 与点槽、逐点解码工作 |

所有存储先扣费，两项额度检查成功后才同时更新，不退款。整数求值成功并不保证剩余费用足以输出小数结果；任何失败都返回 Err，不泄露部分结果。临时释放不依赖剩余预算，结果内外数组与输入隔离。同一 Precision 在独立公开调用间不共享预算。

## 两类独立参考与误差边界

固定 [ClipperD 源码](https://raw.githubusercontent.com/AngusJohnson/Clipper2/21ebba05db8894f0c7217ad35ea518080f324946/CPP/Clipper2Lib/include/clipper2/clipper.engine.h) 使用2的幂作为倍率；[InflatePaths(PathsD)](https://raw.githubusercontent.com/AngusJohnson/Clipper2/21ebba05db8894f0c7217ad35ea518080f324946/CPP/Clipper2Lib/include/clipper2/clipper.h)使用十进制倍率。MoonClip统一十进制，不宣称与所有 ClipperD 输入逐点一致。

196 条 DecimalGrid 由适配器独立 std::round 量化后执行固定整数路线：Boolean112（两构型×四操作×两填充×七精度）、Offset48（四连接×正负×两填充×0/3/6）、Stroke36（四连接×三端点×0/3/6）。偏移仍共同规范化，描边仍开放路径并解释完整宽度，包括合法的次网格空结果。

24 条 ClipperDCommonGrid 真正执行 ClipperD，输入与结果位于两者共同网格；先验证原始浮点输出在目标网格上，再保存整数见证。偏离网格就失败，不能强行重新量化。共同网格不限于整数，但只有这24个固定输入构成当前兼容证据。路线、操作、精度及哈希全部写入独立v5协议，网格与原单位结果均保存。旧772条不变，总数992；同一案例的两种表示不算两条输入。

单次量化在无乘法舍入跨界的理想网格上，坐标舍入偏差最多半格；原始 Double 表示和乘法还有浮点舍入。该局部界不是整体几何误差或拓扑保证。输入量化、交点网格投影、圆弧近似、输出 Double 解码是不同误差来源。严格合并/退化检查只拒绝已定义的问题，不能替代任意拓扑修复。

80 项功能分为类型/复制/精度12、量化20、单位与范围20、预算/错误16、组合隔离12；native和JS执行同一批。新增220对照后各目标1714项。离线工具209=179+30、真实适配器65=51+14另计；本地、普通Linux CI和独立参考CI分别验证，见[兼容报告](compatibility.md)。原规划不变，简化与删点报告留给Commit14。
