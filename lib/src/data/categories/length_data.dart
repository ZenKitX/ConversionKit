import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 长度单位数据
///
/// 包含常用的长度单位，基准单位为米（m）。
class LengthData {
  /// 长度单位列表
  static const units = [
    ConversionUnit(
      id: 'meter',
      name: '米',
      symbol: 'm',
      toBaseRatio: 1,
    ),
    ConversionUnit(
      id: 'kilometer',
      name: '千米',
      symbol: 'km',
      toBaseRatio: 1000,
    ),
    ConversionUnit(
      id: 'centimeter',
      name: '厘米',
      symbol: 'cm',
      toBaseRatio: 0.01,
    ),
    ConversionUnit(
      id: 'millimeter',
      name: '毫米',
      symbol: 'mm',
      toBaseRatio: 0.001,
    ),
    ConversionUnit(
      id: 'foot',
      name: '英尺',
      symbol: 'ft',
      toBaseRatio: 0.3048,
    ),
    ConversionUnit(
      id: 'inch',
      name: '英寸',
      symbol: 'in',
      toBaseRatio: 0.0254,
    ),
    ConversionUnit(
      id: 'yard',
      name: '码',
      symbol: 'yd',
      toBaseRatio: 0.9144,
    ),
    ConversionUnit(
      id: 'mile',
      name: '英里',
      symbol: 'mi',
      toBaseRatio: 1609.344,
    ),
  ];

  /// 长度类别
  static const category = ConversionCategory(
    id: 'length',
    name: '长度',
    units: units,
  );
}
