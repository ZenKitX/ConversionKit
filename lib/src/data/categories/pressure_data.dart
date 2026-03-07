import '../../models/conversion_category.dart';
import '../../models/conversion_unit.dart';

/// 压强单位数据
///
/// 包含常用的压强单位，基准单位为帕斯卡（Pa）。
class PressureData {
  /// 压强单位列表
  static const units = [
    ConversionUnit(id: 'pascal', name: '帕斯卡', symbol: 'Pa', toBaseRatio: 1),
    ConversionUnit(
      id: 'kilopascal',
      name: '千帕',
      symbol: 'kPa',
      toBaseRatio: 1000,
    ),
    ConversionUnit(
      id: 'megapascal',
      name: '兆帕',
      symbol: 'MPa',
      toBaseRatio: 1000000,
    ),
    ConversionUnit(id: 'bar', name: '巴', symbol: 'bar', toBaseRatio: 100000),
    ConversionUnit(
      id: 'atmosphere',
      name: '大气压',
      symbol: 'atm',
      toBaseRatio: 101325,
    ),
    ConversionUnit(
      id: 'mmhg',
      name: '毫米汞柱',
      symbol: 'mmHg',
      toBaseRatio: 133.322,
    ),
    ConversionUnit(
      id: 'psi',
      name: '磅/平方英寸',
      symbol: 'psi',
      toBaseRatio: 6894.76,
    ),
  ];

  /// 压强类别
  static const category = ConversionCategory(
    id: 'pressure',
    name: '压强',
    units: units,
  );
}
