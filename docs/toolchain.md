# 固定工具链与验证记录

本地实际工具链（Windows，2026-10-16）：

```text
moon 0.1.20260915 (2e1a46d 2026-09-15) ~\.moon\bin\moon.exe
moonc v0.10.13+cbb11c36f (2026-09-15) ~\.moon\bin\moonc.exe
moonrun 0.1.20260915 (2e1a46d 2026-09-15) ~\.moon\bin\moonrun.exe

Feature flags enabled: rr_moon_mod,rr_moon_pkg
```

官方归档版本参数为 `0.10.13+cbb11c36f`。Linux CI 固定同版本的二进制与 core 归档及其 SHA256，下载地址和校验值见 `.github/workflows/ci.yml`，不执行滚动的远程安装脚本。安装流程按官方 https://cli.moonbitlang.com/install/unix.sh 的归档布局与 core bundle 步骤编写。

Windows 通过 Git Bash 运行 `bash scripts/check.sh`（本机 Git Bash 位于 `C:/Program Files/Git/bin/bash.exe`；`C:/Windows/System32/bash.exe` 是其他入口）。原生构建使用本机可用的 MSVC 工具链；Linux CI 使用 Ubuntu 24.04 的原生构建环境。脚本核对 moon、moonc、moonrun 的版本、提交和日期，并打印完整版本用于日志对齐。

## Commit 1 本地结果

2026-10-16 已实际通过：native `check --deny-warn`、`test`、`build` 与示例。测试总数 **18**，通过 **18**，失败 **0**，全部是通过公开接口验证的黑盒测试。示例输出 `MoonClip data model OK`。Git Bash 统一入口、格式检查均已通过；从 cmd/example 目录调用同一入口也通过。额外使用临时公开 API 验证了接口漂移会令脚本失败，随后已清理探针并重新通过统一检查。

本笔尚无几何算法对照数据或兼容性通过数。远端 Linux CI 的结果以对应提交的 GitHub Actions 运行记录为准，不能由本地结果推断。

## Commit 2 本地结果（2026-10-17）

沿用上述固定工具链 `0.10.13+cbb11c36f`，未新增外部依赖。core 的 BigInt 支持 native 和 JS；CI 同时 bundle 两目标。具体数值实现与 core 许可见 [整数几何说明](numerics.md)。本机 JS 测试使用 Node.js v24.18.0，检查脚本同时打印 Node.js 版本。

同一批测试共 **71** 项：保留原有 18 项，新增 53 项（含 5 项内部数值白盒测试）。本地 native **71/71**，JS **71/71**；这不是 142 个独立用例。两目标 `check --deny-warn` 均通过；native 构建与扩充后的示例实际成功，输出 `MoonClip geometry foundation OK`。面积回退实际触发，包含最终抵消的案例，没有浮点近似例外。

Linux native / JS 的实际结果以本次提交的 GitHub Actions 日志为准，本地结果与远端结果分别核对。上游参考程序与完整输出比较器仍由 Commit 3 交付。

## Commit 3 参考工具本地结果（2026-10-17）

MoonBit 工具链继续固定为上述版本，运行库和公开接口不因参考工具改变。C++ 参考工具实际使用 GNU C++ 14.2.0（MinGW-W64）、CMake 3.30.2、Ninja 1.12.1、Python 3.11.9，以 C++17 / Release 构建。136 个参考案例实际生成并重复重建核对成功；55 项离线工具测试与 10 项实际适配器集成测试通过。库的原有 71 项测试保持原样，本地 native 71/71、JS 71/71 均实际通过，native 构建和示例成功。

