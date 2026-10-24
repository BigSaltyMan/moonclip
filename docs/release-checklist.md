# 源码包审计与发布检查清单

## 0.3.0 当前发布状态

0.3.0 已正式发布，registry 消费者 native／JS 各一次成功，实际归档与冻结候选一致。见[正式发布记录](release-0.3.0.md)。以下是 Commit 54 当时的候选流程，不表示还需重复上传或验收；候选与历史开发包报告保留原样。

## 历史 0.3.0 发布候选（Commit 54）

Commit 54 的 package scope 为 0.3.0 重新生成 `_build/release-0.3.0/moonclip-0.3.0.zip`，报告为 `metadata_version=0.3.0`、`publication_status=unpublished-release-candidate`。沿用下方 Commit 53 的同一份消费者与 10 项发布工具检查，不增加案例；不预先构建根库，不运行库测试、全量、参考、性能或浏览器验收。

执行 `moon info && moon fmt`、`bash scripts/check.sh --scope package` 和 `git diff --check`；核对实际归档、仓库外 native／JS 各一次消费者及同 SHA Linux CI。提交后以两个 ZIP 的逐文件路径、大小、内容哈希及最终提交字节一致为冻结条件，各存自己的 ZIP 校验和。完整步骤、版本预检来源和发布授权边界见[0.3.0 候选说明](release-0.3.0.md)。

Commit 53 的开发快照、报告及下文历史数字保持原样；其旧输出目录不是当前 package scope 的目标。正式上传需另行授权，不能用候选验证代替注册表安装验证。

<a id="当前开发源码包审计commit-53unreleased"></a>

## 历史开发源码包审计（Commit 53，Unreleased）

本轮不选择新版本号。模块元数据仍为 **0.2.1**，实际产物是含 Unreleased 内容的开发源码包，报告明确写入 `metadata_version: 0.2.1`、`publication_status: unpublished-development-snapshot`。它不是注册表已发布的 0.2.1，也不是下一版冻结候选；原发布 ZIP、校验和、标签及记录保持原样。

```bash
moon info && moon fmt
bash scripts/check.sh --scope package
git diff --check
```

package scope 只核对固定工具链、格式与接口，运行 `tools/conformance/test_release.py`，再调用一次 `check_release.py --report _build/incremental-package/report.json`。不预先构建根库、不运行库测试或 CLI 示例；构建由打包和外部消费者按需完成。普通 CI 使用同一 package scope，演示、基准、完整工具与全量回归步骤跳过。

审计继续走现有流程：仓库外临时源码快照 → `moon package` → 审计真实 ZIP → 仓库外解压 → `moon.work` 本地解析 → native／JS 各一次消费者运行。实际文件集合、逐文件字节与哈希、重复成员、路径穿越、许可、来源和相对文档链接都检查；根运行库与 `.mbti`、升级说明及验收索引按分发规则入包，截图和工具仍排除。非分发材料使用仓库链接，不改写打包后的文件来掩盖链接缺失。

消费者保留基础检查、六个 `TREE_API_OK` 及整数 `RECTCLIP_API_OK`，增加三个小流程：

| 流程标记 | 实际增量调用 |
| --- | --- |
| `INCREMENTAL_API_OK rectclip` | `rect_clip_lines_d`、`rect_clip_polygons_tree_d` |
| `INCREMENTAL_API_OK batch_stroke_query` | `stroke_polylines_tree_d`、同树 `PolyTreeD::locate_many`、原整数 Boolean 树的 `PolyTree64::locate` |
| `INCREMENTAL_API_OK minkowski_tree` | `minkowski_sum_tree_d` |

每个标记在完整坐标、层级或定位断言完成后输出。各目标分别拒绝缺失、重复、未知增量标记及缺失／重复总体成功标记；报告逐目标保存实际 API 名单、流程状态、日志路径，以及编译后解压库与归档仍一致的核对结果。三个流程是包级导入调用证据，不计作新增库测试，也不宣称覆盖所有新增 API。

