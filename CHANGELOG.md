# Changelog

## Unreleased

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
