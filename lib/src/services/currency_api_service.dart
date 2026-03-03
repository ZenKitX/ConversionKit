/// 汇率 API 服务接口
///
/// 定义获取汇率数据的接口，支持多种实现方式。
///
/// ## 实现方式
///
/// - 在线 API：从第三方服务获取实时汇率
/// - 离线缓存：使用本地缓存的汇率数据
/// - 模拟数据：用于测试的固定汇率
abstract class CurrencyApiService {
  /// 获取汇率
  ///
  /// 参数:
  /// - [from]: 源货币代码
  /// - [to]: 目标货币代码
  ///
  /// 返回汇率值，如果获取失败返回 null。
  ///
  /// 示例:
  /// ```dart
  /// final rate = await service.getExchangeRate('USD', 'CNY');
  /// if (rate != null) {
  ///   print('1 USD = $rate CNY');
  /// }
  /// ```
  Future<double?> getExchangeRate(String from, String to);

  /// 批量获取汇率
  ///
  /// 参数:
  /// - [base]: 基准货币代码
  /// - [targets]: 目标货币代码列表
  ///
  /// 返回货币代码到汇率的映射。
  Future<Map<String, double>> getExchangeRates(
    String base,
    List<String> targets,
  );
}

/// 模拟汇率服务
///
/// 用于测试和离线使用的固定汇率数据。
/// 汇率数据基于 2024 年 3 月的大致汇率。
class MockCurrencyApiService implements CurrencyApiService {
  /// 固定汇率表（以 USD 为基准）
  static const _rates = {
    'USD': 1.0,
    'EUR': 0.92,
    'CNY': 7.20,
    'JPY': 149.50,
    'GBP': 0.79,
    'AUD': 1.52,
    'CAD': 1.35,
    'CHF': 0.88,
    'HKD': 7.83,
    'SGD': 1.34,
    'KRW': 1320.0,
    'TWD': 31.50,
  };

  @override
  Future<double?> getExchangeRate(String from, String to) async {
    // 模拟网络延迟
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final fromUpper = from.toUpperCase();
    final toUpper = to.toUpperCase();

    // 相同货币
    if (fromUpper == toUpper) {
      return 1.0;
    }

    // 检查货币是否支持
    if (!_rates.containsKey(fromUpper) || !_rates.containsKey(toUpper)) {
      return null;
    }

    // 计算汇率：from -> USD -> to
    final fromRate = _rates[fromUpper]!;
    final toRate = _rates[toUpper]!;

    return toRate / fromRate;
  }

  @override
  Future<Map<String, double>> getExchangeRates(
    String base,
    List<String> targets,
  ) async {
    final result = <String, double>{};

    for (final target in targets) {
      final rate = await getExchangeRate(base, target);
      if (rate != null) {
        result[target] = rate;
      }
    }

    return result;
  }
}
