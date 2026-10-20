# MoonClip 0.1.0 正式发布记录

2026-10-20 在明确授权后完成 Mooncakes 发布、注册表消费者验证及 GitHub Release。没有执行正式赛事申报。

## 不可变发布身份

| 项目 | 实际结果 |
| --- | --- |
| 模块 / 版本 | BigSaltyMan/moonclip@0.1.0 |
| 源码完整 SHA | `10a9a1012d5fb07a333936ea83ce22e1f98a03d5` |
| GitHub 标签 / Release | [v0.1.0](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.1.0)，直接指向上述候选提交 |
| 正式上传时间 | 2026-10-20T03:16:00.479614+00:00（服务端记录） |
| 包内容 | 46 个文件，185230 字节，运行库、接口、示例、文字文档、许可证与来源 |
| SHA-256 | `880564497fa034450b327c608b7457529bf0cab988ec9d20699d3425f9d4d142` |
| 发布响应 | moon publish 退出 0，服务端 200 OK；注册表元数据 checksum 与候选一致 |
| 正式包下载 | [moonclip-0.1.0.zip](https://github.com/BigSaltyMan/moonclip/releases/download/v0.1.0/moonclip-0.1.0.zip)、[SHA256SUMS](https://github.com/BigSaltyMan/moonclip/releases/download/v0.1.0/SHA256SUMS.txt) |
| 验收摘要 | [registry-verification.json](https://github.com/BigSaltyMan/moonclip/releases/download/v0.1.0/registry-verification.json) |

发布使用仓库外的实际归档，全部成员与授权候选逐字节一致；没有调整版本、运行代码、依赖或工具链。该标签与注册表包保留候选原始文档快照，其中“待发布”文字描述准备阶段；本次主分支的状态更新与此记录说明正式发布结果，不覆盖既有包或移动标签。

## 发布前规则、权限与占用

核对[官方版本与发布说明](https://docs.moonbitlang.com/en/stable/toolchain/moon/package-manage-tour.html)，保持 SemVer 0.1.0。Mooncakes 登录账号 BigSaltyMan，与模块命名空间一致；发布前精确版本及模块查询均返回 404，GitHub 对应标签 / Release 尚不存在。GitHub 登录账号为 BigSaltyMan，具备公共仓库写权限。

服务端 dry-run 返回 202 Accepted，明确说明成功且未做更改；固定 CLI 却以非零退出报告失败，该差异已保留日志，不作为版本占用或代码缺陷。再次查询仍为 404 后执行一次正式 moon publish，返回 200；随后从实时注册表查询确认 0.1.0 未撤回，checksum 正确。没有忽略真正的上传错误或重试覆盖已有版本。

## 真正的注册表消费者

在系统临时目录创建新的消费者项目，没有 moon.work 覆盖；依赖声明为 BigSaltyMan/moonclip@0.1.0。实际执行 `moon add BigSaltyMan/moonclip@0.1.0`、`moon run --target native .` 和 `moon run --target js .`。

| 目标 | 实际结果 |
| --- | --- |
| Windows native | 成功，公开 Boolean、实际孔洞树、Offset、Stroke、小数 Union、Simplify、Minkowski 和错误捕获均完成 |
| Windows JS | 同一份消费者成功，执行相同断言 |
| 依赖来源 | moon tree --json 明确为 source.kind=registry、workspace_member=false |
| 下载内容 | .mooncakes 下 46 个文件的哈希全部与发布候选一致，服务端归档 checksum 同值 |

这是 **Mooncakes 安装验证通过**，区别于 Commit 19 从本地 ZIP 解压得到的候选消费者。此次没有新增 Linux 注册表安装声明；Linux 证据沿用既有候选 CI。

## 复用的正确性与其他证据

沿用[发布源码的完整 Linux CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39362260673)：native / JS 各 2234/2234、离线工具 276、桥接 7/7、基准运行器 4/4、单个基准入口和候选包消费者通过。1384 个参考案例、2276 项能力检查仍分别计数，见 [compatibility.md](compatibility.md)。

GitHub 创建标签自动触发了[额外工作流](https://github.com/BigSaltyMan/moonclip/actions/runs/39363708304)，已在检查步骤中取消；它不是新完成的全量验收，不替代原 CI。没有重建参考、重复 11 项性能测量或重新做浏览器验收。状态说明提交使用 skip ci，不改工作流配置。

性能继续引用 [Commit 18 原环境与源码哈希](benchmarks.md)，演示引用 [Commit 17 记录](demo-acceptance.md)。来源及数值边界见 [upstream.md](upstream.md)、[scope.md](scope.md)，既有代码与证据保持不变。

## 交付记录与后续范围

本地 `_build/release/` 保存 publish-preflight.json、mooncakes-publish.log、mooncakes-published-view.json、registry-dependency-tree.json、registry-consumer-report.json、github-release.json 及最终 publication-delivery.json。前一笔 report.json / delivery.json 保留原始候选状态，不改写历史。公开 Release 附件提供不含本机路径的验收摘要及实际包。

后续版本须重新检查版本占用和规则；本次不自动加版本、不修改已发布包。正式赛事申报及人员字段仍待后续明确授权。
