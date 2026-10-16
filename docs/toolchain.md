# 固定工具链与验证记录

本地实际工具链（Windows，2026-10-16）：

```text
moon 0.1.20260915 (2e1a46d 2026-09-15) ~\.moon\bin\moon.exe
moonc v0.10.13+cbb11c36f (2026-09-15) ~\.moon\bin\moonc.exe
moonrun 0.1.20260915 (2e1a46d 2026-09-15) ~\.moon\bin\moonrun.exe

Feature flags enabled: rr_moon_mod,rr_moon_pkg
```

官方归档版本参数为 `0.10.13+cbb11c36f`。Linux CI 固定同版本的二进制与 core 归档及其 SHA256，下载地址和校验值见 `.github/workflows/ci.yml`，不执行滚动的远程安装脚本。安装流程按官方 https://cli.moonbitlang.com/install/unix.sh 的归档布局与 core bundle 步骤编写。

Windows 通过 Git Bash 运行 `bash scripts/check.sh`（本机 Git Bash 位于 `C:/Program Files/Git/bin/bash.exe`；`C:/Windows/System32/bash.exe` 是其他入口）。原生构建使用本机可用的 MSVC 工具链；Linux CI 使用 Ubuntu 24.04 的原生构建环境。脚本核对 moon、moonc、moonrun 的版本、提交和日期，并打印完整版本用于日志对齐。

## Commit 1 本地结果

2026-10-16 已实际通过：native `check --deny-warn`、`test`、`build` 与示例。测试总数 **18**，通过 **18**，失败 **0**，全部是通过公开接口验证的黑盒测试。示例输出 `MoonClip data model OK`。Git Bash 统一入口、格式检查均已通过；从 cmd/example 目录调用同一入口也通过。额外使用临时公开 API 验证了接口漂移会令脚本失败，随后已清理探针并重新通过统一检查。

本笔尚无几何算法对照数据或兼容性通过数。远端 Linux CI 的结果以对应提交的 GitHub Actions 运行记录为准，不能由本地结果推断。
