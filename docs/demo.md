# MoonClip 交互演示

## Commit 33：整数 Boolean 树点定位（Unreleased）

选择整数 Boolean 的 Tree 输出后可见“启用点定位”，默认关闭。新增“点定位 · 外轮廓 / 孔洞 / 岛”案例只保存三层矩形、参数及默认点 (6,6)。开启后编辑整数 x、y，用现有“计算结果”按钮提交；没有画布取点、悬停、拖动或缓存查询。其他模式／场景出现 query 字段时桥接明确拒绝；页面切换到这些模式会隐藏并关闭开关。

每次提交构建一次整数树，并对同一棵树调用一次 `locate`，再编码展示数据。匹配使用完整点序列、深度和孔洞标记，不循环移位、不反向、不删点；每个命中必须唯一对应展示节点，缺失或歧义返回桥接错误。展示索引不等于库内部编号，只对本次响应有效。没有前端点包含算法，也不从平铺结果构造第二棵树。树构建和公开定位调用分别使用各自的核心预算；节点快照和 JSON 编码不计入核心预算。

状态 Outside、Inside、InHole、OnBoundary 分别显示外部、区域内部、孔洞内部、边界。内部返回最深节点；边界显示全部命中，不承诺几何排序。页面显示命中编号、深度及孔洞标记，紫色虚线为查询高亮，橙色实线仍是独立手动选择，品红点标记查询位置；外部不保留旧高亮。输入、参数或查询点修改会清空旧结论、辅助绘图和有效导出，迟到响应继续受请求编号约束。越界点由核心返回 PolyTreeQuery 错误，失败无可导出的部分树。

树 JSON 沿用 v2，查询开启时额外保存 `result.query` 的 point、status、node_indices，原始查询请求仍在 request 中；重放会重新构树和定位，核对命中快照而不是跨次索引。关闭时响应与导出无 query 字段。查询信息保存在 JSON，SVG 只导出区域结果，不带点或高亮；v1 平铺和 v3 开放导出不变。

