# MoonClip 0.4.0 正式发布记录

**0.4.0 已于 2026-10-26 正式发布。** 本版提供整数／小数开放路线区域求交、求差和闭合中心线平铺／孔洞树描边，以及相应演示、查询和可重放导出。旧包、标签、发布记录和参考清单保持原样。

```bash
moon add BigSaltyMan/moonclip@0.4.0
```

## 源码、归档与上传

- 发布源码：`63db64f23582390d78acac38a9fbfda11a0216b3`；[v0.4.0 标签](https://github.com/BigSaltyMan/moonclip/tree/v0.4.0)精确指向该 SHA，不随本状态文档提交移动。
- [Mooncakes 精确版本](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.4.0/)的服务端创建时间为 `2026-10-26T14:07:38.743993+00:00`（北京时间 2026-10-26 22:07:38），未撤回。
- 实际发布 **Windows 冻结 ZIP**：67 个文件，334263 字节，SHA-256 `e47d4e3e54678104e05eb80cfe43bf0f32acdf56bcbdfb02a0705cae30a7cbc4`。固定工具链的 moon publish 不接受指定 ZIP；从冻结提交创建仓库外干净源码，重新打包及实际上传包均与该候选逐字节一致。
- 一次正式上传返回服务端 200，checksum 与上述归档一致；没有改版本、覆盖或重新登录。固定工具链及发布规则见[工具链](toolchain.md)与[官方发布说明](https://docs.moonbitlang.com/en/latest/toolchain/moon/package-manage-tour.html)。
- Linux 历史候选同为 67 文件、334263 字节，SHA-256 `1f9803e32776b0d2df82570d4d419fc92e7f44c70d05a0803db05d355228d20f`，成员路径与字节相同；该 ZIP 未用于本次上传。

## 新接口与使用边界

| 能力 | 新入口 |
| --- | --- |
| 区域内开放片段 | intersect_polylines、intersect_polylines_d |
| 区域擦除 | difference_polylines、difference_polylines_d |
| 闭合中心线平铺覆盖 | stroke_closed_polyline、stroke_closed_polyline_d |
| 闭合中心线孔洞树 | stroke_closed_tree、stroke_closed_tree_d |

求交包含最终区域边界；求差剔除内部和正长度边界重合区间，切分端点仍可在边界。这是 MoonClip 契约，与 Clipper2 特殊贴边分支存在有意差异。小数路线和区域共同量化，仅区域接受面域有效性检查，详见[区域裁线](lineclip.md)及[小数适配](decimal.md)。

闭合描边覆盖无端点中心线，不等于填充其内部或偏移面域；完整宽度的两侧各一半，尚无批量闭合或闭合简化。树来自最终一次清理，不保证始终一根一孔，见[组合与闭合描边](composition.md)。小数树定位使用原建树 Precision，近边界点可能量化到边界；没有空间索引，演示最多 32 点不等于核心限制。独立公开调用各自建账，内部阶段共享累计预算，显式简化不保证拓扑保持。

## 注册表消费者与下载内容

在仓库外创建新项目，复用发布源码中的消费者夹具，执行精确版本 moon add 和 moon tree --json，确认依赖来源 registry、版本 0.4.0、不是 workspace 成员。固定工具链先解析元数据，再通过项目依赖同步下载源码；没有 moon.work、本地路径替换、候选库复制、共享缓存清理或全局配置修改。

| 目标 | 实际运行 | 结果 |
| --- | --- | --- |
| Windows native | 一次冻结消费者 | 原有检查及五个增量流程均通过 |
| JS | 一次冻结消费者 | 独立验证相同标记及完整断言，均通过 |

五个流程包括原窗口、批量描边查询、小数 Minkowski 树，以及本版的开放路线求交／求差和闭合描边。后两流程实际调用全部八接口，使用手工完整预期检查顺序、方向、中间点、外轮廓、反向孔洞和层级；在实际返回的小数树上另执行孔洞点查询。流程数、API 数和断言数不计作新增库测试。

实际下载的 67 个文件，其路径和字节在两目标编译前后均与冻结 ZIP 和发布源码一致；编译未修改受审计库文件。详细清单、两目标日志及标记保存在交付目录。

## 文档页面、中文链接与附件

实际打开 Mooncakes 页面，确认 **0.4.0 (latest)**、安装命令、README 新能力表、八个 API 标题及八处 since-0.4.0 注释可见。README 的 18 个唯一 blob/v0.4.0/ 目标链接均返回 HTTP 200；区域裁线与小数专题在 GitHub Preview 中实际打开，中文标题和正文正常。此验证不宣称遍历所有标题锚点或修改了 Mooncakes 原始 Markdown 源站编码配置。

[GitHub Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.4.0)于 `2026-10-26T14:15:10Z` 发布，附件为实际发布 ZIP、SHA256SUMS.txt 和去除凭据及本机路径的 acceptance-summary.json。三个附件均已重新下载并逐字节核验，标签保持冻结源码。

## 验证归属与停止边界

完整验收属于 `339947be1cb0ac87ab3a16b9658093806d0a4736`，见[完整验收记录](full-acceptance.md)及[该 SHA CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40313466815)：Windows／Linux 的 native、JS 各 2427/2427，conformance 工具 294、桥接 31/31、参考 1416 案例／2308 能力检查。发布源码运行库执行代码与公开声明保持该基线一致，只同步八处 API 版本注释。

[发布源码 CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40316832927)仅为 package：两平台工具各 10/10、实际归档、native／JS 候选消费者及最终提交内容核对。正式发布又从 registry 运行了上述两个目标各一次，未重复候选消费者、库测试、完整工具集合、参考重建、性能或演示浏览器验收。新增及执行库测试均为 0，没有新增兼容矩阵或赛事申报。

本文件及 README、CHANGELOG 是独立发布状态更新，仅运行 docs scope。最终状态提交 SHA、同 SHA docs CI、页面证据、实际上传清单和附件核对记录写入 `_build/release-0.4.0/publication-final-delivery.json`，不为填写自身 SHA 再补提交，也不移动发布标签或替换已发布包。