普通 CI 不构建 C++；独立手动参考 workflow 另验证实际构建及全部重建。版本锁与来源见 tools/oracle/upstream-lock.json，参数、协议及验证细节见 [参考工具说明](https://github.com/BigSaltyMan/moonclip/blob/6a116b45600cbe8ecd577664a71b50fdfa8ce5c0/tools/oracle/README.md)。实际远端结果以对应提交的两份 Actions 日志为准，离线 CI 成功不替代参考构建/运行的证据。

## Commit 4 本地结果（2026-10-17）

继续使用 `moonc v0.10.13+cbb11c36f` 与既有固定 CI。原有 71 项库回归保持原样，新增 57 项内部扫描白盒测试，共 128 项；本地 native 128/128、JS 128/128，两目标 deny-warn 检查通过。内部测试显式消费退出事件，交点或水平交叉保留待处理边界，不将其计作布尔结果。

公开接口仅增加 2 个资源类别及 5 个错误阶段，Limits 的原有字段和默认值不变。投影使用同一工具链自带 core/double，无新增外部依赖；内部节点、句柄、状态和统计均未公开。原规划书与参考工具/数据未改动。完整统一检查及远端日志按对应提交核对；适配器、协议和数据未改，不重复执行独立参考重建。


## Commit 5 本地结果（2026-10-17）

工具链保持 `moon 0.1.20260915 (2e1a46d)`、`moonc v0.10.13+cbb11c36f`、`moonrun 0.1.20260915 (2e1a46d)`。保留原有 128 项回归，新增 62 项内部数值、事件、水平、输出与组合测试，共 190 项，native 与 JS 使用相同预期分别执行，不能相加为独立用例数。完整脚本和 Linux 结果按最终提交的 Actions 日志核对。

参考编译现在显式定义 CLIPPER2_HI_PRECISION=0，并在 environment.json 记录；此前默认也是普通分支。因修改构建配置，实际使用 GNU C++ 14.2.0、CMake 3.30.2、Python 3.11.9 重新构建，10 项实际适配器测试通过，136 例重建比较一致。参考预期、协议及 reference_only 分类未改动；普通 CI 的 55 项离线检查与独立 rebuild-reference CI 分别作为证据，不能互相替代。


## Commit 6（2026-10-18）

继续使用 moon 0.1.20260915 (2e1a46d)、moonc v0.10.13+cbb11c36f、moonrun 0.1.20260915 (2e1a46d)。根库没有新增 Mooncakes 依赖。库测试 205 项（保留原有 190 项），固定对照 60 项；native、JS 各 265 项独立执行。离线工具 68 项（保留原有 55 项）；原生 CLI 额外实际输出并严格比较 60 项，报告为 required=60/executed=60/passed=60/differences=0/execution_errors=0。

原生命令使用 Python 3.11.9 及标准库负责报告 IO 与严格比较，小型原生 C 桥负责进程传输，运行库几何完全由 MoonBit 执行。参考 C++ 适配器、构建定义和预期未修改，本笔不重复触发独立参考重建。Linux native、JS 和严格对照证据以最终提交的普通 Actions 日志为准。


## Commit 9 本地结果（2026-10-18）

工具链保持 moon 0.1.20260915 (2e1a46d 2026-09-15)、moonc v0.10.13+cbb11c36f (2026-09-15)、moonrun 0.1.20260915 (2e1a46d 2026-09-15)，Node.js v24.18.0、Python 3.11.9。运行库没有新增第三方依赖；同一批 810 项=659 保留+116 独立偏移对照+35 功能/数值/共享预算回归，native 与 JS 分别 810/810，不能相加为独立用例。两个目标 deny-warn、native 构建及示例通过，示例成功信息 `MoonClip geometry, Boolean, PolyTree and offset OK`。

实际独立过滤 Offset native/JS 各 116/116；原 Boolean 152 公开平铺及 152 公开树、48 私有平铺及 48 私有树分别保留。原生严格报告 Boolean paths/tree 各 152/152、Offset paths 116/116，差异和执行错误均为 0，详见 compatibility.md。工具 124/124（保留 104），真实参考适配器 20/20（保留 10），这两类不计入库测试数。

参考构建使用 GNU C++ 14.2.0、CMake 3.30.2、Ninja 1.12.1、C++17 Release、HI_PRECISION=0；固定同 SHA 的 engine.cpp 和新增 offset.cpp。116 新偏移预期实际 --write 并 --check，200 旧 Boolean 全部 --check 字节一致。脚本检查格式、接口、两目标测试/过滤证据、示例、两份离线目录、生成器及分能力报告。Linux 普通 CI 与独立参考 CI 均需按最终提交的 Actions 运行记录另核对；本节是 Windows 本地证据，不代替远端结果。


## Commit 10 本地结果（2026-10-18）

工具链仍为 moon / moonrun 0.1.20260915 (2e1a46d 2026-09-15)、moonc v0.10.13+cbb11c36f (2026-09-15)，Node.js v24.18.0、Python 3.11.9。新增导入固定 core/math，无新增 Mooncakes 包。native、JS 各1006/1006（旧810＋156新对照＋40功能），严格警告检查、native构建、四连接示例成功，输出 `MoonClip geometry, Boolean, PolyTree and four offset joins OK`。

偏移实际独立过滤两端各272/272；原Boolean公开平铺与树各152、私有平铺与树各48保留。原生严格报告 Boolean 两能力各152/152，Offset272/272，差异和执行错误均为0。离线工具134/134（保留124，新增10），真实适配器29/29（保留20，新增9），不计入MoonBit测试数。

参考构建继续 GNU C++14.2.0、CMake3.30.2、Ninja1.12.1、C++17 Release、HI_PRECISION=0，同固定SHA、依赖及编译输入。新增156条参考已锁定、独立生成，并对Boolean200＋Offset272全部逐字节重建核对；原316对数据、旧选择、规划书和构建锁保持字节不变。统一检查脚本验证格式、接口、测试、专属过滤日志、两选择联合、示例、生成器、严格报告和Git差异。最终Linux普通检查与独立参考CI按同提交的Actions日志分别核对，本节仅记录Windows本地结果。


## Commit 11 本地结果（2026-10-18）

固定moon/moonrun 0.1.20260915 (2e1a46d 2026-09-15)、moonc v0.10.13+cbb11c36f (2026-09-15)，Node.js24.18.0、Python3.11.9。无新增运行库依赖。同一批native、JS各1330/1330=旧1006＋276独立描边对照＋48功能；两端deny-warn通过，native构建及包含三种端点/开放转角的示例实际通过，成功标记为 `MoonClip geometry, Boolean, PolyTree, offset and stroke OK`。

专属描边筛选两端各276/276，原Offset272与Boolean公开平铺/树各152、私有各48保留。实际报告分三类执行，零差异、零执行错误。工具155/155（旧134＋21）、真实适配器41/41（旧29＋12），不计入库测试总数。参考仍由GNU C++14.2.0、CMake3.30.2、Ninja1.12.1、C++17 Release、HI_PRECISION=0构建，独立重建200/272/276共748条逐字节一致。

旧参考、旧清单、选择文件和规划书未变。统一脚本检查版本、格式、接口、两端完整测试及各专属筛选、示例、三类数据完整性/生成器、选择及报告差异。最终Linux普通CI与独立参考重建CI须按相同最终SHA的实际日志分别核对，本节仅记录Windows本地结果。


## Commit 15 本地结果（2026-10-19）

固定工具链未变：moon/moonrun 0.1.20260915 (2e1a46d 2026-09-15)，moonc v0.10.13+cbb11c36f (2026-09-15)，rr_moon_mod/rr_moon_pkg。无新增运行依赖。保留2010项，新增144对照及56功能，同一批2210用例：native2210/2210、JS2210/2210，不能相加为独立用例数。两端deny-warn、native构建、实际三类扫掠示例、144独立筛选及全部旧筛选通过；接口仅新增minkowski_sum及三个阶段。

离线工具264/264，真实固定C++适配器89/89。七类独立重建200+272+276+24+220+224+144=1360条逐字节一致；旧参考、清单、选择及规划书2466个文件的Git对象字节不变。兼容性报告完整轮廓零差异、零执行错误，不删除共线点。Git Bash统一检查与暂存审查使用同一脚本；远端普通CI、独立参考CI须在推送后按最终SHA另行核对，本地结果不代替远端证据。


## Commit16 轻量本地证据（2026-10-19）

继续固定moon/moonrun 0.1.20260915 (2e1a46d 2026-09-15)、moonc v0.10.13+cbb11c36f (2026-09-15)。本地只执行新增native24/24、JS24/24、随机实际报告及24条新参考逐字节复核；未重跑旧1360条或本地全量。受影响工具检查为新增12项及已有报告8项，全部通过；之后仅因报告排序修正重跑受影响12项。无真实库缺陷和额外库回归，普通Linux CI的预期全量为2234（旧2210+24），远端实际结果按最终SHA单独核对。

缩减流程在真实固定C++与真实MoonBit stdin探针之后显式注入工具测试故障：默认40次内从2路径8点缩为1路径3点，仍为difference，留档标注tool_test_injected_fault_after_real_moonclip，停止原因为attempt_limit；不是库缺陷，也不宣称全局最小。原本匹配的输入不创建失败材料。根公开接口、上游锁、原有参考/选择及规划书逐字节不变。
