# Commit17 浏览器与导出验收

2026-10-19，Windows，本机Edge156.0.4314.30，通过已启动的http://127.0.0.1:4173实际执行页面交互。内置浏览器运行时路径异常，改用现成Edge与工具自带浏览器操作能力；未向项目添加浏览器测试框架或依赖。截图已逐张查看，并查看390×844窄屏及重新打开的SVG。

| 操作 | 实际结果 |
| --- | --- |
| Boolean切换孔洞案例、修改Union/NonZero、查看并导出 | 成功，2条结果轮廓；SVG/JSON可下载 |
| Offset切换凹形再切回带孔案例，delta7、Round、ArcTolerance0.2 | 成功，2条轮廓保留孔洞；SVG/JSON可下载 |
| Stroke切换返回起点案例，完整宽度12、Round端点、Square连接 | 成功，2条结果轮廓；SVG/JSON可下载 |
| 重开导出的offset.svg | 通过HTTP重新打开；viewBox有效，NonZero填充，孔洞可见 |
| 解析三场景与小数/扫掠导出JSON | 包含原输入、参数、精度、真实结果和简化统计 |
| Boolean小数输入 | Precision2保留小数，另抽查0和6成功 |
| Offset小数+Closed简化 | Precision2，delta2.5，删除1个共线点后计算成功 |
| Stroke小数 | Precision3，完整宽度6.25，成功 |
| Stroke显式Open简化 | 四点直线删2点，报告与结果可见 |
| 单点简化退化 | 三类报告保留，后续计算停止，SVG/JSON导出禁用 |
| Offset的MiterLimit1 | 库InvalidInput显示；有效结果清空，两导出禁用；改回2恢复 |
| 点数组输入[1,2] | 结构化输入错误，无未处理异常 |
| 扫掠选择偏置图案与闭合矩形路线 | 仅整数，精度控件禁用；2条轮廓含孔洞，可导出 |
| 显隐、缩放、自适应 | 正常，视图范围实际变化 |
| 390×844窄屏 | 单列，无横向溢出，控件与结果可用 |
| 静态包dist/index.html通过HTTP打开 | 真实计算成功，导出可用，无页面异常 |
| 页面错误与浏览器控制台 | 0个未处理异常/console.error |

三张主要场景截图位于docs/demo-screenshots。导出原件和详细操作记录保留在本地忽略目录demo/.qa与_build/demo-qa；仓库只保存简短记录及三张截图。截图计时不作为性能基准。

桥接冒烟：7/7通过，覆盖真实整数Boolean、带孔Offset、完整宽度Stroke、固定Minkowski短路线参考、小数三类入口、简化删点/退化阻断、结构化错误及导出结构。没有新增库测试或参考案例。本地未额外运行2234项整套库测试，未触发独立参考重建；普通Linux CI在最终提交上执行完整回归和演示构建/冒烟，远端结果单独核对。


<a id="commit23"></a>

# Commit 23 孔洞层级查看与结构导出验收

2026-10-20，Windows，通过 Codex 内置浏览器实际访问已启动的 `http://127.0.0.1:4173/`。沿用既有页面、Worker 和 Node 冒烟，没有增加浏览器测试框架或 npm 依赖。桌面与 390×844 窄屏分别检查，截图逐张查看；截图中的单次耗时不作为性能结论。

