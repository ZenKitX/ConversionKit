import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 重量单位数据
///
/// 包含常用的重量单位，基准单位为千克（kg）。
class WeightData {
  /// 重量单位列表
  static const units = [
    ConversionUnit(
      id: 'kilogram',
      name: '千克',
      symbol: 'kg',
      toBaseRatio: 1,
    ),
    ConversionUnit(
      id: 'gram',
      name: '克',
      symbol: 'g',
      toBaseRatio: 0.001,
    ),
    ConversionUnit(
      id: 'milligram',
      name: '毫克',
      symbol: 'mg',
      toBaseRatio: 0.000001,
    ),
    ConversionUnit(
      id: 'ton',
      name: '吨',
      symbol: 't',
      toBaseRatio: 1000,
    ),
    ConversionUnit(
      id: 'pound',
      name: '磅',
      symbol: 'lb',
      toBaseRatio: 0.453592,
    ),
    ConversionUnit(
      id: 'ounce',
      name: '盎司',
      symbol: 'oz',
      toBaseRatio: 0.0283495,
    ),
    ConversionUnit(
      id: 'jin',
      name: '斤',
      symbol: '斤',
      toBaseRatio: 0.5,
    ),
    ConversionUnit(
      id: 'liang',
      name: '两',
      symbol: '两',
      toBaseRatio: 0.05,
    ),
  ];

  /// 重量类别
  static const category = ConversionCategory(
    id: 'weight',
    name: '重量',
    units: units,
  );
}
