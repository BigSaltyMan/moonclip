# MoonClip 0.4.0 赛事验收导航

本材料以已发布的 **0.4.0** 为验收版本，供评审核对原目标、交付与证据。项目仓库见 [GitHub](https://github.com/BigSaltyMan/moonclip)，安装和 API 见 [Mooncakes 0.4.0](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.4.0/)，包和发布说明见 [v0.4.0 Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.4.0)。

目标表依据工作区未跟踪的本地 `MoonClip项目申报书.md` 中“核心功能范围”“技术方案”和“预期使用场景”整理；该文件未纳入仓库，本地内容与实际正式提交版本是否完全一致尚未确认，需本人核对。下表的原目标按该本地文本归属；后续新增能力单列，未将其倒写为原承诺。三角剖分属于后续范围，不列为本轮验收缺项。

## 申报目标对应表

| 原申报目标 | 当前实现 | 公开入口或专题 | 验证证据 |
| --- | --- | --- | --- |
| 多边形 Boolean、填充规则及孔洞 | 整数／小数四种 Boolean、EvenOdd／NonZero；整数与小数树表达外轮廓、孔洞及岛 | `boolean_op`、`boolean_op_d`、`boolean_tree`、`boolean_tree_d`；[范围](scope.md) | [完整验收](full-acceptance.md)、[参考比较](compatibility.md) |
| 闭合区域偏移与开放路线加宽 | 整数／小数偏移与开放描边，支持连接、端点和完整宽度 | `offset_polygons[_d]`、`stroke_polyline[_d]`；[组合流程](composition.md) | [完整验收](full-acceptance.md)、[参考比较](compatibility.md) |
| 小数坐标、数值基础与复制隔离 | Precision 0—6 的十进制网格、精确整数谓词及结构化量化错误；输入输出与树访问器隔离 | [小数适配](decimal.md)、[数值路线](numerics.md) | [完整验收](full-acceptance.md) |
| 显式简化与退化报告 | 整数／小数开放及闭合路径简化，报告删点和退化；不保证拓扑保持 | `simplify_paths[_d]`；[简化说明](simplify.md) | [完整验收](full-acceptance.md)、[参考比较](compatibility.md) |
| 整数单图案 Minkowski Sum | 原整数扫掠保留共线点；当前另支持小数及树输出 | `minkowski_sum`；[扫掠说明](minkowski.md) | [完整验收](full-acceptance.md)、[兼容报告](compatibility.md) |
| 错误、累计预算与组合调用 | 每次公开调用独立建账，内部量化、生成、清理和输出共享；失败不返回部分结果 | `Limits`、`ClipError`；[组合与预算](composition.md) | [完整验收](full-acceptance.md) |
| 交互演示、导出及包交付 | 演示调用核心，支持 SVG 与可重放 JSON；0.4.0 注册表包可供外部项目调用 | [演示说明](demo.md)、[发布记录](release-0.4.0.md) | [历史浏览器验收](demo-acceptance.md)、[发布记录](release-0.4.0.md) |
| 锁定参考、测试和性能基线 | 参考清单和双目标回归有记录；性能保留原环境及测量归属 | [兼容报告](compatibility.md)、[性能基线](benchmarks.md) | [完整验收](full-acceptance.md)、[完整 CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40313466815) |

## 原目标之后的增量

小数区域树、树的单点／批量定位、开放路线批量描边、整数／小数窗口裁剪、小数 Minkowski Sum 与树输出，是本地申报书所述阶段之后的扩展。0.4.0 又交付开放路线对闭合区域的整数／小数求交与求差、整数／小数闭合中心线描边及其树与演示。契约分别见[窗口裁剪](rectclip.md)、[区域裁线](lineclip.md)、[组合与描边](composition.md)及[树定位](polytree-query.md)。

## 证据索引

| 证据 | 来源及统计口径 |
| --- | --- |
| 完整正确性与工程验收 | [记录](full-acceptance.md)；最终完整验收提交 `339947be1cb0ac87ab3a16b9658093806d0a4736` 的 [Linux full CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40313466815)。Windows／Linux 的 native、JS **各 2427/2427**；conformance 工具 **294 项**；桥接／导出 **31/31**，分开统计。 |
| 锁定参考 | [兼容报告](compatibility.md)与[完整验收](full-acceptance.md)：**1416 个案例、2308 项能力检查**，零差异、零执行错误；不将能力检查加成案例数，也不宣称覆盖所有增量接口。 |
| 0.4.0 分发与消费者 | [正式发布记录](release-0.4.0.md)、[发布源码 package CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40316832927)、[Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.4.0)。发布源码 `63db64f23582390d78acac38a9fbfda11a0216b3`；状态文档 `90ab4e5ce9213a695bc5863ee7711397d139e834`。包 **67 文件、334263 字节**；仓库外 registry 消费者 native、JS 各一次成功。package CI 不代表发布 SHA 重跑了完整回归。 |
| 演示与历史人工验收 | [演示说明](demo.md)及[浏览器验收](demo-acceptance.md)，截图与历史窄屏容器异常按原记录归属；未确认的异常不预设为页面缺陷。 |
| 性能 | [原性能基线](benchmarks.md)：2026-10-20、Windows x64、Ryzen 9 8940HX、MSVC 14.44、native release，11 项；测量时 HEAD `19d192b4e81e3162decf4d658a92d6b20b286719` 且工作区包含当时新增基准。不是 0.4.0 重测或跨库比较。 |
| 来源、许可和能力边界 | [上游来源](upstream.md)、[相关工作](related-work.md)、[许可证](../LICENSE)、[支持范围](scope.md)。 |

上述记录、CI 和 Release 均为公开证据入口；`_build/full-acceptance/` 与 `_build/release-0.4.0/` 中的本机日志和收据仅作补充。本次整理不重新执行这些检查。

## 约五分钟演示顺序

1. **Boolean 与孔洞树（约 1 分钟）**：在“区域布尔”选择“层级查看 · 外轮廓 / 孔洞 / 岛”，选择树输出并计算；展开根、孔洞和岛，观察深度与高亮。调用 Boolean 树入口。
2. **闭合中心线描边（约 1 分钟）**：在“路线实验 → 路线加宽”选择“整数闭合中心线 · 方框与孔洞”，计算并切换树结构；观察闭合接缝和中心孔洞。调用 `stroke_closed_polyline` 或 `stroke_closed_tree`。
3. **开放路线裁线（约 1 分钟）**：在“区域裁线”选择“整数路线 · 穿过带孔区域”，先选择“保留区域内”，再选择“擦除区域”，各自计算；观察内部两段与外部及孔洞中的三段。调用 `intersect_polylines` 和 `difference_polylines`。
4. **点定位与导出（约 2 分钟）**：回到区域布尔，选择“点定位 · 外轮廓 / 孔洞 / 岛”，启用点定位并计算；查询 `(6,6)` 显示孔洞命中。可改为批量点并选择结果行，观察命中边界；下载 SVG 和树 v2 JSON。重放需将 JSON 中的 `request` 重新提交给桥接，页面没有 JSON 导入面板。调用树 `locate`／`locate_many` 与现有导出。

从仓库的 `demo` 目录运行 `npm run dev`，访问 `http://127.0.0.1:4173/`；具体控件和协议见[演示说明](demo.md)。这是操作提纲，本次整理未重做浏览器验收。

## 讲解提纲

- **存储与计算范围**：点类型可存储更宽的数值，但精确整数计算限定每轴 ±10⁹，避免谓词和中间运算超出约定；越界以结构化错误报告。[数值路线](numerics.md)
- **小数与 Precision**：输入按十进制网格量化后执行整数运算再解码；精度越高，原单位可用坐标范围越小，区域形状和近边界查询可能改变。[小数适配](decimal.md)
- **孔洞树**：最终区域清理后构建父子层级，根深度为 1、孔洞为 2；小数树复制整数拓扑，不再凭浮点重新判断包含。平铺 `to_paths()` 会丢失显式父子关系。[树定位](polytree-query.md)
- **预算**：一次调用的量化、生成、扫描、清理及输出共用账本，临时释放不退款，防止复杂输入通过内部阶段反复重置额度；独立公开调用各自建账。[组合与预算](composition.md)
- **来源与自有工作**：Boolean、偏移等按[上游来源表](upstream.md)参考 Clipper2；MoonClip 自行组织 MoonBit 接口、量化诊断、预算与隔离、开放路线事件切分及验证工具。开放路线边界规则与 Clipper2 部分特殊贴边规则有意不同。
- **证据边界**：参考比较验证锁定案例及对应参数，不证明所有输入兼容；定向、完整回归、消费者、浏览器与历史性能各自归属原提交。[相关工作](related-work.md)

人员、组别、编号、分工及正式申报材料版本由本人确认；本导航不代替赛事最终提交。
