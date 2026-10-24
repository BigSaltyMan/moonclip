# Changelog

## Unreleased

后续变更在本节另行记录；已发布的 0.3.0 源码与归档保持冻结。

## 0.3.1 — 2026-10-24

已发布至 [Mooncakes](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.3.1/) 和 [GitHub Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.3.1)。发布源码固定为 `adad8bb47be1a136c59247d491d6607919253c83`；独立 registry 消费者 native／JS 各一次成功，61 个文件与冻结候选一致。README、安装说明及 since-0.3.0 API 注释已在实际页面核验；原始 Markdown 外链的编码声明限制见[发布记录](docs/release-0.3.1.md)。

- 修正随包 README 的安装示例、当前能力状态，以及小数窗口树、批量描边树、Minkowski 树和整数／小数单点／批量查询的专题说明。
- 将这些已由 0.3.0 提供的公开 API 文档注释改为明确的引入版本；历史候选、验收和发布事实保留原提交归属。
- 仅同步 0.3.1 版本及候选审计元数据。运行库执行代码、公开接口、默认值、精度、错误、预算、依赖和工具链均与 0.3.0 一致；不新增功能或库测试。

## 0.3.0 — 2026-10-24

已发布至 [Mooncakes](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.3.0/) 和 [GitHub Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.3.0)，集中交付 0.2.1 之后的增量。发布源码为 `d21baf6687b5d890392f87574aac48f22cd3d5f0`；独立 registry 消费者 native／JS 各一次成功，61 个下载文件与冻结候选一致。迁移见[升级说明](docs/upgrade-incremental.md)，候选历史与正式发布证据见[发布记录](docs/release-0.3.0.md)。下方旧版本章节保留各发布时的事实与限制。

### 窗口裁剪

- 新增整数／小数开放折线窗口入口 `rect_clip_lines`／`rect_clip_lines_d`，保留片段顺序、方向和普通共线中间点。
- 新增 BoundsD 及整数／小数闭合区域入口 `rect_clip_polygons`／`rect_clip_polygons_d`，支持 EvenOdd／NonZero；树入口 `rect_clip_polygons_tree`／`rect_clip_polygons_tree_d` 在同一次求交后直接构建最终层级。被窗口切开的孔洞可能变成外轮廓凹口。
- 小数窗口独立量化，与路径共用精度网格；原始空窗口仍验证输入，非零窗口量化塌缩返回错误。

### 批量描边与图案扫掠

- 新增 `stroke_polylines`／`stroke_polylines_d` 及 `stroke_polylines_tree`／`stroke_polylines_tree_d`。多条独立开放路线共用样式、预算和一次最终清理，返回合并区域的平铺或孔洞树。
- 新增小数平铺 `minkowski_sum_d` 及整数／小数树入口 `minkowski_sum_tree`／`minkowski_sum_tree_d`。保留图案锚点、路线开闭和共线点，不额外填满闭合路线内部；旧树入口的共线清理行为不变。

### 树查询

- 新增 TreePointLocation64／TreePointLocationD、PolyTree64／PolyTreeD 的 `locate` 与 `locate_many`，区分 Outside、Inside、InHole、OnBoundary；返回最深包含节点或全部边界命中。
- 批量按输入顺序保留重复点并共用预算，任一点错误则整批失败。小数树保存原 Precision，查询时恢复一次临时整数视图，点量化重合允许发生；没有空间索引。

### 演示与交付材料

- 窗口页签支持整数／小数、开放片段／闭合区域，闭合结果可查看孔洞树；批量描边和 Minkowski 也支持整数／小数平铺或树输出。
- 六类区域树均接入单点／批量查询。原始查询坐标保留，行选择只改变展示；最多 32 点是演示限制。JSON 沿用 v1 平铺、v2 树、v3 开放片段，保存真实请求并可重放。
- 整理发布边界、能力说明及定向验收索引，新增 docs 轻量 CI；文档检查新增几何测试 0 项、执行几何测试 0 项，不构建。当前 2406 是完整入口配置期望，历史结果按各提交归属。

### 使用边界与验证归属

- 小数树查询按原建树 Precision 量化后判定；批量描边整批共享样式、统一合并，输出不与路线逐条对应。Minkowski 仍限单图案、单路线，树查询没有空间索引，显式简化不保证拓扑保持。
- 包级证据复用 Commit 53 的三个增量流程及原有检查，0.3.0 候选重新生成准确版本归档，native／JS 分别验证仓库外消费者。增量定向、演示和旧性能证据保留原提交归属，见[验收索引](docs/acceptance-incremental.md)。
- 当前完整入口的 2406 仍是配置期望，不表示发布提交执行过完整回归。沿用同 SHA package CI，本次只新增正式上传、registry 消费者、文档页与 Release 附件核验事实；状态文档提交单独运行 docs CI。包内“待发布／Unreleased”文字是冻结快照，不重新上传同一版本。

## 0.2.1 — 2026-10-21

已发布至 [Mooncakes](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.2.1/) 和 [GitHub Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.2.1)。独立注册表 native／JS 消费者及实际文档页核验通过，见[发布记录](docs/release-0.2.1.md)。

