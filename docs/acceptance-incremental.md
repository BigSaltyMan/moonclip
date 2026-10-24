# 0.2.1 之后的增量验收索引

功能基线为 Commit 51：[`52692624a4ef717d2b462b854cf0ea72390196be`](https://github.com/BigSaltyMan/moonclip/commit/52692624a4ef717d2b462b854cf0ea72390196be)。本文整理既有记录和同 SHA CI，不重新运行历史检查。能力均按开发源码 **Unreleased** 解释，不构成新版本发布或赛事申报验收。

## 统计口径

| 数字或结果 | 归属与含义 |
| --- | --- |
| native 2370/2370、JS 2370/2370 | Commit 26 的历史完整回归，见下方基线证据；不是 Commit 51／52 的全量结果 |
| 2406 | 当前 `scripts/check.sh` 完整入口配置期望；本功能基线未执行新的完整回归，不能写成当前提交全量通过 |
| 核心定向 3/3 | 各自提交与 scope 的实际结果，native、JS 分别记录；不相加为一个目标的结果 |
| 演示 3/3 | 同一筛选组随功能扩展复用，不把每次 3/3 累加为新增独立测试总数，也不算新增库测试 |
| 1416 个参考案例、2308 项能力检查 | 原 1384／2276 加整数开放矩形裁剪 32／32；一个案例可有多项能力检查，两者不能混用 |
| Commit 52 | 新增测试 0 项、执行几何测试 0 项；仅文档链接与差异检查，没有演示构建、参考重建或性能测量 |

普通 CI 由 CHECK_SCOPE 选择范围。Commit 27 之后的功能增量使用轻量 scope，Commit 52 为 docs，Commit 53 为 package；`full` 入口继续保留，普通 CI 绿色不自动表示执行过完整检查。参考目录也不意味着所有新接口已逐项上游对照。

## 历史完整基线与参考

Commit 26：[`cff654190fdbb5bbb47c5cb11b208a6a9f209deb`](https://github.com/BigSaltyMan/moonclip/commit/cff654190fdbb5bbb47c5cb11b208a6a9f209deb)。当时本地新增定向检查 native **47/47**、JS **47/47**；[同 SHA 普通 CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39621063681)完整执行 native **2370/2370**、JS **2370/2370**。新增整数开放裁剪参考为 32 个，[独立 rectclip 参考工作流](https://github.com/BigSaltyMan/moonclip/actions/runs/39621151007)复核新增选择。

既有本地摘要为忽略目录 `_build/commit26/acceptance.json`，本文不要求读者从干净检出访问该产物；持久入口为上述提交、CI 和[兼容报告](compatibility.md)。目录总计 **1416 个案例、2308 项能力检查**。旧参考及选择文件没有随后续功能重建，不声称旧清单执行了新增树、批量或查询入口。

## 核心能力定向证据

下表两目标列记录对应历史 Linux CI 日志中的结果，不表示本笔重跑。每个提交链接对应完整 SHA，CI 链接与该 SHA 一致。

| 能力 | 提交 | scope | CI native | CI JS | 同 SHA CI |
| --- | --- | --- | --- | --- | --- |
| 整数闭合窗口 | [C35 · d189f24](https://github.com/BigSaltyMan/moonclip/commit/d189f24f582822d691b4e8cb7ea83b3fcae49f26) | rectclip-polygons | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39764353675) |
| 小数闭合窗口 | [C36 · cca6cfd](https://github.com/BigSaltyMan/moonclip/commit/cca6cfd13d88c54704ca2e55ae5104b8facb67e0) | rectclip-polygons-decimal | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39765341688) |
| 小数开放窗口 | [C37 · d6f1f63](https://github.com/BigSaltyMan/moonclip/commit/d6f1f63c66f8d726ef5309a4bdd4c63409e76455) | rectclip-lines-decimal | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39766026770) |
| 整数／小数闭合窗口树 | [C43 · ce978e5](https://github.com/BigSaltyMan/moonclip/commit/ce978e511715f52d1e98aea51d456ded4782548f) | rectclip-tree | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39897199923) |
| 整数批量描边 | [C27 · fc7d305](https://github.com/BigSaltyMan/moonclip/commit/fc7d305c46cdcf18869925e02541ddb8e4012c13) | stroke-batch | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39722894024) |
| 小数批量描边 | [C34 · f5fe834](https://github.com/BigSaltyMan/moonclip/commit/f5fe834b528c28f1fd47ea8dea8c9b82b5db2fb9) | stroke-batch-decimal | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39761426445) |
| 整数／小数批量描边树 | [C41 · 0a3c77e](https://github.com/BigSaltyMan/moonclip/commit/0a3c77e15d8d9246788e98ecf44697c104fdee52) | stroke-batch-tree | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39894479593) |
| 小数 Minkowski | [C28 · 1a38f0c](https://github.com/BigSaltyMan/moonclip/commit/1a38f0c349ab923b953490509ec8f95146b3981b) | minkowski-decimal | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39723924193) |
| 整数／小数 Minkowski 树 | [C45 · 139d0c4](https://github.com/BigSaltyMan/moonclip/commit/139d0c44eb881765a5bd89cf6959cb2e991866cb) | minkowski-tree | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39929666499) |
| 整数树单点定位 | [C29 · e7b6b34](https://github.com/BigSaltyMan/moonclip/commit/e7b6b34e20e84ad39fa166e46aa8dd2555977559) | tree-locate | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39724599708) |
| 整数树批量定位 | [C48 · aa8d3bd](https://github.com/BigSaltyMan/moonclip/commit/aa8d3bd3b7f55ae5bce6c27b1ec572cac2af3274) | tree-locate-batch | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/39969283589) |
| 小数树单点／批量定位 | [C50 · f62a875](https://github.com/BigSaltyMan/moonclip/commit/f62a8758d4a341fc4b2ca3a9b37589873269e064) | tree-locate-decimal | 3/3 | 3/3 | [运行](https://github.com/BigSaltyMan/moonclip/actions/runs/40063468200) |

本地历史结果单独处理：已核对 Commit 26 的摘要（native 47/47、JS 47/47），以及 Commit 43、45 的本地验收摘要（两笔分别为 native 3/3、JS 3/3，位于忽略目录 `_build/commit43-acceptance.json`、`_build/commit45-acceptance.json`）。[定位专题](polytree-query.md)另有 Commit 48、50 的 Windows 本地记录，两笔分别为 native 3/3、JS 3/3；这些都是原阶段记录，文档整理没有重跑。上表其余核心提交的本地历史结果在 Commit 52 整理中**未核实**，不从 Linux CI 推算本地通过。截至 Commit 51 的新增全量、性能及候选消费者验收**未执行**；后续开发源码包检查见下方 Commit 53 专节。

这些定向测试针对新增入口的完整坐标、层级、错误、隔离或预算边界，覆盖范围见[窗口](rectclip.md)、[批量组合](composition.md)、[扫掠](minkowski.md)和[查询](polytree-query.md)专题。它们不是任意输入完备性证明。

## 演示与浏览器证据

下面按能力列出最近的对应演示交付。Linux CI 只做该 scope 的静态检查、一次构建及三项桥接／导出检查；Windows 浏览器下载、重放和窄屏记录分开归属，不称为 Linux 浏览器验收。

| 能力组 | 提交及同 SHA CI | 复用检查 | 本地操作记录 |
| --- | --- | --- | --- |
| 批量描边平铺／树、整数／小数 | [C42 · 46db292](https://github.com/BigSaltyMan/moonclip/commit/46db292f5086f0c9c46d59b32bc8476ffa65e2cd) · [CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39896021062) | demo stroke batch: 3/3 | [C42 浏览器及下载重放](demo-acceptance.md#commit-42批量描边孔洞树增量验收) |
| 窗口开放／闭合、平铺／树 | [C44 · eebea22](https://github.com/BigSaltyMan/moonclip/commit/eebea22d4143920aebf79e74331e57e307617f7d) · [CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39926545760) | demo rectclip: 3/3 | [C44 浏览器及下载重放](demo-acceptance.md#commit-44窗口裁剪孔洞树增量验收) |
| Minkowski 平铺／树、整数／小数 | [C46 · 2fe3e36](https://github.com/BigSaltyMan/moonclip/commit/2fe3e368c41362248d80ecff95f5a6a688ab4205) · [CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39931459932) | demo decimal minkowski: 3/3 | [C46 浏览器及下载重放](demo-acceptance.md#commit-46minkowski-sum-孔洞树增量验收) |
| 六类整数树查询路由 | [C47 · a3ecd7f](https://github.com/BigSaltyMan/moonclip/commit/a3ecd7f81522fba13f007fc23e449aed1e63dcaa) · [CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39966275685) | demo tree locate: 3/3 | [C47 浏览器及重放](demo-acceptance.md#commit-47扩展整数树点定位增量验收) |
| 整数批量查询界面 | [C49 · 4ee8bd8](https://github.com/BigSaltyMan/moonclip/commit/4ee8bd83b1cc863adb5fe39985242af98f1d2bc1) · [CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39972897960) | 同一查询组 3/3 | [C49 浏览器及重放](demo-acceptance.md#commit-49整数树批量点定位增量验收) |
| 小数单点／批量查询界面 | [C51 · 5269262](https://github.com/BigSaltyMan/moonclip/commit/52692624a4ef717d2b462b854cf0ea72390196be) · [CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40064333721) | 同一查询组 3/3 | [C51 浏览器及重放](demo-acceptance.md#commit-51小数树单点与批量定位增量验收) |

以上浏览器章节记录了各笔本地三项通过、实际下载文件、真实请求重放、截图和窄屏观察。当前使用范围见[演示说明](demo.md)，不把历史章节中的“当时仅整数”等限制套用到现在。Commit 51 的其余四类小数树接线通过代码审查确认，没有为六场景铺单点／批量全组合矩阵。

临时窄屏容器多次出现无源码位置的 MutationObserver 异常，可获得的错误、时间及堆栈缺失情况保留在原章节。**归因未确认**，没有证据将其定性为布局缺陷，也不写成已解决或控制台完全无异常。本笔不重新进行浏览器验收。

## 性能、消费者与发布的原始归属

- [性能基线](benchmarks.md)属于 Commit 18：`6a116b45600cbe8ecd577664a71b50fdfa8ce5c0`，指定 Windows x64／native release 环境的 11 个案例。没有为本轮新增接口重测，也没有 JS 性能结论。
- [0.1.0 发布](release-0.1.0.md)的源码为 `10a9a1012d5fb07a333936ea83ce22e1f98a03d5`；[0.2.0 发布](release-0.2.0.md)的源码为 `e0ef766b34562bcad2b3f3e0d50002adf7b05912`。历史候选清单、哈希、完整 CI 和消费者结果仍按原记录解释。
- [0.2.1 发布](release-0.2.1.md)的源码为 `02a6043692c966b3687996f9eb5197470712aca0`，独立 registry 消费者 native／JS 已在当时验证；状态文档提交不能冒充发布源码。该发布没有包含本文所列后续增量。
- [旧树接口验收](acceptance-trees.md)与旧候选包只证明当时范围。Commit 52 整理时尚未进行增量接口包级验收；后续开发源码包验证见下节，增量接口的注册表消费者仍**未执行**。没有新增版本、候选冻结或发布结论。

## 开发源码包外部消费者验证（Commit 53）

基线为 `bdebf95b7c23fbcd9ea11ef9f5213cd2b7e20abd`。本笔补上代表性增量接口在实际分发 ZIP 中的导入和调用证据，运行范围为 package scope：固定工具链、格式／接口、受影响的发布工具测试文件、一次正式 `moon package`，以及真实 ZIP 仓库外解压后的 native、JS 消费者。**库测试新增 0 项、执行 0 项**，不产生新的完整回归、参考、性能或浏览器证据。

三个新增流程分别调用小数开放窗口与闭合窗口树、小数批量描边树及同树批量查询／旧整数树单点查询、小数 Minkowski 树；检查完整坐标、顺序和层级。保留基础消费者与六个旧树、整数窗口标记。三个流程及其 API 名称见[审计流程](release-checklist.md#当前开发源码包审计commit-53unreleased)，不将流程数或断言数称作新增库测试，也不展开全部 API 组合。

报告在 `_build/incremental-package/report.json`，显式区分 `metadata_version=0.2.1` 与 `publication_status=unpublished-development-snapshot`；逐目标记录流程状态、实际 API、日志及编译后库字节核对。外部依赖使用 moon.work 解析实际 ZIP 解压目录，不引用开发目录，也没有从注册表安装这些 Unreleased 接口。

本地报告在提交前生成，保留父 SHA／dirty；最终交付以应分发文件哈希对应最终提交，再与同 SHA Linux CI 产物比较。Windows 与 Linux 各存 ZIP 大小及 SHA-256，逐文件路径和内容哈希须一致，ZIP 哈希无需相同。实际包清单、目标运行结果、工具测试数量、CI 链接和跨平台核对结果统一放入提交后 `_build/commit53/delivery.json`，此处不预填旧数字或自身最终 SHA。

本笔未选择下一版版本号、未冻结发布候选、未发布或覆盖注册表 0.2.1，原发布记录和校验和保持原样。执行方法和产物位置见[开发源码包清单](release-checklist.md)。

## 本次文档检查的边界

`bash scripts/check.sh --scope docs` 在工具链检查前进入文档分支，检查指定文档的常规本地 Markdown 文件和图片链接目标，去除片段后解析相对路径，并运行 `git diff --check`。它不访问外网、不递归扫描全仓、不验证全部标题锚点；锚点仅人工抽查。

CI 的 docs 范围跳过 MoonBit 安装、core bundle、库检查、演示、桥接、基准和消费者。本地另按本笔要求运行一次 `moon info`、`moon fmt`，用于确认没有源码或接口变化，不计为几何测试或验收构建。Commit 52 的最终 SHA、实际文档检查结果和同 SHA CI 链接在提交后交付记录中提供，不为填写本文自身 SHA 再补提交。
