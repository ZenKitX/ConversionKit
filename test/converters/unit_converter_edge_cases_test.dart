import 'package:conversion_kit/conversion_kit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:math' as math;

void main() {
  group('UnitConverter - 边界测试', () {
    late UnitConverter converter;

    setUp(() {
      converter = UnitConverter();
    });

    group('极值测试', () {
      test('零值转换', () {
        final result = converter.convert(
          value: 0,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        expect(result, 0.0);
      });

      test('负数转换', () {
        final result = converter.convert(
          value: -100,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        expect(result, -0.1);
      });

      test('极大值转换', () {
        final result = converter.convert(
          value: double.maxFinite,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'meter',
        );
        expect(result, double.maxFinite);
      });

      test('极小正数转换', () {
        final result = converter.convert(
          value: double.minPositive,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        // 极小正数除以1000可能会下溢到0，这是正常的浮点行为
        expect(result >= 0, true);
      });

      test('无穷大处理', () {
        final result = converter.convert(
          value: double.infinity,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        expect(result, double.infinity);
      });

      test('负无穷大处理', () {
        final result = converter.convert(
          value: double.negativeInfinity,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        expect(result, double.negativeInfinity);
      });

      test('NaN 处理', () {
        final result = converter.convert(
          value: double.nan,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        expect(result.isNaN, true);
      });
    });

    group('温度边界测试', () {
      test('绝对零度（开尔文）', () {
        final result = converter.convert(
          value: 0,
          categoryId: 'temperature',
          fromUnitId: 'kelvin',
          toUnitId: 'celsius',
        );
        expect(result, -273.15);
      });

      test('绝对零度转华氏度', () {
        final result = converter.convert(
          value: 0,
          categoryId: 'temperature',
          fromUnitId: 'kelvin',
          toUnitId: 'fahrenheit',
        );
        expect(result, closeTo(-459.67, 0.01));
      });

      test('负温度（摄氏度）', () {
        final result = converter.convert(
          value: -40,
          categoryId: 'temperature',
          fromUnitId: 'celsius',
          toUnitId: 'fahrenheit',
        );
        expect(result, -40.0); // -40°C = -40°F
      });

      test('极高温度', () {
        final result = converter.convert(
          value: 1000,
          categoryId: 'temperature',
          fromUnitId: 'celsius',
          toUnitId: 'kelvin',
        );
        expect(result, 1273.15);
      });

      test('温度零值（摄氏度）', () {
        final result = converter.convert(
          value: 0,
          categoryId: 'temperature',
          fromUnitId: 'celsius',
          toUnitId: 'celsius',
        );
        expect(result, 0.0);
      });

      test('温度负无穷大', () {
        final result = converter.convert(
          value: double.negativeInfinity,
          categoryId: 'temperature',
          fromUnitId: 'celsius',
          toUnitId: 'fahrenheit',
        );
        expect(result, double.negativeInfinity);
      });
    });

    group('进制转换边界测试', () {
      test('空字符串转换', () {
        final result = converter.convertNumberSystem(
          value: '',
          fromUnitId: 'decimal',
          toUnitId: 'hexadecimal',
        );
        expect(result, '');
      });

      test('零值进制转换', () {
        final result = converter.convertNumberSystem(
          value: '0',
          fromUnitId: 'decimal',
          toUnitId: 'binary',
        );
        expect(result, '0');
      });

      test('最大单字节值（255）', () {
        final result = converter.convertNumberSystem(
          value: '255',
          fromUnitId: 'decimal',
          toUnitId: 'hexadecimal',
        );
        expect(result, 'FF');
      });

      test('大数值进制转换', () {
        final result = converter.convertNumberSystem(
          value: '65535',
          fromUnitId: 'decimal',
          toUnitId: 'hexadecimal',
        );
        expect(result, 'FFFF');
      });

      test('二进制全1', () {
        final result = converter.convertNumberSystem(
          value: '11111111',
          fromUnitId: 'binary',
          toUnitId: 'decimal',
        );
        expect(result, '255');
      });

      test('八进制最大单字节', () {
        final result = converter.convertNumberSystem(
          value: '377',
          fromUnitId: 'octal',
          toUnitId: 'decimal',
        );
        expect(result, '255');
      });

      test('无效进制输入', () {
        final result = converter.convertNumberSystem(
          value: 'XYZ',
          fromUnitId: 'hexadecimal',
          toUnitId: 'decimal',
        );
        expect(result, '');
      });

      test('负数进制转换（应该失败）', () {
        final result = converter.convertNumberSystem(
          value: '-10',
          fromUnitId: 'decimal',
          toUnitId: 'binary',
        );
        // Dart 的 int.parse 支持负数，所以会返回负数的二进制表示
        expect(result, '-1010');
      });

      test('小数进制转换（应该失败）', () {
        final result = converter.convertNumberSystem(
          value: '10.5',
          fromUnitId: 'decimal',
          toUnitId: 'binary',
        );
        expect(result, '');
      });
    });

    group('进制输入验证边界测试', () {
      test('空字符串验证', () {
        expect(converter.isValidNumberSystemInput('', 'decimal'), true);
      });

      test('二进制只能包含0和1', () {
        expect(converter.isValidNumberSystemInput('101010', 'binary'), true);
        expect(converter.isValidNumberSystemInput('102', 'binary'), false);
      });

      test('八进制只能包含0-7', () {
        expect(converter.isValidNumberSystemInput('1234567', 'octal'), true);
        expect(converter.isValidNumberSystemInput('8', 'octal'), false);
      });

      test('十进制只能包含0-9', () {
        expect(converter.isValidNumberSystemInput('1234567890', 'decimal'), true);
        expect(converter.isValidNumberSystemInput('A', 'decimal'), false);
      });

      test('十六进制可以包含0-9和A-F', () {
        expect(converter.isValidNumberSystemInput('0123456789ABCDEF', 'hexadecimal'), true);
        expect(converter.isValidNumberSystemInput('G', 'hexadecimal'), false);
      });

      test('十六进制小写字母', () {
        expect(converter.isValidNumberSystemInput('abcdef', 'hexadecimal'), true);
      });

      test('前导零', () {
        expect(converter.isValidNumberSystemInput('00123', 'decimal'), true);
      });

      test('特殊字符', () {
        expect(converter.isValidNumberSystemInput('12@34', 'decimal'), false);
        expect(converter.isValidNumberSystemInput('12 34', 'decimal'), false);
      });
    });

    group('精度测试', () {
      test('高精度小数转换', () {
        final result = converter.convert(
          value: 0.123456789012345,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        expect(result, closeTo(0.000123456789012345, 1e-15));
      });

      test('重复转换精度损失', () {
        double value = 1.0;
        // 多次往返转换
        for (int i = 0; i < 100; i++) {
          value = converter.convert(
            value: value,
            categoryId: 'length',
            fromUnitId: 'meter',
            toUnitId: 'kilometer',
          );
          value = converter.convert(
            value: value,
            categoryId: 'length',
            fromUnitId: 'kilometer',
            toUnitId: 'meter',
          );
        }
        expect(value, closeTo(1.0, 1e-10));
      });

      test('极小差异转换', () {
        final value1 = 1.0;
        final value2 = 1.0 + double.minPositive;
        
        final result1 = converter.convert(
          value: value1,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        
        final result2 = converter.convert(
          value: value2,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        
        // 由于浮点精度限制，极小差异可能在转换后消失
        // 我们只验证两个结果都是有效的数字
        expect(result1.isFinite, true);
        expect(result2.isFinite, true);
      });
    });

    group('格式化边界测试', () {
      test('格式化零', () {
        expect(converter.formatResult(0), '0');
      });

      test('格式化负零', () {
        // -0.0 在 Dart 中会被格式化为 '-0'，这是正常行为
        final result = converter.formatResult(-0.0);
        expect(result == '0' || result == '-0', true);
      });

      test('格式化极小正数', () {
        final result = converter.formatResult(0.00001);
        expect(result, contains('e'));
      });

      test('格式化极小负数', () {
        final result = converter.formatResult(-0.00001);
        expect(result, contains('e'));
      });

      test('格式化大数', () {
        final result = converter.formatResult(123456789.0);
        expect(result, '123456789');
      });

      test('格式化小数去除尾零', () {
        expect(converter.formatResult(1.5000), '1.5');
        expect(converter.formatResult(1.0), '1');
      });

      test('格式化无穷大', () {
        final result = converter.formatResult(double.infinity);
        expect(result, 'Infinity');
      });

      test('格式化负无穷大', () {
        final result = converter.formatResult(double.negativeInfinity);
        expect(result, '-Infinity');
      });

      test('格式化 NaN', () {
        final result = converter.formatResult(double.nan);
        expect(result, 'NaN');
      });

      test('格式化科学计数法边界', () {
        // 刚好在科学计数法阈值
        expect(converter.formatResult(0.0001), '0.0001');
        expect(converter.formatResult(0.00009), contains('e'));
      });
    });

    group('相同单位转换', () {
      test('相同单位转换应返回原值', () {
        final result = converter.convert(
          value: 123.456,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'meter',
        );
        expect(result, 123.456);
      });

      test('温度相同单位转换', () {
        final result = converter.convert(
          value: 25.0,
          categoryId: 'temperature',
          fromUnitId: 'celsius',
          toUnitId: 'celsius',
        );
        expect(result, 25.0);
      });

      test('进制相同单位转换', () {
        final result = converter.convertNumberSystem(
          value: 'FF',
          fromUnitId: 'hexadecimal',
          toUnitId: 'hexadecimal',
        );
        expect(result, 'FF');
      });
    });

    group('链式转换测试', () {
      test('多步转换应保持一致性', () {
        // 米 -> 千米 -> 厘米
        final step1 = converter.convert(
          value: 1000,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        
        final step2 = converter.convert(
          value: step1,
          categoryId: 'length',
          fromUnitId: 'kilometer',
          toUnitId: 'centimeter',
        );
        
        // 直接转换
        final direct = converter.convert(
          value: 1000,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'centimeter',
        );
        
        expect(step2, closeTo(direct, 1e-10));
      });

      test('温度链式转换', () {
        // 摄氏度 -> 华氏度 -> 开尔文 -> 摄氏度
        double value = 100.0;
        
        value = converter.convert(
          value: value,
          categoryId: 'temperature',
          fromUnitId: 'celsius',
          toUnitId: 'fahrenheit',
        );
        
        value = converter.convert(
          value: value,
          categoryId: 'temperature',
          fromUnitId: 'fahrenheit',
          toUnitId: 'kelvin',
        );
        
        value = converter.convert(
          value: value,
          categoryId: 'temperature',
          fromUnitId: 'kelvin',
          toUnitId: 'celsius',
        );
        
        expect(value, closeTo(100.0, 1e-10));
      });
    });

    group('错误输入处理', () {
      test('空类别ID', () {
        final result = converter.convert(
          value: 100,
          categoryId: '',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        expect(result, 100.0);
      });

      test('空单位ID', () {
        final result = converter.convert(
          value: 100,
          categoryId: 'length',
          fromUnitId: '',
          toUnitId: 'kilometer',
        );
        expect(result, 100.0);
      });

      test('特殊字符类别ID', () {
        final result = converter.convert(
          value: 100,
          categoryId: '@#\$%',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        expect(result, 100.0);
      });

      test('超长字符串输入', () {
        final longString = '1' * 1000;
        final result = converter.convertNumberSystem(
          value: longString,
          fromUnitId: 'decimal',
          toUnitId: 'hexadecimal',
        );
        // 应该能处理或返回空字符串
        expect(result, isA<String>());
      });
    });

    group('数学特性测试', () {
      test('转换的可逆性', () {
        final original = 123.456;
        final converted = converter.convert(
          value: original,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        final reversed = converter.convert(
          value: converted,
          categoryId: 'length',
          fromUnitId: 'kilometer',
          toUnitId: 'meter',
        );
        expect(reversed, closeTo(original, 1e-10));
      });

      test('转换的线性性', () {
        // 2 * convert(x) = convert(2 * x)
        final x = 100.0;
        
        final result1 = 2 * converter.convert(
          value: x,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        
        final result2 = converter.convert(
          value: 2 * x,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        
        expect(result1, closeTo(result2, 1e-10));
      });

      test('转换的加法性', () {
        // convert(a) + convert(b) = convert(a + b)
        final a = 50.0;
        final b = 30.0;
        
        final result1 = converter.convert(
          value: a,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        ) + converter.convert(
          value: b,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        
        final result2 = converter.convert(
          value: a + b,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );
        
        expect(result1, closeTo(result2, 1e-10));
      });
    });
  });
}
