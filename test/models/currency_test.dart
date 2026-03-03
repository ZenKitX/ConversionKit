import 'package:conversion_kit/conversion_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Currency', () {
    test('创建货币实例', () {
      const currency = Currency(
        code: 'USD',
        name: '美元',
        symbol: '\$',
      );

      expect(currency.code, 'USD');
      expect(currency.name, '美元');
      expect(currency.symbol, '\$');
    });

    test('货币相等性比较', () {
      const usd1 = Currency(code: 'USD', name: '美元', symbol: '\$');
      const usd2 = Currency(code: 'USD', name: '美元', symbol: '\$');
      const cny = Currency(code: 'CNY', name: '人民币', symbol: '¥');

      expect(usd1, equals(usd2));
      expect(usd1, isNot(equals(cny)));
    });

    test('toString 方法', () {
      const currency = Currency(
        code: 'USD',
        name: '美元',
        symbol: '\$',
      );

      expect(currency.toString(), '美元 (\$)');
    });

    test('hashCode 一致性', () {
      const usd1 = Currency(code: 'USD', name: '美元', symbol: '\$');
      const usd2 = Currency(code: 'USD', name: '美元', symbol: '\$');

      expect(usd1.hashCode, equals(usd2.hashCode));
    });
  });
}
