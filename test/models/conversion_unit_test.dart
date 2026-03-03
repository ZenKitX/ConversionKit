import 'package:conversion_kit/conversion_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversionUnit', () {
    test('创建单位实例', () {
      const unit = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1,
      );

      expect(unit.id, 'meter');
      expect(unit.name, '米');
      expect(unit.symbol, 'm');
      expect(unit.toBaseRatio, 1.0);
    });

    test('单位相等性比较', () {
      const unit1 = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1,
      );

      const unit2 = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1,
      );

      const unit3 = ConversionUnit(
        id: 'kilometer',
        name: '千米',
        symbol: 'km',
        toBaseRatio: 1000,
      );

      expect(unit1, equals(unit2));
      expect(unit1, isNot(equals(unit3)));
    });

    test('toString 方法', () {
      const unit = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1,
      );

      expect(unit.toString(), '米 (m)');
    });

    test('hashCode 一致性', () {
      const unit1 = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1,
      );

      const unit2 = ConversionUnit(
        id: 'meter',
        name: '米',
        symbol: 'm',
        toBaseRatio: 1,
      );

      expect(unit1.hashCode, equals(unit2.hashCode));
    });
  });
}
