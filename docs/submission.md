# MoonClip 成果说明

MoonClip 是用 MoonBit 实现的二维多边形计算库，面向地图区域编辑、矢量遮罩、路线描边和图形工具。验收版本为 **0.4.0**：[项目仓库](https://github.com/BigSaltyMan/moonclip)、[Mooncakes 文档与安装](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.4.0/)及 [GitHub Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.4.0)。

```bash
moon add BigSaltyMan/moonclip@0.4.0
```

## 已交付能力

- 整数／小数闭合区域 Boolean，支持交、并、差、异或及公开的 EvenOdd、NonZero 填充规则。孔洞树表达外轮廓、孔洞与岛，支持整数／小数单点及批量点定位。
- 闭合区域偏移、带端点的开放中心线描边、无端点的闭合中心线描边，以及共享样式并统一合并的开放路线批量描边；支持平铺结果或相应孔洞树。
- 矩形窗口可裁剪开放折线或闭合区域；开放路线与任意闭合区域另支持求交、求差，保留原方向及有序片段。
- 整数／小数 Minkowski Sum 处理单图案、单路线；显式简化提供删点和退化报告。结构化错误、原始输入检查及单次调用内的累计预算用于诊断与资源保护。
- 交互演示调用实际几何核心，展示区域、路线、树及查询，可导出 SVG 与可重放 JSON。接口和数值边界见[支持范围](scope.md)，评审操作见[验收导航](contest-acceptance.md)。

## 来源与工程贡献

核心算法参考或改写自固定的 [Clipper2 2.0.1](https://github.com/AngusJohnson/Clipper2/tree/21ebba05db8894f0c7217ad35ea518080f324946)，采用 BSL-1.0 并保留上游版权；具体来源见[逐文件记录](upstream.md)。C# 是主要引擎阅读与移植参考，固定 C++ 适配器用于生成独立参考结果，运行库不依赖 C++。

MoonClip 的工程工作包括 MoonBit 数据模型与 Result 接口、精确整数谓词、十进制量化诊断、树访问器与复制隔离、跨阶段累计预算、自有开放路线事件切分，以及参考比较器、交互演示和发布消费者工具。与 MoonGeoKit 的固定来源对照及其 2026-10-20 核对范围见[相关工作](related-work.md#与-moongeokit-的区别)；没有跨库性能对比或集成依赖。

## 验证与边界

[完整验收](full-acceptance.md)归属 `339947be1cb0ac87ab3a16b9658093806d0a4736`：Windows、Linux 的 native／JS 分别为 2427/2427；conformance 工具 294 项，桥接／导出 31/31。锁定参考为 1416 个案例、2308 项能力检查，零差异、零执行错误；这些数字分别统计。[兼容报告](compatibility.md)记录各参考范围，不代表所有输入或新增入口均与 Clipper2 完全兼容。

[0.4.0 发布记录](release-0.4.0.md)对应发布源码 `63db64f23582390d78acac38a9fbfda11a0216b3`：实际归档 67 文件、334263 字节，仓库外 registry 消费者 native、JS 各通过一次。[演示说明](demo.md)与[历史浏览器验收](demo-acceptance.md)保留各自提交归属。[性能基线](benchmarks.md)是 2026-10-20 指定 Windows native 环境下的 11 项测量，没有在 0.4.0 重新测量或与其他库配对比较。

Positive／Negative 填充仍为内部能力；开放路线区域裁剪仅提供求交、求差。简化不保证拓扑保持；Minkowski 不包含 Diff 或任意带孔图案集合运算；尚未实现三角剖分。参考比较只覆盖锁定案例与参数，合法输入也可能触及数值或累计预算限制。

## 待本人确认

| 字段 | 状态 |
| --- | --- |
| 申报人、团队、联系方式 | 待本人确认并填写 |
| 组别、申报编号、指导信息 | 待本人确认并填写 |
| 申报材料版本及正式提交情况 | 待本人确认；本材料整理不等于赛事最终提交 |