| 操作 | 实际结果 |
| --- | --- |
| 默认场景与平铺导出 | 原有平铺默认值保留，版本 1 JSON 结构通过冒烟核对 |
| Boolean 层级示例 | 1 根、3 轮廓、最大深度 3；外轮廓／孔洞／岛完整显示，选择孔洞或岛只高亮对应边界 |
| 展开、收起与清除选择 | 子节点可收起后展开，清除后无高亮；节点编号与当前响应的 paths 索引一致 |
| Offset 孔洞随参数变化 | delta=2 有两层；改为 10 后孔洞消失，变为一层；编辑参数立即清除旧树和选择并禁用导出 |
| Stroke 返回起点的开放路线 | 完整宽度 4，Miter／Square，外边界 [-2,-2]—[32,32]，孔洞 [2,2]—[28,28]，树为两层；完整坐标由桥接冒烟独立断言 |
| 三场景整数与小数树 | 六个核心入口均执行，Boolean／Stroke Precision=3，Offset 另检查 0 和 6；冒烟还用真实小数坐标核对完整轮廓 |
| 小数描边零宽度 | 成功空树，根数／轮廓数／最大深度均为 0，没有可选择节点，允许导出有效空结果 |
| 小数 Offset 的 MiterLimit=1 | 显示核心 InvalidInput / DecimalParameters，树、结果和选择清空，导出禁用；改回 2 可恢复 |
| Stroke 单点启用显式简化 | 显示 DegenerateAfterSimplification / SimplifyReport 及原退化索引，不运行后续几何，不导出部分树 |
| 较大请求后立即编辑 | 对 500 个矩形发起请求后将输入改为空；稍后仍处于“输入已更新 · 待计算”，旧响应未恢复树或导出；手动重算得到空树 |
| 切到图案扫掠 | 输出重置为 paths 且控件禁用，旧树与高亮清空；只运行整数平铺 |
| 实际下载 JSON | Boolean、Offset、Stroke 下载原件可解析为 MoonClipDemo v2，保存 request.version=1、result.paths、output、mode、precision 和完整 tree；三份实际下载文件已重放核对，自动测试另核对深复制 |
| 实际下载 SVG 后通过 HTTP 重开 | 单个 NonZero 复合 path，三条轮廓保留孔洞与岛，viewBox 有效，不含输入层或选择高亮；已目视检查 |
| 390×844 及长层级列表 | 单列布局，页面无横向溢出；12 层列表可滚动到末节点并选择，树摘要与高亮保留 |
| 静态包 dist/index.html 通过 HTTP 打开 | 构建产物运行三层 Boolean 树成功，独立 Worker 和模块正常加载 |
| 控制台 | 本次页面捕获的 error／warn 日志为 0 |

当前桥接／导出冒烟 **20/20**：保留原有 7 项，新增 13 项，包括六个树分支、空结果、多根和 12 层索引对齐、错误、显式简化、版本 2 重放与复制隔离及 SVG。`moon info`、`moon fmt`、JS deny-warn 检查、静态构建和 diff 检查通过。未在本地重复运行库全量、旧参考重建、性能测量或赛事提交。最终 SHA 的普通 Linux CI 另执行完整回归、演示构建／20 项冒烟、基准冒烟及候选消费者，其实际结果以该 SHA 的 Actions 日志为准。

库测试仍为 native／JS 各 **2323**，既有 **1384 个参考案例、2276 项能力检查**与根公开接口未变。本次没有新增上游对照矩阵，演示扩展属于 **Unreleased**。

截图保留在 `docs/demo-screenshots/tree-boolean.jpg`、`tree-offset.jpg`、`tree-stroke.jpg` 和 `tree-narrow.jpg`。实际下载 JSON、SVG 和验收收据位于本地忽略目录 `_build/commit23/`；SVG 的 HTTP 重开副本在 `demo/.qa/`。历史 Commit 17 的截图和记录保持原样。

