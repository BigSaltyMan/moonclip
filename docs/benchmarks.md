# Native 性能基线

这是指定环境下的代表性基线，不是吞吐承诺或跨库性能排名。未测 JS、上游 C++ 或其他库；内存**未测量**，不以 0 代替缺失数据。本次没有发现需要修改核心实现的明确问题，未做算法优化或提高预算。

## 复现

从任意调用目录用 Bash 调用脚本（Windows 使用 Git Bash），报告相对仓库根目录：

```bash
bash scripts/bench.sh --target native --report _build/bench/report.json
```

依赖固定 MoonBit 工具链、可用的本机 C 编译器、Python 3.11+ 与 Git；没有新增包依赖。脚本先执行 `moon build --target native --release --deny-warn bench`，再直接执行生成的原生程序，各案例独立进程，构建只做一次。输入和选项由 bench/cases.mbt 的 small-deterministic-v1 固定算法构造；无随机数、外部预期下载或新增上游参考。

默认构建限时 120 秒，案例发现限时 15 秒，每个案例进程 15 秒，案例执行总预算 90 秒。总预算耗尽时后续案例标记未启动的 SuiteDeadline；单案例超时终止该进程树，保留输出片段。可用 `--timeout` / `--suite-timeout` 调整外部时限（有限、正值、最多 300 秒），不改变库预算；`--case boolean_32` 可只复测一项。默认完整选择 11 项，`--smoke` 只运行 boolean_1、一次预热、一个样本和一次调用，供 CI 验证入口，不用于速度比较。

原始 JSON 及 build.log 放在 `_build/bench/`（忽略目录）。报告保存源码父提交、工作区状态、被测源码 / 配置的 SHA256、原生可执行文件 SHA256、环境、参数、输入输出规模、原始样本和统计。environment / source / limits 为整份报告各行共用元数据；每行 requested_schedule 即使失败也保留预设采样参数。报告路径和构建日志为本地路径；仓库仅保留本文摘要。

## 计时方法与检查

- 固定 native release，预热 **2 次单次调用**；随后 **5 个样本**，每样本批量次数见表。每样本时间除以 batch，单位为 **微秒 / 次**；统计为五个单次均值的中位数、最小和最大值，没有 P95。
- 进程内部调用固定 core/bench 单调时钟；本机为 QueryPerformanceCounter，Linux 为 CLOCK_MONOTONIC。不是系统墙钟，也不把进程启动时间当作库耗时。
- 输入生成、选项构造、期望构造、校验、输出规模遍历、统计排序及 JSON / 终端输出在计时外。计时包含公开调用内部的预检、分配、复制、生成、清理与结果构建，也包含很小的闭包分派、结果包装和预分配槽写入开销。保留每次结果直到停止计时，随后检查；返回结果的最终释放在计时外。
- Boolean 递增案例及交点探针断言完整独立矩形集合；凹轮廓偏移、描边、Minkowski 断言已有小型示例的完整轮廓（仅忽略环起点 / 同级排列，保留绕向和共线点）。小数 Union 检查唯一矩形的四个精确二进制分数坐标；简化还检查删点与全部退化列表。
- 尖角压力探针检查唯一输出、正向面积增长、下边界和尖角外扩；圆角探针检查唯一输出、包围盒、独立面积区间及点数下限。这两项是有界压力观察，不增加严格参考兼容性声明。每次预热及每个批次结果均校验。
- 小数结果是完整公开 BooleanD 调用成本，包含量化、整数求值与解码。没有配对实验，不能将它减去另一例 Boolean 时间解释成“纯量化开销”。

状态分为 success、resource_rejected、runtime_error、timeout。资源拒绝保留库的类别、阶段、索引、资源与限制值；进程崩溃、结果检查失败或报告协议错误归 runtime_error。外层超时不会伪装成 ResourceLimitExceeded。任一失败行 statistics_us 为 null，先前完成样本也不进入成功统计。普通案例失败令脚本失败；压力案例正常资源拒绝 / 超时可留作证据，但运行错误仍令脚本失败。

## 实测环境与版本

测量时间：`2026-10-20T02:26:48.558781+00:00`（2026-10-20，Asia/Shanghai）。

- OS：`Windows-10-10.0.26300-SP0`（platform 原始标识），x64 本机程序。
- CPU：**AMD Ryzen 9 8940HX with Radeon Graphics**；未固定频率、核心亲和或隔离后台负载。
- C 编译环境：MSVC 14.44.35207，HostX64/x64，release `/O2 /MT`；通过固定 moon 的实际构建配置及 dry-run 核对，非 debug 构建。
- Python：3.11.9。

```text
moon 0.1.20260915 (2e1a46d 2026-09-15) ~\.moon\bin\moon.exe
moonc v0.10.13+cbb11c36f (2026-09-15) ~\.moon\bin\moonc.exe
moonrun 0.1.20260915 (2e1a46d 2026-09-15) ~\.moon\bin\moonrun.exe

Feature flags enabled: rr_moon_mod,rr_moon_pkg
```

测量时 HEAD 为 Commit 17 `19d192b4e81e3162decf4d658a92d6b20b286719`，工作区 **dirty=true**（本笔新增基准及文档未提交）。被测源码 / 配置总指纹为 `92150d6a2c5f70894c7edf660e5d3bb17e10c23c8deb266d8f08484b29833b95`；报告逐文件记录哈希，避免把父提交误写成已经包含基准的提交。

