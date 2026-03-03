/// 货币模型
///
/// 表示一种货币，包含货币代码、名称和符号。
///
/// 示例:
/// ```dart
/// const usd = Currency(
///   code: 'USD',
///   name: '美元',
///   symbol: '\$',
/// );
/// ```
class Currency {
  /// 货币代码（ISO 4217）
  final String code;

  /// 货币名称
  final String name;

  /// 货币符号
  final String symbol;

  /// 创建货币实例
  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Currency && other.code == code;
  }

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => '$name ($symbol)';
}
