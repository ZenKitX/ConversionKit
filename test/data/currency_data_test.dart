import 'package:conversion_kit/src/data/currencies.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyData', () {
    test('货币总数正确', () {
      expect(CurrencyData.currencies.length, 12);
    });

    test('根据代码查找货币', () {
      final usd = CurrencyData.findCurrencyByCode('USD');
      expect(usd, isNotNull);
      expect(usd?.code, 'USD');
      expect(usd?.name, '美元');
      expect(usd?.symbol, '\$');
    });

    test('查找货币不区分大小写', () {
      final usd1 = CurrencyData.findCurrencyByCode('USD');
      final usd2 = CurrencyData.findCurrencyByCode('usd');
      final usd3 = CurrencyData.findCurrencyByCode('Usd');

      expect(usd1, isNotNull);
      expect(usd2, isNotNull);
      expect(usd3, isNotNull);
      expect(usd1?.code, usd2?.code);
      expect(usd2?.code, usd3?.code);
    });

    test('查找不存在的货币返回 null', () {
      final currency = CurrencyData.findCurrencyByCode('XXX');
      expect(currency, isNull);
    });

    test('包含主流货币', () {
      final codes = CurrencyData.currencies.map((c) => c.code).toList();

      expect(codes, contains('USD'));
      expect(codes, contains('EUR'));
      expect(codes, contains('CNY'));
      expect(codes, contains('JPY'));
      expect(codes, contains('GBP'));
    });

    test('所有货币代码唯一', () {
      final codes = CurrencyData.currencies.map((c) => c.code).toList();
      final uniqueCodes = codes.toSet();

      expect(codes.length, uniqueCodes.length);
    });
  });
}
