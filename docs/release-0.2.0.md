# MoonClip 0.2.0 正式发布记录

**0.2.0 已于 2026-10-21 正式发布。** Mooncakes 上传、独立注册表 native／JS 消费者、v0.2.0 标签和 GitHub Release 均已完成。本记录为发布后状态更新，不改变已经上传的源码和归档。

## 发布对象与时间

| 项目 | 已核验事实 |
| --- | --- |
| 发布源码完整 SHA | `e0ef766b34562bcad2b3f3e0d50002adf7b05912` |
| Mooncakes 精确版本 | [BigSaltyMan/moonclip@0.2.0](https://mooncakes.io/docs/BigSaltyMan/moonclip@0.2.0/)；元数据版本 0.2.0，yanked=false |
| 服务端创建时间 | 2026-10-21 03:12:43.979384 UTC，即北京时间 11:12:43 |
| 注册表消费者验证完成 | 2026-10-21 03:14:04.489381 UTC，即北京时间 11:14:04 |
| GitHub Release | [MoonClip 0.2.0](https://github.com/BigSaltyMan/moonclip/releases/tag/v0.2.0)，2026-10-21 03:18:07 UTC 公开 |
| 标签 | v0.2.0 精确指向发布源码 SHA；v0.1.0 仍指向 `10a9a1012d5fb07a333936ea83ce22e1f98a03d5` |
| 发布后状态提交 | 本文件所在的后续纯文档提交，使用 [skip ci]；其 SHA 另列交付记录，不能冒充发布源码 |

```bash
moon add BigSaltyMan/moonclip@0.2.0
```

上传前重新确认版本、标签和 Release 未占用，冻结归档及仓库外源码逐文件一致。第一次 dry-run 曾发生连接重置，查询确认未发布后再验证，服务端返回 202 并明确未作更改。正式 `moon publish` 只执行一次，退出 0；随后精确版本查询返回 200，服务端校验和与冻结归档一致，未覆盖或移动已有版本。

## 实际包与公开附件

- [实际发布 ZIP](https://github.com/BigSaltyMan/moonclip/releases/download/v0.2.0/moonclip-0.2.0.zip)：**51 个文件、216261 字节**。
- SHA-256：`204c390e0d19953b3d66f27371f90ba18be7b49e6e4b4844db0cc6511a4de412`，与 Mooncakes 服务端 metadata.checksum 相同。
- [SHA256SUMS.txt](https://github.com/BigSaltyMan/moonclip/releases/download/v0.2.0/SHA256SUMS.txt)和[无敏感信息的完整验收摘要](https://github.com/BigSaltyMan/moonclip/releases/download/v0.2.0/publication-delivery.json)包含公开归档清单、逐成员大小／哈希、源码和证据链接。
- 三个附件均从 GitHub Release 重新下载并与上传原件逐字节比较通过。Linux 候选 ZIP 校验和为 `441da606b13f64f446f8480316a0953a65b9bc144d880e9fe8f116b0559f82a2`；两平台 51 个成员内容哈希一致，ZIP 时间戳等元数据可不同。

发布包保留冻结候选时的“待发布”文案快照；本次只在仓库补充正式发布事实，不为修改包内文案重新上传同一版本。[0.1.0 的原发布记录](release-0.1.0.md)、46 文件校验和和首版标签均保持原样。

## 独立注册表安装验证

新建另一个仓库外消费者，只声明 `BigSaltyMan/moonclip@0.2.0`，不使用 moon.work、本地路径依赖或候选库副本。实际执行 moon add、moon tree --json、moon run --target native . 和 moon run --target js .，所有命令退出 0。

依赖树中库的 source.kind 为 registry、workspace_member 为 false；消费者自身是普通本地根模块。下载的 51 个文件集合、大小和 SHA-256 全部与冻结候选对应。

| 目标 | 原有基础能力 | 六个树入口 |
| --- | --- | --- |
| native | 通过 | boolean_tree、boolean_tree_d、offset_tree、offset_tree_d、stroke_tree、stroke_tree_d 各一个成功标记 |
| JS | 通过 | 同样六项分别完成，无缺失、重复或未知标记 |

据此确认 **0.2.0 Mooncakes 安装验证通过**。总体成功和六入口标记仍由实际断言产生，native 结果没有代替 JS。

## 增量、CI 与沿用证据

相对 0.1.0 新增五个公开函数、PolyTreeD / PolyNodeD 及六个访问方式，树构建与解码累计预算、复制隔离、六入口层级交互和 v2 JSON。整数 boolean_tree 已在 0.1.0 提供；旧平铺签名不变。契约和边界见[升级说明](upgrade-trees.md)、[支持范围](scope.md)与[增量验收](acceptance-trees.md)。

沿用[发布源码同 SHA 的 CI](https://github.com/BigSaltyMan/moonclip/actions/runs/39451040373)：native／JS 各 2323/2323、工具 281、桥接 20/20、候选消费者与既有基准冒烟通过。发布标签未重复触发完整 CI，发布后状态文档使用 [skip ci]。

参考仍为 1384 个案例、2276 项能力检查；浏览器沿用 [Commit 23 记录](demo-acceptance.md#commit23)，性能沿用 [Commit 18 的原环境和源码](benchmarks.md)，不重建参考或重复性能／浏览器验收。没有赛事申报或演示托管部署，原规划书、旧参考和未提交申报书未改。

本地 `_build/release-0.2.0/` 保存原候选 report / delivery、上传及 dry-run 日志、注册表依赖树／两目标日志、GitHub Release 与附件复核、最终 publication-final-delivery.json。原候选收据不改写为发布后状态；公开 Release 摘要不包含本机路径或凭据。
