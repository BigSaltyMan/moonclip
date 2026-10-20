# MoonClip 0.1.0 候选验收证据

状态：**发布候选与材料准备；待发布**。没有 Mooncakes 上传、注册表安装、公开 Release 或正式申报完成的声明。

## 版本、归档与消费者

| 项目 | 证据与归属 |
| --- | --- |
| 候选模块 / 版本 | BigSaltyMan/moonclip / 0.1.0；元数据及 [CHANGELOG](../CHANGELOG.md) |
| 源码完整 SHA | 提交后的交付记录，以及 `_build/release/report.json` 的 source 字段；dirty=true 时该 SHA 是父提交，不能冒充最终提交 |
| 实际候选包 | 实际审计通过，46 个文字 / 源码文件；`_build/release/moonclip-0.1.0.zip`，archive 字段保存完整清单、每文件大小 / SHA256、ZIP 大小 / SHA256 |
| Windows 消费者 | **native 通过、JS 通过**；同一份夹具对真实 ZIP 解压内容执行，实际状态和标记见 consumers 字段及两份 consumer 日志 |
| Linux 干净检出 | 提交后的交付记录给出最终同 SHA geometry 工作流链接；运行同一候选脚本，日志另记 Linux 归档、native / JS 消费者结果 |
| 发布状态 | unpublished_candidate；未执行注册表安装验收 |

操作入口及审计规则见 [release-checklist.md](release-checklist.md)。本地报告与 ZIP 是交付产物，不提交重复日志。交付时将归档逐文件哈希与最终提交核对；完整 SHA、包校验和、消费者结果、CI 链接由提交后报告承载，不为本文件自身 SHA 循环补提交。不同系统 ZIP 哈希可不同，必须连同文件清单和来源分别记录。

## 正确性与计数

沿用同一批 **2234 项库测试**，native / JS 分别执行，不能相加为 4468 个独立用例。**1384 个参考案例**对应 **2276 项所选能力检查**：同一输入的平铺、树、中间与最终结果可以是多项能力，案例仍只计一次。[compatibility.md](compatibility.md)维护矩阵与实际结果。

已核验的历史基线：[Commit 18 6a116b45600cbe8ecd577664a71b50fdfa8ce5c0 的 Linux CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39359515706)，native / JS 各 2234/2234、离线工具 276 项、桥接 7 项、基准运行器 4 项和单个基准入口通过。本笔最终提交结果以交付记录中新 CI 为准，不能用前一笔代替。

外部消费者是发布验收程序，不计入库测试或参考案例；工具、桥接冒烟、运行器检查和性能 11 案例分别记录。Windows 本地本笔只打包与运行两端消费者，没有重复库全量、参考重建、性能测量或浏览器验收。

## 既有证据

| 材料 | 实际来源与范围 |
| --- | --- |
| 演示 | 从仓库 `cd demo`、`npm run dev`，打开 http://127.0.0.1:4173；[使用说明](demo.md)与[Commit 17 浏览器验收](demo-acceptance.md)，2026-10-19 Windows Edge；本笔未重做 |
| 性能 | [benchmarks.md](benchmarks.md)，2026-10-20 Windows / Ryzen 9 8940HX / MSVC 14.44 / native release，2 预热、5 样本、11 案例；内存未测，无跨库比较 |
| 性能源码 | Commit 18 测量时 HEAD 为 `19d192b4e81e3162decf4d658a92d6b20b286719`、dirty=true；基线保留源码哈希与配置。本笔不改写为最终提交重新测量 |
| 固定来源 | Clipper2 2.0.1 / Clipper2_2.0.1 / `21ebba05db8894f0c7217ad35ea518080f324946`，BSL-1.0；[LICENSE](../LICENSE)、[来源表](upstream.md) |
| 参考重建 | 沿用既有固定 C++ 及各阶段真实重建证据；本笔没有重建 1384 条参考，[参考记录](reference-cases.md)和兼容报告 |
| 范围与成果 | [scope.md](scope.md)、[related-work.md](related-work.md)、[submission.md](submission.md) |

正式发布、注册表消费者、公开 Release、申报与人员信息均为后续独立步骤，当前不标为完成。