![Boolean 孔洞与岛](https://raw.githubusercontent.com/BigSaltyMan/moonclip/fd047569a3d649fd6b2f08e07985ce364da8150a/docs/demo-screenshots/tree-boolean.jpg)

![偏移孔洞选择](https://raw.githubusercontent.com/BigSaltyMan/moonclip/fd047569a3d649fd6b2f08e07985ce364da8150a/docs/demo-screenshots/tree-offset.jpg)

![描边孔洞选择](https://raw.githubusercontent.com/BigSaltyMan/moonclip/fd047569a3d649fd6b2f08e07985ce364da8150a/docs/demo-screenshots/tree-stroke.jpg)

![窄屏层级列表](https://raw.githubusercontent.com/BigSaltyMan/moonclip/fd047569a3d649fd6b2f08e07985ce364da8150a/docs/demo-screenshots/tree-narrow.jpg)

## Commit 30：窗口裁剪增量验收

2026-10-22，Windows，Codex 内置浏览器，先用 `npm run dev` 启动 http://127.0.0.1:4173。只验收新增“窗口裁剪”页签，没有重验旧场景。复用这次唯一构建产物的 `demo rectclip:` 定向测试 **3/3**；JS 静态检查、前端语法及根公开接口检查通过。新增桥接／导出测试为 3 项，原有 20 项未执行。

- 默认窗口 [0,0]—[10,10]，输入 (-10,5)→(5,5)→(20,5)，真实结果为 (0,5)→(5,5)→(10,5)。DOM 路径为 M0,5L5,5L10,5，输入也未闭合；窗口为紫色虚线，结果覆盖在输入上方以便区分。
- max_x 改为 8，修改时立即禁用导出，计算结果终点更新为 (8,5)。min_x 改为 11 后返回 RectClipParameters / InvalidInput，当前结果清除，SVG／JSON 都禁用；恢复合法窗口后可再次计算。
- 实际点击下载 SVG 和 JSON，保存副本至 `_build/commit30/moonclip-rectclip.svg`、`_build/commit30/moonclip-rectclip.json`。SVG 经 HTTP 重新打开，只有开放线条、fill="none"、scale(1,-1)；JSON version=3，包含原窗口和路线，其 request 重新调用真实 MoonBit 桥接后逐点一致。
- 390×844 视口检查：四字段处于视口内，文档宽度 375 ≤ 390，max_x 可编辑并重新计算；新增页签控制台无 warning/error。临时视口覆盖已恢复。

下载 SVG SHA-256：`0b06c002ef863cd77f4d60d18c48d93eb8a93f2d908c89e66fb0be4eeb0456b6`。JSON SHA-256：`fedcc61d51dfdae3693597129777a8200eeee24a36d8ce102ce042eb221d61fe`。

仅保存一张新增页签截图：[窗口裁剪](demo-screenshots/rectclip.jpg)。这份记录属于本地浏览器和下载验收；同 SHA Linux CI 的轻量构建／测试结果另行核对，不把历史全量、参考、性能或注册表证据算成本笔结果。根几何算法、公开 API、旧参考、版本及发布标签未变，新功能为 Unreleased。

## Commit 31：小数扫掠增量验收

2026-10-22，Windows，Codex 内置浏览器，先重启本会话开发服务，以 `npm run dev` 唯一构建完成后访问 http://127.0.0.1:4173。本地 JS 静态检查及 `demo decimal minkowski:` **3/3** 通过；其中新增 2 项，旧结构化错误检查调整 1 项，保留其余有效断言。未运行整套桥接、库或工具测试，也未重复构建。

- 只验收“图案扫掠”的新增小数案例。Precision=2 时得到完整矩形，实际区域路径为 M1,-0.25L1,0.25L-1,0.25L-1,-0.25Z；4 个顶点、原有绕向和小数坐标保留。
- Precision 改为 3，先失效导出，再计算成功；改为 0 后返回 DecimalQuantize / QuantizationFailure，图案索引 0、顶点 1，关联顶点 0，结果清除且两种导出禁用。
- 恢复 Precision=2 后实际下载 SVG、JSON，副本保存于 `_build/commit31/moonclip-minkowski.svg`、`_build/commit31/moonclip-minkowski.json`。SVG 保留闭合 Z、NonZero 和小数坐标；JSON version=1，request 含原图案、路线、mode=decimal、precision=2、path_is_closed=false。将下载 request 重新交给真实桥接，完整结果逐点一致。
- 切回整数时输入的 ±0.25 保留，Precision 禁用，旧结果立即失效；点击计算返回 BridgeInput / InvalidInput（Integer mode requires integer coordinates），没有悄悄取整。
- 同页 390×844 窄屏下模式、Precision 和图案控件均位于可见宽度内，文档宽度 375 ≤ 390；控制台无 warning/error。临时视口已恢复。小尺度图形暴露坐标轴随缩放变粗的问题，已把 non-scaling-stroke 放到实际轴 path，浏览器复核后不再遮挡矩形。

下载 SVG SHA-256：`299a58dac9bc21036d1d8f3b7b7357031133b069207464b9215da2ae19219dda`。JSON SHA-256：`3d138c36a6490163b8458f72d613bf18adc6a85e54da42e46405261876e0072d`。

仅保存一张截图：[小数扫掠](demo-screenshots/minkowski-decimal.jpg)。本记录属于本地浏览器和下载验收，同 SHA Linux CI 轻量结果另行核对。根 API、整数扫掠及小数量化契约、旧参考、版本、标签和申报书未改动；本笔不接批量描边或点定位演示，保持 Unreleased。

## Commit 32：批量加宽增量验收

2026-10-22，Windows，Codex 内置浏览器；先重启本会话开发服务，`npm run dev` 唯一构建完成后通过 http://127.0.0.1:4173 验收新增页签。本地 JS 静态检查、格式和接口差异检查通过；复用产物的 `demo stroke batch:` **3/3** 通过。未运行全套桥接、库或工具测试，没有追加构建。

- 重叠直线案例的输入路径为 M0,0L10,0 M5,0L15,0，fill=none，两条独立开放子路径没有额外连接。真实输出为 M15,1L0,1L0,-1L15,-1Z，完整矩形 [0,-1]—[15,1]；统计为 2 条输入、1 条输出、4 个输出顶点。
- 将完整宽度改为 3.5、端点改为 Square 后重算成功，确认宽度仍按 Double 参数处理，修改时立即禁用导出。
- 第二条路线顶点设为 (1000000001,0)，返回 StrokeGenerate / CoordinateOutOfRange，path_index=1、vertex_index=1。旧结果层被清除，SVG／JSON 均禁用；恢复合法输入后计算和导出恢复。
- 恢复原案例后实际点击下载 SVG、JSON，副本保留在 `_build/commit32/moonclip-stroke-batch.svg` 和 `_build/commit32/moonclip-stroke-batch.json`。SVG 通过 HTTP 重新打开，显示闭合填充矩形，保留 Z 和 NonZero。JSON 为 v1，完整保存两条原始路线、width=2、Butt、Miter、MiterLimit=2、ArcTolerance=0；用下载的 request 重新调用真实桥接，结果逐点一致。
- 390×844 视口中四页签按两列显示，宽度、端点、连接和两个辅助参数均在横向可见范围内，文档宽度 375 ≤ 390；控制台无 warning/error，临时视口已恢复。
- 切回原“路线加宽”，坐标模式可见、结果结构重新可选、简化控件恢复，默认完整宽度恢复为 12。仅核对控件恢复，没有重验其他场景的操作矩阵。

下载 SVG SHA-256：`8f1b4d4b753fa13af888d1f98663660858e0f9919aa59aac6bc19f1c3021187f`。JSON SHA-256：`685409c067ec7fd2ef77e20383c41ddace6c4f45b04ce176915e026786bf4f44`。

仅保存一张新增页签截图：[批量加宽](demo-screenshots/stroke-batch.jpg)。本记录归属本地浏览器和下载验收；同 SHA Linux CI 只核对本笔轻量构建与 3 项检查，另行报告。根 `.mbti`、库算法、旧参考、规划书、申报书、版本和发布标签未变，功能保持 Unreleased。

## Commit 33：整数树点定位增量验收

2026-10-22，Windows，Codex 内置浏览器；重启本会话开发服务，以 `npm run dev` 唯一构建后通过 http://127.0.0.1:4173 验收本笔整数 Boolean Tree 查询。JS 静态检查、格式和接口差异通过；复用产物的 `demo tree locate:` **3/3** 通过，未跑库全量、历史分类或其他桥接测试，也未重复构建。

- 选择三层矩形案例时开关默认关闭。开启 (6,6) 查询，页面显示“孔洞内部”、本次节点 #1、深度 2、孔洞，紫色虚线命中孔洞完整边界，点标记可见。
- 手动选择外轮廓 #0 后，橙色手动边界与紫色查询 #1 同时存在。查询改为 (10,10)，旧结论／高亮和导出先失效，再显示“区域内部”、节点 #2、深度 3；改为 (-1,1) 返回“外部”，查询边界数为零，不残留岛高亮。
- 查询 x=1000000001 返回 PolyTreeQuery / CoordinateOutOfRange，原路径／顶点索引为 null，旧查询与结果清除、JSON 导出禁用。恢复 (6,6) 可重新计算和导出。
- 实际下载 JSON，副本保存为 `_build/commit33/moonclip-tree-query.json`，格式 v2，原请求 query.point=[6,6]，result.query.status=InHole。将下载 request 重新提交真实桥接后，命中轮廓 [(4,16),(16,16),(16,4),(4,4)]、深度 2、孔洞标记全部一致；没有用跨次节点编号证明对应关系。SVG 辅助核对仍只含区域，不含查询／选择属性。
- 关闭查询并重算后不显示查询结果或点标记；切换小数或平铺模式后控件隐藏且开关关闭。恢复整数 Tree 后可再次显式开启。
- 390×844 视口中 x、y 字段均处于横向可见范围，文档宽度 375 ≤ 390；孔洞结论和节点信息可显示，控制台无 warning/error，临时视口已恢复。

下载 JSON SHA-256：`c0b33ae4e7f9a2caf7a48bcb53b0723a8393611f0cbc358068901c9a16f88555`。仅保存一张完整页面截图：[整数树点定位](demo-screenshots/tree-locate.jpg)。

这份记录归属本地浏览器和下载重放；同 SHA Linux CI 的轻量构建及 3 项检查另行核对。根 `.mbti`、库算法与树存储、旧参考、规划书、申报书、版本和发布标签保持不变。新演示为 Unreleased，不扩展其他树的查询界面。


## Commit 38：小数矩形折线裁剪增量验收

2026-10-22，Windows，本地 `npm run dev` 构建一次后，通过 Codex 内置浏览器访问 http://127.0.0.1:4173/。只检查新增小数流程，原有 3 项 `demo rectclip:` 扩展后 3/3 通过，没有新增测试块。根 `.mbti` 无变化；Linux 同 SHA CI 另行核对，不把本地浏览器记录当作 Linux 证据。

| 操作 | 实际结果 |
|---|---|
| 小数案例 Precision=2 | 窗口和输入正确显示，1 个片段、3 个顶点，完整结果 (-1.25,0.25)→(0.5,0.25)→(2.75,0.25) |
| 修改 max_x=2.25、Precision=3 | 结果末点更新为 (2.25,0.25)，共线中间点保留 |
| min_x=0.1、max_x=0.2、Precision=0 | 核心 DecimalQuantize / QuantizationFailure，旧结果清除，SVG／JSON 导出禁用 |
| 实际下载并打开 SVG | 开放 d 为 M-1.25,0.25L0.5,0.25L2.75,0.25，fill=none，无 Z，仅结果线条 |
| 实际下载 v3 JSON 并重放 | 原始窗口、路线、mode=decimal、precision=2 完整保留；request 重放逐点一致 |
| 小数切回整数 | 原窗口和路线保留，Precision 禁用，BridgeInput 明确拒绝小数，导出禁用 |
| 窄屏 | 390×844 同源 iframe 容器中页签换行，模式／精度和窗口参数可操作，未改产品页面布局或引入依赖 |
| 控制台 | 主页面 error／warn 为 0；窄屏容器记录 1 条无源码位置的 MutationObserver observe 异常，页面仍正常操作和计算。演示源文件未包含该调用，异常归因未确认，不宣称窄屏控制台完全无异常 |

浏览器视口 override 未改变实际 1280×720 尺寸，因此改用忽略目录中的同源 iframe 创建真实 390×844 内容视口；已清除 override 并关闭临时容器。截图仅保存[小数裁剪页签](demo-screenshots/commit38-decimal-rectclip.png)。浏览器实际下载原件复制在忽略目录 `demo/.qa/commit38/result.svg` 与 `result.json`，Node 使用生成的真实 MoonBit 桥接重放 JSON。截图计时不是性能测量。未复测其他场景、完整桥接、根库、参考、性能或候选包；未调整版本或发布。


## Commit 39：小数多路线批量描边增量验收

2026-10-22，Windows，在本地 `npm run dev` 构建一次后，通过 Codex 内置浏览器访问 http://127.0.0.1:4173/。原有 3 项 `demo stroke batch:` 扩展后 **3/3** 通过，没有新增测试块或 scope；导出代码直接复用，根 `.mbti` 无变化。Linux 同 SHA 轻量 CI 单独核对，不把本地浏览器操作计为 Linux 验收。

| 操作 | 实际结果 |
|---|---|
| 小数批量案例，width=0.5、Precision=2 | 两条输入独立开放，输出合并为四顶点矩形 [-1.25,0.25]—[1.75,0.75] |
| 修改 width=1、Precision=3 | 真实重新计算，区域更新为 [-1.25,0]—[1.75,1] |
| 两条路线分别含 (0.001,0)、(0.002,0)，Precision=2 | DecimalQuantize / QuantizationFailure，path=1、vertex=0，related 指向 path=0、vertex=0；旧结果清除，导出禁用 |
| 恢复案例并实际下载 SVG／JSON | SVG 可打开，闭合且 NonZero 填充，真实小数坐标保留；v1 JSON 保留原始路线、mode=decimal、precision=2 和 width=0.5 等原单位参数，request 重放逐点一致 |
| 切回整数 | 小数路线和参数原值保留，Precision 禁用，BridgeInput 明确拒绝坐标，导出禁用 |
| 主页面与窄屏对照 | 实际主页面内容视口 1280×720；临时同源 iframe 内脚本实测 390×844、scrollWidth=375。两处均完成案例、宽度／精度更新、量化错误、恢复和模式拒绝操作，窄屏控件正常；下载和重放使用主页面实际文件 |

有限对照只执行一轮。主页面 error／warn 日志为空。临时窄屏容器的浏览器日志再次出现：

```text
Uncaught TypeError: Failed to execute 'observe' on 'MutationObserver': parameter 1 is not of type 'Node'.
```

日志时间为 **2026-10-22T11:18:21.282Z**，早于诊断页 load 记录 **11:18:21.445Z**，即进入批量页签之前；浏览器日志接口没有提供来源地址、行列或堆栈，保存时 source／stack 明确记为 null。临时子页安装的 error／unhandledrejection 监听没有捕获对应事件（errors=[]）。演示 app／worker／export／HTML 和桥接源码未找到 MutationObserver 调用；这些观察不足以确定错误来源，**归因仍未确认，暂不定性为页面布局缺陷**，也不宣称窄屏控制台完全无异常。没有据此修改产品布局、加入防御性补丁或展开长期排查。

诊断仅在忽略目录中的 HTML 副本加入监听和 base 地址，不改产品页面；实际视口数据由子页通过同源 postMessage 报告，不使用设置目标值冒充测量结果。完整本地诊断位于 `demo/.qa/commit39/main-observation.json`、`narrow-observation.json`；实际下载原件为同目录 `result.svg`、`result.json`。临时容器已关闭，未设置浏览器 viewport override。

仅保存一张[小数批量加宽截图](demo-screenshots/commit39-decimal-stroke-batch.png)，截图计时不代表性能结论。未运行库全量、完整工具／桥接、参考重建、性能、基准或候选验收；未修改消费者、版本和发布标签，保持 Unreleased。


## Commit 40：闭合区域窗口裁剪增量验收

2026-10-22，Windows，启动 `npm run dev` 构建一次后，通过 Codex 内置浏览器访问 http://127.0.0.1:4173/。扩展已有 `demo rectclip:` 三项后 **3/3** 通过，没有新增测试块或 scope。根 `.mbti` 无变化；Linux 同 SHA 轻量 CI 另行核对，不把本地浏览器操作当作 Linux 验收。

| 操作 | 实际结果 |
|---|---|
| 开放切闭合 | 原点数组逐字保留，案例列表切换为区域案例并选择“保留当前输入”，填充规则可见，旧结果和导出清除 |
| 整数同向嵌套矩形 | EvenOdd 返回窗口外轮廓及孔洞（2 轮廓／8 点）；NonZero 返回完整窗口（1 轮廓／4 点），完整坐标已核对 |
| 小数带孔区域 | Precision=2 返回窗口 [-1.25,-0.5]—[2.75,2.5] 及负向孔洞 [0,0]—[1,1] |
| 修改 max_x=2.25、Precision=3 | 外轮廓右界更新为 2.25，孔洞保留，2 轮廓／8 点 |
| 实际闭合下载 | 恢复手算案例后下载 SVG、v1 JSON；SVG 打开后孔洞可见，两个 Z 闭合轮廓、NonZero 填充。JSON 保存 input_kind=polygons、EvenOdd、窗口、原始路径、decimal 和 precision=2；真实桥接重放逐点一致 |
| 切回开放 | 原区域点数组保留，填充规则隐藏，输入不再闭合、无填充，导出禁用；选择小数开放案例后恢复三点片段，实际下载 JSON 为 v3、input_kind=lines、geometry=open-paths |
| 窄屏抽查 | 临时同源 iframe 内实测 390×844、scrollWidth=375；输入类型、模式、Precision、填充和窗口控件可用，区域计算正常 |

主页面控制台 error／warn 为 0。临时窄屏容器仍记录一条 `Uncaught TypeError: Failed to execute 'observe' on 'MutationObserver': parameter 1 is not of type 'Node'.`，时间为 **2026-10-22T15:32:58.259Z**，早于容器 load 记录 **15:32:58.406Z**。来源地址及堆栈未提供，局部 error／unhandledrejection 监听记录为空；**归因继续未确认，不定性为页面布局缺陷**，不宣称窄屏控制台完全无异常。本笔只做一次抽查，没有修改浏览器环境、重复排查或据此更改布局。

下载原件及重放材料保留在忽略目录 `demo/.qa/commit40/result.svg`、`result.json`、`open-result.json`；主页面／窄屏诊断保留在同目录 `main-observation.json`、`narrow-observation.json`。诊断仅位于临时 HTML 副本，未混入产品；容器已关闭。仅新增一张[区域窗口裁剪截图](demo-screenshots/commit40-rectclip-regions.png)，计时不作为性能证据。

未运行库全量、全部工具／桥接、参考重建、性能、基准或候选验收；原规划书、申报书、版本和标签不变，新演示保持 Unreleased。
