library;

/// ConversionKit - 单位换算工具包
///
/// 提供长度、面积、重量、温度等多种单位的转换功能。
///
/// ## 特性
///
/// - 🔢 **9 大类别**: 长度、面积、重量、温度、体积、速度、压强、功率、进制
/// - 📏 **60+ 单位**: 涵盖常用的国际单位和中国传统单位
/// - 🌡️ **特殊转换**: 温度和进制转换的特殊处理
/// - 🎯 **高精度**: 使用 double 类型保证转换精度
/// - 🚀 **零依赖**: 纯 Dart 实现，无外部依赖
///
/// ## 使用示例
///
/// ```dart
/// import 'package:conversion_kit/conversion_kit.dart';
///
/// final converter = UnitConverter();
///
/// // 长度转换
/// final meters = converter.convert(
///   value: 1.0,
///   categoryId: 'length',
///   fromUnitId: 'kilometer',
///   toUnitId: 'meter',
/// ); // 返回 1000.0
///
/// // 温度转换
/// final fahrenheit = converter.convert(
///   value: 0,
///   categoryId: 'temperature',
///   fromUnitId: 'celsius',
///   toUnitId: 'fahrenheit',
/// ); // 返回 32.0
///
/// // 进制转换
/// final hex = converter.convertNumberSystem(
///   value: '255',
///   fromUnitId: 'decimal',
///   toUnitId: 'hexadecimal',
/// ); // 返回 'FF'
/// ```

// 导出模型
export 'src/models/conversion_unit.dart';
export 'src/models/conversion_category.dart';

// 导出转换器
export 'src/converters/unit_converter.dart';

// 导出数据
export 'src/data/conversion_data.dart';

// 导出工具
export 'src/utils/conversion_logic.dart';
