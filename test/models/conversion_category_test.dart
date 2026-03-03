import 'package:conversion_kit/conversion_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversionCategory', () {
    const meter = ConversionUnit(
      id: 'meter',
      name: '米',
      symbol: 'm',
      toBaseRatio: 1,
    );

    const kilometer = ConversionUnit(
      id: 'kilometer',
      name: '千米',
      symbol: 'km',
      toBaseRatio: 1000,
    );

    test('创建类别实例', () {
      const category = ConversionCategory(
        id: 'length',
        name: '长度',
        units: [meter, kilometer],
      );

      expect(category.id, 'length');
      expect(category.name, '长度');
      expect(category.units.length, 2);
      expect(category.requiresApi, false);
      expect(category.isSpecial, false);
    });

    test('创建特殊类别', () {
      const category = ConversionCategory(
        id: 'temperature',
        name: '温度',
        units: [],
        isSpecial: true,
      );

      expect(category.isSpecial, true);
    });

    test('根据 ID 查找单位', () {
      const category = ConversionCategory(
        id: 'length',
        name: '长度',
        units: [meter, kilometer],
      );

      final foundUnit = category.findUnitById('meter');
      expect(foundUnit, isNotNull);
      expect(foundUnit?.id, 'meter');

      final notFound = category.findUnitById('invalid');
      expect(notFound, isNull);
    });

    test('类别相等性比较', () {
      const category1 = ConversionCategory(
        id: 'length',
        name: '长度',
        units: [meter],
      );

      const category2 = ConversionCategory(
        id: 'length',
        name: '长度',
        units: [meter],
      );

      const category3 = ConversionCategory(id: 'weight', name: '重量', units: []);

      expect(category1, equals(category2));
      expect(category1, isNot(equals(category3)));
    });

    test('toString 方法', () {
      const category = ConversionCategory(
        id: 'length',
        name: '长度',
        units: [meter],
      );

      expect(category.toString(), '长度');
    });
  });
}
