import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 进制单位数据
///
/// 进制转换使用特殊的整数转换逻辑，不使用 toBaseRatio。
class NumberSystemData {
  /// 进制单位列表
  static const units = [
    ConversionUnit(
      id: 'binary',
      name: '二进制',
      symbol: 'BIN',
      toBaseRatio: 2,
    ),
    ConversionUnit(
      id: 'octal',
      name: '八进制',
      symbol: 'OCT',
      toBaseRatio: 8,
    ),
    ConversionUnit(
      id: 'decimal',
      name: '十进制',
      symbol: 'DEC',
      toBaseRatio: 10,
    ),
    ConversionUnit(
      id: 'hexadecimal',
      name: '十六进制',
      symbol: 'HEX',
      toBaseRatio: 16,
    ),
  ];

  /// 进制类别（标记为特殊类别）
  static const category = ConversionCategory(
    id: 'number_system',
    name: '进制',
    units: units,
    isSpecial: true,
  );
}
