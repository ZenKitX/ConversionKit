/// 换算历史记录模型
class ConversionHistory {
  /// 类别 ID
  final String categoryId;

  /// 源单位 ID
  final String fromUnitId;

  /// 目标单位 ID
  final String toUnitId;

  /// 输入值
  final double inputValue;

  /// 输出值
  final double outputValue;

  /// 记录时间
  final DateTime timestamp;

  /// 创建换算历史记录
  const ConversionHistory({
    required this.categoryId,
    required this.fromUnitId,
    required this.toUnitId,
    required this.inputValue,
    required this.outputValue,
    required this.timestamp,
  });

  /// 从 JSON 创建
  factory ConversionHistory.fromJson(Map<String, dynamic> json) {
    return ConversionHistory(
      categoryId: json['categoryId'] as String,
      fromUnitId: json['fromUnitId'] as String,
      toUnitId: json['toUnitId'] as String,
      inputValue: (json['inputValue'] as num).toDouble(),
      outputValue: (json['outputValue'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'fromUnitId': fromUnitId,
      'toUnitId': toUnitId,
      'inputValue': inputValue,
      'outputValue': outputValue,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversionHistory &&
          runtimeType == other.runtimeType &&
          categoryId == other.categoryId &&
          fromUnitId == other.fromUnitId &&
          toUnitId == other.toUnitId &&
          inputValue == other.inputValue &&
          outputValue == other.outputValue &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      categoryId.hashCode ^
      fromUnitId.hashCode ^
      toUnitId.hashCode ^
      inputValue.hashCode ^
      outputValue.hashCode ^
      timestamp.hashCode;

  @override
  String toString() {
    return 'ConversionHistory('
        'categoryId: $categoryId, '
        'fromUnitId: $fromUnitId, '
        'toUnitId: $toUnitId, '
        'inputValue: $inputValue, '
        'outputValue: $outputValue, '
        'timestamp: $timestamp)';
  }
}
