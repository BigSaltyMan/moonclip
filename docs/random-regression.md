# 固定种子随机回归与失败缩减

Commit16保留原有2210项库测试和1360条参考，只新增24条v1公开Boolean平铺对照。同一批库测试预期2234，两目标分别执行；平铺/树、组合中间/最终、小数网格/解码及简化统计都是能力检查，不能累加为独立案例。兼容报告的清单矩阵列出1384个独立案例与2276个选中能力检查，逐项值为包含该值的案例数，不代表笛卡尔积全覆盖。

## 锁定输入

种子20261019，算法xorshift32-small-polygons-v1，32位移位/异或和取模均显式固定，不依赖Python random版本。生成顺序：矩形、正交凹形、小凸形；每类Intersection、Union、Difference、Xor；每种EvenOdd、NonZero。每类几何生成一次，四操作两规则共享同一几何，坐标小于100、每条最多6点。清单保存种子、构型、顺序、哈希；source记录算法及种子，选择文件恰好24条。构造器对已存在输入只核对，不覆盖；失败不能换种子、删除案例或改预期。

请求复用v1，固定C++程序真实生成；独立testdata/random目录，不增加协议。生成器依据明确目录分派，混合旧Boolean/随机批次在执行前拒绝。上游锁、旧1360参考/清单/选择和原规划书不变。

```bash
python tools/conformance/random_cases.py --construct
bash scripts/generate_reference.sh --manifest testdata/random-manifest.json --write
python tools/conformance/random_cases.py --generate
```

## 本地轻量验证

```bash
python -m unittest discover -s tools/conformance -p test_random.py
moon test --target native --filter 'reference random paths: *'
moon test --target js --filter 'reference random paths: *'
bash scripts/generate_reference.sh --manifest testdata/random-manifest.json --check
moon run --target native cmd/conformance -- --random-only --random-manifest testdata/random-manifest.json --report-json _build/conformance/random-report.json --report-md _build/conformance/random-report.md
```

random-only只调用24条随机入口，不执行旧七类几何。完整兼容文档在本地保留C15已有执行证据并加入新报告/矩阵；普通Linux CI只运行一次完整check.sh，重新执行2234项及完整报告。随机案例已纳入全量，不新增重复随机筛选。JS24证据必须来自JS日志；干净CI以包含锁定24条的成功2234全量JS日志证明执行，不能用native替代。独立参考工作流默认catalog=random，只复核新增24条；catalog=all留给最终验收。

## 真实失败的可选缩减

默认检查不启动真实缩减。确认存在真实失败后运行：

```bash
python tools/conformance/reduce_failure.py testdata/random/inputs/CASE.json
```

工具先核对公开v1合法输入及已验证C++二进制，只编译一次cmd/reduce_probe，随后直接通过stdin执行每个候选；不会重建整套测试。探针仅使用公开boolean_op，JSON坐标在±10^9内可精确解析；它不属于根几何API。

依次尝试删路径、删顶点、坐标改为0/±1、坐标向零折半；只接受复杂度下降且双方实际执行后仍保留原失败类别的候选，操作及填充规则不变。参数错误、超时、进程错误、非法输出不能冒充轮廓差异。原始传输/参数错误保留原件并停止，不进行伪几何缩减。默认最多40次候选尝试（原始复现另计），每次至多执行双方各一次；--max-attempts可调整，--timeout默认10秒。次数耗尽报告当前结果，不保证全局最小。

_build/conformance/failures/<输入哈希>-<UTC时间>/保存original.json、reduced.json、双方原始/缩减结果、metadata.json；元数据含种子、来源、双方版本/二进制哈希、失败类别、尝试记录、停止原因。无失败不创建材料目录，不自动写永久回归。确认真实库缺陷后才最小修复，并将缩减案例作为永久回归，按实际数量更新基线。工具测试的注入故障明确标注tool_test_injected_fault，不是库缺陷。

本笔本地无真实库缺陷。工具流程验证在真实C++与真实MoonBit探针后显式注入输出故障，40次内从2条路径/8点缩到1条路径/3点并保存；失败类别保持difference，停止原因为attempt_limit。没有修改几何预期或比较器。
