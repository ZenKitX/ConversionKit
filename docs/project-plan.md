# ConversionKit 项目规划

## 项目定位

ConversionKit 是一个综合性的数据转换工具包，融合了两个方向：

1. **数据编解码** - 参考 `package:convert`，提供十六进制、百分号编码、代码页等编解码功能
2. **单位换算** - 提供长度、面积、重量、温度等物理单位的转换功能

## 项目愿景

打造一个功能完整、易于使用、高性能的 Dart 转换工具包，成为 Flutter/Dart 开发者在数据转换和单位换算场景下的首选方案。

## 核心特性

### 已实现功能（单位换算模块）

- ✅ 9 大类别：长度、面积、重量、温度、体积、速度、压强、功率、进制
- ✅ 60+ 单位转换
- ✅ 特殊转换：温度（非线性）、进制（整数转换）
- ✅ 完整的测试覆盖
- ✅ 零外部依赖

### 待实现功能（编解码模块）

参考 `package:convert` 的设计，计划实现：

1. **十六进制编解码** (Hex Codec)
   - RFC 4648 Base16 规范
   - 字节数组 ↔ 十六进制字符串
   - 支持大小写选项

2. **百分号编码** (Percent Encoding)
   - RFC 3986 URL 编码规范
   - 字节数组 ↔ 百分号编码字符串
   - 可配置保留字符集

3. **代码页编码** (CodePage)
   - ISO-8859 系列编码（Latin-2 到 Latin-10）
   - 西里尔、阿拉伯、希腊、希伯来等字符集
   - 单字节字符编码支持

4. **日期时间格式化器** (Fixed DateTime Formatter)
   - 固定模式的日期时间格式化
   - 高性能解析和格式化
   - 支持自定义格式模式

5. **累加器 Sink** (Accumulator Sinks)
   - 通用累加器 (AccumulatorSink)
   - 字节累加器 (ByteAccumulatorSink)
   - 字符串累加器 (StringAccumulatorSink)

6. **身份编解码器** (Identity Codec)
   - 不做任何转换的占位符编解码器
   - 支持编解码器组合

## 项目架构

### 目录结构

```
conversion_kit/
├── lib/
│   ├── conversion_kit.dart              # 主导出文件
│   └── src/
│       ├── models/                       # 数据模型
│       │   ├── conversion_unit.dart      # 单位模型
│       │   └── conversion_category.dart  # 类别模型
│       ├── converters/                   # 转换器
│       │   └── unit_converter.dart       # 单位转换器
│       ├── data/                         # 数据定义
│       │   └── conversion_data.dart      # 单位数据
│       ├── utils/                        # 工具类
│       │   └── conversion_logic.dart     # 转换逻辑
│       ├── codecs/                       # 编解码器（新增）
│       │   ├── hex/                      # 十六进制
│       │   │   ├── hex_codec.dart
│       │   │   ├── hex_encoder.dart
│       │   │   └── hex_decoder.dart
│       │   ├── percent/                  # 百分号编码
│       │   │   ├── percent_codec.dart
│       │   │   ├── percent_encoder.dart
│       │   │   └── percent_decoder.dart
│       │   ├── codepage/                 # 代码页
│       │   │   └── codepage.dart
│       │   ├── datetime/                 # 日期时间
│       │   │   └── fixed_datetime_formatter.dart
│       │   └── identity/                 # 身份编解码器
│       │       └── identity_codec.dart
│       ├── sinks/                        # 累加器（新增）
│       │   ├── accumulator_sink.dart
│       │   ├── byte_accumulator_sink.dart
│       │   └── string_accumulator_sink.dart
│       └── extensions/                   # 扩展方法（新增）
│           └── conversion_extensions.dart
├── test/                                 # 测试文件
│   ├── models/
│   ├── converters/
│   ├── data/
│   ├── utils/
│   ├── codecs/                          # 编解码器测试
│   ├── sinks/                           # 累加器测试
│   └── extensions/                      # 扩展方法测试
├── example/
│   ├── unit_conversion_example.dart     # 单位换算示例
│   └── codec_example.dart               # 编解码示例
├── benchmark/                           # 性能测试（新增）
│   ├── conversion_benchmark.dart
│   └── codec_benchmark.dart
├── docs/                                # 文档
│   ├── convert-package-research.md      # convert 包调研
│   ├── conversion-kit-research.md       # 单位换算调研
│   ├── development-plan.md              # 原开发计划
│   └── project-plan.md                  # 本文档
├── pubspec.yaml
├── README.md
├── CHANGELOG.md
└── LICENSE
```

## 设计原则

### 1. 模块化设计

- **单位换算模块**：独立的单位转换功能
- **编解码模块**：独立的数据编解码功能
- 两个模块可以独立使用，互不干扰

### 2. 统一的 API 风格

遵循 Dart 的 `Codec<S, T>` 接口设计：

```dart
abstract class Codec<S, T> {
  Encoder<S, T> get encoder;
  Decoder<T, S> get decoder;
  
  T encode(S input);
  S decode(T encoded);
  
  Codec<S, R> fuse<R>(Codec<T, R> other);
}
```

### 3. 零依赖原则

- 仅依赖 Dart SDK 和 Flutter SDK
- 不引入第三方依赖
- 保持包的轻量级

