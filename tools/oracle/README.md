# 固定 Clipper2 参考工具

本工具为后续 MoonClip 布尔运算生成独立预期。它不参与 MoonClip 运行库链接，也不在 `moon test` 或普通 CI 中下载、编译或执行 C++。

## 固定源码与构建

参考版本为 Clipper2 2.0.1，标签 `Clipper2_2.0.1`，完整 SHA `21ebba05db8894f0c7217ad35ea518080f324946`。完整 SHA 是身份依据。`upstream-lock.json` 固定下载 URL、归档 SHA256、编译输入、协议版本与额外依赖。获取归档后逐字节验证整个已解压源码树，任何修改、多出文件、链接或校验失败均停止，不回退到 main 或其他版本。

Commit 5 显式固定 `CLIPPER2_HI_PRECISION=0`，reference 库及适配器共用该定义，构建报告 environment.json 的 compile_definitions 记录为 0。此前未定义此宏，同样进入固定源码的普通分支；没有切换数值算法。

实际编译 `CPP/Clipper2Lib/src/clipper.engine.cpp`，并包含该固定提交的 `CPP/Clipper2Lib/include/clipper2/` 头文件。JSON 解析使用 nlohmann/json 3.12.0 的单头文件，固定其 SHA256 和 MIT 许可文本的 SHA256。它只供适配器使用。版权和完整 MIT 许可见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)；下载的上游文件保留原版权和 BSL-1.0 许可。

2026-10-17 本地实际验证环境：Windows Git Bash、GNU C++ 14.2.0（MinGW-W64 x86_64-ucrt-mcf-seh）、CMake 3.30.2、Ninja 1.12.1、Python 3.11.9。使用 C++17、Ninja、`CMAKE_BUILD_TYPE=Release`，并行度 2。路径参数转换为 CMake 可用的正斜杠形式。

```bash
bash scripts/build_oracle.sh
python tools/oracle/test_adapter.py
bash scripts/generate_reference.sh --manifest testdata/manifest.json --check
```

下载、源码、编译产物和环境报告均位于被忽略的 `.tmp/oracle/`。`build/environment.json` 记录实际编译器、CMake、配置命令、源码身份、适配器及可执行文件哈希和耗时；生成器拒绝身份不符或过期的构建。

## 协议 v1

适配器从 stdin 读取一个 UTF-8 JSON 请求，在 stdout 写一个 JSON 响应。输入采用 `format_version: 1`；响应采用 `adapter_protocol_version: 1`。请求字段必须完整且没有未知字段。示例见 [`overlap_difference_evenodd.json`](../../testdata/upstream/inputs/overlap_difference_evenodd.json)。

请求包含 `case_id`、`source`、`operation`、`fill_rule`、`options`、`subject` 和 `clip`。四种操作为 Intersection / Union / Difference / Xor，四种规则为 EvenOdd / NonZero / Positive / Negative。Difference 始终是 subject 减 clip。v1 明确设置 `preserve_collinear: false`、`reverse_solution: false`，不能省略或使用数值替代布尔值。开启这些选项需另行扩展协议及对照契约。

坐标必须是 JSON 整数 token，范围为 ±10^9（含边界），不经过 Double 解析；拒绝 true、小数、指数形式和数字字符串。请求限制为 8 MiB、合计 10,000 条路径及 100,000 个顶点，原始重复点照计。输入允许空路径、空 subject 和空 clip。解析器拒绝重复字段及过深 JSON。

每个请求新建两个 Clipper64 实例，分别 Execute 到 Paths64 和 PolyTree64，均核对执行状态和 ErrorCode。平铺与树结果独立保存，不从面积或点包含关系猜树。

成功原始响应包含 `format_version`、`case_id`、`oracle_commit`、`adapter_protocol_version`、`status: success`、`paths` 和 `tree`。树根只有 `children`，真实节点有 `path` 与 `children`；根层为 0，外轮廓、孔洞、孔中岛依次在第 1、2、3 层。输出轮廓至少三个顶点，不重复存储首点。

工具错误在 stderr 给出英文说明，stdout 返回 `status: error`，退出码 2。成功空区域的退出码为 0，且平铺和树均为空。生成器设置每个案例默认 20 秒超时（`--timeout` 可设为 (0,300] 秒），非零退出、错误响应、无效 JSON、超时均属于工具失败。

## 数据生成与复查

`construct_cases.py` 只写明确定义的人工输入及清单，从不生成预期；修改它之后须审查输入变化并重新运行参考适配器。

```bash
# 仅在有意修改案例定义时运行：
python tools/oracle/construct_cases.py
# 明确要求更新工作区中的候选预期：
bash scripts/generate_reference.sh --manifest testdata/manifest.json --write
# 审查输入、哈希、绕向、孔洞归属和差异，再执行：
bash scripts/generate_reference.sh --manifest testdata/manifest.json --check
```

