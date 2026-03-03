import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 面积单位数据
///
/// 包含常用的面积单位，基准单位为平方米（m²）。
class AreaData {
  /// 面积单位列表
  static const units = [
    ConversionUnit(
      id: 'square_meter',
      name: '平方米',
      symbol: 'm²',
      toBaseRatio: 1,
    ),
    ConversionUnit(
      id: 'square_kilometer',
      name: '平方千米',
      symbol: 'km²',
      toBaseRatio: 1000000,
    ),
    ConversionUnit(
      id: 'square_centimeter',
      name: '平方厘米',
      symbol: 'cm²',
      toBaseRatio: 0.0001,
    ),
    ConversionUnit(
      id: 'hectare',
      name: '公顷',
      symbol: 'ha',
      toBaseRatio: 10000,
    ),
    ConversionUnit(
      id: 'mu',
      name: '亩',
      symbol: '亩',
      toBaseRatio: 666.67,
    ),
    ConversionUnit(
      id: 'square_foot',
      name: '平方英尺',
      symbol: 'ft²',
      toBaseRatio: 0.092903,
    ),
    ConversionUnit(
      id: 'square_mile',
      name: '平方英里',
      symbol: 'mi²',
      toBaseRatio: 2589988.11,
    ),
  ];

  /// 面积类别
  static const category = ConversionCategory(
    id: 'area',
    name: '面积',
    units: units,
  );
}
