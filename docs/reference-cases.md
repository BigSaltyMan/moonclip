# 固定参考案例与工具验证

## 来源与状态

200 个输入均由 BigSaltyMan 于 2026 年为 MoonClip 自行构造，BSL-1.0。每份输入的 `source.kind` 为 `moonclip_constructed`，`source.group` 定位到下表，`source.intent` 记录构造目的。没有复制上游测试数据。定义脚本为 `tools/oracle/construct_cases.py`；稳定 ID 为 `组名_操作_规则`，不依赖数组下标。

每个预期由固定 Clipper2 C++ 提交 `21ebba05db8894f0c7217ad35ea518080f324946` 真实执行生成，并关联同名输入的完整文件 SHA256。案例级及 validation.paths/tree 状态一致：公开 EO/NZ 各 76 条为 validate；内部正负各 24 条为 validate_internal。两项能力分别执行和记录。

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
| winding_overlap | 同向 Subject +2，Clip 穿过单/双覆盖区；四操作×四规则 | 16 |
| winding_reversed | overlap 两个操作数全部反向，验证负绕数对偶 | 16 |
| winding_nested | 外轮廓、反向孔、岛及第四条交叠轮廓，对含孔 Clip | 16 |
| winding_cancel_touch | 正反抵消、共边与共顶点、多轮廓 Clip 覆盖 | 16 |
| 合计 | 四种操作各 50；EO/NZ 各 76；正负各 24 | 200 |

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

前两条离线运行；第三条需要预先构建参考程序。普通 CI 执行前两条，手动参考 CI 另执行真实构建、10 项适配器集成测试和全部重建。成功空结果、参考生成数、工具测试数、MoonBit 的 71 项基础回归不相互替代。该段记录 Commit 3 时尚未运行 MoonClip 布尔对照的状态。

工具限制：UTF-8 JSON 最多 8 MiB，输入/输出最多 10,000 条路径及 100,000 个顶点，树深最多 64；根容器不计为真实轮廓。输出必须保留顶点与绕向且不重复存储首点。当前没有偏移、描边、小数、开放路径或完整几何兼容性矩阵。后续分段不同的几何结果需另立独立证据，不能直接删点或放宽容差。


## Commit 6 能力级验证

清单保留案例级 reference_only，并增加 validation.paths / validation.tree。预先锁定的全部 60 条 EvenOdd 的 paths=validate，其余 76 条 paths=reference_only；全部 136 条 tree=reference_only。固定集合见 testdata/evenodd-selection.json，实际逐例平铺结果见 compatibility.md。生成测试在 native 与 JS 分别执行，不修改参考坐标、绕向、顶点或预期哈希。


## Commit 7 扩展与验证

先固定四组输入、稳定 ID、构造意图及各规则数量，再运行 MoonClip。construct_cases.py 保留已有元数据并设置规则对应状态。原 evenodd-selection.json 的 60 条基线字节不变，boolean-selection.json 锁定全 200 条；选择依据 fill_rule，不是名称 negative。

本地 2026-10-18 固定普通精度参考重新构建，适配器 10 项测试通过，完整 --write 后 --check 重建 200/200；原有 136 条输入与预期字节不变。工具原 68 项加 17 项，85 项通过，新增覆盖集合完整性、内部混入公开、NonZero 误用 EvenOdd、原生命令不读取预期几何、实际过滤不能零执行。

native、JS 各执行同一批 427 项（205 旧库 +22 新功能 +152 公开 +48 私有对照）。两目标各独立过滤 48/48（Positive/Negative 各 24）。公开 native 严格报告 required/executed/passed=152，差异/错误为零；私有记录与 200 条树未验证状态分别列于 compatibility.md。远端 Linux 和独立参考 CI 链接在本笔交付记录单独提供，本地结果不代替远端证据。


## Commit 8 树能力消费

本笔没有增加、改写参考输入或预期：200 对文件及 evenodd-selection.json、boolean-selection.json 保持字节不变。公开 152 案例各有旧平铺和新树测试，私有 48 案例各有旧平铺和新树测试。树比较保留父子、深度、轮廓全部坐标/顶点/方向和重数，只允许环起点和同父孩子次序变化，不能平铺后比较。

运行器独立调用两个入口，输入/哈希生成文件不链接预期几何；严格报告分别列 paths、tree、both，152 案例不写成 304 案例。native/JS 专属过滤分别执行公开树 152 和内部树 48，并保留原私有平铺 48；树日志必须有独立选择标记，缺失或旧平铺日志不能产生树通过记录。JSON 工具协议最大深度 64 不是库限制，32 项新功能回归包含 72 层及显式五层断言。

每目标实际全量目标为 659（427 旧回归+200 树对照+32 功能）；最终本地和 Linux 运行证据分别在交付报告中核对。参考构建/适配器协议未变，继续完整性检查；不把旧参考重建数量当作本笔树执行数量。

工具回归保留原 85 项，新增 19 项，合计 104 项；覆盖父子改变、节点提升、反转、重数、遗漏、兄弟重排、树错误及缺失结果、旧路径日志拒绝与双入口独立运行。固定参考适配器 10 项与 200 条本地重建另行核对通过，未修改参考构建和协议。


