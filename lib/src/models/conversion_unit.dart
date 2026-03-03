/// 单位模型
///
/// 表示一个可转换的单位，包含单位的标识、名称、符号和转换比率。
///
/// 示例:
/// ```dart
/// const meter = ConversionUnit(
///   id: 'meter',
///   name: '米',
///   symbol: 'm',
///   toBaseRatio: 1.0,
/// );
/// ```
class ConversionUnit {
  /// 单位唯一标识
  final String id;

  /// 单位名称（本地化）
  final String name;

  /// 单位符号
  final String symbol;

  /// 转换到基准单位的比率
  ///
  /// 例如：1 千米 = 1000 米，则千米的 toBaseRatio 为 1000.0
  final double toBaseRatio;

  const ConversionUnit({
    required this.id,
    required this.name,
    required this.symbol,
    required this.toBaseRatio,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ConversionUnit && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '$name ($symbol)';
}
