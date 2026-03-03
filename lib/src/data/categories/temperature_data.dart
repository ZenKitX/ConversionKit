import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 温度单位数据
///
/// 温度转换使用特殊的非线性公式，不使用 toBaseRatio。
class TemperatureData {
  /// 温度单位列表
  static const units = [
    ConversionUnit(
      id: 'celsius',
      name: '摄氏度',
      symbol: '°C',
      toBaseRatio: 1,
    ),
    ConversionUnit(
      id: 'fahrenheit',
      name: '华氏度',
      symbol: '°F',
      toBaseRatio: 1,
    ),
    ConversionUnit(
      id: 'kelvin',
      name: '开尔文',
      symbol: 'K',
      toBaseRatio: 1,
    ),
  ];

  /// 温度类别（标记为特殊类别）
  static const category = ConversionCategory(
    id: 'temperature',
    name: '温度',
    units: units,
    isSpecial: true,
  );
}