产物位于 `_build/incremental-package/`：`moonclip-0.2.1-development-snapshot.zip`、`report.json`、打包日志、两个消费者日志和工具检查日志。Linux CI 保存同目录的工作流附件供双平台对照。文件数、大小和 ZIP SHA-256 按实际结果填写，Windows／Linux 分别记录；两平台比较逐文件路径和内容哈希，不要求 ZIP 时间戳或压缩字节相同。

提交前报告保留基线 SHA 和 dirty 状态。最终提交后以逐文件哈希对应应分发的提交字节，并将完整 SHA、两平台报告和校验和、同 SHA CI 放在 `_build/commit53/delivery.json`，不为填写自身 SHA 再补提交。验证结果归属见[增量验收索引](acceptance-incremental.md#开发源码包外部消费者验证commit-53)。本轮不执行注册表安装、publish、服务端 dry-run、登录、标签、Release 或赛事申报。

## 历史：0.1.0 发布候选检查清单

以下保留 0.1.0 及后续 0.2.0 的原阶段流程和数字，不作为当前开发源码包的新发布结论。

状态：**0.1.0 已于 2026-10-20 正式发布**，注册表消费者与 GitHub Release 已完成，见 [发布记录](release-0.1.0.md)。下文保留候选审计方法和通用发布前检查；正式赛事申报未执行。

## 固定内容与分发

- BigSaltyMan/moonclip，0.1.0，仓库 https://github.com/BigSaltyMan/moonclip；README.md、LICENSE、BSL-1.0 与实际文件一致，首版内容见 [CHANGELOG](../CHANGELOG.md)。
- 工具链保持[固定版本](toolchain.md)，不升级依赖。`.moonignore` 排除测试、参考数据、工具、演示、基准、截图和构建目录；分发运行库全部源码、配置和根公开接口、cmd/example 及文字文档。
- [upstream.md](upstream.md) 独立说明固定来源、完整 SHA、许可证、改写与自有贡献；不分发的开发材料使用仓库链接。

## 实际归档与外部消费者

```bash
python scripts/check_release.py --report _build/release/report.json
```

脚本核对 `moon version --all` 和元数据，在系统临时目录创建完整源码快照，执行固定工具链正式支持的 **moon package**。工具自动检查并生成 `_build/publish/*.zip`；不是自行拼装 ZIP，不调用 moon publish。moon package --list 只辅助查看，验收针对实际归档。

审计逐成员核对精确分发清单、UTF-8 文本、原始字节、许可 / 来源及相对文档链接，拒绝缺失、额外文件、重复成员、符号链接、路径穿越和本机用户 / 检出目录路径。report.json 记录全部文件大小 / SHA256 及 ZIP 大小 / SHA256。不同系统的归档时间戳可能不同，每份产物以自己的报告识别。

在另一个仓库外目录解压真实 ZIP 为 library，复制同一份消费者夹具为 consumer，以 **moon.work** 将两者作为成员。消费者 moon.mod 声明 BigSaltyMan/moonclip@0.1.0，由 workspace 本地解析到解压目录，不引用开发工作区或注册表。native / JS 各运行一次，检查 Boolean、实际孔洞树、Offset、Stroke、小数 Union、显式简化、Minkowski 及公开错误。

ZIP、report.json、package.log、consumer-native.log、consumer-js.log 位于 `_build/release/`。成功日志为 `External candidate consumer native: success` / `js: success`；记录为**候选包外部消费者验证**，不能称为 Mooncakes 安装验证。

构建 / 打包 / 每目标消费者命令限时 180 秒，失败或超时非零退出并保存错误报告。只清理脚本自己创建且已核对的临时目录，不改全局配置、不清空共享缓存。普通 CI 在最终提交的干净检出中运行同一入口，不重建参考、不重复 11 项性能测量。

## 提交后与正式发布边界

提交前运行 moon info、moon fmt、git diff --check，审查根接口。最终完整 SHA、包校验和、消费者状态及同 SHA CI 链接由提交后的交付报告承载，见 [acceptance.md](acceptance.md)。未提交源码的检查保留父 SHA / dirty 标记，交付时以包内逐文件哈希核对最终提交，避免为填写自身 SHA 反复补提交。

发布前检查要求如下；本次已获得明确授权并完成第 1—3 项，公开 Release 也已创建，赛事申报仍未授权：

1. Mooncakes 的版本规则、账号 / 模块名归属及 BigSaltyMan/moonclip@0.1.0 占用情况；准备阶段版本号不构成预留。
2. 候选与拟发布提交一致，许可、元数据和实际归档审计通过。
3. 上传成功后，在干净外部项目从注册表获取指定版本并运行消费者，成功后才能补安装命令及“Mooncakes 安装验证通过”。
4. 公开 Release、申报提交及人员字段分别按授权和事实完成。

[官方版本说明](https://docs.moonbitlang.com/en/stable/toolchain/moon/package-manage-tour.html)描述 SemVer 格式。本次核对账号 BigSaltyMan、模块 / 版本发布前 404、服务端 dry-run 202 接受，随后正式上传 200；未来版本仍须重新核对实时规则与占用。

## 后续树能力版本发布前检查

0.2.0 已于 2026-10-21 完成正式上传、注册表消费者、标签及公开 Release，见[发布记录](release-0.2.0.md)。下列内容保留为该版本发布前的检查流程，不能据此再次上传同一版本；赛事申报未执行。已发布 0.1.0 的记录和上文历史核验保持原样。[升级说明](upgrade-trees.md)区分五个新增库入口与首版已提供的整数 Boolean 树，[增量验收](acceptance-trees.md)保留测试和历史 CI 归属。

- 已确定拟发布版本为 0.2.0，正式上传前仍重新核对 Mooncakes 的实时版本规则、账号／模块归属与版本占用；准备文档不构成版本预留。
- 本笔将元数据、消费者依赖与审计配置同步为 0.2.0，并重新生成准确版本的候选；Commit 24 沿用 0.1.0 元数据的产物只保留为历史候选，不得覆盖已发布版本。
- 执行 `python scripts/check_release.py --report _build/release-0.2.0/report.json`。核对实际归档的精确文件集合、原始字节、大小、SHA-256、许可、来源与相对链接；升级和增量验收两份新文档均应分发。文件数按实际结果记录，不沿用 Commit 23 的 48 文件或 Commit 24 的 50 文件作为固定要求。
- 在真实归档的仓库外解压消费者中，native、JS 各自执行 `boolean_tree`、`boolean_tree_d`、`offset_tree`、`offset_tree_d`、`stroke_tree`、`stroke_tree_d`；六个 `TREE_API_OK` 标记必须各出现一次，且总体成功标记有效。对照各自日志及 `consumers.<target>.tree_apis_checked`，不能用 native 结果代替 JS。
- 核对编译没有修改解压库；逐成员路径和内容哈希对应拟发布提交。Windows、Linux 的 ZIP 各保存自己的大小和校验和，不要求归档时间戳或 ZIP 哈希相同。
- 核对最终 SHA 的现有 Linux CI。库测试仍为两端各 2323，桥接 20，工具在本笔增加 5 项后为 281；保持参考 1384 案例／2276 能力检查，不扩大新入口的上游兼容性声明。浏览器和性能沿用原归属，不推导未测树性能。
- 获得后续明确发布授权后，再执行标签、Mooncakes 上传及 GitHub Release；成功后从注册表在干净外部项目验证对应新版本，才能增加安装与正式发布结论。正式申报及人员字段另按授权完成。

最终 SHA、实际归档清单、两平台各自 ZIP 校验和、六入口结果及 CI 链接放在提交后的交付记录中。提交前报告保留父 SHA / dirty 状态，再以文件哈希对应最终源码，避免为填写自身 SHA 反复补提交。
