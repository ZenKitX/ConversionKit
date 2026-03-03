import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 体积单位数据
///
/// 包含常用的体积单位，基准单位为立方米（m³）。
class VolumeData {
  /// 体积单位列表
  static const units = [
    ConversionUnit(
      id: 'cubic_meter',
      name: '立方米',
      symbol: 'm³',
      toBaseRatio: 1,
    ),
    ConversionUnit(id: 'liter', name: '升', symbol: 'L', toBaseRatio: 0.001),
    ConversionUnit(
      id: 'milliliter',
      name: '毫升',
      symbol: 'mL',
      toBaseRatio: 0.000001,
    ),
    ConversionUnit(
      id: 'cubic_centimeter',
      name: '立方厘米',
      symbol: 'cm³',
      toBaseRatio: 0.000001,
    ),
    ConversionUnit(
      id: 'gallon',
      name: '加仑',
      symbol: 'gal',
      toBaseRatio: 0.00378541,
    ),
    ConversionUnit(
      id: 'pint',
      name: '品脱',
      symbol: 'pt',
      toBaseRatio: 0.000473176,
    ),
    ConversionUnit(
      id: 'cubic_foot',
      name: '立方英尺',
      symbol: 'ft³',
      toBaseRatio: 0.0283168,
    ),
  ];

  /// 体积类别
  static const category = ConversionCategory(
    id: 'volume',
    name: '体积',
    units: units,
  );
}
