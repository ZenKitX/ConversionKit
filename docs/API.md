# ConversionKit API 参考文档

本文档提供 ConversionKit 的完整 API 参考。

## 目录

- [单位换算](#单位换算)
- [汇率转换](#汇率转换)
- [房贷计算](#房贷计算)
- [数据模型](#数据模型)

---

## 单位换算

### UnitConverter

主要的单位转换器类。

#### 构造函数

```dart
UnitConverter()
```

创建一个单位转换器实例。

#### 方法

##### convert

```dart
double convert({
  required double value,
  required String categoryId,
  required String fromUnitId,
  required String toUnitId,
})
```

转换数值。

**参数:**
- `value`: 要转换的数值
- `categoryId`: 类别 ID（如 'length', 'area', 'weight'）
- `fromUnitId`: 源单位 ID
- `toUnitId`: 目标单位 ID

**返回:** 转换后的数值

**示例:**
```dart
final converter = UnitConverter();
final meters = converter.convert(
  value: 1.0,
  categoryId: 'length',
  fromUnitId: 'kilometer',
  toUnitId: 'meter',
);
print(meters); // 1000.0
```

##### convertNumberSystem

```dart
String convertNumberSystem({
  required String value,
  required String fromUnitId,
  required String toUnitId,
})
```

转换进制。

**参数:**
- `value`: 要转换的字符串值
- `fromUnitId`: 源进制 ID（'binary', 'octal', 'decimal', 'hexadecimal'）
- `toUnitId`: 目标进制 ID

**返回:** 转换后的字符串

**示例:**
```dart
final hex = converter.convertNumberSystem(
  value: '255',
  fromUnitId: 'decimal',
  toUnitId: 'hexadecimal',
);
print(hex); // FF
```

##### isValidNumberSystemInput

```dart
bool isValidNumberSystemInput(String value, String unitId)
```

验证进制输入是否有效。

**参数:**
- `value`: 要验证的字符串
- `unitId`: 进制 ID

**返回:** 是否有效

##### formatResult

```dart
String formatResult(double value)
```

格式化结果，移除尾部零，极小值使用科学计数法。

**参数:**
- `value`: 要格式化的数值

**返回:** 格式化后的字符串

##### getAllCategories

```dart
List<ConversionCategory> getAllCategories()
```

获取所有类别。

**返回:** 类别列表

##### getCategory

```dart
ConversionCategory? getCategory(String categoryId)
```

获取指定类别。

**参数:**
- `categoryId`: 类别 ID

**返回:** 类别对象，如果不存在返回 null

##### getUnits

```dart
List<ConversionUnit>? getUnits(String categoryId)
```

获取类别的所有单位。

**参数:**
- `categoryId`: 类别 ID

**返回:** 单位列表，如果类别不存在返回 null

---

## 汇率转换

### CurrencyConverter

汇率转换器类。

#### 构造函数

```dart
CurrencyConverter({CurrencyApiService? apiService})
```

创建汇率转换器实例。

**参数:**
- `apiService`: 汇率 API 服务，默认使用 `MockCurrencyApiService`

#### 方法

##### convert

```dart
Future<double?> convert({
  required double value,
  required String from,
  required String to,
})
```

转换货币。

**参数:**
- `value`: 要转换的金额
- `from`: 源货币代码（ISO 4217）
- `to`: 目标货币代码

**返回:** 转换后的金额，如果失败返回 null

**示例:**
```dart
final converter = CurrencyConverter();
final cny = await converter.convert(
  value: 100,
  from: 'USD',
  to: 'CNY',
);
print(cny); // 约 720.0
```

##### convertMultiple

```dart
Future<Map<String, double>> convertMultiple({
  required double value,
  required String from,
  required List<String> targets,
})
```

批量转换货币。

**参数:**
- `value`: 要转换的金额
- `from`: 源货币代码
- `targets`: 目标货币代码列表

**返回:** 货币代码到金额的映射

**示例:**
```dart
final results = await converter.convertMultiple(
  value: 100,
  from: 'USD',
  targets: ['CNY', 'EUR', 'JPY'],
);
```

##### formatAmount

```dart
String formatAmount({
  required double value,
  required String currencyCode,
  int decimals = 2,
})
```

格式化货币金额。

**参数:**
- `value`: 金额
- `currencyCode`: 货币代码
- `decimals`: 小数位数，默认为 2

**返回:** 格式化后的字符串（带千分位）

**示例:**
```dart
final formatted = converter.formatAmount(
  value: 1234567.89,
  currencyCode: 'USD',
);
print(formatted); // 1,234,567.89
```

### CurrencyData

货币数据类。

#### 静态属性

##### currencies

```dart
static const List<Currency> currencies
```

所有支持的货币列表。

#### 静态方法

##### findCurrencyByCode

```dart
static Currency? findCurrencyByCode(String code)
```

根据货币代码查找货币。

**参数:**
- `code`: 货币代码（不区分大小写）

**返回:** 货币对象，如果不存在返回 null

---

## 房贷计算

### MortgageCalculator

房贷计算器类。

#### 构造函数

```dart
MortgageCalculator()
```

创建房贷计算器实例。

#### 方法

##### calculate

```dart
MortgageResult calculate({
  required double principal,
  required double annualRate,
  required int years,
  required MortgageType type,
})
```

计算房贷。

**参数:**
- `principal`: 贷款本金
- `annualRate`: 年利率（如 0.049 表示 4.9%）
- `years`: 贷款年数
- `type`: 房贷类型（`MortgageType.equalPayment` 或 `MortgageType.equalPrincipal`）

**返回:** 房贷计算结果

**示例:**
```dart
final calculator = MortgageCalculator();
final result = calculator.calculate(
  principal: 1000000,
  annualRate: 0.049,
  years: 30,
  type: MortgageType.equalPayment,
);
print('月供: ${result.monthlyPayment}');
```

##### calculatePrepayment

```dart
PrepaymentResult calculatePrepayment({
  required double principal,
  required double annualRate,
  required int years,
  required int paidMonths,
  required double prepaymentAmount,
  required MortgageType type,
})
```

计算提前还款。

**参数:**
- `principal`: 原贷款本金
- `annualRate`: 年利率
- `years`: 总贷款年数
- `paidMonths`: 已还月数
- `prepaymentAmount`: 提前还款金额
- `type`: 房贷类型

**返回:** 提前还款结果

**示例:**
```dart
final result = calculator.calculatePrepayment(
  principal: 1000000,
  annualRate: 0.049,
  years: 30,
  paidMonths: 60,
  prepaymentAmount: 200000,
  type: MortgageType.equalPayment,
);
print('节省利息: ${result.savedInterest}');
```

##### calculateCombination

```dart
MortgageResult calculateCombination({
  required double commercialPrincipal,
  required double commercialRate,
  required double providentPrincipal,
  required double providentRate,
  required int years,
  required MortgageType type,
})
```

计算组合贷款。

**参数:**
- `commercialPrincipal`: 商业贷款本金
- `commercialRate`: 商业贷款年利率
- `providentPrincipal`: 公积金贷款本金
- `providentRate`: 公积金贷款年利率
- `years`: 贷款年数
- `type`: 房贷类型

**返回:** 组合贷款计算结果

**示例:**
```dart
final result = calculator.calculateCombination(
  commercialPrincipal: 700000,
  commercialRate: 0.049,
  providentPrincipal: 300000,
  providentRate: 0.0325,
  years: 30,
  type: MortgageType.equalPayment,
);
```

##### formatAmount

```dart
String formatAmount(double amount, {int decimals = 2})
```

格式化金额。

**参数:**
- `amount`: 金额
- `decimals`: 小数位数，默认为 2

**返回:** 格式化后的字符串（带千分位）

---

## 数据模型

### ConversionUnit

单位模型。

#### 属性

```dart
final String id;           // 单位 ID
final String name;         // 单位名称
final String symbol;       // 单位符号
final double toBaseRatio;  // 到基准单位的转换比率
```

#### 构造函数

```dart
const ConversionUnit({
  required this.id,
  required this.name,
  required this.symbol,
  required this.toBaseRatio,
})
```

### ConversionCategory

类别模型。

#### 属性

```dart
final String id;                      // 类别 ID
final String name;                    // 类别名称
final List<ConversionUnit> units;     // 单位列表
final bool isSpecial;                 // 是否为特殊类别
```

#### 构造函数

```dart
const ConversionCategory({
  required this.id,
  required this.name,
  required this.units,
  this.isSpecial = false,
})
```

#### 方法

##### findUnitById

```dart
ConversionUnit? findUnitById(String unitId)
```

根据 ID 查找单位。

### Currency

货币模型。

#### 属性

```dart
final String code;    // 货币代码（ISO 4217）
final String name;    // 货币名称
final String symbol;  // 货币符号
```

#### 构造函数

```dart
const Currency({
  required this.code,
  required this.name,
  required this.symbol,
})
```

### MortgageType

房贷类型枚举。

```dart
enum MortgageType {
  equalPayment,   // 等额本息
  equalPrincipal, // 等额本金
}
```

### MortgageResult

房贷计算结果。

#### 属性

```dart
final double monthlyPayment;              // 月供金额
final double totalPayment;                // 还款总额
final double totalInterest;               // 利息总额
final List<MonthlyPayment> schedule;      // 还款计划表
```

### MonthlyPayment

月供详情。

#### 属性

```dart
final int month;                    // 期数
final double payment;               // 月供金额
final double principal;             // 本金
final double interest;              // 利息
final double remainingPrincipal;    // 剩余本金
```

### PrepaymentResult

提前还款结果。

#### 属性

```dart
final double savedInterest;         // 节省的利息
final double newMonthlyPayment;     // 新的月供金额
final double newTotalPayment;       // 新的还款总额
final double newTotalInterest;      // 新的利息总额
final int reducedMonths;            // 减少的月数
```

---

## 支持的单位

### 长度 (length)

| ID | 名称 | 符号 | 基准比率 |
|----|------|------|----------|
| meter | 米 | m | 1 |
| kilometer | 千米 | km | 1000 |
| centimeter | 厘米 | cm | 0.01 |
| millimeter | 毫米 | mm | 0.001 |
| foot | 英尺 | ft | 0.3048 |
| inch | 英寸 | in | 0.0254 |
| yard | 码 | yd | 0.9144 |
| mile | 英里 | mi | 1609.344 |

### 面积 (area)

| ID | 名称 | 符号 | 基准比率 |
|----|------|------|----------|
| square_meter | 平方米 | m² | 1 |
| square_kilometer | 平方千米 | km² | 1000000 |
| square_centimeter | 平方厘米 | cm² | 0.0001 |
| hectare | 公顷 | ha | 10000 |
| mu | 亩 | 亩 | 666.67 |
| square_foot | 平方英尺 | ft² | 0.092903 |
| square_mile | 平方英里 | mi² | 2589988.11 |

### 重量 (weight)

| ID | 名称 | 符号 | 基准比率 |
|----|------|------|----------|
| kilogram | 千克 | kg | 1 |
| gram | 克 | g | 0.001 |
| milligram | 毫克 | mg | 0.000001 |
| ton | 吨 | t | 1000 |
| pound | 磅 | lb | 0.453592 |
| ounce | 盎司 | oz | 0.0283495 |
| jin | 斤 | 斤 | 0.5 |
| liang | 两 | 两 | 0.05 |

### 温度 (temperature) - 特殊转换

| ID | 名称 | 符号 |
|----|------|------|
| celsius | 摄氏度 | °C |
| fahrenheit | 华氏度 | °F |
| kelvin | 开尔文 | K |

### 体积 (volume)

| ID | 名称 | 符号 | 基准比率 |
|----|------|------|----------|
| cubic_meter | 立方米 | m³ | 1 |
| liter | 升 | L | 0.001 |
| milliliter | 毫升 | mL | 0.000001 |
| cubic_centimeter | 立方厘米 | cm³ | 0.000001 |
| gallon | 加仑 | gal | 0.00378541 |
| pint | 品脱 | pt | 0.000473176 |
| cubic_foot | 立方英尺 | ft³ | 0.0283168 |

### 速度 (speed)

| ID | 名称 | 符号 | 基准比率 |
|----|------|------|----------|
| meter_per_second | 米/秒 | m/s | 1 |
| kilometer_per_hour | 千米/时 | km/h | 0.277778 |
| mile_per_hour | 英里/时 | mph | 0.44704 |
| knot | 节 | kn | 0.514444 |
| foot_per_second | 英尺/秒 | ft/s | 0.3048 |

### 压强 (pressure)

| ID | 名称 | 符号 | 基准比率 |
|----|------|------|----------|
| pascal | 帕斯卡 | Pa | 1 |
| kilopascal | 千帕 | kPa | 1000 |
| megapascal | 兆帕 | MPa | 1000000 |
| bar | 巴 | bar | 100000 |
| atmosphere | 大气压 | atm | 101325 |
| mmhg | 毫米汞柱 | mmHg | 133.322 |
| psi | 磅/平方英寸 | psi | 6894.76 |

### 功率 (power)

| ID | 名称 | 符号 | 基准比率 |
|----|------|------|----------|
| watt | 瓦特 | W | 1 |
| kilowatt | 千瓦 | kW | 1000 |
| megawatt | 兆瓦 | MW | 1000000 |
| horsepower | 马力 | hp | 745.7 |
| btu_per_hour | BTU/时 | BTU/h | 0.293071 |

### 进制 (number_system) - 特殊转换

| ID | 名称 | 符号 |
|----|------|------|
| binary | 二进制 | BIN |
| octal | 八进制 | OCT |
| decimal | 十进制 | DEC |
| hexadecimal | 十六进制 | HEX |

### 支持的货币

| 代码 | 名称 | 符号 |
|------|------|------|
| USD | 美元 | $ |
| EUR | 欧元 | € |
| CNY | 人民币 | ¥ |
| JPY | 日元 | ¥ |
| GBP | 英镑 | £ |
| AUD | 澳元 | A$ |
| CAD | 加元 | C$ |
| CHF | 瑞士法郎 | CHF |
| HKD | 港币 | HK$ |
| SGD | 新加坡元 | S$ |
| KRW | 韩元 | ₩ |
| TWD | 新台币 | NT$ |

---

## 错误处理

所有方法都进行了适当的错误处理：

- 无效的类别 ID 或单位 ID 会返回原值或 null
- 无效的进制输入会返回空字符串
- 不支持的货币会返回 null
- 无效的参数（如负数本金）会返回 0 或空结果

建议在使用前进行参数验证。

---

## 性能考虑

- 所有单位换算都是纯计算，性能极高（< 1 微秒）
- 温度转换略慢（< 2 微秒）
- 进制转换取决于数值大小（< 10 微秒）
- 汇率查询使用模拟服务时有 100ms 延迟（模拟网络请求）
- 房贷计算取决于贷款期限（30 年约 < 10 毫秒）

---

## 版本历史

- **v0.2.0** (2026-03-03)
  - 新增汇率换算功能
  - 新增房贷计算器功能
  - 数据按类别拆分重构
  
- **v0.1.0** (2024-03-03)
  - 初始版本
  - 9 大类别单位换算
  - 60+ 单位支持

---

**文档版本**: 1.0  
**更新日期**: 2026-03-03  
**作者**: ZenKitX Team
