import '../models/conversion_unit.dart';

/// 换算逻辑工具类
///
/// 提供各种单位之间的转换逻辑。
class ConversionLogic {
  /// 基本单位换算
  ///
  /// 使用基准单位作为中间值进行转换：
  /// 1. 将源单位转换为基准单位
  /// 2. 将基准单位转换为目标单位
  ///
  /// 示例:
  /// ```dart
  /// final result = ConversionLogic.convert(
  ///   value: 1.0,
  ///   fromUnit: kilometer,
  ///   toUnit: meter,
  /// ); // 返回 1000.0
  /// ```
  static double convert({
    required double value,
    required ConversionUnit fromUnit,
    required ConversionUnit toUnit,
  }) {
    // 先转换到基准单位，再转换到目标单位
    final baseValue = value * fromUnit.toBaseRatio;
    return baseValue / toUnit.toBaseRatio;
  }

  /// 温度换算（特殊处理）
  ///
  /// 温度转换不能使用简单的比率，需要特殊的公式。
  ///
  /// 支持的单位：
  /// - celsius: 摄氏度
  /// - fahrenheit: 华氏度
  /// - kelvin: 开尔文
  ///
  /// 示例:
  /// ```dart
  /// final fahrenheit = ConversionLogic.convertTemperature(
  ///   value: 0,
  ///   fromUnitId: 'celsius',
  ///   toUnitId: 'fahrenheit',
  /// ); // 返回 32.0
  /// ```
  static double convertTemperature({
    required double value,
    required String fromUnitId,
    required String toUnitId,
  }) {
    if (fromUnitId == toUnitId) return value;

    // 先转换到摄氏度
    double celsius;
    switch (fromUnitId) {
      case 'celsius':
        celsius = value;
        break;
      case 'fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'kelvin':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    // 再从摄氏度转换到目标单位
    switch (toUnitId) {
      case 'celsius':
        return celsius;
      case 'fahrenheit':
        return celsius * 9 / 5 + 32;
      case 'kelvin':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }

  /// 进制转换（特殊处理）
  ///
  /// 支持二进制、八进制、十进制、十六进制之间的转换。
  ///
  /// 示例:
  /// ```dart
  /// final hex = ConversionLogic.convertNumberSystem(
  ///   value: '255',
  ///   fromUnitId: 'decimal',
  ///   toUnitId: 'hexadecimal',
  /// ); // 返回 'FF'
  /// ```
  static String convertNumberSystem({
    required String value,
    required String fromUnitId,
    required String toUnitId,
  }) {
    if (fromUnitId == toUnitId) return value;

    try {
      // 获取进制基数
      final fromBase = _getBase(fromUnitId);
      final toBase = _getBase(toUnitId);

      // 先转换为十进制
      final decimalValue = int.parse(value, radix: fromBase);

      // 再转换为目标进制
      return decimalValue.toRadixString(toBase).toUpperCase();
    } catch (e) {
      return '';
    }
  }

  /// 获取进制基数
  static int _getBase(String unitId) {
    switch (unitId) {
      case 'binary':
        return 2;
      case 'octal':
        return 8;
      case 'decimal':
        return 10;
      case 'hexadecimal':
        return 16;
      default:
        return 10;
    }
  }

  /// 验证进制输入
  ///
  /// 检查输入的字符串是否符合指定进制的格式。
  ///
  /// 示例:
  /// ```dart
  /// final isValid = ConversionLogic.isValidNumberSystemInput('FF', 'hexadecimal');
  /// // 返回 true
  /// ```
  static bool isValidNumberSystemInput(String value, String unitId) {
    if (value.isEmpty) return true;

    try {
      final base = _getBase(unitId);
      int.parse(value, radix: base);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// 格式化显示结果
  ///
  /// 将数值格式化为易读的字符串：
  /// - 科学计数法用于极小值
  /// - 移除尾部的零
  ///
  /// 示例:
  /// ```dart
  /// final formatted = ConversionLogic.formatResult(0.00001234);
  /// // 返回 '1.234000e-5'
  /// ```
  static String formatResult(double value) {
    if (value.abs() < 0.0001 && value != 0) {
      return value.toStringAsExponential(6);
    }

    // 移除尾部的零
    return value.toStringAsFixed(8).replaceAll(RegExp(r'\.?0+$'), '');
  }
}
