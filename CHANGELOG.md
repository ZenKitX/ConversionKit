# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-03-03

### Added

- 汇率换算功能
  - `Currency` 模型（ISO 4217 标准）
  - `CurrencyData` 类，包含 12 种主流货币
  - `CurrencyApiService` 接口和 `MockCurrencyApiService` 实现
  - `CurrencyConverter` 汇率转换器
  - 支持单个和批量货币转换
  - 金额格式化（千分位、小数位）
  - 特殊处理日元和韩元（无小数）
  - 汇率换算示例文件
- 房贷计算器功能
  - `Mortgage` 相关模型（`MortgageResult`, `MonthlyPayment`, `PrepaymentResult`）
  - `MortgageLogic` 房贷计算逻辑
  - `MortgageCalculator` 计算器
  - 支持等额本息和等额本金两种还款方式
  - 支持提前还款计算
  - 支持组合贷款（商业贷款 + 公积金贷款）
  - 生成完整的还款计划表
  - 房贷计算器示例文件
- 架构设计文档（`docs/ARCHITECTURE.md`）
  - SOLID 设计原则说明
  - 完整的目录结构
  - 模块划分说明
  - 数据组织原则和实现方案
  - 扩展指南和最佳实践

### Changed

- 重构数据组织结构
  - 按类别拆分数据文件到 `lib/src/data/categories/` 目录
  - 每个类别独立一个文件，降低耦合度
  - `ConversionData` 重构为聚合类
- 统一所有类别数据文件的代码格式
  - 所有 `ConversionUnit` 实例使用一致的多行格式
  - 提高代码可读性和维护性

### Documentation

- 更新项目计划（`docs/project-plan.md`）
  - 添加数据组织原则部分
  - 明确 v0.2.0 功能范围
- 添加使用示例
  - `example/currency_example.dart` - 汇率换算示例
  - `example/mortgage_example.dart` - 房贷计算器示例

### Tests

- 新增 31 个单元测试
  - 汇率转换测试（19 个）
  - 房贷计算测试（12 个）
- 总测试数量：98 个
- 测试覆盖率：> 95%

### Features

- 💱 汇率换算（12 种主流货币）
- 🏠 房贷计算器（等额本息、等额本金、提前还款、组合贷款）
- 📊 完整的还款计划表生成
- 💰 金额格式化工具
- 🔢 9 大类别，60+ 单位
- 🌡️ 特殊转换（温度、进制）
- 🎯 高精度转换
- 🚀 零依赖
- ✅ 完整测试

[0.2.0]: https://github.com/ZenKitX/ConversionKit/releases/tag/v0.2.0

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
