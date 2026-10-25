# MoonClip 0.3.2 文档链接修正版发布记录

**0.3.2 已于 2026-10-25 正式发布。** README 的文档、示例、接口和许可入口改为固定提交的 GitHub 渲染页面，避免 Mooncakes 原始 Markdown 外链未声明字符编码时出现中文乱码。没有修改 Mooncakes 静态源站配置；0.3.1 及更早版本的原包、标签和记录保持原样。

## 发布源码与归档

- 发布源码：`2171a5e8be30a36ae9ed32d18fafd6bf40d2a958`；[v0.3.2 标签](https://github.com/BigSaltyMan/moonclip/tree/v0.3.2)精确指向该 SHA。
- 运行库源码（包括 API 注释）与根 `.mbti` 和 0.3.1 发布源码 `adad8bb47be1a136c59247d491d6607919253c83` 逐字节一致。依赖、工具链、几何行为及消费者案例未变。
- 实际发布 Windows 冻结 ZIP：**62 文件、296346 字节**，SHA-256 `1bf57a22d8beaf04e42480c76096735324b06fd142d6eb12b1641e392aa5f624`。
- Linux 候选同为 62 文件、296346 字节，SHA-256 `7aae846c9d0d022cbb1ea8c4aea624684127b137a1d75fd7a1a1dc3718fec6c6`。两平台成员路径、大小、哈希与实际字节一致，每个成员对应冻结提交。
- 在仓库外从冻结提交准备干净源码。固定工具链的 `moon publish` 不支持指定 ZIP，重新打包和实际上传 ZIP 均与 Windows 冻结候选完全一致。
- 一次正式上传成功，服务端创建时间为 `2026-10-25T02:04:22.189109+00:00`（北京时间 2026-10-25 10:04:22），checksum 与实际 ZIP 一致，未撤回。

## 注册表消费者

```bash
moon add BigSaltyMan/moonclip@0.3.2
```

在全新仓库外项目从 registry 安装精确 0.3.2。`moon tree --json` 确认来源为 registry、不是 workspace 成员；没有 moon.work、本地依赖替换、候选库复制、共享缓存清空或全局配置修改。

| 目标 | 实际执行 | 结果 |
| --- | --- | --- |
| Windows native | 一次现有消费者运行 | 基础检查、六个旧树入口、整数窗口及三个增量流程通过 |
| JS | 一次现有消费者运行 | 独立校验相同执行标记和完整断言，通过 |

三个增量流程实际调用 `rect_clip_lines_d`、`rect_clip_polygons_tree_d`、`stroke_polylines_tree_d`、`PolyTreeD::locate_many`、`PolyTree64::locate`、`minkowski_sum_tree_d`，不代表所有 API 参数组合。实际下载 62 个文件与冻结候选的路径、大小、内容哈希完全一致，编译后未改变。

## 实际文档链接核验

[Mooncakes 0.3.2 文档](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.3.2/)已生成，实际显示 0.3.2、安装命令、链接修正版介绍及原公开接口。包内 README 的 30 个普通链接均为 GitHub 页面，其中 28 个文档或文件链接固定在 `c9ccdb9bff41c26119a924f6fea7dea5e0bed01d`，另两个为原有工作流及脚本的 main 链接。

实际页面抽查“树点定位”“图案扫掠”“组合流程”的 href，均指向上述固定提交的 GitHub `/blob/` 渲染页面。打开树点定位专题，中文标题、状态表和 Precision 说明正常显示，证据保存为 `github-rendered-query-doc.txt` 和 `github-chinese-document.png`。修复的是 README 导航目标，没有把原始 Markdown 字节损坏、源站编码配置已修复或全部外部页面逐项浏览写成结论。

原 0.3.1 的源站响应和用户观察保留在[该版记录](release-0.3.1.md)，不篡改旧包。固定链接中的说明与本版 API 相同，不依赖未来 main 分支改动。

## CI、Release 与状态提交

[发布源码 package CI](https://github.com/BigSaltyMan/moonclip/actions/runs/40152882088)通过。Windows／Linux 发布工具各 **10/10**，候选消费者 native、JS 各一次成功。正式上传后另行运行上述 registry 消费者，没有重复候选运行。这是包级证据，不是该 SHA 全量回归；新增与执行库测试均为 0，2406 仍只为完整入口配置期望。未重建参考、测性能或重验演示浏览器，未执行赛事申报。

[GitHub Release](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.3.2)附件为实际发布 ZIP、`SHA256SUMS.txt`、无凭据和本机路径的验收摘要；附件重新下载逐字节核对。完整清单、两平台候选、注册表日志与文档证据保存在 `_build/release-0.3.2/`。

本文件及发布状态是独立文档提交，只运行 docs scope；最终状态提交 SHA、同 SHA docs CI 与各阶段回执写入 `_build/release-0.3.2/publication-final-delivery.json`。标签保持冻结源码，不移动到状态提交，不为更新包内“待发布”的 CHANGELOG 再次上传同一版本。
