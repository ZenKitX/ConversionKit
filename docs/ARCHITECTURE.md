# ConversionKit 架构设计

本文档描述 ConversionKit 项目的架构设计原则和实现方案。

## 目录

1. [设计原则](#设计原则)
2. [目录结构](#目录结构)
3. [模块划分](#模块划分)
4. [数据组织](#数据组织)
5. [扩展指南](#扩展指南)

## 设计原则

### 1. 单一职责原则 (Single Responsibility Principle)

每个类、文件只负责一个明确的功能。

**示例**：
- `LengthData` 只负责长度单位数据
- `UnitConverter` 只负责单位转换逻辑
- `ConversionLogic` 只负责转换算法

### 2. 开闭原则 (Open-Closed Principle)

对扩展开放，对修改关闭。

**实现**：
- 添加新类别不需要修改现有代码
- 只需新增类别数据文件并在 `ConversionData` 中引用

### 3. 低耦合原则 (Low Coupling)

模块之间保持松散耦合，减少相互依赖。

**实现**：
- 各类别数据文件独立，互不依赖
- 通过统一接口访问数据

### 4. 高内聚原则 (High Cohesion)

相关功能聚合在一起。

**实现**：
- 同一类别的所有单位定义在同一文件
- 转换逻辑集中在 `ConversionLogic`

### 5. 依赖倒置原则 (Dependency Inversion Principle)

依赖抽象而不是具体实现。

**实现**：
- 使用 `ConversionCategory` 和 `ConversionUnit` 模型
- 转换器依赖模型接口而不是具体数据

## 目录结构

```
lib/
├── conversion_kit.dart              # 主导出文件
└── src/                             # 源代码目录
    ├── models/                      # 数据模型
    │   ├── conversion_unit.dart     # 单位模型
    │   ├── conversion_category.dart # 类别模型
    │   └── currency.dart            # 货币模型
    ├── converters/                  # 转换器
    │   └── unit_converter.dart      # 单位转换器
    ├── calculators/                 # 计算器（待实现）
    │   └── mortgage_calculator.dart # 房贷计算器
    ├── data/                        # 数据定义
    │   ├── conversion_data.dart     # 数据聚合类
    │   └── categories/              # 类别数据目录
    │       ├── length_data.dart     # 长度单位数据
    │       ├── area_data.dart       # 面积单位数据
    │       ├── weight_data.dart     # 重量单位数据
    │       ├── temperature_data.dart # 温度单位数据
    │       ├── volume_data.dart     # 体积单位数据
    │       ├── speed_data.dart      # 速度单位数据
    │       ├── pressure_data.dart   # 压强单位数据
    │       ├── power_data.dart      # 功率单位数据
    │       └── number_system_data.dart # 进制单位数据
    ├── services/                    # 服务层（待实现）
    │   ├── currency_api_service.dart # 汇率 API 服务
    │   └── cache_service.dart       # 缓存服务
    ├── utils/                       # 工具类
    │   └── conversion_logic.dart    # 转换逻辑
    └── ui/                          # UI 组件（待实现）
        ├── widgets/                 # 通用组件
        └── screens/                 # 页面

test/                                # 测试目录
├── models/                          # 模型测试
├── converters/                      # 转换器测试
├── calculators/                     # 计算器测试
├── data/                            # 数据测试
├── services/                        # 服务测试
└── utils/                           # 工具测试
```

## 模块划分

### Models（数据模型）

定义核心数据结构，不包含业务逻辑。

**职责**：
- 定义数据结构
- 提供基本的相等性比较
- 提供字符串表示

**示例**：
```dart
class ConversionUnit {
  const ConversionUnit({
    required this.id,
    required this.name,
    required this.symbol,
    required this.toBaseRatio,
  });

  final String id;
  final String name;
  final String symbol;
  final double toBaseRatio;
}
```

### Data（数据定义）

存储静态数据，按类别组织。

**设计原则**：
- 每个类别一个文件
- 使用 `const` 定义不可变数据
- 提供类别实例

**文件结构**：
```dart
// lib/src/data/categories/length_data.dart
class LengthData {
  static const units = [/* 单位列表 */];
  static const category = ConversionCategory(
    id: 'length',
    name: '长度',
    units: units,
  );
}
```

### Converters（转换器）

实现转换逻辑，协调数据和算法。

**职责**：
- 提供统一的转换接口
- 调用转换算法
- 处理特殊情况

### Utils（工具类）

提供纯函数的工具方法。

**职责**：
- 实现转换算法
- 提供格式化方法
- 提供验证方法

## 数据组织

### 为什么按类别拆分数据？

#### 问题

原始设计将所有数据放在一个文件中：

```dart
// ❌ 不好的设计
class ConversionData {
  static const lengthUnits = [/* 8 个单位 */];
  static const areaUnits = [/* 7 个单位 */];
  static const weightUnits = [/* 8 个单位 */];
  // ... 更多类别
  static final categories = [/* 9 个类别 */];
}
```

**缺点**：
1. 文件过大（300+ 行）
2. 职责不清
3. 难以维护
4. 耦合度高
5. 扩展性差

#### 解决方案

按类别拆分数据文件：

```dart
// ✅ 好的设计

// lib/src/data/categories/length_data.dart
class LengthData {
  static const units = [/* 长度单位 */];
  static const category = ConversionCategory(
    id: 'length',
    name: '长度',
    units: units,
  );
}

// lib/src/data/conversion_data.dart
class ConversionData {
  static final categories = [
    LengthData.category,
    AreaData.category,
    // ... 其他类别
  ];
}
```

**优点**：
1. **单一职责**：每个文件只负责一个类别
2. **低耦合**：各类别独立，互不影响
3. **易扩展**：添加新类别只需新增文件
4. **易维护**：修改某类别只需修改对应文件
5. **清晰明了**：文件结构一目了然

### 数据文件模板

创建新类别数据文件时，遵循以下模板：

```dart
import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// [类别名称]单位数据
///
/// 包含常用的[类别名称]单位，基准单位为[基准单位]。
class [ClassName]Data {
  /// [类别名称]单位列表
  static const units = [
    ConversionUnit(
      id: 'unit_id',
      name: '单位名称',
      symbol: '符号',
      toBaseRatio: 1,
    ),
    // 更多单位...
  ];

  /// [类别名称]类别
  static const category = ConversionCategory(
    id: 'category_id',
    name: '类别名称',
    units: units,
    isSpecial: false, // 如果是特殊类别设为 true
  );
}
```

### 特殊类别处理

某些类别需要特殊的转换逻辑：

#### 温度转换

温度转换使用非线性公式，不能使用简单的比率：

```dart
class TemperatureData {
  static const units = [
    ConversionUnit(id: 'celsius', name: '摄氏度', symbol: '°C', toBaseRatio: 1),
    ConversionUnit(id: 'fahrenheit', name: '华氏度', symbol: '°F', toBaseRatio: 1),
    ConversionUnit(id: 'kelvin', name: '开尔文', symbol: 'K', toBaseRatio: 1),
  ];

  static const category = ConversionCategory(
    id: 'temperature',
    name: '温度',
    units: units,
    isSpecial: true, // 标记为特殊类别
  );
}
```

转换逻辑在 `ConversionLogic.convertTemperature()` 中实现。

#### 进制转换

进制转换使用整数转换，不使用浮点数：

```dart
class NumberSystemData {
  static const units = [
    ConversionUnit(id: 'binary', name: '二进制', symbol: 'BIN', toBaseRatio: 2),
    ConversionUnit(id: 'octal', name: '八进制', symbol: 'OCT', toBaseRatio: 8),
    ConversionUnit(id: 'decimal', name: '十进制', symbol: 'DEC', toBaseRatio: 10),
    ConversionUnit(id: 'hexadecimal', name: '十六进制', symbol: 'HEX', toBaseRatio: 16),
  ];

  static const category = ConversionCategory(
    id: 'number_system',
    name: '进制',
    units: units,
    isSpecial: true, // 标记为特殊类别
  );
}
```

转换逻辑在 `ConversionLogic.convertNumberSystem()` 中实现。

## 扩展指南

### 添加新类别

按照以下步骤添加新类别：

#### 1. 创建类别数据文件

在 `lib/src/data/categories/` 目录下创建新文件：

```dart
// lib/src/data/categories/time_data.dart
import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 时间单位数据
///
/// 包含常用的时间单位，基准单位为秒（s）。
class TimeData {
  /// 时间单位列表
  static const units = [
    ConversionUnit(id: 'second', name: '秒', symbol: 's', toBaseRatio: 1),
    ConversionUnit(id: 'minute', name: '分钟', symbol: 'min', toBaseRatio: 60),
    ConversionUnit(id: 'hour', name: '小时', symbol: 'h', toBaseRatio: 3600),
    ConversionUnit(id: 'day', name: '天', symbol: 'd', toBaseRatio: 86400),
  ];

  /// 时间类别
  static const category = ConversionCategory(
    id: 'time',
    name: '时间',
    units: units,
  );
}
```

#### 2. 在 ConversionData 中引用

更新 `lib/src/data/conversion_data.dart`：

```dart
import 'categories/time_data.dart'; // 添加导入

class ConversionData {
  static final categories = [
    LengthData.category,
    // ... 其他类别
    TimeData.category, // 添加新类别
  ];
}
```

#### 3. 创建测试文件

创建 `test/data/categories/time_data_test.dart`：

```dart
import 'package:conversion_kit/src/data/categories/time_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TimeData', () {
    test('时间单位数量正确', () {
      expect(TimeData.units.length, 4);
    });

    test('时间类别配置正确', () {
      expect(TimeData.category.id, 'time');
      expect(TimeData.category.name, '时间');
      expect(TimeData.category.isSpecial, false);
    });
  });
}
```

#### 4. 提交代码

```bash
git add lib/src/data/categories/time_data.dart
git add lib/src/data/conversion_data.dart
git add test/data/categories/time_data_test.dart
git commit -m "feat(data): 添加时间单位类别

- 创建 TimeData 类，包含秒、分钟、小时、天
- 基准单位为秒（s）
- 在 ConversionData 中注册新类别
- 添加完整的单元测试
- 所有测试通过"
```

### 添加新单位

在现有类别中添加新单位：

#### 1. 更新类别数据文件

```dart
// lib/src/data/categories/length_data.dart
class LengthData {
  static const units = [
    // 现有单位...
    ConversionUnit(
      id: 'nautical_mile',
      name: '海里',
      symbol: 'nmi',
      toBaseRatio: 1852,
    ), // 新增单位
  ];
}
```

#### 2. 更新测试

```dart
test('长度类别包含正确数量的单位', () {
  final category = ConversionData.findCategoryById('length');
  expect(category?.units.length, 9); // 更新数量
});
```

#### 3. 提交代码

```bash
git add lib/src/data/categories/length_data.dart
git add test/data/conversion_data_test.dart
git commit -m "feat(data): 长度类别添加海里单位

- 添加海里（nautical mile）单位
- 1 海里 = 1852 米
- 更新测试
- 所有测试通过"
```

## 最佳实践

### 1. 保持数据不可变

使用 `const` 定义所有数据：

```dart
// ✅ 好的做法
static const units = [
  ConversionUnit(id: 'meter', name: '米', symbol: 'm', toBaseRatio: 1),
];

// ❌ 不好的做法
static var units = [
  ConversionUnit(id: 'meter', name: '米', symbol: 'm', toBaseRatio: 1),
];
```

### 2. 提供完整的文档注释

每个类别数据文件都应该有清晰的文档：

```dart
/// 长度单位数据
///
/// 包含常用的长度单位，基准单位为米（m）。
///
/// ## 支持的单位
///
/// - 米 (m) - 基准单位
/// - 千米 (km) - 1000 米
/// - 厘米 (cm) - 0.01 米
/// - 毫米 (mm) - 0.001 米
/// - 英尺 (ft) - 0.3048 米
/// - 英寸 (in) - 0.0254 米
/// - 码 (yd) - 0.9144 米
/// - 英里 (mi) - 1609.344 米
class LengthData {
  // ...
}
```

### 3. 保持命名一致性

- 类名：`[Category]Data`（如 `LengthData`）
- 文件名：`[category]_data.dart`（如 `length_data.dart`）
- 类别 ID：小写下划线（如 `length`、`number_system`）
- 单位 ID：小写下划线（如 `meter`、`square_meter`）

### 4. 测试覆盖

每个类别数据文件都应该有对应的测试：

- 单位数量测试
- 类别配置测试
- 特殊标记测试（如果适用）

## 总结

ConversionKit 的架构设计遵循 SOLID 原则，通过模块化、低耦合的设计，实现了：

1. **易维护**：每个文件职责单一，修改影响范围小
2. **易扩展**：添加新功能不需要修改现有代码
3. **易测试**：模块独立，测试简单直接
4. **易理解**：结构清晰，文档完善

这种设计为项目的长期发展奠定了坚实的基础。

---

**文档版本**: 1.0  
**创建日期**: 2026-03-03  
**作者**: ZenKitX Team
