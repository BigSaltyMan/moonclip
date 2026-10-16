# 上游来源与移植记录

## 固定参考

- 仓库：https://github.com/AngusJohnson/Clipper2
- 版本：Clipper2 2.0.1
- 标签：`Clipper2_2.0.1`
- 完整提交：`21ebba05db8894f0c7217ad35ea518080f324946`
- 许可证：BSL-1.0；[固定提交的 LICENSE](https://github.com/AngusJohnson/Clipper2/blob/21ebba05db8894f0c7217ad35ea518080f324946/LICENSE)

2026-10-16 核验：`git ls-remote` 返回该标签指向上述完整 SHA；发布页显示 `Clipper2_2.0.1` / `21ebba0`。已读取该提交的完整 LICENSE，并将原文（前置 MoonClip 版权行）写入根目录 LICENSE。另已读取该提交的 C# `Clipper.Core.cs`，核对 Point64 构造、坐标比较和 Path64 / Paths64 声明。该源码头部版权为 `Angus Johnson 2010-2025`，许可指向 Boost Software License 1.0。

## 已发生的参考

| 上游文件 | MoonBit 文件 | 类型与修改说明 |
| --- | --- | --- |
| `CSharp/Clipper2Lib/Clipper.Core.cs`：Point64、Path64、Paths64 | `types.mbt` | 沿用整数点与有序轮廓容器的设计和命名；使用不可变 Int64 坐标、MoonBit Array 类型别名和派生 Eq。未直接改写上游函数体；未引入 Double 构造、Z 坐标、运算符算术或引擎。 |
| 无直接对应代码 | `types.mbt`：`copy_path`、`copy_paths` | MoonClip 自行实现的容器辅助逻辑，调用 MoonBit 标准库复制及 map；对每个输入轮廓分别复制，切断内外数组别名。 |
| 无直接对应代码 | `types_test.mbt`、`cmd/example/main.mbt` | MoonClip 自行编写的契约测试和公开接口示例。 |

本笔没有直接移植上游代码。MoonClip 原创代码版权使用实际提交作者 Git 身份 `BigSaltyMan`，年份 2026。上游源码的上述版权记录保留在此；以后直接移植代码时，必须在对应文件保留该文件实际的版权与许可声明。

C# 源码作为主要阅读与后续移植参考；固定版本的 C++ 实现作为独立对照。MoonClip 运行库由 MoonBit 实现，不依赖外部几何运行时；参考程序只用于后续测试数据生成。

## 计划范围（尚未移植或实现）

| 上游参考文件 | 计划用途与目标 |
| --- | --- |
| `CSharp/Clipper2Lib/Clipper.Core.cs` 中的几何辅助逻辑 | Commit 2：几何谓词、输入整理、坐标边界及错误契约；具体移植关系实现时补录。 |
| `CPP/Clipper2Lib/include/clipper2/clipper.h` 与固定提交 C++ 实现 | Commit 3：`tools/oracle/` 适配器、版本化数据格式、生成脚本和独立对照数据。 |
| `CSharp/Clipper2Lib/Clipper.Engine.cs` | 后续扫描线与布尔运算引擎；尚未建立 MoonBit 对应文件。 |
| `CSharp/Clipper2Lib/Clipper.Offset.cs` | 后续偏移与描边；尚未建立 MoonBit 对应文件。 |

本笔不提供 C++ 参考适配器或算法兼容性通过数。以后按实际实现补充逐文件来源记录。
