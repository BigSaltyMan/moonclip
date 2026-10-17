# Commit 3 参考案例与工具验证

## 来源与状态

136 个输入均由 BigSaltyMan 于 2026 年为 MoonClip 自行构造，BSL-1.0。每份输入的 `source.kind` 为 `moonclip_constructed`，`source.group` 定位到下表，`source.intent` 记录构造目的。没有复制上游测试数据。定义脚本为 `tools/oracle/construct_cases.py`；稳定 ID 为 `组名_操作_规则`，不依赖数组下标。

每个预期由固定 Clipper2 C++ 提交 `21ebba05db8894f0c7217ad35ea518080f324946` 真实执行生成，并关联同名输入的完整文件 SHA256。清单内所有状态均为 **reference_only**：参考已经生成，MoonClip 尚未实现或接入这些布尔操作。

## 覆盖矩阵

前 15 组分别派生 Intersection、Union、Difference、Xor，且覆盖 EvenOdd、NonZero，每组 8 个案例。

| 组名 | 输入构造与验证目的 | 案例数 |
| --- | --- | ---: |
| disjoint | 分离矩形，空交集与多个独立区域 | 8 |
| overlap | 部分重叠矩形，Difference 的 operand 顺序 | 8 |
| contained | 内矩形完全包含于外矩形，差集产生孔洞 | 8 |
| coincident | 完全重合，差集和异或为成功空结果 | 8 |
| touch_vertex | 只有一个公共顶点，区域不凭空重叠 | 8 |
| touch_edge | 共边、水平边与合并行为 | 8 |
| concave | 凹 L 形与矩形，分割与凹角 | 8 |
| multipart | 多个 subject 区域与横跨两者的 clip | 8 |
| hole | 含负坐标的外框减内框，保留真实孔洞归属 | 8 |
| island | 外框、反向孔洞、孔中岛，第三级树节点 | 8 |
| self_crossing | 蝴蝶形自交输入及分开的两个叶瓣 | 8 |
| negative_collinear | 负坐标、水平边和共线中间点 | 8 |
| empty_subject | 空 subject，Difference 不能交换操作数 | 8 |
| empty_clip | 空 clip，交/并/差/异或各自语义 | 8 |
| empty_both | 两端皆空，合法的成功空结果 | 8 |
| direction_ccw | 逆时针矩形，四操作 × Positive/Negative | 8 |
| direction_cw | 顺时针矩形，四操作 × Positive/Negative | 8 |
| 合计 | 四种操作各 34；EvenOdd/NonZero 各 60；Positive/Negative 各 8 | 136 |

全部采用 `PreserveCollinear=false`、`ReverseSolution=false`，坐标处于 Commit 2 接受范围内。对同一请求分别保存平铺和 PolyTree 原始输出。

## 实际复查

2026-10-17 在 Windows Git Bash 下实际构建、生成并重建核对 136/136 个参考结果；重复生成与已提交候选的规范 JSON 字节一致。环境为 GNU C++ 14.2.0（MinGW-W64）、CMake 3.30.2、Ninja 1.12.1、Python 3.11.9，C++17 / Release，完整参数见参考工具 README。

重点核对：

- `overlap_difference_evenodd` 的结果边界为 [0,0,5,10]；交换 subject/clip 后为 [10,0,15,10]，说明方向不是被忽略的面积差。
- `contained_difference_evenodd` 有 2 个轮廓、1 个孔洞、树深 2；`hole_difference_evenodd` 外层 area2=3200，孔洞 area2=-800。
- `island_union_nonzero` 有 3 个轮廓、1 个孔洞、树深 3，外层、孔洞、岛的 area2 分别为 7200、-3200、800。
- 相切点、共边和不相交输入的 Intersection 均为空；coincident 的 Difference/Xor 也为空，工具均明确报告成功。
- CCW + Positive 与 CW + Negative 的 Union 为一条轮廓，另两种方向/规则组合为空。EvenOdd、NonZero 和定向规则的参考能力不代表 MoonClip 已公开该能力。

55 项 Python 离线工具测试实际通过，覆盖 5 份合法比较器文件与 13 份故意破坏的反例文件，以及格式、哈希、遗漏、失败与超时；固定 seed 的最小旋转测试另与暴力循环枚举核对。实际 C++ 适配器集成测试 10 项通过，独立验证严格 token 解析、选项、操作数顺序、孔中岛、定向填充、成功空结果和源码修改拒绝。两组测试分别统计。

比较器反例包括同面积的 4×4 正方形与 8×2 长方形、少点/多点/去共线点、反向、少轮廓/多轮廓/重复轮廓，以及平铺轮廓完全相同而孔洞换父节点或岛升到根层。错误父子关系的反例先确认平铺和树内轮廓一致，再断言失败位置是树比较。

## 检查与能力边界

```bash
python -m unittest discover -s tools/conformance -p "test_*.py"
python scripts/check_reference.py --manifest testdata/manifest.json --strict
bash scripts/generate_reference.sh --manifest testdata/manifest.json --check
```

前两条离线运行；第三条需要预先构建参考程序。普通 CI 执行前两条，手动参考 CI 另执行真实构建、10 项适配器集成测试和全部重建。成功空结果、参考生成数、工具测试数、MoonBit 的 71 项基础回归不相互替代。MoonClip 布尔兼容性尚未运行，没有布尔运算兼容性通过数。

工具限制：UTF-8 JSON 最多 8 MiB，输入/输出最多 10,000 条路径及 100,000 个顶点，树深最多 64；根容器不计为真实轮廓。输出必须保留顶点与绕向且不重复存储首点。当前没有偏移、描边、小数、开放路径或完整几何兼容性矩阵。后续分段不同的几何结果需另立独立证据，不能直接删点或放宽容差。
