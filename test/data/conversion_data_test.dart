import 'package:conversion_kit/conversion_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversionData', () {
    test('类别总数正确', () {
      expect(ConversionData.categories.length, 9);
    });

    test('根据 ID 查找类别', () {
      final category = ConversionData.findCategoryById('length');
      expect(category, isNotNull);
      expect(category?.name, '长度');
    });

    test('查找不存在的类别', () {
      final category = ConversionData.findCategoryById('invalid');
      expect(category, isNull);
    });

    test('长度类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('length');
      expect(category?.units.length, 8);
    });

    test('面积类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('area');
      expect(category?.units.length, 7);
    });

    test('重量类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('weight');
      expect(category?.units.length, 8);
    });

    test('温度类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('temperature');
      expect(category?.units.length, 3);
    });

    test('体积类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('volume');
      expect(category?.units.length, 7);
    });

    test('速度类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('speed');
      expect(category?.units.length, 5);
    });

    test('压强类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('pressure');
      expect(category?.units.length, 7);
    });

    test('功率类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('power');
      expect(category?.units.length, 5);
    });

    test('进制类别包含正确数量的单位', () {
      final category = ConversionData.findCategoryById('number_system');
      expect(category?.units.length, 4);
    });

    test('温度类别标记为特殊', () {
      final category = ConversionData.findCategoryById('temperature');
      expect(category?.isSpecial, true);
    });

    test('进制类别标记为特殊', () {
      final category = ConversionData.findCategoryById('number_system');
      expect(category?.isSpecial, true);
    });

    test('普通类别不是特殊类别', () {
      final category = ConversionData.findCategoryById('length');
      expect(category?.isSpecial, false);
    });
  });
}
