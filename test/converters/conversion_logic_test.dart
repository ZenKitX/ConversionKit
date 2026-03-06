import 'package:conversion_kit/conversion_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversionLogic', () {
    group('基本单位换算', () {
      test('千米转米', () {
        const kilometer = ConversionUnit(
          id: 'kilometer',
          name: '千米',
          symbol: 'km',
          toBaseRatio: 1000,
        );

        const meter = ConversionUnit(
          id: 'meter',
          name: '米',
          symbol: 'm',
          toBaseRatio: 1,
        );

        final result = ConversionLogic.convert(
          value: 1,
          fromUnit: kilometer,
          toUnit: meter,
        );

        expect(result, 1000.0);
      });

      test('米转千米', () {
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

        final result = ConversionLogic.convert(
          value: 1000,
          fromUnit: meter,
          toUnit: kilometer,
        );

        expect(result, 1.0);
      });

      test('相同单位转换', () {
        const meter = ConversionUnit(
          id: 'meter',
          name: '米',
          symbol: 'm',
          toBaseRatio: 1,
        );

        final result = ConversionLogic.convert(
          value: 100,
          fromUnit: meter,
          toUnit: meter,
        );

        expect(result, 100.0);
      });
    });

    group('温度换算', () {
      test('摄氏度转华氏度', () {
        final result = ConversionLogic.convertTemperature(
          value: 0,
          fromUnitId: 'celsius',
          toUnitId: 'fahrenheit',
        );

        expect(result, 32.0);
      });

      test('华氏度转摄氏度', () {
        final result = ConversionLogic.convertTemperature(
          value: 32,
          fromUnitId: 'fahrenheit',
          toUnitId: 'celsius',
        );

        expect(result, 0.0);
      });

      test('摄氏度转开尔文', () {
        final result = ConversionLogic.convertTemperature(
          value: 0,
          fromUnitId: 'celsius',
          toUnitId: 'kelvin',
        );

        expect(result, 273.15);
      });

      test('开尔文转摄氏度', () {
        final result = ConversionLogic.convertTemperature(
          value: 273.15,
          fromUnitId: 'kelvin',
          toUnitId: 'celsius',
        );

        expect(result, 0.0);
      });

      test('相同单位转换', () {
        final result = ConversionLogic.convertTemperature(
          value: 100,
          fromUnitId: 'celsius',
          toUnitId: 'celsius',
        );

        expect(result, 100.0);
      });
    });

    group('进制转换', () {
      test('十进制转十六进制', () {
        final result = ConversionLogic.convertNumberSystem(
          value: '255',
          fromUnitId: 'decimal',
          toUnitId: 'hexadecimal',
        );

        expect(result, 'FF');
      });

      test('十六进制转十进制', () {
        final result = ConversionLogic.convertNumberSystem(
          value: 'FF',
          fromUnitId: 'hexadecimal',
          toUnitId: 'decimal',
        );

        expect(result, '255');
      });

      test('十进制转二进制', () {
        final result = ConversionLogic.convertNumberSystem(
          value: '8',
          fromUnitId: 'decimal',
          toUnitId: 'binary',
        );

        expect(result, '1000');
      });

      test('二进制转十进制', () {
        final result = ConversionLogic.convertNumberSystem(
          value: '1000',
          fromUnitId: 'binary',
          toUnitId: 'decimal',
        );

        expect(result, '8');
      });

      test('相同进制转换', () {
        final result = ConversionLogic.convertNumberSystem(
          value: '123',
          fromUnitId: 'decimal',
          toUnitId: 'decimal',
        );

        expect(result, '123');
      });

      test('无效输入返回空字符串', () {
        final result = ConversionLogic.convertNumberSystem(
          value: 'invalid',
          fromUnitId: 'decimal',
          toUnitId: 'hexadecimal',
        );

        expect(result, '');
      });
    });

    group('进制输入验证', () {
      test('验证十进制输入', () {
        expect(
          ConversionLogic.isValidNumberSystemInput('123', 'decimal'),
          true,
        );
        expect(
          ConversionLogic.isValidNumberSystemInput('abc', 'decimal'),
          false,
        );
      });

      test('验证十六进制输入', () {
        expect(
          ConversionLogic.isValidNumberSystemInput('FF', 'hexadecimal'),
          true,
        );
        expect(
          ConversionLogic.isValidNumberSystemInput('GG', 'hexadecimal'),
          false,
        );
      });

      test('验证二进制输入', () {
        expect(
          ConversionLogic.isValidNumberSystemInput('1010', 'binary'),
          true,
        );
        expect(
          ConversionLogic.isValidNumberSystemInput('1234', 'binary'),
          false,
        );
      });

      test('空输入有效', () {
        expect(ConversionLogic.isValidNumberSystemInput('', 'decimal'), true);
      });
    });

    group('格式化结果', () {
      test('格式化普通数值', () {
        final result = ConversionLogic.formatResult(123.456);
        expect(result, '123.456');
      });

      test('格式化整数', () {
        final result = ConversionLogic.formatResult(100);
        expect(result, '100');
      });

      test('格式化极小值（科学计数法）', () {
        final result = ConversionLogic.formatResult(0.00001);
        expect(result, '1.000000e-5');
      });

      test('移除尾部零', () {
        final result = ConversionLogic.formatResult(1.50000000);
        expect(result, '1.5');
      });
    });
  });
}
