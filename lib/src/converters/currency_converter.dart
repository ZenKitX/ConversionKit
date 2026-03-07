import '../services/currency_api.dart';

/// 汇率转换器
///
/// 提供货币之间的汇率转换功能。
///
/// ## 使用示例
///
/// ```dart
/// final converter = CurrencyConverter();
///
/// // 转换货币
/// final result = await converter.convert(
///   value: 100,
///   from: 'USD',
///   to: 'CNY',
/// );
///
/// print('100 USD = $result CNY');
/// ```
class CurrencyConverter {
  /// 创建汇率转换器
  ///
  /// 参数:
  /// - [apiService]: 汇率 API 服务，默认使用模拟服务
  CurrencyConverter({CurrencyApiService? apiService})
    : _apiService = apiService ?? MockCurrencyApiService();

  final CurrencyApiService _apiService;

  /// 转换货币
  ///
  /// 参数:
  /// - [value]: 要转换的金额
  /// - [from]: 源货币代码
  /// - [to]: 目标货币代码
  ///
  /// 返回转换后的金额，如果转换失败返回 null。
  ///
  /// 示例:
  /// ```dart
  /// final result = await converter.convert(
  ///   value: 100,
  ///   from: 'USD',
  ///   to: 'CNY',
  /// );
  /// ```
  Future<double?> convert({
    required double value,
    required String from,
    required String to,
  }) async {
    // 获取汇率
    final rate = await _apiService.getExchangeRate(from, to);

    if (rate == null) {
      return null;
    }

    // 计算转换结果
    return value * rate;
  }

  /// 批量转换货币
  ///
  /// 将一个金额转换为多种目标货币。
  ///
  /// 参数:
  /// - [value]: 要转换的金额
  /// - [from]: 源货币代码
  /// - [targets]: 目标货币代码列表
  ///
  /// 返回货币代码到转换金额的映射。
  ///
  /// 示例:
  /// ```dart
  /// final results = await converter.convertMultiple(
  ///   value: 100,
  ///   from: 'USD',
  ///   targets: ['CNY', 'EUR', 'JPY'],
  /// );
  /// ```
  Future<Map<String, double>> convertMultiple({
    required double value,
    required String from,
    required List<String> targets,
  }) async {
    final rates = await _apiService.getExchangeRates(from, targets);
    final result = <String, double>{};

    for (final entry in rates.entries) {
      result[entry.key] = value * entry.value;
    }

    return result;
  }

  /// 格式化货币金额
  ///
  /// 参数:
  /// - [value]: 金额
  /// - [currencyCode]: 货币代码
  /// - [decimals]: 小数位数，默认为 2
  ///
  /// 返回格式化后的字符串。
  ///
  /// 示例:
  /// ```dart
  /// final formatted = converter.formatAmount(
  ///   value: 1234.56,
  ///   currencyCode: 'USD',
  /// );
  /// // 返回: "1,234.56"
  /// ```
  String formatAmount({
    required double value,
    required String currencyCode,
    int decimals = 2,
  }) {
    // 特殊处理：日元和韩元通常不使用小数
    final noDecimalCurrencies = ['JPY', 'KRW'];
    final actualDecimals =
        noDecimalCurrencies.contains(currencyCode.toUpperCase()) ? 0 : decimals;

    // 格式化数字
    final formatted = value.toStringAsFixed(actualDecimals);

    // 添加千分位分隔符
    final parts = formatted.split('.');
    final integerPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : '';

    final buffer = StringBuffer();
    var count = 0;

    for (var i = integerPart.length - 1; i >= 0; i--) {
      if (count > 0 && count % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(integerPart[i]);
      count++;
    }

    final result = buffer.toString().split('').reversed.join();

    return decimalPart.isEmpty ? result : '$result.$decimalPart';
  }
}
