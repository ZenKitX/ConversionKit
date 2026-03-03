import 'package:conversion_kit/src/converters/currency_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CurrencyConverter', () {
    late CurrencyConverter converter;

    setUp(() {
      converter = CurrencyConverter();
    });

    group('基本转换', () {
      test('USD 转 CNY', () async {
        final result = await converter.convert(
          value: 100,
          from: 'USD',
          to: 'CNY',
        );

        expect(result, isNotNull);
        expect(result, greaterThan(0));
        // 基于模拟汇率 1 USD = 7.20 CNY
        expect(result, closeTo(720, 1));
      });

      test('EUR 转 USD', () async {
        final result = await converter.convert(
          value: 100,
          from: 'EUR',
          to: 'USD',
        );

        expect(result, isNotNull);
        expect(result, greaterThan(0));
      });

      test('相同货币转换返回原值', () async {
        final result = await converter.convert(
          value: 100,
          from: 'USD',
          to: 'USD',
        );

        expect(result, 100);
      });

      test('不区分大小写', () async {
        final result1 = await converter.convert(
          value: 100,
          from: 'USD',
          to: 'CNY',
        );

        final result2 = await converter.convert(
          value: 100,
          from: 'usd',
          to: 'cny',
        );

        expect(result1, result2);
      });

      test('不支持的货币返回 null', () async {
        final result = await converter.convert(
          value: 100,
          from: 'USD',
          to: 'XXX',
        );

        expect(result, isNull);
      });
    });

    group('批量转换', () {
      test('转换为多种货币', () async {
        final results = await converter.convertMultiple(
          value: 100,
          from: 'USD',
          targets: ['CNY', 'EUR', 'JPY'],
        );

        expect(results.length, 3);
        expect(results['CNY'], isNotNull);
        expect(results['EUR'], isNotNull);
        expect(results['JPY'], isNotNull);
      });

      test('包含不支持的货币', () async {
        final results = await converter.convertMultiple(
          value: 100,
          from: 'USD',
          targets: ['CNY', 'XXX', 'EUR'],
        );

        expect(results.length, 2);
        expect(results.containsKey('CNY'), true);
        expect(results.containsKey('EUR'), true);
        expect(results.containsKey('XXX'), false);
      });
    });

    group('格式化金额', () {
      test('格式化普通金额', () {
        final formatted = converter.formatAmount(
          value: 1234.56,
          currencyCode: 'USD',
        );

        expect(formatted, '1,234.56');
      });

      test('格式化大额金额', () {
        final formatted = converter.formatAmount(
          value: 1234567.89,
          currencyCode: 'USD',
        );

        expect(formatted, '1,234,567.89');
      });

      test('格式化日元（无小数）', () {
        final formatted = converter.formatAmount(
          value: 1234.56,
          currencyCode: 'JPY',
        );

        expect(formatted, '1,235');
      });

      test('格式化韩元（无小数）', () {
        final formatted = converter.formatAmount(
          value: 1234567.89,
          currencyCode: 'KRW',
        );

        expect(formatted, '1,234,568');
      });

      test('自定义小数位数', () {
        final formatted = converter.formatAmount(
          value: 1234.56789,
          currencyCode: 'USD',
          decimals: 4,
        );

        expect(formatted, '1,234.5679');
      });

      test('格式化小额金额', () {
        final formatted = converter.formatAmount(
          value: 0.99,
          currencyCode: 'USD',
        );

        expect(formatted, '0.99');
      });
    });
  });
}
