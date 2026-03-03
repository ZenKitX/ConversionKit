/// 换算收藏模型
class ConversionFavorite {
  /// 收藏 ID
  final String id;

  /// 收藏名称
  final String name;

  /// 类别 ID
  final String categoryId;

  /// 源单位 ID
  final String fromUnitId;

  /// 目标单位 ID
  final String toUnitId;

  /// 创建时间
  final DateTime createdAt;

  /// 创建换算收藏
  const ConversionFavorite({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.fromUnitId,
    required this.toUnitId,
    required this.createdAt,
  });

  /// 从 JSON 创建
  factory ConversionFavorite.fromJson(Map<String, dynamic> json) {
    return ConversionFavorite(
      id: json['id'] as String,
      name: json['name'] as String,
      categoryId: json['categoryId'] as String,
      fromUnitId: json['fromUnitId'] as String,
      toUnitId: json['toUnitId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  /// 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'fromUnitId': fromUnitId,
      'toUnitId': toUnitId,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  /// 复制并修改
  ConversionFavorite copyWith({
    String? id,
    String? name,
    String? categoryId,
    String? fromUnitId,
    String? toUnitId,
    DateTime? createdAt,
  }) {
    return ConversionFavorite(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      fromUnitId: fromUnitId ?? this.fromUnitId,
      toUnitId: toUnitId ?? this.toUnitId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConversionFavorite &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          categoryId == other.categoryId &&
          fromUnitId == other.fromUnitId &&
          toUnitId == other.toUnitId &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      categoryId.hashCode ^
      fromUnitId.hashCode ^
      toUnitId.hashCode ^
      createdAt.hashCode;

  @override
  String toString() {
    return 'ConversionFavorite('
        'id: $id, '
        'name: $name, '
        'categoryId: $categoryId, '
        'fromUnitId: $fromUnitId, '
        'toUnitId: $toUnitId, '
        'createdAt: $createdAt)';
  }
}
