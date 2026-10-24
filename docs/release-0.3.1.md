# MoonClip 0.3.1 正式发布记录

**0.3.1 已于 2026-10-24 正式发布。** 它修正随包 README、专题文档及公开 API 注释；运行库执行代码、公开接口、默认值、精度、错误、预算、依赖和固定工具链与 0.3.0 保持一致。

## 发布源码与上传

- 发布源码：`adad8bb47be1a136c59247d491d6607919253c83`；[v0.3.1 标签](https://github.com/BigSaltyMan/moonclip/tree/v0.3.1)精确指向该 SHA。
- 0.3.0 运行库基线：`d21baf6687b5d890392f87574aac48f22cd3d5f0`；17 行公开注释改为 since 0.3.0，非文档行与根接口逐字节核对未变。
- Mooncakes：[BigSaltyMan/moonclip@0.3.1](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.3.1/)，未撤回；服务端创建时间 `2026-10-24T15:50:48.883101+00:00`（北京时间 2026-10-24 23:50:48）。
- 实际使用 **Windows 冻结候选**，61 文件、292345 字节，SHA-256 `358e746892f9ae5e661e34f101e7046e04c5bbb6a9c721e3195a93a99a4e8fc4`。固定命令不支持指定 ZIP 上传；仓库外从冻结提交准备干净源码，重新打包及实际上传 ZIP 均与该候选完全一致。
- Linux 历史候选同为 61 文件、292345 字节，SHA-256 `f421a8d4a018e118a9a14acdbf8d20f41dff9bef4bb4ae7d5b95e7f21cb45b30`；成员路径与内容相同，该 ZIP 未用于本次上传。
- 正式 `moon publish` 一次请求成功，服务端 checksum 与 Windows ZIP 一致；没有改版本、覆盖旧包或重新登录。

```bash
moon add BigSaltyMan/moonclip@0.3.1
```

## 注册表消费者

在仓库外新建消费者，从冻结提交读取现有消费者夹具，声明精确 0.3.1，再运行 moon add 与 moon tree --json。依赖来源为 registry、不是 workspace 成员；没有 moon.work、本地路径依赖或候选库复制，没有清空共享缓存、修改全局配置。

| 目标 | 实际执行 | 标记及结果 |
| --- | --- | --- |
| Windows native | 一次消费者运行 | 基础检查、六个旧树入口、整数窗口及三个增量流程全部通过 |
| JS | 一次消费者运行 | 独立核对相同标记和完整断言，全部通过 |

三个增量流程实际调用 rect_clip_lines_d、rect_clip_polygons_tree_d、stroke_polylines_tree_d、PolyTreeD::locate_many、PolyTree64::locate、minkowski_sum_tree_d。不是全部 API 参数矩阵。实际下载的 61 个文件，其路径、大小、SHA-256 和字节均对应冻结候选及发布源码；编译后受审计文件不变。

## 文档页与原始 Markdown 外链

主文档页已生成，实际显示 **0.3.1 (latest)**、README 的 `moon add BigSaltyMan/moonclip@0.3.1`、文档修正版介绍，以及整数／小数定位、窗口树、批量树、扫掠树接口和 since-0.3.0 注释。当前 README 没有旧的“尚未发布／当前源码候选”文案；历史候选和验收章节仍保留原阶段事实。

用户报告 README 蓝链打开原始 Markdown 后中文乱码，GitHub 正常。抽查 polytree-query.md、rectclip.md、minkowski.md：Mooncakes 静态源站返回 **Content-Type: text/markdown，没有 charset**；三份字节与冻结 ZIP 完全一致，严格 UTF-8 解码成功。浏览器编码猜测与该现象相符；内置浏览器直接打开原始 .md 被客户端阻止，未冒充已完成该页浏览器渲染核验。响应头、内容哈希与主文档页证据保存在交付目录。

可直接使用 [v0.3.1 GitHub 专题文档](https://github.com/BigSaltyMan/moonclip/tree/v0.3.1/docs)阅读。此静态源站编码声明限制已记录在 Release 说明；未修改、覆盖或再次上传已发布 0.3.1。

## GitHub 与证据归属

[GitHub Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.3.1)附件为实际发布 ZIP、SHA256SUMS.txt、无凭据和本机路径的 acceptance-summary.json；三个附件均重新下载逐字节核验。原 0.3.0 和更早包、标签、校验和、发布记录保持原样。

沿用[发布源码 package CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40108249728)，它证明原候选范围：Windows／Linux 发布工具各 10/10、两目标候选消费者和逐文件交付一致性，不能写成该 SHA 全量回归。正式发布没有重跑候选消费者、库测试、全部工具测试、参考、性能或演示浏览器验收；新增和执行库测试均为 0，2406 只为完整入口配置期望。历史功能证据见[增量验收索引](acceptance-incremental.md)。

本文件是独立的发布状态更新；该提交只运行 docs scope，本地链接及差异检查不执行几何构建。状态文档 SHA、同 SHA docs CI、实际包完整清单、各阶段结果与限制放入 `_build/release-0.3.1/publication-final-delivery.json`。发布标签保持冻结 SHA，不移动到状态提交。本次未执行赛事申报。
