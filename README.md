# ConversionKit

单位换算工具包 - 提供单位换算、汇率转换、房贷计算等功能。

## 特性

- 🔢 **9 大类别**: 长度、面积、重量、温度、体积、速度、压强、功率、进制
- 📏 **60+ 单位**: 涵盖常用的国际单位和中国传统单位
- 💱 **汇率换算**: 支持 12 种主流货币的实时汇率转换
- 🏠 **房贷计算**: 等额本息、等额本金、提前还款、组合贷款
- 🌡️ **特殊转换**: 温度和进制转换的特殊处理
- 🎯 **高精度**: 使用 double 类型保证转换精度
- 🚀 **零依赖**: 纯 Dart 实现，无外部依赖
- ✅ **完整测试**: 98 个单元测试覆盖

## 安装

在 `pubspec.yaml` 中添加依赖：

```yaml
dependencies:
  conversion_kit: ^0.2.0
```

然后运行：

```bash
flutter pub get
```

## 快速开始

### 单位换算

```dart
import 'package:conversion_kit/conversion_kit.dart';

void main() {
  final converter = UnitConverter();

  // 长度转换
  final meters = converter.convert(
    value: 1.0,
    categoryId: 'length',
    fromUnitId: 'kilometer',
    toUnitId: 'meter',
  );
  print('1 千米 = $meters 米'); // 输出: 1 千米 = 1000.0 米

  // 温度转换
  final fahrenheit = converter.convert(
    value: 0,
    categoryId: 'temperature',
    fromUnitId: 'celsius',
    toUnitId: 'fahrenheit',
  );
  print('0 摄氏度 = $fahrenheit 华氏度'); // 输出: 0 摄氏度 = 32.0 华氏度

  // 进制转换
  final hex = converter.convertNumberSystem(
    value: '255',
    fromUnitId: 'decimal',
    toUnitId: 'hexadecimal',
  );
  print('255 (十进制) = $hex (十六进制)'); // 输出: 255 (十进制) = FF (十六进制)
}
```

### 汇率换算

```dart
import 'package:conversion_kit/conversion_kit.dart';

void main() async {
  final converter = CurrencyConverter();

  // 单个货币转换
  final cny = await converter.convert(
    value: 100,
    from: 'USD',
    to: 'CNY',
  );
  print('100 USD = $cny CNY');

  // 批量转换
  final results = await converter.convertMultiple(
    value: 100,
    from: 'USD',
    targets: ['CNY', 'EUR', 'JPY'],
  );
  
  // 金额格式化
  final formatted = converter.formatAmount(
    value: 1234567.89,
    currencyCode: 'USD',
  );
  print(formatted); // 1,234,567.89
}
```

### 房贷计算

```dart
import 'package:conversion_kit/conversion_kit.dart';

void main() {
  final calculator = MortgageCalculator();

  // 等额本息
  final result = calculator.calculate(
    principal: 1000000,
    annualRate: 0.049,
    years: 30,
    type: MortgageType.equalPayment,
  );
  
  print('月供: ${calculator.formatAmount(result.monthlyPayment)} 元');
  print('利息总额: ${calculator.formatAmount(result.totalInterest)} 元');

  // 提前还款
  final prepayment = calculator.calculatePrepayment(
    principal: 1000000,
    annualRate: 0.049,
    years: 30,
    paidMonths: 60,
    prepaymentAmount: 200000,
    type: MortgageType.equalPayment,
  );
  
  print('节省利息: ${calculator.formatAmount(prepayment.savedInterest)} 元');
}
```

## 支持的类别

### 1. 长度 (length)
- 米 (m)、千米 (km)、厘米 (cm)、毫米 (mm)
- 英尺 (ft)、英寸 (in)、码 (yd)、英里 (mi)

### 2. 面积 (area)
- 平方米 (m²)、平方千米 (km²)、平方厘米 (cm²)
- 公顷 (ha)、亩
- 平方英尺 (ft²)、平方英里 (mi²)

### 3. 重量 (weight)
- 千克 (kg)、克 (g)、毫克 (mg)、吨 (t)
- 磅 (lb)、盎司 (oz)
- 斤、两

### 4. 温度 (temperature) - 特殊转换
- 摄氏度 (°C)、华氏度 (°F)、开尔文 (K)

### 5. 体积 (volume)
- 立方米 (m³)、升 (L)、毫升 (mL)、立方厘米 (cm³)
- 加仑 (gal)、品脱 (pt)、立方英尺 (ft³)

### 6. 速度 (speed)
- 米/秒 (m/s)、千米/时 (km/h)
- 英里/时 (mph)、节 (kn)、英尺/秒 (ft/s)

### 7. 压强 (pressure)
- 帕斯卡 (Pa)、千帕 (kPa)、兆帕 (MPa)
- 巴 (bar)、大气压 (atm)、毫米汞柱 (mmHg)、磅/平方英寸 (psi)

