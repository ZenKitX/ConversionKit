import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 速度单位数据
///
/// 包含常用的速度单位，基准单位为米/秒（m/s）。
class SpeedData {
  /// 速度单位列表
  static const units = [
    ConversionUnit(
      id: 'meter_per_second',
      name: '米/秒',
      symbol: 'm/s',
      toBaseRatio: 1,
    ),
    ConversionUnit(
      id: 'kilometer_per_hour',
      name: '千米/时',
      symbol: 'km/h',
      toBaseRatio: 0.277778,
    ),
    ConversionUnit(
      id: 'mile_per_hour',
      name: '英里/时',
      symbol: 'mph',
      toBaseRatio: 0.44704,
    ),
    ConversionUnit(id: 'knot', name: '节', symbol: 'kn', toBaseRatio: 0.514444),
    ConversionUnit(
      id: 'foot_per_second',
      name: '英尺/秒',
      symbol: 'ft/s',
      toBaseRatio: 0.3048,
    ),
  ];

  /// 速度类别
  static const category = ConversionCategory(
    id: 'speed',
    name: '速度',
    units: units,
  );
}