## Commit 9 独立偏移矩阵

新增 116 份自行构造请求，第一次执行 MoonClip 偏移前由 `tools/oracle/construct_offset.py` 锁定 ID、几何、距离、样式和填充规则。单独 offset-manifest/offset-selection，原 Boolean 清单、两选择及 200 对数据不改。全部预期由固定 C++ 同时编译 engine.cpp / offset.cpp，独立共同 Union 后使用 ClipperOffset Polygon 实际生成，协议 v2 不含树。

| 形状组 | 正距离 | 负距离 | 规则 × Join | 数量 |
| --- | ---: | ---: | --- | ---: |
| rectangle | 2 | -2 | EO/NZ × Miter/Bevel | 8 |
| concave_l | 4 | -4 | 同上 | 8 |
| multipart | 3（跨 4 单位间隙合并） | -2 | 同上 | 8 |
| hole | 12（孔洞消失） | -4 | 同上 | 8 |
| island | 4 | -4 | 同上 | 8 |
| neck | 3 | -3（4 单位桥分裂） | 同上 | 8 |
| acute | 3 | -2 | 同上 | 8 |
| overlap | 3 | -3 | 同上 | 8 |
| mixed_overlap | 3 | -3 | 同上 | 8 |
| self_crossing | 3 | -3 | 同上 | 8 |
| small | 0、±0.49、±0.5 | 含正负零边界 | 5 ×2 ×2 | 20 |
| miter4 / miter10 | 3 | -2 | 两额外限制 ×2 规则 ×2 符号 | 8 |
| collapse | -5 恰好消失、-6 过量收缩 | — | 两距离 ×2 规则 ×2 Join | 8 |
| 合计 | | | | 116 |

MiterLimit 为默认 2；额外两组仅 Miter 分别 4、10。参考请求值为锁定值，不能为通过而调整。完整轮廓比较保留所有坐标、点数、绕向及重数，只规范化循环起点/轮廓顺序；不使用面积或包围盒替代。

`generate_offset.py` 生成 116 项公开测试及 inputs-only 命令数据，实际执行需独立过滤 `reference offset paths: *`，native/JS 各严格 116；日志带专属选择标记才可写入报告。命令 `--offset-manifest` 将 116 项单独计为 Offset public paths，Boolean 仍为 200 参考（152 公开平铺+树、48 私有平铺+树）。独立输入总数 316，不将能力数或目标数相加。

本地同一批 810 库测试=659 原回归+116 偏移完整轮廓+35 功能及预算；工具 124=104+20，真实适配器 20=10+10。116 份偏移已生成并重复 --check，200 份原布尔已重建 --check，均逐字节一致。最终远端记录分别来自普通 Linux CI 与手动 rebuild-reference，不能用离线完整性代替参考实际重建。


## Commit 10 新增 156 条连接与精度对照

在首次执行 MoonClip 新连接之前锁定全部新输入，复用原 116 条记录而不重新定义或补写字段；旧 offset-selection.json 保持字节不变。新增 offset-join-selection.json 锁定156条，读取器检查排序、唯一、两批互斥及联合等于完整272清单。构造脚本重复运行核对已有定义，相异则报错，不重写旧输入。

| 新增类别 | 明确参数与目的 | 数量 |
| --- | --- | ---: |
| 基础 Square / Round | Commit 9 十组原几何、原正负距离 ×EO/NZ ×Square/Round | 80 |
| 极小与阈值 | 原重叠区域，0、±0.49、±0.5 ×两规则 ×两连接 | 20 |
| 收缩退化 | 原10×10矩形，-5、-6 ×两规则 ×两连接 | 8 |
| Round 显式容差 | rectangle / acute / hole / neck 原几何坐标统一乘5；delta=±10；tol=0.05/0.25/1.0；EO/NZ | 48 |
| 新增合计 | | 156 |

显式容差组的矩形为50×50、锐角底边300、孔洞外边长300；窄颈宽20，收缩10后桥消失并分裂。所有意图、样式、距离和容差写入输入。矩形正偏移在三容差下的实际最终顶点数为24、16、12；这是选定案例的证据，不推广为所有输入的单调性承诺。自动精度、小正容差、近共线、原始终点、舍入和解析圆弧由40项功能回归补充。

独立固定 C++ 生成新预期；原200 Boolean和116 Offset的输入/预期逐字节保留。偏移v2新增可选arc_tolerance（省略为0）并扩展四Join，不改Boolean v1、锁定SHA、构建定义、依赖。参考程序在调用上游前还检查保守采样上界（每顶点按半圈估算，总计不超过100000），防止不受控的上游整数转换/循环；它只拒绝超出适配器资源范围的请求，不改变几何或调低精度，库本身使用实际逐角累计预算。

全量每目标1006=旧810+156对照+40功能；偏移过滤272=旧116+156。工具134=124+10、真实适配器29=20+9分别统计。独立参考472=Boolean200+Offset272；多目标和多能力不计为独立输入数。普通Linux CI与独立参考CI须分别查看最终提交的执行日志。
