import 'package:conversion_kit/conversion_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UnitConverter', () {
    late UnitConverter converter;

    setUp(() {
      converter = UnitConverter();
    });

    group('基本转换', () {
      test('长度转换：千米转米', () {
        final result = converter.convert(
          value: 1,
          categoryId: 'length',
          fromUnitId: 'kilometer',
          toUnitId: 'meter',
        );

        expect(result, 1000.0);
      });

      test('重量转换：千克转克', () {
        final result = converter.convert(
          value: 1,
          categoryId: 'weight',
          fromUnitId: 'kilogram',
          toUnitId: 'gram',
        );

        expect(result, 1000.0);
      });

      test('无效类别返回原值', () {
        final result = converter.convert(
          value: 100,
          categoryId: 'invalid',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );

        expect(result, 100.0);
      });

      test('无效单位返回原值', () {
        final result = converter.convert(
          value: 100,
          categoryId: 'length',
          fromUnitId: 'invalid',
          toUnitId: 'meter',
        );

        expect(result, 100.0);
      });
    });

    group('温度转换', () {
      test('摄氏度转华氏度', () {
        final result = converter.convert(
          value: 0,
          categoryId: 'temperature',
          fromUnitId: 'celsius',
          toUnitId: 'fahrenheit',
        );

        expect(result, 32.0);
      });

      test('华氏度转摄氏度', () {
        final result = converter.convert(
          value: 32,
          categoryId: 'temperature',
          fromUnitId: 'fahrenheit',
          toUnitId: 'celsius',
        );

        expect(result, 0.0);
      });
    });

    group('进制转换', () {
      test('十进制转十六进制', () {
        final result = converter.convertNumberSystem(
          value: '255',
          fromUnitId: 'decimal',
          toUnitId: 'hexadecimal',
        );

        expect(result, 'FF');
      });

      test('二进制转十进制', () {
        final result = converter.convertNumberSystem(
          value: '1010',
          fromUnitId: 'binary',
          toUnitId: 'decimal',
        );

        expect(result, '10');
      });
    });

    group('进制输入验证', () {
      test('验证有效输入', () {
        final isValid = converter.isValidNumberSystemInput('FF', 'hexadecimal');
        expect(isValid, true);
      });

      test('验证无效输入', () {
        final isValid = converter.isValidNumberSystemInput('GG', 'hexadecimal');
        expect(isValid, false);
      });
    });

    group('格式化结果', () {
      test('格式化普通数值', () {
        final result = converter.formatResult(123.456);
        expect(result, '123.456');
      });

      test('格式化整数', () {
        final result = converter.formatResult(100);
        expect(result, '100');
      });
    });

    group('获取数据', () {
      test('获取所有类别', () {
        final categories = converter.getAllCategories();
        expect(categories.length, 9);
        expect(categories.first.id, 'length');
      });

      test('获取指定类别', () {
        final category = converter.getCategory('length');
        expect(category, isNotNull);
        expect(category?.name, '长度');
      });

      test('获取不存在的类别', () {
        final category = converter.getCategory('invalid');
        expect(category, isNull);
      });

      test('获取类别的所有单位', () {
        final units = converter.getUnits('length');
        expect(units, isNotNull);
        expect(units!.length, 8);
      });

      test('获取不存在类别的单位', () {
        final units = converter.getUnits('invalid');
        expect(units, isNull);
      });
    });
  });
}
