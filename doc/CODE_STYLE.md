# 代码风格指南

本文档定义了 ConversionKit 项目的代码风格规范。

## 基本原则

1. **一致性**: 保持代码风格一致
2. **可读性**: 代码应该易于理解
3. **简洁性**: 避免不必要的复杂性
4. **可维护性**: 便于后续维护和扩展

## 命名规范

### 文件命名

- 使用 `snake_case`（小写下划线）
- 文件名应该描述其内容

```dart
// 好的示例
unit_converter.dart
conversion_data.dart
mortgage_calculator.dart

// 不好的示例
UnitConverter.dart
conversionData.dart
MortgageCalc.dart
```

### 类命名

- 使用 `PascalCase`（大驼峰）
- 类名应该是名词或名词短语

```dart
// 好的示例
class UnitConverter {}
class ConversionCategory {}
class MortgageCalculator {}

// 不好的示例
class unitConverter {}
class conversion_category {}
class Calculate {}
```

### 变量和方法命名

- 使用 `camelCase`（小驼峰）
- 变量名应该是名词
- 方法名应该是动词或动词短语
- 布尔变量使用 `is`、`has`、`can` 等前缀

```dart
// 好的示例
final converter = UnitConverter();
final isValid = true;
final hasData = false;

double convert(double value) {}
bool validate(String input) {}

// 不好的示例
final Converter = UnitConverter();
final valid = true;

double conversion(double value) {}
bool check(String input) {}
```

### 常量命名

- 使用 `lowerCamelCase`
- 编译时常量使用 `const`

```dart
// 好的示例
const pi = 3.14159;
const maxRetries = 3;
const defaultTimeout = Duration(seconds: 30);

// 不好的示例
const PI = 3.14159;
const MAX_RETRIES = 3;
```

### 枚举命名

- 枚举类型使用 `PascalCase`
- 枚举值使用 `camelCase`

```dart
// 好的示例
enum ConversionType {
  length,
  weight,
  temperature,
}

// 不好的示例
enum conversion_type {
  LENGTH,
  WEIGHT,
  TEMPERATURE,
}
```

## 代码格式

### 缩进

- 使用 2 个空格缩进
- 不使用 Tab

### 行长度

- 每行最多 80 个字符
- 超过时适当换行

```dart
// 好的示例
final result = converter.convert(
  value: 1.0,
  categoryId: 'length',
  fromUnitId: 'meter',
  toUnitId: 'kilometer',
);

// 不好的示例
final result = converter.convert(value: 1.0, categoryId: 'length', fromUnitId: 'meter', toUnitId: 'kilometer');
```

### 尾随逗号

- 多行参数列表使用尾随逗号
- 有助于格式化和 diff

```dart
// 好的示例
final category = ConversionCategory(
  id: 'length',
  name: '长度',
  units: lengthUnits,
);

// 不好的示例
final category = ConversionCategory(
  id: 'length',
  name: '长度',
  units: lengthUnits
);
```

### 空行

- 类成员之间使用一个空行
- 逻辑块之间使用一个空行
- 不要有多个连续空行

```dart
class UnitConverter {
  final ConversionData data;

  UnitConverter(this.data);

  double convert(double value) {
    // 实现
  }

  bool validate(String input) {
    // 实现
  }
}
```

## 类型注解

### 公共 API

- 必须显式声明返回类型
- 必须显式声明参数类型

```dart
// 好的示例
double convert({
  required double value,
  required String categoryId,
  required String fromUnitId,
  required String toUnitId,
}) {
  // 实现
}

// 不好的示例
convert({
  required value,
  required categoryId,
  required fromUnitId,
  required toUnitId,
}) {
  // 实现
}
```

### 局部变量

- 可以省略类型（使用类型推断）
- 复杂类型建议显式声明

```dart
// 好的示例
final converter = UnitConverter();
final result = converter.convert(/* ... */);

// 也可以
final UnitConverter converter = UnitConverter();
final double result = converter.convert(/* ... */);
```

## 文档注释

### 公共 API

- 所有公共类、方法、属性必须有文档注释
- 使用 `///` 三斜线注释
- 第一行是简短描述（一句话）
- 详细说明另起段落
- 包含使用示例

