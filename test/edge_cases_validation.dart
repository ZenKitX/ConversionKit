/// 边界测试验证脚本
///
/// 这个脚本用于快速验证边界测试的基本功能
import '../lib/conversion_kit.dart';

void main() {
  print('=== ConversionKit 边界测试验证 ===\n');

  final converter = UnitConverter();
  int passedTests = 0;
  int totalTests = 0;

  void test(String name, bool Function() testFn) {
    totalTests++;
    try {
      if (testFn()) {
        print('✓ $name');
        passedTests++;
      } else {
        print('✗ $name - 断言失败');
      }
    } catch (e) {
      print('✗ $name - 异常: $e');
    }
  }

  print('--- 极值测试 ---');

  test('零值转换', () {
    final result = converter.convert(
      value: 0,
      categoryId: 'length',
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
    );
    return result == 0.0;
  });

  test('负数转换', () {
    final result = converter.convert(
      value: -100,
      categoryId: 'length',
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
    );
    return result == -0.1;
  });

  test('无穷大处理', () {
    final result = converter.convert(
      value: double.infinity,
      categoryId: 'length',
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
    );
    return result == double.infinity;
  });

  test('NaN 处理', () {
    final result = converter.convert(
      value: double.nan,
      categoryId: 'length',
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
    );
    return result.isNaN;
  });

  print('\n--- 温度边界测试 ---');

  test('绝对零度', () {
    final result = converter.convert(
      value: 0,
      categoryId: 'temperature',
      fromUnitId: 'kelvin',
      toUnitId: 'celsius',
    );
    return result == -273.15;
  });

  test('负温度', () {
    final result = converter.convert(
      value: -40,
      categoryId: 'temperature',
      fromUnitId: 'celsius',
      toUnitId: 'fahrenheit',
    );
    return result == -40.0;
  });

  test('温度无穷大', () {
    final result = converter.convert(
      value: double.infinity,
      categoryId: 'temperature',
      fromUnitId: 'celsius',
      toUnitId: 'fahrenheit',
    );
    return result == double.infinity;
  });

  print('\n--- 进制转换边界测试 ---');

  test('空字符串转换', () {
    final result = converter.convertNumberSystem(
      value: '',
      fromUnitId: 'decimal',
      toUnitId: 'hexadecimal',
    );
    return result == '';
  });

  test('零值进制转换', () {
    final result = converter.convertNumberSystem(
      value: '0',
      fromUnitId: 'decimal',
      toUnitId: 'binary',
    );
    return result == '0';
  });

  test('最大单字节值', () {
    final result = converter.convertNumberSystem(
      value: '255',
      fromUnitId: 'decimal',
      toUnitId: 'hexadecimal',
    );
    return result == 'FF';
  });

  test('无效进制输入', () {
    final result = converter.convertNumberSystem(
      value: 'XYZ',
      fromUnitId: 'hexadecimal',
      toUnitId: 'decimal',
    );
    return result == '';
  });

  print('\n--- 进制输入验证 ---');

  test('空字符串验证', () {
    return converter.isValidNumberSystemInput('', 'decimal');
  });

  test('二进制只能包含0和1', () {
    return converter.isValidNumberSystemInput('101010', 'binary') &&
        !converter.isValidNumberSystemInput('102', 'binary');
  });

  test('十六进制可以包含A-F', () {
    return converter.isValidNumberSystemInput('ABCDEF', 'hexadecimal') &&
        !converter.isValidNumberSystemInput('G', 'hexadecimal');
  });

  print('\n--- 格式化边界测试 ---');

  test('格式化零', () {
    return converter.formatResult(0) == '0';
  });

  test('格式化极小正数', () {
    final result = converter.formatResult(0.00001);
    return result.contains('e');
  });

  test('格式化去除尾零', () {
    return converter.formatResult(1.5000) == '1.5' &&
        converter.formatResult(1.0) == '1';
  });

  test('格式化无穷大', () {
    return converter.formatResult(double.infinity) == 'Infinity';
  });

  test('格式化 NaN', () {
    return converter.formatResult(double.nan) == 'NaN';
  });

  print('\n--- 精度测试 ---');

  test('高精度小数转换', () {
    final result = converter.convert(
      value: 0.123456789012345,
      categoryId: 'length',
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
    );
    return (result - 0.000123456789012345).abs() < 1e-15;
  });

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
    return (reversed - original).abs() < 1e-10;
  });

  print('\n--- 错误输入处理 ---');

  test('空类别ID', () {
    final result = converter.convert(
      value: 100,
      categoryId: '',
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
    );
    return result == 100.0;
  });

  test('无效类别返回原值', () {
    final result = converter.convert(
      value: 100,
      categoryId: 'invalid',
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
    );
    return result == 100.0;
  });

  print('\n--- ConversionLogic 直接测试 ---');

  test('温度转换对称性', () {
    final temp = 100.0;
    final toF = ConversionLogic.convertTemperature(
      value: temp,
      fromUnitId: 'celsius',
      toUnitId: 'fahrenheit',
    );
    final back = ConversionLogic.convertTemperature(
      value: toF,
      fromUnitId: 'fahrenheit',
      toUnitId: 'celsius',
    );
    return (back - temp).abs() < 1e-10;
  });

  test('进制转换循环性', () {
    final value = '255';
    final hex = ConversionLogic.convertNumberSystem(
      value: value,
      fromUnitId: 'decimal',
      toUnitId: 'hexadecimal',
    );
    final binary = ConversionLogic.convertNumberSystem(
      value: hex,
      fromUnitId: 'hexadecimal',
      toUnitId: 'binary',
    );
    final back = ConversionLogic.convertNumberSystem(
      value: binary,
      fromUnitId: 'binary',
      toUnitId: 'decimal',
    );
    return back == value;
  });

  print('\n=== 测试结果 ===');
  print('通过: $passedTests / $totalTests');
  print('失败: ${totalTests - passedTests}');

  if (passedTests == totalTests) {
    print('\n✅ 所有边界测试通过！');
  } else {
    print('\n⚠️  部分测试失败，请检查实现');
  }
}