### 8. 功率 (power)
- 瓦特 (W)、千瓦 (kW)、兆瓦 (MW)
- 马力 (hp)、BTU/时 (BTU/h)

### 9. 进制 (number_system) - 特殊转换
- 二进制 (BIN)、八进制 (OCT)、十进制 (DEC)、十六进制 (HEX)

## 使用示例

### 基本转换

```dart
final converter = UnitConverter();

// 长度转换
final result = converter.convert(
  value: 1.0,
  categoryId: 'length',
  fromUnitId: 'kilometer',
  toUnitId: 'meter',
);
print(result); // 1000.0
```

### 温度转换

```dart
// 摄氏度转华氏度
final fahrenheit = converter.convert(
  value: 0,
  categoryId: 'temperature',
  fromUnitId: 'celsius',
  toUnitId: 'fahrenheit',
);
print(fahrenheit); // 32.0

// 华氏度转开尔文
final kelvin = converter.convert(
  value: 32,
  categoryId: 'temperature',
  fromUnitId: 'fahrenheit',
  toUnitId: 'kelvin',
);
print(kelvin); // 273.15
```

### 进制转换

```dart
// 十进制转十六进制
final hex = converter.convertNumberSystem(
  value: '255',
  fromUnitId: 'decimal',
  toUnitId: 'hexadecimal',
);
print(hex); // FF

// 验证进制输入
final isValid = converter.isValidNumberSystemInput('FF', 'hexadecimal');
print(isValid); // true
```

### 格式化结果

```dart
// 格式化数值，移除尾部零
final formatted = converter.formatResult(123.456000);
print(formatted); // 123.456

// 极小值使用科学计数法
final scientific = converter.formatResult(0.00001);
print(scientific); // 1.000000e-5
```

### 获取类别和单位信息

```dart
// 获取所有类别
final categories = converter.getAllCategories();
for (final category in categories) {
  print('${category.name}: ${category.units.length} 个单位');
}

// 获取指定类别
final lengthCategory = converter.getCategory('length');
print(lengthCategory?.name); // 长度

// 获取类别的所有单位
final units = converter.getUnits('length');
for (final unit in units!) {
  print('${unit.name} (${unit.symbol})');
}
```

## API 文档

### 单位换算

#### UnitConverter

主要的转换器类，提供所有转换功能。

方法：
- `convert()` - 转换数值
- `convertNumberSystem()` - 转换进制
- `isValidNumberSystemInput()` - 验证进制输入
- `formatResult()` - 格式化结果
- `getAllCategories()` - 获取所有类别
- `getCategory()` - 获取指定类别
- `getUnits()` - 获取类别的所有单位

### 汇率换算

#### CurrencyConverter

汇率转换器，提供货币转换功能。

方法：
- `convert()` - 转换货币
- `convertMultiple()` - 批量转换
- `formatAmount()` - 格式化金额

#### Currency

货币模型，包含货币代码、名称和符号。

#### CurrencyData

货币数据类，包含 12 种主流货币：
- USD (美元)、EUR (欧元)、CNY (人民币)
- JPY (日元)、GBP (英镑)、AUD (澳元)
- CAD (加元)、CHF (瑞士法郎)、HKD (港币)
- SGD (新加坡元)、KRW (韩元)、TWD (新台币)

### 房贷计算

#### MortgageCalculator

房贷计算器，提供房贷计算功能。

方法：
- `calculate()` - 计算房贷
- `calculatePrepayment()` - 计算提前还款
- `calculateCombination()` - 计算组合贷款
- `formatAmount()` - 格式化金额

#### MortgageType

房贷类型枚举：
- `equalPayment` - 等额本息
- `equalPrincipal` - 等额本金

#### MortgageResult

房贷计算结果，包含：
- `monthlyPayment` - 月供金额
- `totalPayment` - 还款总额
- `totalInterest` - 利息总额
- `schedule` - 还款计划表

### 数据模型

#### ConversionUnit

单位模型，包含单位的标识、名称、符号和转换比率。

#### ConversionCategory

类别模型，包含一组相关的单位。

#### ConversionLogic

转换逻辑工具类，提供底层转换算法。

#### ConversionData

数据定义类，包含所有支持的单位和类别。

## 测试

运行所有测试：

```bash
cd conversion_kit
flutter test
```

运行代码分析：

```bash
flutter analyze
```

## 设计原则

1. **零依赖**: 纯 Dart 实现，不依赖任何外部包
2. **高精度**: 使用 double 类型保证转换精度
3. **易扩展**: 清晰的数据结构，方便添加新单位
4. **类型安全**: 使用强类型，避免运行时错误
5. **完整测试**: 98 个单元测试覆盖所有功能
6. **模块化**: 按功能模块组织代码，低耦合高内聚
7. **SOLID 原则**: 遵循单一职责、开闭原则等设计原则

详细的架构设计请参考 [ARCHITECTURE.md](docs/ARCHITECTURE.md)。

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！

## 更新日志

查看 [CHANGELOG.md](CHANGELOG.md) 了解版本更新历史。
