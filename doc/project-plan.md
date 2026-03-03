# ConversionKit 项目规划

## 项目定位

ConversionKit 是一个专注于单位换算的 Flutter 工具包，提供完整的单位转换功能和计算器功能。

## 项目愿景

打造一个功能完整、易于使用、界面美观的单位换算工具包，为 Flutter 开发者提供开箱即用的换算解决方案。

## 核心特性

### 已实现功能（v0.1.0）

- ✅ 9 大类别：长度、面积、重量、温度、体积、速度、压强、功率、进制
- ✅ 60+ 单位转换
- ✅ 特殊转换：温度（非线性）、进制（整数转换）
- ✅ 完整的测试覆盖
- ✅ 零外部依赖

### 待实现功能

#### 1. 汇率换算（v0.2.0）
- 实时汇率查询（需要 API 支持）
- 离线汇率缓存
- 支持主流货币：USD, EUR, CNY, JPY, GBP 等
- 汇率历史记录
- 自动更新机制

#### 2. 房贷计算器（v0.2.0）
- 等额本息计算
- 等额本金计算
- 提前还款计算
- 还款计划表生成
- 利息总额计算
- 支持商业贷款、公积金贷款、组合贷款

#### 3. UI 组件库（v0.3.0）
- 换算类别选择界面
- 单位选择器
- 数值输入组件
- 结果展示组件
- 历史记录组件
- 收藏功能

#### 4. 扩展功能（v0.4.0）
- 时间换算（年、月、日、时、分、秒）
- 数据存储换算（Byte, KB, MB, GB, TB）
- 能量换算（焦耳、卡路里、千瓦时）
- 角度换算（度、弧度、梯度）

## 项目架构

### 目录结构

```
conversion_kit/
├── lib/
│   ├── conversion_kit.dart              # 主导出文件
│   └── src/
│       ├── models/                       # 数据模型
│       │   ├── conversion_unit.dart      # 单位模型
│       │   ├── conversion_category.dart  # 类别模型
│       │   ├── currency.dart             # 货币模型（新增）
│       │   └── mortgage.dart             # 房贷模型（新增）
│       ├── converters/                   # 转换器
│       │   ├── unit_converter.dart       # 单位转换器
│       │   └── currency_converter.dart   # 汇率转换器（新增）
│       ├── calculators/                  # 计算器（新增）
│       │   └── mortgage_calculator.dart  # 房贷计算器
│       ├── data/                         # 数据定义
│       │   ├── conversion_data.dart      # 数据聚合类
│       │   ├── currency_data.dart        # 货币数据（新增）
│       │   └── categories/               # 类别数据目录
│       │       ├── length_data.dart      # 长度单位数据
│       │       ├── area_data.dart        # 面积单位数据
│       │       ├── weight_data.dart      # 重量单位数据
│       │       ├── temperature_data.dart # 温度单位数据
│       │       ├── volume_data.dart      # 体积单位数据
│       │       ├── speed_data.dart       # 速度单位数据
│       │       ├── pressure_data.dart    # 压强单位数据
│       │       ├── power_data.dart       # 功率单位数据
│       │       └── number_system_data.dart # 进制单位数据
│       ├── services/                     # 服务层（新增）
│       │   ├── currency_api_service.dart # 汇率 API 服务
│       │   └── cache_service.dart        # 缓存服务
│       ├── utils/                        # 工具类
│       │   ├── conversion_logic.dart     # 转换逻辑
│       │   └── mortgage_logic.dart       # 房贷计算逻辑（新增）
│       ├── ui/                           # UI 组件（新增）
│       │   ├── widgets/                  # 通用组件
│       │   │   ├── category_grid.dart    # 类别网格
│       │   │   ├── unit_selector.dart    # 单位选择器
│       │   │   ├── value_input.dart      # 数值输入
│       │   │   └── result_display.dart   # 结果展示
│       │   └── screens/                  # 页面
│       │       ├── home_screen.dart      # 主页
│       │       ├── conversion_screen.dart # 换算页面
│       │       ├── currency_screen.dart  # 汇率页面
│       │       └── mortgage_screen.dart  # 房贷页面
│       └── extensions/                   # 扩展方法（新增）
│           └── conversion_extensions.dart
├── test/                                 # 测试文件
│   ├── models/
│   ├── converters/
│   ├── calculators/                     # 计算器测试
│   ├── data/
│   │   └── categories/                  # 类别数据测试
│   ├── services/                        # 服务测试
│   ├── utils/
│   └── extensions/
├── example/
│   ├── unit_conversion_example.dart     # 单位换算示例
│   ├── currency_example.dart            # 汇率换算示例
│   └── mortgage_example.dart            # 房贷计算示例
├── doc/                                # 文档
│   ├── ARCHITECTURE.md                  # 架构设计文档
│   ├── CODE_STYLE.md                    # 代码风格指南
│   ├── CONTRIBUTING.md                  # 贡献指南
│   ├── STANDARDS.md                     # 规范化标准
│   ├── conversion-kit-research.md       # 单位换算调研
│   ├── convert-package-research.md      # convert 包调研
│   ├── development-plan.md              # 原开发计划
│   ├── project-plan.md                  # 本文档
│   └── api-integration.md               # API 集成文档（新增）
├── pubspec.yaml
├── README.md
├── CHANGELOG.md
└── LICENSE
```

