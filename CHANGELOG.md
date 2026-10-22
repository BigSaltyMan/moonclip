# Changelog

## Unreleased

- 新增不可变 `BoundsD` 与 `rect_clip_polygons_d`：小数窗口独立量化，区域使用同一精度网格，复用整数窗口裁剪并累计解码预算；区分原始空窗口与量化塌缩。新增 3 项定向测试，未发布。

- 新增 `rect_clip_polygons`：使用现有 Boolean 求交裁剪整数闭合区域，支持 EvenOdd／NonZero 和孔洞；内部矩形不占原始输入额度，预检、窗口构造和扫描共用预算。新增 3 项定向测试，未发布。

- 新增 `stroke_polylines_d`：独立开放路线共同量化，复用整数批量描边并统一解码为合并平铺区域。完整宽度与 ArcTolerance 按 Precision 缩放，全流程共享预算；零宽度仍检查原始输入与量化碰撞。新增 3 项定向测试，未发布。

- 整数 Boolean 树演示新增点定位：同次构树并调用 `locate`，按完整节点快照关联展示索引，区分内部、孔洞、外部和全部边界命中。定位高亮独立于手动选择；v2 JSON 可保存并重放查询，SVG 仍只导出区域。新增 3 项定向检查，未发布。

- 路线实验新增“批量加宽”页签：整数多路线共享宽度和样式，一次调用 `stroke_polylines` 生成合并区域，支持区域 SVG 和可重放 v1 JSON。新增 3 项桥接／导出定向检查，未发布新版本。

- 图案扫掠演示接入 `minkowski_sum_d`：可切换整数／小数与 Precision，保留锚点和开闭语义；区域 SVG 与 v1 JSON 可重放。新增 2 项检查、调整 1 项旧错误检查，仍未发布。

- 演示的路线实验新增“窗口裁剪”页签：整数多路线输入、矩形参数、真实 MoonBit 开放片段显示、开放 SVG 和可重放的 v3 JSON 导出。只新增 3 项桥接／导出测试，其他场景导出格式不变。

- 新增整数 `PolyTree64::locate`、`TreePointLocation64` 与 `PolyTreeQuery` 阶段：返回外部、最深填充节点、最深孔洞节点或全部边界命中。直接读取既有树层级并使用精确谓词，独立查询预算，最坏线性访问全部轮廓顶点。

- 新增 `minkowski_sum_d`：图案和路线共同量化后复用整数扫掠，默认 Precision=3（支持 0—6），量化、生成、清理和解码共享预算。支持两点图案；生成坐标仍受整数边界约束。未新增参考矩阵或发布版本。

- 新增整数 `stroke_polylines`：多条独立开放路线共用完整宽度、端点和连接参数，分别生成后统一 Positive Union 清理，返回合并的平铺闭合区域。整批原始输入、生成和清理共用预算；旧单路线与树入口保持不变。

- 新增整数 `rect_clip_lines`：轴对齐矩形窗口的开放折线裁剪，保留有向片段顺序和完整共线顶点。
- 新增 RectClipParameters、RectClipEvaluate、RectClipOutput 阶段，共用输入边界、结构化错误和一次调用累计预算。
- 固定 C++ v8 参考仅覆盖新增整数开放路线；不增加小数、闭合区域裁剪、任意区域开放路径 Boolean、树或演示。

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