| 被测文件 | SHA256 |
| --- | --- |
| bench/cases.mbt | `8d6d19939f96be3d7c83403e7c7fb612fd8c4047a86e8ba1d957b4bce0339e81` |
| bench/main.mbt | `d6a55a5220f82dfb8243c0410d506f2a5894468cf1c8aa2e490c80ef58654fca` |
| bench/moon.pkg | `df295c8f80aa0befd33ef29a517dd04f3bcbae0a8fc8beaa7e27eda2b81bb82f` |
| scripts/bench.py | `ac6f3f4f23abd1bf1d24521efe63febe0b45bdfe22e0f40f94b3e0fafb656168` |
| scripts/bench.sh | `7023dbdfcf86192ee82d9c6a488495c7a7d8db2eaabe1213f1c07b2383f3b5c4` |

被测可执行文件 SHA256：`ea41d31519de2b9b52b9d9748aaf9fdf626463f632f3cc968409eb472a27d785`。后续不同机器 / 编译器构建的二进制哈希可以不同；复现应核对源码、工具链和配置，而非要求机器码一致。

## 输入与参数

| 案例 | 固定构造与操作 |
| --- | --- |
| boolean_1 / 8 / 32 | n 对独立的 20×20 矩形，水平平移 10、垂直平移 −5；Intersection / NonZero，预期 n 个 10×15 矩形 |
| offset_concave | 40×40 缺角 L 形，6 点，凸凹角；Miter +2，MiterLimit=2，ArcTolerance=0，NonZero |
| stroke_route | (0,0)→(20,0)→(20,20)，完整 width=4，Miter / Butt，MiterLimit=2，ArcTolerance=0 |
| decimal_union | 两个带负坐标的小数矩形，Union / NonZero，Precision=3（默认）；预期 [−1.25,−0.25]—[2.25,1.25] |
| simplify_collinear | 20×20 方形下边多一个中点，Closed，epsilon=.25；5 点变 4 点，removed=1，三类退化列表为空 |
| minkowski_route | 图案为 [−2,−1]—[2,1] 的 4 点矩形，路线 3 点同 stroke_route；开放，锚点原点；保留共线点 |
| stress_intersections | 12 条水平带 ×12 条垂直带，宽 4、间距 10，Intersection / NonZero；144 个完整小矩形 |
| stress_sharp_offset | 12 个窄尖齿，27 个输入点，尖顶高 300、谷高 100，Miter +5，MiterLimit=2，ArcTolerance=0，NonZero |
| stress_round_tolerance | 100×100 方形，Round +100，ArcTolerance=.001，MiterLimit=2，NonZero |

## 结果

表内规模为“路径数 / 顶点数”。前三档 Boolean 是同一操作、同一构造的有限规模观察，其余没有展开参数全排列。

| 案例 | 输入 | 输出 | batch | 中位数 µs | 最小 µs | 最大 µs | 状态 |
| --- | ---: | ---: | ---: | ---: | ---: | ---: | --- |
| boolean_1 | 2 / 8 | 1 / 4 | 5 | 34.940 | 33.840 | 65.260 | success |
| boolean_8 | 16 / 64 | 8 / 32 | 5 | 316.300 | 297.760 | 345.220 | success |
| boolean_32 | 64 / 256 | 32 / 128 | 5 | 1931.120 | 1870.500 | 1978.340 | success |
| offset_concave | 1 / 6 | 1 / 6 | 5 | 63.340 | 61.900 | 64.440 | success |
| stroke_route | 1 / 3 | 1 / 6 | 5 | 44.020 | 40.380 | 48.040 | success |
| decimal_union | 2 / 8 | 1 / 4 | 5 | 41.260 | 40.280 | 42.820 | success |
| simplify_collinear | 1 / 5 | 1 / 4 | 20 | 3.005 | 2.990 | 3.210 | success |
| minkowski_route | 2 / 7 | 1 / 10 | 3 | 165.233 | 162.500 | 170.067 | success |
| stress_intersections | 24 / 96 | 144 / 576 | 1 | 10778.800 | 10409.900 | 11820.200 | success |
| stress_sharp_offset | 1 / 27 | 1 / 39 | 1 | 495.200 | 484.300 | 518.300 | success |
| stress_round_tolerance | 1 / 4 | 1 / 192 | 1 | 4048.300 | 3975.300 | 4067.000 | success |

**11 项成功，资源拒绝 0，运行错误 0，超时 0。** 三个压力探针都正常终止；这不意味着任意交点密集、尖角或小容差输入能在默认预算内完成。圆角结果为 192 点，不能从最终点数推断中间生成和清理只分配了 192 个节点。

Boolean 随输入增大明显变慢；单纯按顶点数外推不适用于不同交点密度或输出规模，三个点不能证明某个渐近复杂度。短操作的后台调度、分配器和时钟开销更容易影响样本范围；这里保留原始少量样本，不给虚构的分位数或稳定性保证。没有基于这些观测改动核心实现、数值规则、资源默认值或几何语义。

## 验证边界

本地只执行基准及四项运行器契约检查（统计 / 单位、资源错误、崩溃 / 协议、真实外部超时），未重复运行 2234 项库全量、全部离线工具测试或参考重建。报告审查补齐失败行的预设采样参数后，复用 release 产物记录本表最终值；这不是性能优化前后实验。现有普通 Linux CI 对提交运行一次全量正确性检查，并增加一个极小基准冒烟；共享机器上不设置时间阈值，不把 CI 冒烟数据混入本地基线。演示代码未改，未重复浏览器验收。