### 数据组织原则

#### 按类别拆分数据

为了保持代码的可维护性和可扩展性，我们将单位数据按类别拆分到独立文件中：

**设计原则**：
1. **单一职责**：每个文件只负责一个类别的数据
2. **低耦合**：各类别数据独立，互不影响
3. **易扩展**：添加新类别只需新增文件
4. **易维护**：修改某类别只需修改对应文件

**实现方式**：
- 每个类别数据独立在 `lib/src/data/categories/` 目录下
- `ConversionData` 作为聚合类提供统一访问接口
- 使用 `const` 定义不可变数据

详细的架构设计请参考 [ARCHITECTURE.md](ARCHITECTURE.md)。

## 设计原则

### 1. 模块化设计

- **单位换算模块**：基础的物理单位转换
- **汇率换算模块**：实时货币汇率转换
- **房贷计算模块**：贷款计算和还款计划
- **UI 组件模块**：可复用的界面组件
- 各模块独立，可按需使用

### 2. 统一的 API 风格

```dart
// 单位换算
final converter = UnitConverter();
final result = converter.convert(
  value: 1.0,
  categoryId: 'length',
  fromUnitId: 'meter',
  toUnitId: 'kilometer',
);

// 汇率换算
final currencyConverter = CurrencyConverter();
final amount = await currencyConverter.convert(
  value: 100.0,
  from: 'USD',
  to: 'CNY',
);

// 房贷计算
final calculator = MortgageCalculator();
final result = calculator.calculateEqualPayment(
  principal: 1000000,
  annualRate: 0.049,
  years: 30,
);
```

### 3. 最小依赖原则

- 核心功能零外部依赖
- 汇率功能需要 `http` 包（可选）
- UI 组件依赖 Flutter SDK
- 保持包的轻量级

### 4. 高性能

- 本地计算优先
- 汇率数据缓存
- 避免不必要的网络请求
- 优化计算算法

### 5. 完整测试

- 每个功能都有对应的单元测试
- 测试覆盖正常情况和边界情况
- Widget 测试覆盖 UI 组件

### 6. 清晰的文档

- 所有公共 API 都有详细的文档注释
- 提供使用示例
- 包含最佳实践指南

## 特色功能

### 1. 扩展方法

为常用类型添加便捷的扩展方法：

```dart
// 单位转换扩展
extension DoubleConversionExtension on double {
  double toKilometers() => this * 1000;
  double toMiles() => this * 1.60934;
  double toCelsius() => (this - 32) * 5 / 9;
  double toFahrenheit() => this * 9 / 5 + 32;
}

// 货币扩展
extension CurrencyExtension on double {
  Future<double> toUSD() async => await CurrencyConverter().convert(
    value: this,
    from: 'CNY',
    to: 'USD',
  );
}
```

### 2. 智能输入

- 自动识别输入格式
- 支持科学计数法
- 支持千分位分隔符
- 实时输入验证

### 3. 历史记录

- 保存最近的换算记录
- 快速重复换算
- 收藏常用换算

### 4. 离线支持

