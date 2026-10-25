# MoonClip

MoonClip 是用 MoonBit 实现的二维多边形几何库，提供整数和十进制网格上的小数运算。运行库不依赖 C++ 或其他几何运行时。

## 安装与使用

```bash
moon add BigSaltyMan/moonclip@0.3.2
```

**0.3.2 是文档链接修正版**，将文档与示例入口指向固定提交的 GitHub 渲染页面，避免 Mooncakes 原始 Markdown 外链未声明编码时出现中文乱码。运行库行为、公开接口、依赖及工具链与 0.3.1 保持一致；下表能力自 0.3.0 提供。旧版本的发布和验证证据见 [0.3.1 发布记录](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/release-0.3.1.md)，不转记为本版注册表安装证据。 0.3.2 已于 2026-10-25 正式发布，独立 registry 消费者 native／JS、主文档页及 GitHub 中文文档蓝链核验通过，见 [0.3.2 Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.3.2)。

在包的 `moon.pkg` 中导入 `BigSaltyMan/moonclip`；可参考受检的[示例配置](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/cmd/example/moon.pkg)和 [CLI 示例](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/cmd/example/main.mbt)。已发布的 Boolean、Offset、单路线 Stroke、显式简化及基础几何见[支持范围](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/scope.md)；0.2.0 增加的树接口见[旧树接口升级说明](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/upgrade-trees.md)。

## 0.3.0 能力

开发源码另有 **Unreleased** 接口 `intersect_polylines`／`intersect_polylines_d`，用于整数／小数开放折线与闭合填充区域求交；保留最终区域边界，输出有序开放片段。小数两侧共同量化，仅区域检查闭合有效性。这两个接口不在上述注册表 0.3.2 包内，契约及与矩形裁剪的区别见[开放折线区域求交](https://github.com/BigSaltyMan/moonclip/blob/main/docs/lineclip.md)。下表仍描述已发布能力。

| 能力 | 整数 | 小数 | 输出 | 使用说明 |
| --- | --- | --- | --- | --- |
| 开放折线窗口裁剪 | 支持 | 支持 | 有序开放片段 | [窗口裁剪](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/rectclip.md) |
| 闭合区域窗口裁剪 | 支持 | 支持 | 平铺／孔洞树 | [窗口裁剪](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/rectclip.md) |
| 多路线批量描边 | 支持 | 支持 | 平铺／孔洞树 | [组合流程](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/composition.md) |
| Minkowski Sum | 支持 | 支持 | 平铺／孔洞树 | [图案扫掠](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/minkowski.md) |
| 树单点／批量定位 | 支持 | 支持 | 定位状态与命中节点 | [树点定位](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/polytree-query.md) |

整数平铺 `minkowski_sum` 已在 0.1.0 提供；表中小数、树及其他增量的发布边界见[源码升级说明](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/upgrade-incremental.md)。详细接口以[生成接口](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/pkg.generated.mbti)为准，[CHANGELOG](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/CHANGELOG.md)按版本记录变化。

## 从源码开始使用

使用[固定工具链](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/toolchain.md)，Windows 的 shell 脚本通过 Git Bash 执行：

```bash
git clone https://github.com/BigSaltyMan/moonclip.git
cd moonclip
moon run --target native cmd/example
```

[`cmd/example/main.mbt`](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/cmd/example/main.mbt) 包含完整轮廓、孔洞、复制隔离、错误和查询断言，是源码 API 的使用起点。需要迁移现有调用时，先阅读[增量升级说明](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/upgrade-incremental.md)，再按任务进入专题文档。

Point64 保存 Int64，几何计算接受每轴 ±1,000,000,000；PointD 使用 Precision 0—6（默认 3）量化到同一整数网格，原单位范围随精度缩小。几何输入的量化合并可能报错，查询点量化重合则允许。计算返回 `Result`，失败不修改输入或发布部分结果；合法坐标和输入数量也可能因内部累计预算而被拒绝。数值与所有权契约见[支持范围](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/scope.md)、[数值路线](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/numerics.md)和[小数适配](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/decimal.md)。

## 浏览器演示

```bash
cd demo
npm run dev
```

服务启动后打开 **http://127.0.0.1:4173/**。Boolean、Offset、单路线描边、批量描边、闭合窗口裁剪及 Minkowski 六类区域树均支持整数／小数、层级查看、节点高亮和单点／批量定位。开放窗口裁剪返回开放片段；开放片段和平铺结果不支持树查询。

小数定位使用本次建树 Precision，靠近边界的点可能量化到边界；页面标记仍显示原始输入坐标。JSON 保存真实请求和结果：平铺区域 v1、孔洞树 v2、开放片段 v3；SVG 按区域或开放线条导出。启动、操作及协议见[演示说明](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/demo.md)，历史下载重放与窄屏观察见[浏览器验收](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/demo-acceptance.md)。

## 验证证据与检查入口

[增量验收索引](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/acceptance-incremental.md)区分历史完整回归、各次定向检查、浏览器操作和发布证据。Commit 26 的历史完整回归为 native **2370/2370**、JS **2370/2370**；当前完整入口的 **2406** 是配置期望数，未据此宣称当前源码已全量通过。参考目录为 **1416 个案例、2308 项能力检查**，不代表所有新增接口都有逐项上游对照。

普通 CI 按 `CHECK_SCOPE` 选择文档、核心、演示或包检查范围；发布源码、状态文档和文档修正版候选的证据按各自提交与 scope 记录，package 或 docs 成功均不表示完整回归通过。完整检查入口仍保留，需显式选择；实际执行范围见[工作流](https://github.com/BigSaltyMan/moonclip/blob/main/.github/workflows/ci.yml)与[检查脚本](https://github.com/BigSaltyMan/moonclip/blob/main/scripts/check.sh)。文档检查只验证指定材料的本地链接目标存在和差异空白，不构建或执行几何：

```bash
bash scripts/check.sh --scope docs
```

[性能报告](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/benchmarks.md)保留原测量提交的 Windows native 基线，不能作为新增功能的性能结论。发布、候选消费者及历史树验收分别见[0.3.0 发布记录](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/release-0.3.0.md)与[旧树验收](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/acceptance-trees.md)。

## 来源与许可

固定参考 **Clipper2 2.0.1 / `Clipper2_2.0.1` / `21ebba05db8894f0c7217ad35ea518080f324946`**，采用 BSL-1.0。C# 是主要引擎阅读与移植参考；固定 C++ 适配器用于生成、复核测试数据，运行库不依赖它。普通 CI 不下载或构建 C++ 参考。移植范围、自有适配和上游关系见[来源说明](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/upstream.md)、[相关工作](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/docs/related-work.md)及[许可证](https://github.com/BigSaltyMan/moonclip/blob/c9ccdb9bff41c26119a924f6fea7dea5e0bed01d/LICENSE)。
