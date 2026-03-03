import 'package:flutter_test/flutter_test.dart';
import 'package:conversion_kit/conversion_kit.dart';

void main() {
  group('ConversionData', () {
    test('长度单位数量正确', () {
      expect(ConversionData.lengthUnits.length, 8);
    });

    test('面积单位数量正确', () {
      expect(ConversionData.areaUnits.length, 7);
    });

    test('重量单位数量正确', () {
      expect(ConversionData.weightUnits.length, 8);
    });

    test('温度单位数量正确', () {
      expect(ConversionData.temperatureUnits.length, 3);
    });

    test('体积单位数量正确', () {
      expect(ConversionData.volumeUnits.length, 7);
    });

    test('速度单位数量正确', () {
      expect(ConversionData.speedUnits.length, 5);
    });

    test('压强单位数量正确', () {
      expect(ConversionData.pressureUnits.length, 7);
    });

    test('功率单位数量正确', () {
      expect(ConversionData.powerUnits.length, 5);
    });

    test('进制单位数量正确', () {
      expect(ConversionData.numberSystemUnits.length, 4);
    });

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
