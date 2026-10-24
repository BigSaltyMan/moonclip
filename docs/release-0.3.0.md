# MoonClip 0.3.0 正式发布记录

**0.3.0 已于 2026-10-24 正式发布。** 发布源码与标签固定为 `d21baf6687b5d890392f87574aac48f22cd3d5f0`；本文件属于随后单独提交的发布状态记录，不能冒充包内源码。

## 正式发布结果

| 项目 | 实际结果 |
| --- | --- |
| Mooncakes | [BigSaltyMan/moonclip@0.3.0](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.3.0/)，未撤回；服务端校验和与实际上传 ZIP 一致 |
| 上传时间 | 2026-10-24 15:19:48 UTC（北京时间 23:19:48）；固定工具链 `moon publish` 一次正式请求成功 |
| GitHub 标签 | [v0.3.0](https://github.com/BigSaltyMan/moonclip/tree/v0.3.0)，精确指向上述冻结源码，不随状态提交移动 |
| GitHub Release | [MoonClip 0.3.0](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.3.0)，ZIP、SHA256SUMS.txt、去敏验收摘要三个附件均重新下载逐字节核验 |
| 发布源码 CI | [package CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40088821022)，同 SHA；不代表该 SHA 全量回归 |
| registry 消费者 | Windows native 一次成功、JS 一次成功；两个目标分别核对标记及三个增量流程 |
| 下载内容 | 精确版本来源为 registry；61 个文件的路径、大小、SHA-256 和字节与冻结候选及 Git 源码一致；编译后未改变 |
| 文档页 | build_status=success；实际页面的 0.3.0、README、新窗口/批量/扫掠接口及两种树定位方法可见；文字快照限制见下文 |

```bash
moon add BigSaltyMan/moonclip@0.3.0
```

### 实际上传归档

选用 **Windows 冻结候选**。固定工具链不支持指定归档上传，因此从冻结提交在仓库外准备干净源码，执行 `moon package` 核对后正式 `moon publish`。重打包和实际上传 ZIP 与原 Windows 候选完全相同：

- 61 个文件，288641 字节。
- SHA-256：`31d0e426617f7e6286bac80ddde099ccfa14c71b423c7122e8a24fa8b9de8d71`。
- 历史 Linux 候选同为 61 文件、288641 字节，SHA-256 `e126af3ec06e9673f33d2cf7d771d36cfcdba8e24b76815a0e53bd5f5c514077`；包内路径与内容相同，该 ZIP 未用于本次上传。
- 注册表 manifest 的 checksum 与 Windows ZIP 相同，版本未撤回。上传成功、registry 验证成功及 GitHub Release 成功分别留有回执。

### 独立注册表验证与证据归属

仓库外全新消费者声明精确的 0.3.0，执行 `moon add` 和 `moon tree --json`，没有 moon.work、本地路径替换、候选库复制、共享缓存清空或全局配置修改。复用冻结的现有消费者，native／JS 各运行一次：基础检查、六个旧树标记、整数窗口标记及以下三个流程全部通过。

| 增量流程 | 实际公开调用 |
| --- | --- |
| 窗口 | rect_clip_lines_d、rect_clip_polygons_tree_d |
| 批量描边与查询 | stroke_polylines_tree_d、PolyTreeD::locate_many、PolyTree64::locate |
| 小数扫掠树 | minkowski_sum_tree_d |

它们是代表性包级分发、导入和执行证据，不是全部接口组合矩阵。原 package CI、10 项发布工具、候选消费者和各次定向测试保留原提交归属。本次没有重跑候选消费者、库测试、全量、参考、性能或演示浏览器验收；2406 仍仅为完整入口配置期望。

### 文档快照与状态提交

注册表文档由冻结包生成：版本与新增接口可见，**README、专题及 API 注释仍含候选阶段“待发布／Unreleased”文字和旧安装示例**，已在实际页面核验并如实记录。它们不是尚未上传的依据。为保持用户授权的冻结内容，未修改包、重复发布或移动标签；仓库 README、CHANGELOG 和当前说明在本次独立状态文档提交中更新。未来包的文字整理另行安排。

状态提交只执行 `docs` scope 的本地链接和 `git diff --check`，CI 跳过 MoonBit 安装、core bundle、几何和演示构建。完整状态提交 SHA、同 SHA docs CI、逐文件清单、两目标日志及所有核验结果保存于 `_build/release-0.3.0/publication-final-delivery.json`；Release 附件 `acceptance-summary.json` 提供无本机路径的发布验收摘要。

小数定位仍使用原建树 Precision；批量描边统一样式和合并；Minkowski 为单图案、单路线且保留共线点；查询没有空间索引；简化不保证拓扑保持。详细契约见[升级说明](upgrade-incremental.md)。本次未执行赛事申报。

## 候选准备与冻结记录（Commit 54 历史）

以下段落保留候选阶段的规则查询、验证范围及当时尚未授权上传的事实；它们的时态仅属于 Commit 54，不表示当前发布状态。

**0.3.0 尚未正式发布。** 本笔将已完成增量包级验收的能力归入功能版本，重新生成版本准确的候选。注册表当前可安装版本仍为 0.2.1；候选通过及冻结不等于上传、注册表安装验证或赛事申报。

## 候选范围

以 Commit 53（`85c5815497652507678ce8c178d7c76d81ef5111`）为基线，不增加算法、公开接口或消费者案例：

- 整数／小数开放折线窗口裁剪，保留有效片段的顺序、方向和普通共线中间点。
- 整数／小数闭合区域窗口裁剪及孔洞树，层级来自最终求交区域。
- 整数／小数多路线批量描边及孔洞树，整批统一样式、统一合并，输出不与输入逐条对应。
- 小数 Minkowski Sum 及整数／小数树输出，仍为单图案、单路线，保留共线点，不额外填满闭合路线内部。
- 整数／小数树单点及批量定位；小数查询使用原建树 Precision，查询仍线性访问轮廓顶点，没有空间索引。
- 对应交互演示、可重放导出、升级说明、增量定向证据及包级消费者验证。

使用迁移见[升级说明](upgrade-incremental.md)，完整契约见[支持范围](scope.md)及相应专题；显式简化仍不保证拓扑保持。旧定向、浏览器、参考与性能证据按[验收索引](acceptance-incremental.md)保留原提交归属，不转记为本候选重新执行。

## 发布规则与版本占用预检

查询时间为 **2026-10-24 11:02 UTC**（北京时间 19:02），在版本修改之前完成：

| 来源 | 实际查询结果 |
| --- | --- |
| [MoonBit 官方发布规则](https://docs.moonbitlang.com/en/stable/toolchain/moon/package-manage-tour.html#semantic-versioning-convention) | HTTP 200；版本遵循 MAJOR.MINOR.PATCH，兼容功能增加递增 MINOR；不发布时可以跳过账号设置 |
| [Mooncakes 0.3.0 manifest](https://mooncakes.io/api/v0/manifest/BigSaltyMan/moonclip@0.3.0) | 11:02:04 UTC，HTTP 404，响应 `Package not found` |
| [Mooncakes 0.2.1 对照 manifest](https://mooncakes.io/api/v0/manifest/BigSaltyMan/moonclip@0.2.1) | 同时 HTTP 200，latest_version 为 0.2.1，版本列表为 0.2.1、0.2.0、0.1.0 |
| [GitHub v0.3.0 标签查询](https://api.github.com/repos/BigSaltyMan/moonclip/git/matching-refs/tags/v0.3.0) | 11:02:28 UTC，通过现有 GitHub 连接器成功查询，匹配列表为空 |
| [GitHub Release 列表](https://api.github.com/repos/BigSaltyMan/moonclip/releases?per_page=100) | 同次成功查询仅有 v0.2.1、v0.2.0、v0.1.0，无 v0.3.0 或 0.3.0 |

GitHub 的直接公开 HTTP 请求曾返回 403 限流，该失败保留在原始记录，未被解释为版本未占用；随后由现有连接器成功核对，没有重新登录。原始响应、时间、来源及官方规则页面哈希保存在 `_build/commit54/version-preflight.json`。

查询只说明当时未发现目标版本、标签或 Release，不构成版本预留。正式上传前必须重新核对占用和权限；如已占用则停止，不自动换版本或覆盖发布。

## 固定环境与准确版本归档

工具链保持 [固定版本](toolchain.md)：moon／moonrun `0.1.20260915 (2e1a46d 2026-09-15)`，moonc `v0.10.13+cbb11c36f`；Linux 沿用原 Action SHA、工具链和 core 归档校验和，不升级依赖。

根 `moon.mod` 与外部消费者库依赖同步为 0.3.0，消费者自身版本仍为 0.0.0。审计报告必须写入：

```yaml
metadata_version: 0.3.0
publication_status: unpublished-release-candidate
```

候选从版本正确的源码重新执行 `moon package`，不是将 Commit 53 的 ZIP 改名。开发快照 `_build/incremental-package/` 及其报告、校验和保持原样。

## 本地与同 SHA CI 的验证范围

```bash
moon info && moon fmt
bash scripts/check.sh --scope package
git diff --check
```

package scope 只执行固定工具链、格式和接口差异核对、既有发布工具测试文件，以及一次真实打包和两个外部消费者。沿用原有 10 项工具检查结构，不增加测试矩阵，实际通过数量以日志为准。打包及消费者内部按需编译，不额外运行根库构建、静态检查、CLI 示例或其他 scope。

现有流程保持：独立临时源码快照 → moon package → 真实 ZIP 审计 → 仓库外解压 → moon.work 本地解析 → native、JS 各一次消费者运行。基础检查、六个旧树和整数窗口标记，以及窗口、小数批量树查询、小数 Minkowski 树三个增量流程均保留。

审计检查实际成员集合与逐文件原始字节、根接口、许可、来源和文档链接；拒绝重复成员、路径穿越、额外产物及无关工作区文件。新发布说明按既有文字文档分发规则入包。消费者明确声明 0.3.0，依赖解压候选而非开发目录或注册表；各目标分别核对标记，编译后受审计库文件必须不变。

**新增库测试 0 项、执行库测试 0 项。** 不运行全量或全部工具测试，不重建参考、不测性能、不重新验收浏览器、不构建演示。2406 仍只是完整检查入口的配置期望，不能写成候选提交全量通过。候选消费者不是 0.3.0 的注册表安装验证。

## 产物与冻结规则

主交付目录为 `_build/release-0.3.0/`：`moonclip-0.3.0.zip`、`report.json`、提交后 `delivery.json`、`release-notes.md` 和 `SHA256SUMS`；另保留打包、工具及消费者日志。Linux 同 SHA package CI 保存对应附件，下载后的报告与 ZIP 单独放在该目录的 `linux/`，不覆盖 Windows 原件。

文件数、大小和 ZIP SHA-256 根据本次实际产物记录。Windows、Linux 比较逐文件路径、大小和内容哈希，并将真实归档内的文件字节与最终候选提交对应；不要求 ZIP 时间戳、压缩字节或 ZIP 哈希相同。

提交前报告保留基线 SHA／dirty 状态。完整候选源码 SHA、两平台校验和与清单、消费者及工具结果、同 SHA CI 和冻结结论放在提交后 delivery.json，不为填写自身 SHA 再补提交。冻结后若分发内容改变，原候选失效，必须重新打包验证并记录，不能继续沿用旧校验和。

## 正式发布的后续授权边界

本笔不执行 Mooncakes 上传、服务端 dry-run、账号登录、远端标签、GitHub Release 或赛事申报。候选冻结后，正式上传须对具体 SHA 和归档另行取得明确授权。

授权后先重新确认官方规则、账号／模块和仓库写权限、0.3.0 占用及标签／Release 状态，再核对冻结源码与归档一致。仅在这些条件满足时上传，随后使用独立 registry 消费者验证 native／JS，再创建精确指向候选 SHA 的 v0.3.0 和 Release。版本占用、归档不一致或需要修改候选源码时先停止报告，不自动覆盖、换版本或移动标签。