- 所有单位换算完全离线
- 汇率数据本地缓存
- 自动更新机制

### 5. 主题定制

- 支持亮色/暗色主题
- 自定义主题色
- 适配系统主题

## 功能对比

### ConversionKit vs 其他换算应用

| 功能 | 普通换算应用 | ConversionKit |
|------|-------------|---------------|
| 基础单位换算 | ✅ | ✅ |
| 汇率换算 | ✅ | ✅ |
| 房贷计算 | ❌ | ✅ |
| 开源可定制 | ❌ | ✅ |
| Flutter 组件 | ❌ | ✅ |
| 完整测试 | ❌ | ✅ |
| 离线支持 | 部分 | ✅ |
| API 友好 | ❌ | ✅ |

### 定位

- **面向开发者**：提供可复用的组件和 API
- **面向用户**：提供完整的换算应用
- **开源免费**：MIT 协议，可商用

## 适用场景

### 开发者场景

- ✅ Flutter 应用中需要单位换算功能
- ✅ 需要汇率换算的电商应用
- ✅ 房贷计算器应用
- ✅ 工具类应用开发
- ✅ 教育类应用

### 用户场景

- ✅ 日常单位换算
- ✅ 出国旅游汇率查询
- ✅ 购房贷款计算
- ✅ 学习和工作中的单位转换
- ✅ 跨国购物价格对比

## 技术限制

- ⚠️ 汇率数据需要网络连接（首次获取）
- ⚠️ double 精度限制（约 15-17 位有效数字）
- ⚠️ 不支持复杂单位组合（如 m/s²）
- ⚠️ 房贷计算基于标准公式，不包含特殊政策

## 性能目标

### 单位换算

- 基本转换：< 1 微秒
- 温度转换：< 2 微秒
- 进制转换：< 10 微秒

### 汇率换算

- 本地缓存查询：< 1 毫秒
- API 请求：< 2 秒
- 缓存有效期：24 小时

### 房贷计算

- 等额本息/本金：< 10 毫秒
- 还款计划生成（30年）：< 50 毫秒

## 质量目标

- 测试覆盖率：> 95%
- 代码分析：0 错误，0 警告
- 文档覆盖率：100%（所有公共 API）
- 性能回归：< 5%

## 发布计划

### v0.1.0（当前版本）✅

- ✅ 单位换算核心功能
- ✅ 9 大类别，60+ 单位
- ✅ 特殊转换：温度、进制
- ✅ 完整测试覆盖（63 个测试）

### v0.2.0（汇率与房贷）

**核心功能**
- 汇率换算器实现
- 汇率 API 集成（支持多个数据源）
- 汇率缓存机制
- 房贷计算器（等额本息、等额本金）
- 提前还款计算
- 还款计划表生成

**测试**
- 汇率转换测试
- 房贷计算测试
- API 集成测试

### v0.3.0（UI 组件）

**UI 组件**
- 类别网格组件
- 单位选择器
- 数值输入组件
- 结果展示组件
- 汇率页面
- 房贷计算页面

**功能增强**
- 历史记录
- 收藏功能
- 主题切换

### v0.4.0（扩展功能）

- 时间换算
- 数据存储换算
- 能量换算
- 角度换算
- 扩展方法
- 性能优化

### v1.0.0（正式版）

- 完整功能
- 完善文档
- 示例应用
- 发布到 pub.dev
- 应用商店上架

## 下一步行动

### 立即开始（v0.2.0）

1. **汇率换算模块**
   - 设计 Currency 模型
   - 实现 CurrencyConverter
   - 集成汇率 API（考虑多个数据源）
   - 实现缓存机制
   - 编写测试

2. **房贷计算模块**
   - 设计 Mortgage 模型
   - 实现 MortgageCalculator
   - 等额本息/本金算法
   - 提前还款计算
   - 还款计划生成
   - 编写测试

3. **文档完善**
   - API 集成文档
   - 使用示例
   - 最佳实践

### 后续计划

4. **UI 组件开发**（v0.3.0）
5. **扩展功能**（v0.4.0）
6. **性能优化和发布**（v1.0.0）

---

**文档版本**: 2.0  
**更新日期**: 2026-03-03  
**作者**: ZenKitX Team