两种模式先验证输入清单，并在临时目录生成完整批次。`--write` 只有全部案例成功后才替换工作区的 expected 目录；未提交文件仍是待审查候选，任何案例失败都保留整份旧基线。`--check` 不修改预期文件，严格比较重建后的规范 JSON 字节，并核对完整轮廓与树。所有构建与计时信息另存忽略的报告，不写入核心参考数据。

Python 为已提交结果补充输入文件 SHA256 和独立整数指标。序列化固定为 UTF-8（无 BOM）、键排序、两空格缩进和 LF，末尾一个换行。精确两倍有向面积使用规范十进制字符串；顶点数、边界框、树深及孔洞数只是完整性与诊断指标。

失败信息含案例 ID 或文件/节点位置，不打印全部输入。按 `case_id` 找到 inputs/expected 的同名文件；适配器可单独重放：

```bash
.tmp/oracle/build/moonclip-oracle < testdata/upstream/inputs/overlap_difference_evenodd.json
```

Git Bash 下 Windows 可执行文件扩展名为 `.exe`。不要在失败后自动执行 `--write` 接受新结果。

## 离线检查与边界

```bash
python -m unittest discover -s tools/conformance -p "test_*.py"
python scripts/check_reference.py --manifest testdata/manifest.json --strict
```

这两个步骤只需要 Python 3.11+ 标准库，不访问上游、不调用 C++。工具单元测试的进程失败/超时反例启动的是本机 Python，不是参考适配器。根 `scripts/check.sh` 同时执行库回归与这两个步骤。普通 CI 固定 Python 3.11.9；独立 `rebuild-reference` workflow 仅由手动触发，用于验证固定 C++ 构建和参考重建。

比较器只消除循环起点、平铺排列和同一父节点下的子节点排列，保留绕向、所有顶点、重复数量、父子关系和层级。重复最小坐标采用完整循环序列比较；采用线性时间最小旋转算法，不反向、不去共线点、不加容差、不用面积或 MoonClip Xor 代替比较。

本笔仅支持闭合路径布尔参考，不含开放路径布尔、偏移、描边、小数、简化或 Minkowski Sum。参考案例全部为 `reference_only`，不能计作 MoonClip 对应操作已通过。覆盖和实际执行记录见 [reference-cases.md](../../docs/reference-cases.md)。


## Offset protocol v2

Boolean requests/results remain protocol 1. `operation=OffsetPolygons` requires format_version=2, paths, finite numeric delta, join_type=Miter/Bevel, finite miter_limit>=2, fill_rule=EvenOdd/NonZero and both fixed output options false. Numeric booleans/strings are rejected, as are unknown joins and private fill rules. Results are v2 paths only, with no inferred tree. Generation attaches original input SHA256 and exact path metrics.

The adapter independently calls fixed-engine Union on all original inputs, then ClipperOffset(miter_limit,0,false,false), EndType::Polygon. It never takes normalized geometry or expectations from MoonClip. CMake adds the locked clipper.offset.cpp, keeps engine.cpp and CLIPPER2_HI_PRECISION=0; dependency versions/checksums/licenses are unchanged. Lock records offset_protocol_version=2 separately. Source verification still audits the complete fixed archive.

```bash
bash scripts/build_oracle.sh
python tools/oracle/test_adapter.py
bash scripts/generate_reference.sh --manifest testdata/offset-manifest.json --write
bash scripts/generate_reference.sh --manifest testdata/offset-manifest.json --check
bash scripts/generate_reference.sh --manifest testdata/manifest.json --check
```

116 offset inputs and 200 Boolean inputs are separate catalogs. Offset publication stages the whole batch and replaces only testdata/offset/expected after all requests succeed. It never writes Boolean expectations. Actual adapter tests: 20 (10 retained +10 offset). Ordinary CI uses only committed data; rebuild-reference executes both full catalogs with the real C++ binary.


## Commit 10 optional ArcTolerance and new joins

Offset v2 now accepts Miter/Bevel/Square/Round and optional arc_tolerance (default 0.0). Tolerance must be a finite numeric token >=0; booleans, strings, negative/nonfinite values and unknown fields are rejected, including empty/zero inputs. Real JoinType::Square / JoinType::Round and the requested tolerance are passed to the fixed ClipperOffset constructor. Boolean v1 and old116 offset request/expectation bytes are unchanged.

The old116 selection is immutable; offset-join-selection locks156 new cases, with disjoint complete union272. The constructor reuses verified old records and refuses changed definitions. Explicit tolerance cases use four geometries scaled5, signed radius10, tolerances.05/.25/1.0, both fill rules (48 cases). Reference output still comes entirely from fixed C++ Union then Offset.

Before calling upstream Round, the adapter bounds a conservative sample estimate (normalized vertices times maximum half-circle samples) by100000, preventing unsafe upstream int casts or unbounded loops for adversarial tiny tolerance/large radius. This adapter execution guard only rejects oversized requests; it never changes tolerance or geometry. MoonClip uses its own actual per-corner cumulative budgets. Integration tests total29; offline tools134. Independent rebuild now checks200 Boolean+272 Offset=472 files; ordinary CI does not build/invoke C++.
