# MoonClip 0.2.1 文档修正版发布记录

**0.2.1 已于 2026-10-21 正式发布。** 本版本修正 Mooncakes 页面中“0.2.0 尚未正式发布”和“仅开发源码可用”的过时说明，更新安装命令，并整理小数、组合、演示及来源文档。运行库源码和公开接口与 0.2.0 逐字节一致。

## 发布对象

| 项目 | 已核验事实 |
| --- | --- |
| 发布源码 | `02a6043692c966b3687996f9eb5197470712aca0` |
| 注册表 | [BigSaltyMan/moonclip@0.2.1](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.2.1/)；yanked=false |
| 注册表创建时间 | 2026-10-21 12:47:48.561168 UTC，即北京时间 20:47:48 |
| 标签 | v0.2.1 精确指向上述发布源码 |
| GitHub Release | [v0.2.1](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.2.1)，2026-10-21 12:51:58 UTC 公开 |
| 实际归档 | 51 个文件，217133 字节 |
| ZIP SHA-256 | `bfc155c3300921f42454fda0c3abf2f869c000afff7cda5967ba90ff979d8e0b` |

注册表服务端校验和与冻结归档一致。正式上传仅执行一次，退出 0。GitHub Release 的 [ZIP](https://github.com/BigSaltyMan/moonclip/releases/download/v0.2.1/moonclip-0.2.1.zip)、[SHA256SUMS.txt](https://github.com/BigSaltyMan/moonclip/releases/download/v0.2.1/SHA256SUMS.txt)及[验收摘要](https://github.com/BigSaltyMan/moonclip/releases/download/v0.2.1/publication-delivery.json)均已重新下载并逐字节核对。

```bash
moon add BigSaltyMan/moonclip@0.2.1
```

## 独立安装与页面核验

仓库外新建消费者，不使用 moon.work、本地路径依赖或候选库副本。依赖树确认 source.kind=registry、workspace_member=false；实际下载的 51 个文件集合及哈希与冻结候选一致。native、JS 分别执行成功，各有 boolean_tree、boolean_tree_d、offset_tree、offset_tree_d、stroke_tree、stroke_tree_d 六个唯一成功标记。

Mooncakes 实际渲染页面已检查：版本选择器显示 0.2.1 (latest)，安装命令为 0.2.1，树章节明确写明“0.2.0 正式发布”；页面不再含“尚未正式发布”。截图留存于本地 `_build/release-0.2.1/mooncakes-readme-verified.jpg`。

旧固定版本 0.2.0 的包内 README 是当时错误文案的历史快照，本次不覆盖旧包或移动 v0.2.0。查看最新说明应使用上方 0.2.1 页面。

## 验证范围与交付记录

本次执行归档审计、两个目标的候选消费者、5 项发布工具定向检查，以及发布后的两个目标注册表消费者。完整库测试沿用 [0.2.0 的 CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39451040373)，其源码归属为 `e0ef766b34562bcad2b3f3e0d50002adf7b05912`，不能记作本补丁 SHA 的新全量执行。没有重建参考、重测性能或重复演示验收。

本文件和发布后的 README 状态更新属于后续纯文档提交，使用 [skip ci]；发布源码、标签和注册表包始终对应 `02a6043692c966b3687996f9eb5197470712aca0`，不为状态文案再次上传相同版本。

本地 `_build/release-0.2.1/` 保存原候选 report、上传日志与收据、注册表依赖树和消费者日志、Release 与附件核对、页面截图及 `publication-final-delivery.json`。原规划书、申报书和已有无关改动不在本次提交范围。