本地开发服务只构建一次，复用产物执行 `node --test --test-name-pattern="demo tree locate:" smoke.test.mjs`。普通 CI 使用 `bash scripts/check.sh --scope demo-tree-locate`，只做格式／接口、JS 静态检查、一次构建和 3 项定向检查。见[增量验收](demo-acceptance.md#commit-33整数树点定位增量验收)。不接小数、Offset／Stroke、批量点、索引或最近边查询，未调整版本或发布。

## Commit 32：多路线批量加宽（Unreleased）

“路线实验 → 批量加宽”一次提交 `Paths` 中的多条独立开放路线，桥接只调用一次 `stroke_polylines`。全部路线共享完整宽度、端点、连接、MiterLimit 与 ArcTolerance，由核心统一清理重叠区域。仅支持整数坐标和平铺输出，width 仍是 Double 完整宽度，可以包含小数；不提供小数坐标模式、树或简化。原有单路线页签仍独立保留。

只提供“两条直线 · 重叠合并”和“两条转角路线 · 共享样式”两个输入案例；编辑区为多路线 Paths。输入按开放子路径绘制，不连接各路线端点；结果按 NonZero 闭合区域显示，可含孔洞，不保证与输入路线逐条对应。页面统计输入路线、输出轮廓和输出顶点，四个路线页签使用两列布局。批量页签隐藏模式／Precision、树、填充和简化控件，请求只保留整批适用参数。

修改坐标、宽度或样式以及场景切换都会清除有效结果、禁用导出，迟到响应仍受请求编号约束。SVG 导出真实合并区域，JSON 沿用 v1，保存完整原始路线和共享样式，request 可直接重放，不使用裁剪页签的开放输出协议。

本地开发服务只构建一次，复用产物执行 `node --test --test-name-pattern="demo stroke batch:" smoke.test.mjs`。普通 CI 使用 `bash scripts/check.sh --scope demo-stroke-batch`，只执行格式／接口、JS 静态检查、一次构建及 3 项定向检查。浏览器、下载与重放见[增量验收](demo-acceptance.md#commit-32批量加宽增量验收)。Commit 32 未接批量小数、批量树、逐路线样式或树点定位；整数 Boolean 树查询见上方 Commit 33，仍未发布。

## Commit 31：小数图案扫掠（Unreleased）

沿用“路线实验 → 图案扫掠”，整数调用 `minkowski_sum`，小数直接调用 `minkowski_sum_d`。新增“小数扫掠 · 两点图案”案例：图案 (0,-0.25)、(0,0.25)，开放路线 (-1,0)→(1,0)，Precision=2，结果为四顶点矩形 [-1,-0.25]—[1,0.25]。已有整数案例仍是默认项，图案下拉中的“案例／自定义图案”不会替换编辑区坐标。

小数模式启用 Precision，默认 3、支持 0—6，图案与路线使用相同坐标单位，由 MoonBit 入口共同量化；精度过粗可能发生量化碰撞。图案不自动居中，不额外补满端点或闭合路线内部。模式切换保留原始输入、立即清除结果并禁用导出；切回整数后含小数的输入会明确报错，不静默取整。树输出及隐式简化继续拒绝，窗口裁剪仍只支持整数开放路线。

扫掠结果仍按闭合区域显示和 NonZero SVG 导出；JSON 沿用 v1，完整保存模式、Precision、图案、路线、开闭参数及真实结果，request 可直接重放。没有前端倍率缩放或量化。小尺度视图的坐标轴在实际 path 上设置固定线宽，避免缩放后遮挡区域。

本地 `npm run dev` 只构建一次，随后复用产物执行 `node --test --test-name-pattern="demo decimal minkowski:" smoke.test.mjs`。本笔新增 2 项检查、调整 1 项旧错误检查，只执行这 3 项。普通 CI 使用 `bash scripts/check.sh --scope demo-minkowski-decimal`，只做格式／接口、JS 静态检查、一次构建及 3 项定向检查；不运行完整桥接或库测试。浏览器与实际下载验收见[记录](demo-acceptance.md#commit-31小数扫掠增量验收)，未发布新版本。

## Commit 30：窗口裁剪（Unreleased）

从“路线实验”进入“窗口裁剪”，选择案例或编辑多路线 `Paths` 数组和 min_x、min_y、max_x、max_y，点击计算。只接受整数开放路线；隐藏宽度、连接、端点、填充、Precision、树和简化选项。每条路线独立，不连接端点。窗口用紫色虚线、输入用橙色、结果用绿色表示，可切换输入／结果显示、缩放及自适应；视图范围包含窗口、输入和结果，统计输入路线数、输出片段数和顶点数。

桥接独立分派 `scene: "rectclip"`，真实调用 `rect_clip_lines`，响应标记 `geometry: "open-paths"`。窗口和路线复用整数解析，小数坐标、小数模式、树或启用简化均拒绝。输入修改、切换场景或失败会清除结果并禁用导出；请求编号继续阻止迟到响应恢复旧结果。

SVG 仅导出真实结果，使用开放 M/L 与 fill="none"，不闭合或补点，y 向上；空结果使用默认视图生成合法空 SVG。JSON 为 MoonClipDemo v3，记录完整原始 request 与开放路径 result；重新提交 request 即可复现。旧区域 v1、树 v2 格式不变，不新增导入界面。两个案例分别为保留中间点的穿越和先出后入的分段输入。

本笔本地只运行 `npm run dev` 构建一次，然后在 demo 中复用产物执行 `node --test --test-name-pattern="demo rectclip:" smoke.test.mjs`。普通 CI 使用 `bash scripts/check.sh --scope demo-rectclip`，只进行格式／接口、JS 静态检查、一次静态构建及 3 项定向测试；不执行下文历史全套验收入口。浏览器记录见[增量验收](demo-acceptance.md#commit-30窗口裁剪增量验收)。其他三项增量的演示接入另行安排，未发布新版本。

本文的六个树入口均自 **0.2.0** 提供，见[正式发布记录](release-0.2.0.md)。演示从仓库启动；旧锚点继续兼容已有链接，截图和验收记录保留原提交归属。

## 本地启动与静态构建

使用项目固定MoonBit工具链与Node.js20以上。本机验证Node.js24.18.0；没有npm依赖，不需要npm install。Windows的npm脚本使用已安装Git Bash，Linux使用bash。

```bash
cd demo
npm run dev
```

dev只构建cmd/demo所需JS，并在127.0.0.1:4173启动HTTP服务。先启动再打开网址，不使用file://。无热更新；修改网页文件后刷新，修改MoonBit桥接后运行bash scripts/build_demo.sh再刷新（在根目录运行）。静态文件通过相对地址加载ES模块和worker，同源HTTP/HTTPS托管即可。

```bash
# 另一个终端，demo目录；复用已编译产物
npm test
npm run build -- --reuse
# 干净检出或需要重新编译
npm run build
```

build生成demo/dist，包含HTML、CSS、案例输入、界面/导出/worker脚本和MoonBit JS。dist、generated、node_modules及本地.qa导出材料均被忽略，不提交编译JS。build_demo.sh可从任意调用目录运行，只构建JS桥接包，不运行整套库测试。npm test仅执行20项桥接/导出冒烟，不增加几何对照矩阵。

## 场景与参数

| 场景 | 输入与参数 | 坐标模式 |
| --- | --- | --- |
| 区域Boolean | 两组有序轮廓；Intersection/Union/Difference/Xor；EvenOdd/NonZero | 整数或小数 |
| 带孔偏移 | 轮廓及孔洞；有符号delta；四种Join；MiterLimit；ArcTolerance | 整数或小数 |
| 路线加宽 | 单条开放路线；完整width；Butt/Square/Round端点；四种Join | 整数或小数 |
| 图案扫掠 | 一个图案、一条路线；显式开闭；图案直接相加 | 整数／小数，开发演示 Unreleased |
| 批量加宽 | 多条独立开放路线、共享样式、一次合并覆盖区域 | 仅整数坐标，开发演示 Unreleased |

整数坐标要求合法JSON整数，桥接只接受可精确表示的安全整数，之后由库检查几何范围±10^9；小数直接构造PointD并传入Precision0—6。没有前端自行缩放的小数扫掠。距离、完整宽度、正ArcTolerance及epsilon都使用当前输入坐标的原始单位；MiterLimit无量纲且至少2，ArcTolerance0保留库的自动策略。允许负偏移，参数错误原样显示库错误和位置。

案例文件只含输入与参数，取材于已有矩形、孔洞、凹轮廓、折线和整数图案构型，不链接参考预期作为结果。点数组编辑器：Boolean/Offset为Paths（多层数组），Stroke/Minkowski路线为Path，图案也为Path；批量加宽为Paths。闭合轮廓一般不重复首点；路线末尾返回首点不替代扫掠的显式闭合开关。

图形按数学坐标系显示，x向右、y向上。蓝色为输入区域/操作数A，橙色为操作数B或路线，紫色为局部图案及原点十字，绿色为真实结果。扫掠图案绘于局部原点，路线各顶点对应平移位置；偏置图案不会自动居中。可显隐输入/结果、自适应、按钮/滚轮缩放、拖动平移。绘制通过SVG坐标变换处理y轴，不改变核心语义。结果按NonZero复合路径绘制孔洞。

<a id="unreleased-孔洞层级查看与桥接协议"></a>

## 孔洞层级查看与桥接协议（自 0.2.0）

结果结构默认 `paths`；切换为 `tree` 后重新计算，Boolean、Offset、Stroke 根据整数／小数模式分别调用 `boolean_tree` / `boolean_tree_d`、`offset_tree` / `offset_tree_d`、`stroke_tree` / `stroke_tree_d`。每次只运行选中的一个几何入口。Minkowski 禁用层级输出并重置为平铺，切换时清空树与选择。演示从仓库运行，所调用的新增库入口已随 Mooncakes 0.2.0 发布，0.1.0 不包含它们。

桥接请求仍为 `version: 1`，可选 `output: "paths" | "tree"`，省略时为 `paths`。未知值或 Minkowski 的 tree 请求返回 `BridgeInput` 错误。成功响应保留 paths，并标记 output；只有树响应包含 tree：

```json
{
  "output": "tree",
  "paths": [[[0,0],[20,0],[20,20],[0,20]], [[5,5],[5,15],[15,15],[15,5]]],
  "tree": {
    "roots": [0],
    "nodes": [
      {"parent": null, "children": [1], "depth": 1, "is_hole": false},
      {"parent": 0, "children": [], "depth": 2, "is_hole": true}
    ]
  }
}
```

paths 保留完整 `[x,y]` 点数组。`nodes[i]` 与 `paths[i]` 一一对应，所有索引在当前响应内有效；根 parent 为 null。空区域 paths、roots、nodes 都为空数组。桥接仅通过公开树访问器，使用迭代队列在同一次遍历中分配轮廓和节点索引，不根据几何猜父子，也不依赖另一次 `to_paths()` 的顺序。传输保留完整点序、绕向和小数值，不保证跨请求节点编号稳定。

面板列出根数、轮廓数、最大深度，以及每个节点的编号、深度、外轮廓／孔洞和顶点数。点击展开箭头收起或展开孩子；点击节点仅高亮对应边界，孔洞不会单独填实。可清除选择，窄屏列表可滚动。主结果始终按 NonZero 复合路径绘制。

三个“层级查看”示例只保存输入：Boolean 展示外轮廓／孔洞／岛；Offset 的矩形孔洞可把 delta 从 2 调到 10 观察消失；Stroke 展示返回起点的开放路线，在 Miter 连接、Square 端点及完整宽度 4 下形成孔洞。首尾重合不改成闭合偏移。

## 显式简化与失败

简化默认关闭。开启时Boolean与Offset调用Closed，Stroke调用Open。Boolean的报告路径索引先排列全部subject，再排列全部clip。显示removed_vertices、removed_per_path及input_degenerate_indices、degenerate_indices、collapsed_indices。

三类退化列表任一非空时，先显示报告并停止后续计算；不补点、不删除路径、不自动过滤。简化不是拓扑修复。Minkowski不隐式简化，切到扫掠时关闭简化开关。

worker调用同一MoonBit编译产物，界面不实现Boolean、Offset、Stroke、Simplify或Minkowski。JSON解析/类型错误与库错误分开返回，库错误保留kind、stage、path_index、vertex_index及适用的轴/值/资源/关联位置。输入编辑立即失效结果，旧请求的迟到响应按请求编号丢弃；失败后无结果层且两个导出按钮禁用。修正后必须重新计算。

## 导出与复现

SVG只导出当前有效结果，包含独立viewBox、白色背景、数学坐标变换与NonZero填充，孔洞保持为空；不需要外部字体、样式或脚本。坐标来自真实结果数组。

平铺 JSON 格式为 MoonClipDemo 版本 1，包含kernel、完整原始request（场景、两操作数/路线/图案、模式、参数、precision、简化选项）、result.paths及simplification统计。可把导出的request再次传给compute复现；结果不从SVG字符串或像素反推。整数结果precision为null；request中的precision在整数模式下不参与量化。

树 JSON 为 MoonClipDemo 版本 2，result 同时包含 output、mode、precision、paths 与 tree，可选 query 只用于整数 Boolean 树点定位；顶层 request 仍是可直接重放的版本 1 桥接请求，simplification 保留统计。所有数组、节点、输入参数与简化报告都独立复制。SVG 仍只输出结果轮廓，不输出输入层、节点列表或高亮。

启用简化时先显式简化，再调用所选树入口；简化与几何是两次公开调用，各自建立核心预算。单个树入口内沿用核心累计预算，桥接 JSON 序列化、公开访问器副本和 UI 绘制不计入核心预算。编辑输入、输出模式、精度或参数立即清空摘要、树与选择，禁用导出；错误不会自动改为平铺重算，迟到响应不能重新启用导出。

图案扫掠不额外补满完整端点图案，短路线可留空隙，闭合路线可留孔洞。演示不提供开放Boolean、MinkowskiDiff、带孔图案集合、批量小数或批量树描边。页面显示的耗时仅为worker内单次桥接调用时长，不是基准性能结论。

不依赖浏览器的同类公开调用保留在cmd/example/main.mbt：moon run --target native cmd/example。

## 实际场景截图

![区域Boolean](https://raw.githubusercontent.com/BigSaltyMan/moonclip/6a116b45600cbe8ecd577664a71b50fdfa8ce5c0/docs/demo-screenshots/boolean.png)

![带孔偏移](https://raw.githubusercontent.com/BigSaltyMan/moonclip/6a116b45600cbe8ecd577664a71b50fdfa8ce5c0/docs/demo-screenshots/offset.png)

![路线加宽](https://raw.githubusercontent.com/BigSaltyMan/moonclip/6a116b45600cbe8ecd577664a71b50fdfa8ce5c0/docs/demo-screenshots/stroke.png)


## 层级查看验收

Commit 23 的实际交互、导出与窄屏记录见 [浏览器验收](demo-acceptance.md#commit23)。库回归仍为 native／JS 各 2323；20 项桥接／导出测试独立统计。现有 1384 条参考、2276 项能力检查没有扩展，本次不据此宣称新增演示入口已进入上游矩阵。