```dart
/// 单位转换器。
///
/// 提供统一的单位转换接口，支持多种类别的单位转换。
///
/// ## 使用示例
///
/// ```dart
/// final converter = UnitConverter();
/// final result = converter.convert(
///   value: 1.0,
///   categoryId: 'length',
///   fromUnitId: 'kilometer',
///   toUnitId: 'meter',
/// );
/// ```
class UnitConverter {
  /// 转换数值。
  ///
  /// 根据类别和单位 ID 进行转换。
  ///
  /// 参数:
  /// - [value]: 要转换的数值
  /// - [categoryId]: 类别 ID
  /// - [fromUnitId]: 源单位 ID
  /// - [toUnitId]: 目标单位 ID
  ///
  /// 返回转换后的数值，如果转换失败返回原值。
  double convert({
    required double value,
    required String categoryId,
    required String fromUnitId,
    required String toUnitId,
  }) {
    // 实现
  }
}
```

### 私有成员

- 复杂逻辑使用行内注释
- 使用 `//` 双斜线注释

```dart
double _calculateResult(double value) {
  // 先转换到基准单位
  final baseValue = value * fromUnit.toBaseRatio;
  
  // 再转换到目标单位
  return baseValue / toUnit.toBaseRatio;
}
```

## 最佳实践

### 使用 const

- 尽可能使用 `const` 构造函数
- 编译时常量使用 `const`

```dart
// 好的示例
const unit = ConversionUnit(
  id: 'meter',
  name: '米',
  symbol: 'm',
  toBaseRatio: 1.0,
);

// 不好的示例
final unit = ConversionUnit(
  id: 'meter',
  name: '米',
  symbol: 'm',
  toBaseRatio: 1.0,
);
```

### 使用 final

- 不可变变量使用 `final`
- 优先使用 `final` 而不是 `var`

```dart
// 好的示例
final converter = UnitConverter();
final result = converter.convert(/* ... */);

// 不好的示例
var converter = UnitConverter();
var result = converter.convert(/* ... */);
```

### 避免 null

- 使用非空类型
- 必要时使用 `?` 标记可空类型
- 使用 `required` 标记必需参数

```dart
// 好的示例
class ConversionUnit {
  final String id;
  final String name;
  final String? description; // 可选
  
  const ConversionUnit({
    required this.id,
    required this.name,
    this.description,
  });
}

// 不好的示例
class ConversionUnit {
  String? id;
  String? name;
  String? description;
  
  ConversionUnit(this.id, this.name, this.description);
}
```

### 使用命名参数

- 多个参数时使用命名参数
- 提高可读性

```dart
// 好的示例
converter.convert(
  value: 1.0,
  categoryId: 'length',
  fromUnitId: 'meter',
  toUnitId: 'kilometer',
);

// 不好的示例
converter.convert(1.0, 'length', 'meter', 'kilometer');
```

### 错误处理

- 使用异常处理错误情况
- 提供有意义的错误信息
- 文档中说明可能抛出的异常

```dart
/// 转换数值。
///
/// 抛出 [ArgumentError] 如果类别或单位不存在。
double convert({
  required double value,
  required String categoryId,
  required String fromUnitId,
  required String toUnitId,
}) {
  final category = _findCategory(categoryId);
  if (category == null) {
    throw ArgumentError('类别不存在: $categoryId');
  }
  
  // ...
}
```

## 测试风格

### 测试命名

- 使用描述性的测试名称
- 说明测试的内容和期望

```dart
test('千米转米应该返回正确结果', () {
  final result = converter.convert(
    value: 1.0,
    categoryId: 'length',
    fromUnitId: 'kilometer',
    toUnitId: 'meter',
  );
  
  expect(result, 1000.0);
});
```

### 测试组织

- 使用 `group` 组织相关测试
- 使用 `setUp` 和 `tearDown` 管理测试状态

```dart
group('UnitConverter', () {
  late UnitConverter converter;

  setUp(() {
    converter = UnitConverter();
  });

  group('长度转换', () {
    test('千米转米应该返回正确结果', () {
      // ...
    });

    test('相同单位转换应该返回原值', () {
      // ...
    });
  });
});
```

## 工具

### 格式化

```bash
# 格式化所有文件
dart format .

# 检查格式（不修改）
dart format --output=none --set-exit-if-changed .
```

### 分析

```bash
# 运行代码分析
flutter analyze

# 修复可自动修复的问题
dart fix --apply
```

### 测试

```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/converters/unit_converter_test.dart

# 生成覆盖率报告
flutter test --coverage
```

---

遵循这些规范将帮助保持代码库的一致性和可维护性。
