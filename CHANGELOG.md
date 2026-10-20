# Changelog

## Unreleased

- 新增 `offset_tree` / `offset_tree_d`，返回最终偏移区域的整数／小数孔洞树，沿用填充、连接和参数语义；尚未随 0.1.0 发布。
- 共用偏移执行器，在规范化快捷分支或最终清理回调内提取树并解码；空规范化结果使用计费空树，不额外扫描，旧平铺输出不承担树费用。
- 新增 27 项偏移树定向测试，覆盖完整轮廓、拓扑变化、复制隔离、累计预算边界及失败清理；源码全量增至 2294，旧参考计数不变。CLI 示例与真实候选 ZIP 的 native／JS 消费者增加两个新入口。
- 新增 `boolean_tree_d`、`PolyTreeD` / `PolyNodeD` 及六个只读访问器，仅开发源码可用，未包含在已发布的 0.1.0 中。
- 在同一次累计预算内构建整数孔洞树并解码坐标，保留父子关系、深度和方向；新增输出分配与工作计费，失败沿用整数求值清理路径。
- 新增 33 项定向回归，native / JS 执行同一批；完整回归计数为 2267。旧 1384 个参考案例及 2276 项能力检查不变，不代表已覆盖新小数树入口。
- CLI 示例增加小数外轮廓、孔洞和岛的完整轮廓与层级断言。没有更改既有整数树、小数平铺接口或发布标签，不自动发布新版本。

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
