# 0.1.0 发布候选检查清单

状态：**待发布**。本笔准备候选归档与材料，不执行 Mooncakes 上传、GitHub Release 或正式申报；注册表安装验证尚未完成。

## 固定内容与分发

- BigSaltyMan/moonclip，0.1.0，仓库 https://github.com/BigSaltyMan/moonclip；README.md、LICENSE、BSL-1.0 与实际文件一致，首版内容见 [CHANGELOG](../CHANGELOG.md)。
- 工具链保持[固定版本](toolchain.md)，不升级依赖。`.moonignore` 排除测试、参考数据、工具、演示、基准、截图和构建目录；分发运行库全部源码、配置和根公开接口、cmd/example 及文字文档。
- [upstream.md](upstream.md) 独立说明固定来源、完整 SHA、许可证、改写与自有贡献；不分发的开发材料使用仓库链接。

## 实际归档与外部消费者

```bash
python scripts/check_release.py --report _build/release/report.json
```

脚本核对 `moon version --all` 和元数据，在系统临时目录创建完整源码快照，执行固定工具链正式支持的 **moon package**。工具自动检查并生成 `_build/publish/*.zip`；不是自行拼装 ZIP，不调用 moon publish。moon package --list 只辅助查看，验收针对实际归档。

审计逐成员核对精确分发清单、UTF-8 文本、原始字节、许可 / 来源及相对文档链接，拒绝缺失、额外文件、重复成员、符号链接、路径穿越和本机用户 / 检出目录路径。report.json 记录全部文件大小 / SHA256 及 ZIP 大小 / SHA256。不同系统的归档时间戳可能不同，每份产物以自己的报告识别。

在另一个仓库外目录解压真实 ZIP 为 library，复制同一份消费者夹具为 consumer，以 **moon.work** 将两者作为成员。消费者 moon.mod 声明 BigSaltyMan/moonclip@0.1.0，由 workspace 本地解析到解压目录，不引用开发工作区或注册表。native / JS 各运行一次，检查 Boolean、实际孔洞树、Offset、Stroke、小数 Union、显式简化、Minkowski 及公开错误。

ZIP、report.json、package.log、consumer-native.log、consumer-js.log 位于 `_build/release/`。成功日志为 `External candidate consumer native: success` / `js: success`；记录为**候选包外部消费者验证**，不能称为 Mooncakes 安装验证。

构建 / 打包 / 每目标消费者命令限时 180 秒，失败或超时非零退出并保存错误报告。只清理脚本自己创建且已核对的临时目录，不改全局配置、不清空共享缓存。普通 CI 在最终提交的干净检出中运行同一入口，不重建参考、不重复 11 项性能测量。

## 提交后与正式发布边界

提交前运行 moon info、moon fmt、git diff --check，审查根接口。最终完整 SHA、包校验和、消费者状态及同 SHA CI 链接由提交后的交付报告承载，见 [acceptance.md](acceptance.md)。未提交源码的检查保留父 SHA / dirty 标记，交付时以包内逐文件哈希核对最终提交，避免为填写自身 SHA 反复补提交。

正式发布须后续明确授权，并在当时重新核对：

1. Mooncakes 的版本规则、账号 / 模块名归属及 BigSaltyMan/moonclip@0.1.0 占用情况；准备阶段版本号不构成预留。
2. 候选与拟发布提交一致，许可、元数据和实际归档审计通过。
3. 上传成功后，在干净外部项目从注册表获取指定版本并运行消费者，成功后才能补安装命令及“Mooncakes 安装验证通过”。
4. 公开 Release、申报提交及人员字段分别按授权和事实完成。

[官方版本说明](https://docs.moonbitlang.com/en/latest/toolchain/moon/package-manage-tour.html)描述 SemVer 格式；发布时仍需核对实时服务端规则与占用。本笔不以旧经验替代当时检查。