- 修正注册表文档中的过时发布状态、安装版本和树接口说明；0.2.0 已包含五个新增函数及小数树类型，并非只能从开发源码使用。
- 小数、组合及演示文档的树章节改为 0.2.0 已提供的能力，保留旧锚点供已有链接使用；来源记录中的提交阶段描述仍按历史解释。
- 运行库源码、公开接口、依赖及工具链与 0.2.0 相同。0.2.0 的包、标签和发布记录保持原样。

## 0.2.0 — 2026-10-21

已发布至 Mooncakes，并创建 [GitHub Release v0.2.0](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.2.0)。发布源码固定为 `e0ef766b34562bcad2b3f3e0d50002adf7b05912`；独立注册表消费者 native／JS 均通过，51 个下载文件与冻结候选一致。发布后状态文档提交与发布源码分开，见 [0.2.0 发布记录](docs/release-0.2.0.md)。

### 库接口

- 新增 `boolean_tree_d`、`PolyTreeD` / `PolyNodeD` 及六个树／节点访问方法，新增 `offset_tree` / `offset_tree_d`、`stroke_tree` / `stroke_tree_d`。共 5 个新库入口，整数 `boolean_tree` 已随 0.1.0 发布。
- 偏移树返回最终区域，沿用填充、连接和参数语义；描边树仍只接收单条开放路线，width 是完整宽度，支持三种端点及四种连接。原有平铺签名和默认值保持不变。

### 执行契约

- 树构建与小数解码纳入单次累计预算，保留父子关系、深度、绕向与访问器复制隔离。小数层级来自量化后的整数区域，转换失败沿用扫描清理路径。
- 偏移／描边共用既有生成与清理，在清理回调或已验证的快捷分支提取树。空树仍验证输入并计费，不额外扫描；旧平铺输出不承担树构建费用。描边首尾重合保留开放端点语义。

### 演示

- Commit 23 接入 Boolean、Offset、Stroke 的整数／小数六个树入口，提供可展开层级、轮廓索引、深度／孔洞标记与仅描边的选择高亮。保留默认平铺模式，Minkowski 仍仅整数平铺。
- 树 JSON 使用 MoonClipDemo v2，保留轮廓与父子索引及可重放的 v1 桥接请求；原 v1 平铺 JSON 与结果专用 NonZero SVG 保持兼容。编辑、失败与迟到响应不能恢复旧树或旧导出。

### 验证与材料

- Commit 20 新增 33 项小数树回归，当时库全量 2267；Commit 21 新增 27 项偏移树回归，当时 2294；Commit 22 新增 29 项描边树回归，当前 2323。两目标分别执行同一批测试，不相加。
- Commit 23 新增 13 项桥接／导出检查，原 7 项增至 20；其浏览器与下载记录保留原提交归属。CLI 示例覆盖小数三层树、偏移树和描边树。
- Commit 24 补齐候选包 `boolean_tree_d` 直接调用，在六个树入口断言成功后分别输出可审计标记；native／JS 分别记录。新增 5 项标记工具测试，普通 CI 离线工具由 276 增至 281 项。
- 新增[升级说明](docs/upgrade-trees.md)和[增量验收](docs/acceptance-trees.md)，随源码候选分发。归档清单与文件数按实际结果记录，最终 SHA、校验和和 CI 由提交后的交付记录承载。
- 旧 1384 个参考案例、2276 项能力检查及选择文件不变，不宣称已逐项覆盖新树入口。未单独测量新树性能，未修改首版历史记录、标签或包；以上内容均未随 0.1.0 发布。

## 0.1.0 — 2026-10-20

已发布至 Mooncakes，并创建 [GitHub Release v0.1.0](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.1.0)。发布源码为 `10a9a1012d5fb07a333936ea83ce22e1f98a03d5`；仓库外注册表消费者 native、JS 均通过，完整记录见 [正式发布验收](docs/release-0.1.0.md)。

- 整数与统一十进制网格的小数 Boolean：Intersection、Union、Difference、Xor，公开 EvenOdd / NonZero。
- 整数 PolyTree 外轮廓、孔洞与岛的层级及独立访问器。
- 闭合区域偏移、开放路线描边；Miter / Bevel / Square / Round 连接与 Butt / Square / Round 端点。
- Precision 0—6、MiterLimit / ArcTolerance、显式整数 / 小数简化及删点、原有退化 / 最终退化 / 新塌缩报告。
- 整数单图案、单路线 Minkowski Sum，显式开闭与锚点语义。
- 不可变整数 / 小数点、复制隔离、精确方向与 BigInt 面积、输入整理、结构化错误、坐标边界与累计资源预算。
- 固定 Clipper2 2.0.1 参考：1384 个独立案例、2276 项能力检查；native / JS 同一批 2234 项库回归。
- 三组浏览器交互演示及扫掠页签、SVG / JSON 导出、11 项指定环境 native 性能基线。
- 实际候选归档审计、仓库外 native / JS 公开接口消费者与可追踪验收材料。

当前限制与数值约定见 [scope.md](docs/scope.md)；来源、许可及适配贡献见 [upstream.md](docs/upstream.md)。Positive / Negative 仍为内部能力，简化不保证拓扑保持，Minkowski 只有整数公开入口。