### 4. 高性能

- 使用类型化数组（Uint8List、Uint16List）
- 避免不必要的内存分配
- 支持分块转换（chunked conversion）

### 5. 完整测试

- 每个功能都有对应的单元测试
- 测试覆盖正常情况和边界情况
- 性能基准测试

### 6. 清晰的文档

- 所有公共 API 都有详细的文档注释
- 提供使用示例
- 包含性能说明和注意事项

## 个人风格体现

### 1. 扩展方法

为常用类型添加便捷的扩展方法：

```dart
// 十六进制扩展
extension HexExtension on List<int> {
  String toHex({bool uppercase = false}) => hex.encode(this);
}

extension HexStringExtension on String {
  List<int> fromHex() => hex.decode(this);
}

// 百分号编码扩展
extension PercentExtension on String {
  String percentEncode() => utf8.fuse(percent).encode(this);
  String percentDecode() => utf8.fuse(percent).decode(this);
}

// 单位转换扩展
extension DoubleConversionExtension on double {
  double convertLength({
    required String from,
    required String to,
  }) => UnitConverter().convert(
    value: this,
    categoryId: 'length',
    fromUnitId: from,
    toUnitId: to,
  );
}
```

### 2. 构建器模式

提供更灵活的配置方式：

```dart
// 十六进制编解码器构建器
final customHex = HexCodec.builder()
  .uppercase(true)
  .separator(':')
  .build();

// 百分号编码构建器
final customPercent = PercentCodec.builder()
  .preserveChars('.-_~')
  .spaceAsPlus(false)
  .build();
```

### 3. Try* 系列方法

提供不抛异常的版本：

```dart
// 原版：失败时抛异常
final result = hex.decode('invalid'); // 抛出 FormatException

// Try 版本：失败时返回 null
final result = hex.tryDecode('invalid'); // 返回 null
```

### 4. 链式调用

支持流畅的链式调用：

```dart
final result = 'Hello World'
  .percentEncode()
  .toUpperCase()
  .percentDecode();
```

## 与现有项目的关系

### ConversionKit vs package:convert

| 特性 | package:convert | ConversionKit |
|------|----------------|---------------|
| 十六进制编解码 | ✅ | ✅ 计划实现 |
| 百分号编码 | ✅ | ✅ 计划实现 |
| 代码页编码 | ✅ | ✅ 计划实现 |
| 日期时间格式化 | ✅ | ✅ 计划实现 |
| 累加器 Sink | ✅ | ✅ 计划实现 |
| 身份编解码器 | ✅ | ✅ 计划实现 |
| 单位换算 | ❌ | ✅ 已实现 |
| 扩展方法 | ❌ | ✅ 计划实现 |
| 构建器模式 | ❌ | ✅ 计划实现 |
| Try* 方法 | ❌ | ✅ 计划实现 |

### 定位差异

- **package:convert**: 专注于数据编解码，Dart 官方维护
- **ConversionKit**: 综合性转换工具包，包含编解码 + 单位换算

## 适用场景

### 单位换算模块

- ✅ 计算器应用
- ✅ 工具类应用
- ✅ 教育类应用
- ✅ 科学计算应用

### 编解码模块

- ✅ 网络通信（URL 编码、十六进制数据）
- ✅ 数据存储（编码转换）
- ✅ 遗留系统集成（代码页转换）
- ✅ 日志处理（固定格式日期时间）

## 不适用场景

- ❌ 需要实时汇率的金融应用（需要额外实现 API 集成）
- ❌ 需要极高精度的科学计算（double 精度限制）
- ❌ 需要复杂单位组合（如 m/s²）
- ❌ 需要 Base64 编码（使用 dart:convert 内置）
- ❌ 需要 JSON 处理（使用 dart:convert 内置）

## 性能目标

### 单位换算

- 基本转换：< 1 微秒
- 温度转换：< 2 微秒
- 进制转换：< 10 微秒（取决于数字大小）

### 编解码

- 十六进制编码：< 1 微秒/字节
- 百分号编码：< 2 微秒/字节
- 代码页转换：< 1 微秒/字符

## 质量目标

- 测试覆盖率：> 95%
- 代码分析：0 错误，0 警告
- 文档覆盖率：100%（所有公共 API）
- 性能回归：< 5%

## 发布计划

### v0.1.0（当前版本）

- ✅ 单位换算核心功能
- ✅ 9 大类别，60+ 单位
- ✅ 基础测试覆盖

### v0.2.0（编解码基础）

- 十六进制编解码
- 百分号编码
- 身份编解码器
- 累加器 Sink

### v0.3.0（编解码完整）

- 代码页编码
- 日期时间格式化器
- 完整的编解码测试

### v0.4.0（增强功能）

- 扩展方法
- 构建器模式
- Try* 系列方法
- 性能优化

### v1.0.0（正式版）

- 完整功能
- 完善文档
- 性能基准测试
- 发布到 pub.dev

## 下一步行动

1. 完成编解码模块的详细开发计划
2. 开始实现十六进制编解码器
3. 逐步完善其他编解码功能
4. 添加扩展方法和便捷 API
5. 完善文档和示例
6. 性能优化和测试
7. 准备发布

---

**文档版本**: 1.0  
**创建日期**: 2026-03-03  
**作者**: ZenKitX Team
