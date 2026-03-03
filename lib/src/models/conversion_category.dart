import 'conversion_unit.dart';

/// 换算类别模型
///
/// 表示一组相关的单位，如长度、重量等。
///
/// 示例:
/// ```dart
/// const lengthCategory = ConversionCategory(
///   id: 'length',
///   name: '长度',
///   units: [meter, kilometer, centimeter],
/// );
/// ```
class ConversionCategory {
  /// 类别唯一标识
  final String id;

  /// 类别名称（本地化）
  final String name;

  /// 该类别下的所有单位
  final List<ConversionUnit> units;

  /// 是否需要 API 支持（如汇率换算）
  final bool requiresApi;

  /// 是否为特殊换算（如温度、进制）
  ///
  /// 特殊换算不使用简单的比率转换，需要特殊的转换逻辑
  final bool isSpecial;

  const ConversionCategory({
    required this.id,
    required this.name,
    required this.units,
    this.requiresApi = false,
    this.isSpecial = false,
  });

  /// 根据 ID 查找单位
  ConversionUnit? findUnitById(String unitId) {
    try {
      return units.firstWhere((unit) => unit.id == unitId);
    } catch (e) {
      return null;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConversionCategory && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => name;
}
