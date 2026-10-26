# 当前源码完整回归与工程验收

日期：2026-10-26。Windows 本地执行的功能源码为 `f5bce22e353368ce2b0dd17753976b9720c7a480`，工作区仅含本次验收配置与文档调整，以及保留的规划书、申报书和 `.vscode/` 无关改动。根运行库、库测试、接口、版本、依赖、参考及消费者案例未改；0.4.0 候选准备暂停，没有新功能或发布。

最终验收提交 SHA、Linux 同 SHA CI、附件 ID／摘要及各日志哈希保存在提交后的 `_build/full-acceptance/delivery.json`。这里不预填尚未执行的 Linux 结果，也不为填写自身 SHA 另作提交。

## Windows 实际结果

固定工具链为 moon 0.1.20260915 (2e1a46d)、moonc v0.10.13+cbb11c36f、moonrun 0.1.20260915 (2e1a46d)。通过 Visual Studio native 编译环境调用 Git Bash；Python 3.12.14，Node.js 24.18.0。实际执行 `moon info && moon fmt`，根 `.mbti` 与源码未出现意外差异。

| 检查 | 实际执行结果 | 证据 |
| --- | --- | --- |
| native 完整库回归 | 2427/2427，失败 0 | `full.log`、`conformance/all-native.log` |
| JS 完整库回归 | 2427/2427，失败 0 | `full.log`、`conformance/all-js.log` |
| native 构建与 CLI 示例 | 成功 | `full.log` |
| conformance 工具全集 | 294 项，OK | `full.log` |
| 锁定参考完整性与生成文件 | 9 份清单严格检查及生成文件 --check 全部成功，无 expected 改动 | `full.log` |
| MoonClip 实际参考比较 | 所有目录 differences=0、execution_errors=0；兼容报告无差异 | `conformance/report.json`、`docs/compatibility.md` |
| 文档本地链接 | 20 份文档、177 个本地文件／图片目标存在 | `docs.log` |
| 演示构建 | 一次成功 | `demo-build.log` |
| 全部桥接／导出检查 | 31/31，失败 0、跳过 0，复用上述产物 | `demo-tests.log` |
| 基准工具 | 4 项，OK | `bench-tools.log` |
| 极小基准入口冒烟 | boolean_1，成功；1 warmup／1 sample／batch 1 | `bench-smoke.json`、`bench.log` |
| 实际源码包 | moon package、ZIP 成员审计、独立解压均成功 | `package/report.json`、`package/package.log` |
| 外部消费者 native | 一次真实运行成功，编译未改变解压库的受审计文件 | `package/consumer-native.log` |
| 外部消费者 JS | 一次真实运行成功，编译未改变解压库的受审计文件 | `package/consumer-js.log` |

日志位于 `_build/full-acceptance/`，完整入口未在外面追加第二轮库测试或旧 scope。native 与 JS 各自为 2427，不相加为独立用例总数；配置期望 2427 现在由上述实际日志确认。新增库测试 0 项。294 项工具测试包含现有 10 项发布工具检查；本笔只在原报告字段用例中增加源码快照状态断言，没有新增测试块。

## 报告筛选与参考口径

完整入口为报告重跑的筛选是同一套库测试的子集，不再次计入 2427：两个目标均分别执行矩形开放裁剪 47、开放描边树 29、偏移树 27、小数树 33、Minkowski 参考 144、简化参考 224、小数参考 220、组合参考 24、Boolean 公共路径 152、Stroke 参考 276、Offset 参考 272、内部路径 48、公共树 152、内部树 48，全部通过。

参考目录保持 **1416 个案例、2308 项能力检查**，分别统计。实际报告中 Boolean 公共 paths/tree 各 152；内部 paths/tree 两目标各 48；Offset 272、Stroke 276、Composition 24（中间与最终各一次）、Decimal 220（网格与解码）、Simplify 224（有序结果、删除数量与退化报告）、Minkowski 144、锁定随机 24、矩形开放裁剪 32，均无差异及执行错误。一个案例可有多项能力检查，不等同于新增独立案例。

本次只验证已提交清单、哈希、生成文件和 MoonClip 对锁定 expected 的执行比较，未下载／编译 C++，未生成或替换上游 expected，未扩大随机或兼容矩阵。这些旧参考不构成全部增量接口的逐项上游兼容性证明。`docs/compatibility.md` 未发生变化。

## 工程与源码包边界

文档脚本只检查常规本地 Markdown／图片路径，忽略片段后检查目标；不验证标题锚点或外网链接。本文补记结果没有引入新的链接目标。演示只构建一次并执行全部 31 项桥接／导出检查，没有手动重做浏览器验收；历史浏览器截图及临时容器异常的原归属不变。

基准只验证入口可运行，不是 11 项性能基线重测，不设性能阈值，不将一个样本用作性能结论；未测内存。原性能记录保持原提交归属。

包审计仍复用正式 moon package、仓库外源码快照及独立解压，通过 moon.work 本地依赖运行原有消费者。现有消费者保留原检查、六个树入口、整数窗口，以及 rectclip、batch_stroke_query、minkowski_tree 三个增量流程；没有新增八接口消费者矩阵，也没有从注册表安装本轮源码。

本次显式传入 `--publication-status unpublished-source-test-snapshot`，metadata_version 仍是 **0.3.2**。这是含后续源码的测试归档，不是重新发布的 0.3.2，不是冻结的新候选。原候选默认行为保持不变；旧成功标记中的 candidate 字样沿用夹具，不决定本次报告状态。

Windows 测试包为 **67 文件、331097 字节**，SHA-256 为 `e1887ac3da8a8d95b6d25fea8176174066ba284396b828ae0a07edaf0709651c`。它来自上述功能基线及当时的验收工作区快照，包内本文为结果补记前的文档；原字节另存 `package/packaged-full-acceptance.md`。该测试包不充当最终提交的候选冻结清单。运行库／接口与本笔最终提交一致；Linux 包由最终提交重新检查，其实际清单、大小与哈希单列在交付记录，不假定两份测试包文档或 ZIP 字节相同。

## 问题、调整与 Linux 验收

本次 Windows 执行没有失败测试或实际几何差异，没有核心修复、费用数字调整、放宽比较、删除案例或接口更改。必要工程调整仅为：包审计增加可选源码快照状态（保留候选默认值）；文档检查纳入本文；普通 CI 切到 full，记录每项日志并保存附件，超时预算改为 45 分钟。固定 Action SHA、工具链及只读仓库权限保持不变。

Linux 复用同一工作流和 full 入口，独立执行两目标完整回归、工具全集和参考比较，再做文档、一次演示构建及完整桥接、基准工具及极小冒烟、源码包审计和两目标消费者。附件 `full-acceptance-linux` 保存 `_build/full-acceptance/` 与 `_build/conformance/`。最终结果以同 SHA CI 的实际日志和提交后 delivery.json 为准，不能沿用轻量 CI。

本轮完成后停在完整验收，不继续 0.4.0 候选准备，不上传、不建标签或 Release，不执行赛事申报。旧包、校验和、标签和无关工作区改动保留。
