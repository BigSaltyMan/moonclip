# 树接口增量验收与证据索引

本记录汇总 Commit 20—23，并说明 Commit 24 的消费者验收范围。新增能力属于 **Unreleased 开发源码**，没有确定后续版本号，没有改写已发布的 0.1.0，也没有执行正式赛事申报。用法见[树接口升级说明](upgrade-trees.md)；首版事实保留在[历史验收](acceptance.md)和[首版发布记录](release-0.1.0.md)。

## 已完成增量及历史证据

| 提交 | 增量与数量 | 同一源码的公开证据 | 契约与使用入口 |
| --- | --- | --- | --- |
| Commit 20，`5259ba10748b29d93c20e167925f48514e87110a` | 小数 Boolean 树、PolyTreeD / PolyNodeD 及访问器；新增 33 项库测试，2234 → 2267 | [Linux CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39390719375) | [小数树](decimal.md#unreleased小数孔洞树)、[CLI 示例](../cmd/example/main.mbt) |
| Commit 21，`ecd94063b13c684c000c0229b2dc1ba2a600dfc1` | 整数／小数偏移树；新增 27 项库测试，2267 → 2294 | [Linux CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39394235671) | [偏移树](composition.md#unreleasedoffset-trees) |
| Commit 22，`4c550a58d1931339cf7c84d5ab66832ce8eae57c` | 整数／小数描边树；新增 29 项库测试，2294 → 2323 | [Linux CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39439280296) | [描边树](composition.md#unreleasedstroke-trees) |
| Commit 23，最终 `ab49f5092853a81d70a49b7a9e8d78fe7610defd` | 层级交互、边界选择高亮和 v2 JSON；新增 13 项桥接／导出检查，7 → 20 | [最终 Linux CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39444133715)；含截图分发链接修复 | [演示协议](demo.md)、[浏览器验收与截图](demo-acceptance.md#commit23) |

表中 CI 证明对应提交当时的执行结果，不替代本笔最终 SHA 的检查。Commit 20—22 的本地收据仅作辅助附件；以上公开 CI 和仓库中的契约、示例、测试是可访问的证据入口。

## 数量不能混用

| 内容 | 当前口径 |
| --- | --- |
| 库回归 | 2234＋33＋27＋29＝**2323**；native、JS 分别执行同一批，不能相加为独立用例 |
| 演示桥接／导出 | 7＋13＝**20**；与库测试分开记录，本笔没有新增或重跑本地桥接检查 |
| 旧工具基线 | Commit 23 离线工具 **276** 项 |
| 本笔工具增量 | **5 项**包消费者标记工具测试；普通 CI 的工具总数为 276＋5＝**281**，实际通过数量由最终日志记录 |
| 上游参考 | **1384 个独立案例、2276 项能力检查**；锁定输入、预期及选择文件不变 |
| 本笔候选消费者 | 六个树入口；从实际候选包解压，在 native、JS 上分别运行并收集标记 |

新增定向测试不自动成为上游参考案例。旧参考的 Boolean 整数树检查，也不能视为已逐项覆盖新小数 Boolean 树、偏移树和描边树。消费者是小规模真实使用检查，不另算几何参考矩阵。

## 六入口消费者实际检查什么

消费者夹具见[仓库源码](https://github.com/BigSaltyMan/moonclip/blob/main/tools/release-consumer/main.mbt)。保留原有调用，补齐 `boolean_tree_d`，不为打印标记重复执行同一案例。

| 入口 | 检查范围 | 通过后标记 |
| --- | --- | --- |
| `boolean_tree` | 整数差集的完整外轮廓、反向孔洞、根／孩子、深度和孔洞属性 | `TREE_API_OK boolean_tree` |
| `boolean_tree_d` | 手工三层小数矩形预期；完整点序允许环起点变化，保留绕向；根／孩子数、深度、孔洞、叶节点及输入不变 | `TREE_API_OK boolean_tree_d` |
| `offset_tree` | 带孔矩形偏移后的完整整数外轮廓、孔洞及两层关系 | `TREE_API_OK offset_tree` |
| `offset_tree_d` | 小数偏移完整轮廓及两层关系，与相应确定整数网格结果对齐 | `TREE_API_OK offset_tree_d` |
| `stroke_tree` | 返回起点的开放路线，完整宽度 4、Square 端点；外轮廓、孔洞和两层关系 | `TREE_API_OK stroke_tree` |
| `stroke_tree_d` | 同一构型的小数描边，完整轮廓、深度、孔洞及叶节点 | `TREE_API_OK stroke_tree_d` |

`scripts/check_release.py` 保留非零退出和总体成功标记检查；对每个目标独立验证六个树标记各出现一次，拒绝缺失、重复或未知标记。原始日志分别写入 `consumer-native.log`、`consumer-js.log`，报告的 `consumers.<target>.tree_apis_checked` 只在该目标实际日志通过后记录。native 成功不能补齐 JS 的缺项。

工具单元测试验证完整、缺失、重复、未知／格式错误，以及 native 结果不能代替 JS。这些注入错误只检查审计工具，不表示真实库出现相应故障。实际几何断言仍由候选消费者执行。

## 候选、最终提交与跨平台核对

运行 `python scripts/check_release.py --report _build/release-trees/report.json`，使用固定工具链正式生成实际 ZIP，审计精确分发集合、每个成员的原始字节、大小和 SHA-256、许可、来源及相对文档链接，再在仓库外解压运行消费者。编译结束后复核解压库的源码和接口没有改变。两个新增文档随源码候选分发，文件数按实际归档记录；Commit 23 的 **48 文件**仅保留为历史事实。

本笔沿用 `moon.mod` 的 0.1.0 元数据，该 ZIP 仅是**含 Unreleased 内容的源码候选**，不是新发布包，不得覆盖已发布的 0.1.0。实际文件路径、逐成员大小／SHA-256 与最终源码核对；不同系统生成的 ZIP 时间戳和归档 SHA-256 可以不同，每份分别保存。

本地在提交前运行的报告会如实保留父 SHA 和 dirty 状态，不伪装成最终提交的干净检查。最终完整 SHA、本地和 Linux 归档清单／校验和、两目标消费者结果、同 SHA CI 链接由**提交后的交付记录**承载；不为在正文填写自身 SHA 反复补提交。本地 `_build` 附件不作为本文唯一可用证据。

## 本笔验证边界

本地只执行 `moon info`、`moon fmt`、diff 检查、新增标记工具测试，以及一次实际候选验收；不重复库全量、全部工具、桥接、浏览器、参考重建或性能测量。最终 SHA 的现有 Linux CI 执行完整回归、工具、演示与桥接、既有基准冒烟和候选验收，实际结果以交付记录链接的日志为准。

Commit 23 的浏览器记录沿用原归属，不改写为本笔重新验收。性能继续引用 [Commit 18 的原报告](benchmarks.md)：源码 `6a116b45600cbe8ecd577664a71b50fdfa8ce5c0`，Windows x64、Ryzen 9 8940HX、MSVC 14.44、固定 MoonBit、native release。新增树入口没有单独耗时或内存测量，不能从旧平铺结果推导性能；CI 的极小基准冒烟不是重复性能测量。

根 API、几何实现、固定工具链与依赖、旧参考及选择、原规划书、0.1.0 标签／包／历史发布记录保持不变。未提交申报书不在本笔编辑范围；更新成果说明不等于正式申报。下一版的版本号、实时占用核对、上传和公开 Release 仍按后续明确授权执行，见[发布前检查](release-checklist.md#后续树能力版本发布前检查)。
