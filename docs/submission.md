# MoonClip 成果说明

仓库：https://github.com/BigSaltyMan/moonclip 。版本 **0.1.0 已于 2026-10-20 发布**，注册表消费者 native / JS 通过，[GitHub Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.1.0)已创建。项目用于二维区域构造与拓扑运算，运行库由 MoonBit 实现。

## 能力与贡献

**已发布 0.1.0** 提供整数与小数 Boolean（四种操作、EvenOdd / NonZero）、整数 PolyTree、闭合偏移、开放折线加宽、四种连接与三种端点、Precision 0—6、显式简化与删点 / 退化报告，以及整数 Minkowski Sum，可用于二维编辑器、遮罩、合并裁剪、缓冲及路线覆盖边界。参数与限制见 [scope.md](scope.md)。

**当前开发源码（Unreleased）** 新增 `boolean_tree_d`、`offset_tree` / `offset_tree_d`、`stroke_tree` / `stroke_tree_d` 五个库入口，以及 `PolyTreeD` / `PolyNodeD` 及访问器；整数 `boolean_tree` 已在首版提供。开发演示接入六个树入口，支持层级展开、边界选择高亮和保留结构的 v2 JSON。升级方法见[升级说明](upgrade-trees.md)，增量与证据见[树验收材料](acceptance-trees.md)。这些内容没有发布到 Mooncakes，也未确定下一版版本号。

核心算法参考或改写自固定 **Clipper2 2.0.1 / 21ebba05db8894f0c7217ad35ea518080f324946**，遵循 BSL-1.0 并保留上游版权，不能宣称这些算法为 MoonClip 原创。C# 是主要引擎阅读与移植参考，各函数实际来源见 [upstream.md](upstream.md)。

MoonClip 自行实现或加强了公开 Result 接口、不可变点及复制隔离、严格十进制量化与诊断、精确整数谓词 / 面积、跨阶段累计预算、索引化引擎状态和错误终止、树访问器隔离与退化报告；建立固定 C++ 参考适配器、完整比较器、锁定数据、随机失败缩减、双目标回归、交互演示、性能基线与候选包消费者工具。C++ 只用于独立参考数据生成，不是运行依赖。

## 与 MoonGeoKit 的区别

MoonClip 面向二维区域构造与拓扑运算，提供多边形布尔运算、孔洞层级、闭合轮廓偏移、开放折线加宽和整数 Minkowski Sum。MoonGeoKit 侧重基础几何关系、距离与包含判断，以及动态网格空间索引。两者适用于不同环节：MoonGeoKit 可用于筛选空间候选对象，MoonClip 可进一步生成合并、裁剪、缓冲或描边后的区域边界，形成互补。

2026-10-20 核对的固定 README / API、来源链接和简短功能表只维护在 [related-work.md](related-work.md#与-moongeokit-的区别)。上述是组合用途说明，没有新增 MoonGeoKit 集成依赖、跨库适配或速度比较。

## 验收入口与限制

- [首版历史验收](acceptance.md)保留原交付事实；[当前树增量验收](acceptance-trees.md)索引 Commit 20—23 的公开证据及六入口实际候选消费者，最终 SHA / 清单 / 校验和 / CI 由提交后交付记录承载。
- [兼容性](compatibility.md)：1384 个参考案例、2276 项能力检查；首版同一批 2234 项库测试在两端分别执行，当前开发源码为 2323 项；桥接另计 20 项，不能与参考或两目标数量混加。
- [演示](demo.md)和[浏览器记录](demo-acceptance.md)：三组场景、扫掠、显式简化及 SVG / JSON 导出；Unreleased 层级与 v2 JSON 沿用 Commit 23 的验收，本笔不重新执行。
- [性能](benchmarks.md)：Commit 18 指定 Windows native release 的 11 案例，本笔未重测，也未测上游；没有新增树入口的独立性能结论。

Positive / Negative 仍内部；简化不保证拓扑保持；Minkowski 仅整数单图案单路线；没有开放路径 Boolean 或一般拓扑修复。小数 PolyTree 已在开发源码提供，未包含于已发布的 0.1.0；层级由量化区域决定，树构建及解码消耗累计预算。合法输入仍可能触及数值或累计预算边界。

Mooncakes 发布、注册表安装验证和公开 Release 已完成，证据见 [release-0.1.0.md](release-0.1.0.md)。本次没有执行正式赛事申报。

| 待确认字段 | 内容 |
| --- | --- |
| 申报人 / 团队 / 联系方式 | 待填 |
| 组别 / 申报编号 / 指导信息 | 待填 |
| 正式发布 | 2026-10-20，BigSaltyMan/moonclip@0.1.0；链接见正式发布记录 |
