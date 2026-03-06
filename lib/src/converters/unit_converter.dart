import '../data/conversions.dart';
import '../models/conversion_category.dart';
import '../models/conversion_unit.dart';
import 'conversion_logic.dart';

/// 单位转换器
///
/// 提供统一的单位转换接口。
///
/// 示例:
/// ```dart
/// final converter = UnitConverter();
///
/// // 长度转换
/// final result = converter.convert(
///   value: 1.0,
///   categoryId: 'length',
///   fromUnitId: 'kilometer',
///   toUnitId: 'meter',
/// ); // 返回 1000.0
///
/// // 温度转换
/// final temp = converter.convert(
///   value: 0,
///   categoryId: 'temperature',
///   fromUnitId: 'celsius',
///   toUnitId: 'fahrenheit',
/// ); // 返回 32.0
/// ```
class UnitConverter {
  /// 转换数值
  ///
  /// 根据类别和单位 ID 进行转换。
  ///
  /// 参数:
  /// - [value]: 要转换的数值
  /// - [categoryId]: 类别 ID（如 'length', 'temperature'）
  /// - [fromUnitId]: 源单位 ID
  /// - [toUnitId]: 目标单位 ID
  ///
  /// 返回转换后的数值，如果转换失败返回原值。
  double convert({
    required double value,
    required String categoryId,
    required String fromUnitId,
    required String toUnitId,
  }) {
    // 查找类别
    final category = ConversionData.findCategoryById(categoryId);
    if (category == null) return value;

    // 特殊处理：温度
    if (category.id == 'temperature') {
      return ConversionLogic.convertTemperature(
        value: value,
        fromUnitId: fromUnitId,
        toUnitId: toUnitId,
      );
    }

    // 查找单位
    final fromUnit = category.findUnitById(fromUnitId);
    final toUnit = category.findUnitById(toUnitId);

    if (fromUnit == null || toUnit == null) return value;

    // 基本转换
    return ConversionLogic.convert(
      value: value,
      fromUnit: fromUnit,
      toUnit: toUnit,
    );
  }

  /// 转换进制
  ///
  /// 在不同进制之间转换数字。
  ///
  /// 参数:
  /// - [value]: 要转换的字符串（数字）
  /// - [fromUnitId]: 源进制 ID（如 'decimal', 'hexadecimal'）
  /// - [toUnitId]: 目标进制 ID
  ///
  /// 返回转换后的字符串。
  String convertNumberSystem({
    required String value,
    required String fromUnitId,
    required String toUnitId,
  }) {
    return ConversionLogic.convertNumberSystem(
      value: value,
      fromUnitId: fromUnitId,
      toUnitId: toUnitId,
    );
  }

  /// 验证进制输入
  ///
  /// 检查输入是否符合指定进制的格式。
  bool isValidNumberSystemInput(String value, String unitId) {
    return ConversionLogic.isValidNumberSystemInput(value, unitId);
  }

  /// 格式化结果
  ///
  /// 将数值格式化为易读的字符串。
  String formatResult(double value) {
    return ConversionLogic.formatResult(value);
  }

  /// 获取所有类别
  List<ConversionCategory> getAllCategories() {
    return ConversionData.categories;
  }

  /// 获取指定类别
  ConversionCategory? getCategory(String categoryId) {
    return ConversionData.findCategoryById(categoryId);
  }

  /// 获取指定类别的所有单位
  List<ConversionUnit>? getUnits(String categoryId) {
    final category = ConversionData.findCategoryById(categoryId);
    return category?.units;
  }
}
