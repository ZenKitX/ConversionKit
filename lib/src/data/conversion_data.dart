import '../models/conversion_category.dart';
import 'categories/area_data.dart';
import 'categories/length_data.dart';
import 'categories/number_system_data.dart';
import 'categories/power_data.dart';
import 'categories/pressure_data.dart';
import 'categories/speed_data.dart';
import 'categories/temperature_data.dart';
import 'categories/volume_data.dart';
import 'categories/weight_data.dart';

/// 换算数据定义
///
/// 聚合所有类别的单位数据，提供统一的访问接口。
///
/// ## 设计原则
///
/// - 单一职责：每个类别数据独立在单独的文件中
/// - 低耦合：各类别数据互不影响
/// - 易扩展：添加新类别只需新增文件并在此处引用
/// - 易维护：修改某类别数据只需修改对应文件
///
/// ## 使用示例
///
/// ```dart
/// // 获取所有类别
/// final categories = ConversionData.categories;
///
/// // 查找特定类别
/// final lengthCategory = ConversionData.findCategoryById('length');
/// ```
class ConversionData {
  /// 所有类别列表
  ///
  /// 包含 9 大类别：
  /// - 长度 (length)
  /// - 面积 (area)
  /// - 重量 (weight)
  /// - 温度 (temperature) - 特殊类别
  /// - 体积 (volume)
  /// - 速度 (speed)
  /// - 压强 (pressure)
  /// - 功率 (power)
  /// - 进制 (number_system) - 特殊类别
  static final categories = [
    LengthData.category,
    AreaData.category,
    WeightData.category,
    TemperatureData.category,
    VolumeData.category,
    SpeedData.category,
    PressureData.category,
    PowerData.category,
    NumberSystemData.category,
  ];

  /// 根据 ID 查找类别
  ///
  /// 参数:
  /// - [categoryId]: 类别 ID
  ///
  /// 返回找到的类别，如果不存在返回 null。
  static ConversionCategory? findCategoryById(String categoryId) {
    try {
      return categories.firstWhere((category) => category.id == categoryId);
    } catch (e) {
      return null;
    }
  }
}
