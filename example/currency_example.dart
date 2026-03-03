import 'package:conversion_kit/conversion_kit.dart';

/// 汇率换算示例
///
/// 演示如何使用 CurrencyConverter 进行货币转换。
void main() async {
  print('=== ConversionKit 汇率换算示例 ===\n');

  // 创建汇率转换器
  final converter = CurrencyConverter();

  // 示例 1: 基本货币转换
  print('示例 1: 基本货币转换');
  final usdToCny = await converter.convert(
    value: 100,
    from: 'USD',
    to: 'CNY',
  );
  print('100 USD = ${usdToCny?.toStringAsFixed(2)} CNY');

  final eurToUsd = await converter.convert(
    value: 100,
    from: 'EUR',
    to: 'USD',
  );
  print('100 EUR = ${eurToUsd?.toStringAsFixed(2)} USD\n');

  // 示例 2: 批量转换
  print('示例 2: 批量转换');
  final results = await converter.convertMultiple(
    value: 100,
    from: 'USD',
    targets: ['CNY', 'EUR', 'JPY', 'GBP'],
  );

  print('100 USD 转换为多种货币:');
  for (final entry in results.entries) {
    final formatted = converter.formatAmount(
      value: entry.value,
      currencyCode: entry.key,
    );
    print('  ${entry.key}: $formatted');
  }
  print('');

  // 示例 3: 金额格式化
  print('示例 3: 金额格式化');
  final amounts = {
    'USD': 1234567.89,
    'EUR': 987654.32,
    'JPY': 1234567.0,
    'CNY': 9876543.21,
  };

  for (final entry in amounts.entries) {
    final formatted = converter.formatAmount(
      value: entry.value,
      currencyCode: entry.key,
    );
    print('${entry.key}: $formatted');
  }
  print('');

  // 示例 4: 查询货币信息
  print('示例 4: 查询货币信息');
  final currencies = ['USD', 'EUR', 'CNY', 'JPY'];

  for (final code in currencies) {
    final currency = CurrencyData.findCurrencyByCode(code);
    if (currency != null) {
      print('${currency.code}: ${currency.name} (${currency.symbol})');
    }
  }
  print('');

  // 示例 5: 实际应用场景
  print('示例 5: 实际应用场景 - 跨境购物');
  const productPriceUsd = 299.99;
  print('商品价格: \$${productPriceUsd.toStringAsFixed(2)} USD');

  final priceInCny = await converter.convert(
    value: productPriceUsd,
    from: 'USD',
    to: 'CNY',
  );

  if (priceInCny != null) {
    final formatted = converter.formatAmount(
      value: priceInCny,
      currencyCode: 'CNY',
    );
    print('人民币价格: ¥$formatted CNY');
  }
}
