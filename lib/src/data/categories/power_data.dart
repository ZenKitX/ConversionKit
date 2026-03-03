import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 功率单位数据
///
/// 包含常用的功率单位，基准单位为瓦特（W）。
class PowerData {
  /// 功率单位列表
  static const units = [
    ConversionUnit(
      id: 'watt',
      name: '瓦特',
      symbol: 'W',
      toBaseRatio: 1,
    ),
    ConversionUnit(
      id: 'kilowatt',
      name: '千瓦',
      symbol: 'kW',
      toBaseRatio: 1000,
    ),
    ConversionUnit(
      id: 'megawatt',
      name: '兆瓦',
      symbol: 'MW',
      toBaseRatio: 1000000,
    ),
    ConversionUnit(
      id: 'horsepower',
      name: '马力',
      symbol: 'hp',
      toBaseRatio: 745.7,
    ),
    ConversionUnit(
      id: 'btu_per_hour',
      name: 'BTU/时',
      symbol: 'BTU/h',
      toBaseRatio: 0.293071,
    ),
  ];

  /// 功率类别
  static const category = ConversionCategory(
    id: 'power',
    name: '功率',
    units: units,
  );
}
