# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-03-03

### Added

- 初始版本发布
- 支持 9 大类别的单位换算：
  - 长度 (8 个单位)
  - 面积 (7 个单位)
  - 重量 (8 个单位)
  - 温度 (3 个单位，特殊转换)
  - 体积 (7 个单位)
  - 速度 (5 个单位)
  - 压强 (7 个单位)
  - 功率 (5 个单位)
  - 进制 (4 个单位，特殊转换)
- 核心功能：
  - `UnitConverter` - 统一的转换接口
  - `ConversionLogic` - 转换逻辑工具类
  - `ConversionData` - 数据定义
  - `ConversionUnit` - 单位模型
  - `ConversionCategory` - 类别模型
- 特殊转换支持：
  - 温度转换（摄氏度、华氏度、开尔文）
  - 进制转换（二进制、八进制、十进制、十六进制）
- 工具方法：
  - 进制输入验证
  - 结果格式化（移除尾部零、科学计数法）
- 完整的单元测试覆盖（100+ 测试用例）
- 详细的 API 文档和使用示例
- 零外部依赖

### Features

- 🔢 9 大类别，60+ 单位
- 🌡️ 特殊转换（温度、进制）
- 🎯 高精度转换
- 🚀 零依赖
- ✅ 完整测试

[0.1.0]: https://github.com/ZenKitX/conversion_kit/releases/tag/v0.1.0
