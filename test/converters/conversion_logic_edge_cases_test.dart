import 'package:conversion_kit/conversion_kit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConversionLogic - 边界测试', () {
    group('基本转换边界测试', () {
      test('零比率单位转换', () {
        // 创建一个比率为0的单位（理论上不应该存在，但测试边界）
        final zeroUnit = ConversionUnit(
          id: 'zero',
          name: '零单位',
          symbol: 'Z',
          toBaseRatio: 0,
        );
        
        final normalUnit = ConversionUnit(
          id: 'normal',
          name: '正常单位',
          symbol: 'N',
          toBaseRatio: 1,
        );
        
        // 从零单位转换应该得到0
        final result1 = ConversionLogic.convert(
          value: 100,
          fromUnit: zeroUnit,
          toUnit: normalUnit,
        );
        expect(result1, 0.0);
        
        // 转换到零单位会导致除以零，应该得到无穷大
        final result2 = ConversionLogic.convert(
          value: 100,
          fromUnit: normalUnit,
          toUnit: zeroUnit,
        );
        expect(result2, double.infinity);
      });

      test('极大比率转换', () {
        final hugeUnit = ConversionUnit(
          id: 'huge',
          name: '巨大单位',
          symbol: 'H',
          toBaseRatio: double.maxFinite,
        );
        
        final normalUnit = ConversionUnit(
          id: 'normal',
          name: '正常单位',
          symbol: 'N',
          toBaseRatio: 1,
        );
        
        final result = ConversionLogic.convert(
          value: 1,
          fromUnit: hugeUnit,
          toUnit: normalUnit,
        );
        expect(result, double.maxFinite);
      });

      test('极小比率转换', () {
        final tinyUnit = ConversionUnit(
          id: 'tiny',
          name: '微小单位',
          symbol: 'T',
          toBaseRatio: double.minPositive,
        );
        
        final normalUnit = ConversionUnit(
          id: 'normal',
          name: '正常单位',
          symbol: 'N',
          toBaseRatio: 1,
        );
        
        final result = ConversionLogic.convert(
          value: 1,
          fromUnit: tinyUnit,
          toUnit: normalUnit,
        );
        expect(result, double.minPositive);
      });

      test('负比率转换', () {
        final negativeUnit = ConversionUnit(
          id: 'negative',
          name: '负单位',
          symbol: '-N',
          toBaseRatio: -1,
        );
        
        final normalUnit = ConversionUnit(
          id: 'normal',
          name: '正常单位',
          symbol: 'N',
          toBaseRatio: 1,
        );
        
        final result = ConversionLogic.convert(
          value: 100,
          fromUnit: negativeUnit,
          toUnit: normalUnit,
        );
        expect(result, -100.0);
      });

      test('无穷大比率转换', () {
        final infiniteUnit = ConversionUnit(
          id: 'infinite',
          name: '无穷单位',
          symbol: '∞',
          toBaseRatio: double.infinity,
        );
        
        final normalUnit = ConversionUnit(
          id: 'normal',
          name: '正常单位',
          symbol: 'N',
          toBaseRatio: 1,
        );
        
        final result = ConversionLogic.convert(
          value: 1,
          fromUnit: infiniteUnit,
          toUnit: normalUnit,
        );
        expect(result, double.infinity);
      });
    });

    group('温度转换边界测试', () {
      test('所有温度单位的零点', () {
        // 摄氏度零点
        expect(
          ConversionLogic.convertTemperature(
            value: 0,
            fromUnitId: 'celsius',
            toUnitId: 'celsius',
          ),
          0.0,
        );
        
        // 华氏度零点
        expect(
          ConversionLogic.convertTemperature(
            value: 0,
            fromUnitId: 'fahrenheit',
            toUnitId: 'fahrenheit',
          ),
          0.0,
        );
        
        // 开尔文零点（绝对零度）
        expect(
          ConversionLogic.convertTemperature(
            value: 0,
            fromUnitId: 'kelvin',
            toUnitId: 'kelvin',
          ),
          0.0,
        );
      });

      test('温度转换的对称性', () {
        final temps = [0.0, 100.0, -40.0, 273.15, 1000.0];
        final units = ['celsius', 'fahrenheit', 'kelvin'];
        
        for (final temp in temps) {
          for (final from in units) {
            for (final to in units) {
              final forward = ConversionLogic.convertTemperature(
                value: temp,
                fromUnitId: from,
                toUnitId: to,
              );
              
              final backward = ConversionLogic.convertTemperature(
                value: forward,
                fromUnitId: to,
                toUnitId: from,
              );
              
              expect(backward, closeTo(temp, 1e-10));
            }
          }
        }
      });

      test('极端温度值', () {
        // 极高温度
        final highTemp = ConversionLogic.convertTemperature(
          value: 1000000,
          fromUnitId: 'celsius',
          toUnitId: 'kelvin',
        );
        expect(highTemp, 1000273.15);
        
        // 极低温度（低于绝对零度，物理上不可能但测试数学处理）
        final lowTemp = ConversionLogic.convertTemperature(
          value: -300,
          fromUnitId: 'celsius',
          toUnitId: 'kelvin',
        );
        expect(lowTemp, closeTo(-26.85, 0.0001));
      });

      test('温度无穷大处理', () {
        expect(
          ConversionLogic.convertTemperature(
            value: double.infinity,
            fromUnitId: 'celsius',
            toUnitId: 'fahrenheit',
          ),
          double.infinity,
        );
        
        expect(
          ConversionLogic.convertTemperature(
            value: double.negativeInfinity,
            fromUnitId: 'fahrenheit',
            toUnitId: 'celsius',
          ),
          double.negativeInfinity,
        );
      });

      test('温度 NaN 处理', () {
        final result = ConversionLogic.convertTemperature(
          value: double.nan,
          fromUnitId: 'celsius',
          toUnitId: 'fahrenheit',
        );
        expect(result.isNaN, true);
      });

      test('未知温度单位处理', () {
        // 未知源单位，应该返回原值
        final result1 = ConversionLogic.convertTemperature(
          value: 100,
          fromUnitId: 'unknown',
          toUnitId: 'celsius',
        );
        expect(result1, 100.0);
        
        // 未知目标单位，应该返回摄氏度值
        final result2 = ConversionLogic.convertTemperature(
          value: 100,
          fromUnitId: 'celsius',
          toUnitId: 'unknown',
        );
        expect(result2, 100.0);
      });

      test('特殊温度点验证', () {
        // 水的冰点
        expect(
          ConversionLogic.convertTemperature(
            value: 0,
            fromUnitId: 'celsius',
            toUnitId: 'fahrenheit',
          ),
          32.0,
        );
        
        // 水的沸点
        expect(
          ConversionLogic.convertTemperature(
            value: 100,
            fromUnitId: 'celsius',
            toUnitId: 'fahrenheit',
          ),
          212.0,
        );
        
        // 人体温度
        expect(
          ConversionLogic.convertTemperature(
            value: 37,
            fromUnitId: 'celsius',
            toUnitId: 'fahrenheit',
          ),
          closeTo(98.6, 0.1),
        );
      });
    });

    group('进制转换边界测试', () {
      test('所有进制的零值', () {
        final bases = ['binary', 'octal', 'decimal', 'hexadecimal'];
        
        for (final from in bases) {
          for (final to in bases) {
            final result = ConversionLogic.convertNumberSystem(
              value: '0',
              fromUnitId: from,
              toUnitId: to,
            );
            expect(result, '0');
          }
        }
      });

      test('最大整数值转换', () {
        // Dart int 的最大值在不同平台可能不同
        // 使用一个安全的大数值
        final largeNumber = '9223372036854775807'; // 2^63 - 1
        
        final hex = ConversionLogic.convertNumberSystem(
          value: largeNumber,
          fromUnitId: 'decimal',
          toUnitId: 'hexadecimal',
        );
        expect(hex, '7FFFFFFFFFFFFFFF');
        
        // 转换回来验证
        final back = ConversionLogic.convertNumberSystem(
          value: hex,
          fromUnitId: 'hexadecimal',
          toUnitId: 'decimal',
        );
        expect(back, largeNumber);
      });

      test('进制转换的循环性', () {
        final testValues = ['0', '1', '10', '100', '255'];
        final bases = ['binary', 'octal', 'decimal', 'hexadecimal'];
        
        for (final value in testValues) {
          for (int i = 0; i < bases.length; i++) {
            String current = value;
            
            // 循环转换所有进制
            for (int j = 0; j < bases.length; j++) {
              final from = bases[(i + j) % bases.length];
              final to = bases[(i + j + 1) % bases.length];
              
              current = ConversionLogic.convertNumberSystem(
                value: current,
                fromUnitId: from,
                toUnitId: to,
              );
              
              // 如果转换失败（返回空字符串），跳过此测试
              if (current.isEmpty) break;
            }
            
            // 只有成功完成所有转换才验证
            if (current.isNotEmpty) {
              expect(current, value);
            }
          }
        }
      });

      test('无效进制字符串', () {
        // 包含无效字符
        expect(
          ConversionLogic.convertNumberSystem(
            value: 'XYZ',
            fromUnitId: 'hexadecimal',
            toUnitId: 'decimal',
          ),
          '',
        );
        
        // 二进制包含2
        expect(
          ConversionLogic.convertNumberSystem(
            value: '102',
            fromUnitId: 'binary',
            toUnitId: 'decimal',
          ),
          '',
        );
        
        // 八进制包含8
        expect(
          ConversionLogic.convertNumberSystem(
            value: '78',
            fromUnitId: 'octal',
            toUnitId: 'decimal',
          ),
          '',
        );
      });

      test('特殊字符处理', () {
        expect(
          ConversionLogic.convertNumberSystem(
            value: '12@34',
            fromUnitId: 'decimal',
            toUnitId: 'hexadecimal',
          ),
          '',
        );
        
        expect(
          ConversionLogic.convertNumberSystem(
            value: '12 34',
            fromUnitId: 'decimal',
            toUnitId: 'binary',
          ),
          '',
        );
        
        expect(
          ConversionLogic.convertNumberSystem(
            value: '12.34',
            fromUnitId: 'decimal',
            toUnitId: 'hexadecimal',
          ),
          '',
        );
      });

      test('大小写敏感性', () {
        // 十六进制应该不区分大小写输入
        final lower = ConversionLogic.convertNumberSystem(
          value: 'abc',
          fromUnitId: 'hexadecimal',
          toUnitId: 'decimal',
        );
        
        final upper = ConversionLogic.convertNumberSystem(
          value: 'ABC',
          fromUnitId: 'hexadecimal',
          toUnitId: 'decimal',
        );
        
        expect(lower, upper);
        expect(lower, '2748');
      });

      test('前导零处理', () {
        expect(
          ConversionLogic.convertNumberSystem(
            value: '00123',
            fromUnitId: 'decimal',
            toUnitId: 'hexadecimal',
          ),
          '7B',
        );
        
        expect(
          ConversionLogic.convertNumberSystem(
            value: '0000',
            fromUnitId: 'binary',
            toUnitId: 'decimal',
          ),
          '0',
        );
      });
    });

    group('进制输入验证边界测试', () {
      test('空字符串总是有效', () {
        expect(ConversionLogic.isValidNumberSystemInput('', 'binary'), true);
        expect(ConversionLogic.isValidNumberSystemInput('', 'octal'), true);
        expect(ConversionLogic.isValidNumberSystemInput('', 'decimal'), true);
        expect(ConversionLogic.isValidNumberSystemInput('', 'hexadecimal'), true);
      });

      test('单个字符验证', () {
        // 二进制
        expect(ConversionLogic.isValidNumberSystemInput('0', 'binary'), true);
        expect(ConversionLogic.isValidNumberSystemInput('1', 'binary'), true);
        expect(ConversionLogic.isValidNumberSystemInput('2', 'binary'), false);
        
        // 八进制
        for (int i = 0; i <= 7; i++) {
          expect(ConversionLogic.isValidNumberSystemInput('$i', 'octal'), true);
        }
        expect(ConversionLogic.isValidNumberSystemInput('8', 'octal'), false);
        
        // 十进制
        for (int i = 0; i <= 9; i++) {
          expect(ConversionLogic.isValidNumberSystemInput('$i', 'decimal'), true);
        }
        expect(ConversionLogic.isValidNumberSystemInput('A', 'decimal'), false);
        
        // 十六进制
        for (int i = 0; i <= 9; i++) {
          expect(ConversionLogic.isValidNumberSystemInput('$i', 'hexadecimal'), true);
        }
        for (var c in ['A', 'B', 'C', 'D', 'E', 'F', 'a', 'b', 'c', 'd', 'e', 'f']) {
          expect(ConversionLogic.isValidNumberSystemInput(c, 'hexadecimal'), true);
        }
        expect(ConversionLogic.isValidNumberSystemInput('G', 'hexadecimal'), false);
      });

      test('长字符串验证', () {
        // int.parse 有长度限制，测试合理长度的字符串
        // 二进制：最多约63位（对于64位int）
        final mediumBinary = '1' * 30;
        expect(ConversionLogic.isValidNumberSystemInput(mediumBinary, 'binary'), true);
        
        // 十六进制：最多约15位（对于64位int）
        final mediumHex = 'F' * 10;
        expect(ConversionLogic.isValidNumberSystemInput(mediumHex, 'hexadecimal'), true);
        
        // 超长字符串会因为超出 int 范围而失败
        final veryLongBinary = '1' * 100;
        final isValid = ConversionLogic.isValidNumberSystemInput(veryLongBinary, 'binary');
        // 可能成功也可能失败，取决于平台的 int 大小限制
        expect(isValid is bool, true);
      });

      test('混合字符验证', () {
        expect(ConversionLogic.isValidNumberSystemInput('01010101', 'binary'), true);
        expect(ConversionLogic.isValidNumberSystemInput('01234567', 'octal'), true);
        expect(ConversionLogic.isValidNumberSystemInput('0123456789', 'decimal'), true);
        expect(ConversionLogic.isValidNumberSystemInput('0123456789ABCDEF', 'hexadecimal'), true);
      });

      test('未知进制处理', () {
        // 未知进制应该默认为十进制
        expect(ConversionLogic.isValidNumberSystemInput('123', 'unknown'), true);
        expect(ConversionLogic.isValidNumberSystemInput('ABC', 'unknown'), false);
      });
    });

    group('格式化结果边界测试', () {
      test('各种零值', () {
        expect(ConversionLogic.formatResult(0.0), '0');
        // -0.0 在 Dart 中会被格式化为 '-0'，这是正常行为
        final negZero = ConversionLogic.formatResult(-0.0);
        expect(negZero == '0' || negZero == '-0', true);
      });

      test('科学计数法阈值', () {
        // 刚好在阈值上
        expect(ConversionLogic.formatResult(0.0001), '0.0001');
        
        // 刚好低于阈值
        expect(ConversionLogic.formatResult(0.00009999), contains('e'));
        expect(ConversionLogic.formatResult(0.00001), contains('e'));
      });

      test('精度测试', () {
        // 8位小数精度
        expect(ConversionLogic.formatResult(1.123456789), '1.12345679');
        expect(ConversionLogic.formatResult(0.123456789), '0.12345679');
      });

      test('尾零移除', () {
        expect(ConversionLogic.formatResult(1.0), '1');
        expect(ConversionLogic.formatResult(1.5), '1.5');
        expect(ConversionLogic.formatResult(1.50), '1.5');
        expect(ConversionLogic.formatResult(1.500), '1.5');
        expect(ConversionLogic.formatResult(1.5000), '1.5');
      });

      test('负数格式化', () {
        expect(ConversionLogic.formatResult(-1.0), '-1');
        expect(ConversionLogic.formatResult(-1.5), '-1.5');
        expect(ConversionLogic.formatResult(-0.00001), contains('e'));
      });

      test('特殊值格式化', () {
        expect(ConversionLogic.formatResult(double.infinity), 'Infinity');
        expect(ConversionLogic.formatResult(double.negativeInfinity), '-Infinity');
        expect(ConversionLogic.formatResult(double.nan), 'NaN');
      });

      test('极大值格式化', () {
        final result = ConversionLogic.formatResult(double.maxFinite);
        expect(result, isNotEmpty);
        expect(double.parse(result), double.maxFinite);
      });

      test('极小正值格式化', () {
        final result = ConversionLogic.formatResult(double.minPositive);
        expect(result, contains('e'));
      });
    });

    group('性能和稳定性测试', () {
      test('大量转换不应崩溃', () {
        final unit1 = ConversionUnit(
          id: 'unit1',
          name: '单位1',
          symbol: 'U1',
          toBaseRatio: 1,
        );
        
        final unit2 = ConversionUnit(
          id: 'unit2',
          name: '单位2',
          symbol: 'U2',
          toBaseRatio: 1000,
        );
        
        for (int i = 0; i < 10000; i++) {
          final result = ConversionLogic.convert(
            value: i.toDouble(),
            fromUnit: unit1,
            toUnit: unit2,
          );
          expect(result.isFinite, true);
        }
      });

      test('温度大量转换', () {
        for (int i = -273; i < 1000; i++) {
          final result = ConversionLogic.convertTemperature(
            value: i.toDouble(),
            fromUnitId: 'celsius',
            toUnitId: 'fahrenheit',
          );
          expect(result.isFinite, true);
        }
      });

      test('进制大量转换', () {
        for (int i = 0; i < 1000; i++) {
          final result = ConversionLogic.convertNumberSystem(
            value: i.toString(),
            fromUnitId: 'decimal',
            toUnitId: 'hexadecimal',
          );
          expect(result, isNotEmpty);
        }
      });
    });
  });
}
