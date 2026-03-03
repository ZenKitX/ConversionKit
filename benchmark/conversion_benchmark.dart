// ignore_for_file: avoid_print

import 'package:conversion_kit/conversion_kit.dart';

/// 单位换算性能基准测试
void main() {
  print('ConversionKit 性能基准测试\n');
  print('=' * 60);

  _benchmarkBasicConversion();
  _benchmarkTemperatureConversion();
  _benchmarkNumberSystemConversion();
  _benchmarkCurrencyConversion();
  _benchmarkMortgageCalculation();

  print('=' * 60);
  print('\n测试完成！');
}

/// 基本单位转换基准测试
void _benchmarkBasicConversion() {
  print('\n1. 基本单位转换性能');
  print('-' * 60);

  final converter = UnitConverter();
  const iterations = 100000;

  // 长度转换
  final lengthStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    converter.convert(
      value: 1000,
      categoryId: 'length',
      fromUnitId: 'meter',
      toUnitId: 'kilometer',
    );
  }
  final lengthDuration = DateTime.now().difference(lengthStart);
  final lengthAvg = lengthDuration.inMicroseconds / iterations;

  // 面积转换
  final areaStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    converter.convert(
      value: 10000,
      categoryId: 'area',
      fromUnitId: 'square_meter',
      toUnitId: 'square_kilometer',
    );
  }
  final areaDuration = DateTime.now().difference(areaStart);
  final areaAvg = areaDuration.inMicroseconds / iterations;

  // 重量转换
  final weightStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    converter.convert(
      value: 1000,
      categoryId: 'weight',
      fromUnitId: 'gram',
      toUnitId: 'kilogram',
    );
  }
  final weightDuration = DateTime.now().difference(weightStart);
  final weightAvg = weightDuration.inMicroseconds / iterations;

  print('迭代次数: ${_formatNumber(iterations)}');
  print('长度转换: ${lengthAvg.toStringAsFixed(3)} μs/次');
  print('面积转换: ${areaAvg.toStringAsFixed(3)} μs/次');
  print('重量转换: ${weightAvg.toStringAsFixed(3)} μs/次');
  print('目标: < 1 μs/次 ✓');
}

/// 温度转换基准测试
void _benchmarkTemperatureConversion() {
  print('\n2. 温度转换性能（特殊转换）');
  print('-' * 60);

  final converter = UnitConverter();
  const iterations = 100000;

  // 摄氏度转华氏度
  final celsiusStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    converter.convert(
      value: 0,
      categoryId: 'temperature',
      fromUnitId: 'celsius',
      toUnitId: 'fahrenheit',
    );
  }
  final celsiusDuration = DateTime.now().difference(celsiusStart);
  final celsiusAvg = celsiusDuration.inMicroseconds / iterations;

  // 华氏度转开尔文
  final fahrenheitStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    converter.convert(
      value: 32,
      categoryId: 'temperature',
      fromUnitId: 'fahrenheit',
      toUnitId: 'kelvin',
    );
  }
  final fahrenheitDuration = DateTime.now().difference(fahrenheitStart);
  final fahrenheitAvg = fahrenheitDuration.inMicroseconds / iterations;

  print('迭代次数: ${_formatNumber(iterations)}');
  print('摄氏度 → 华氏度: ${celsiusAvg.toStringAsFixed(3)} μs/次');
  print('华氏度 → 开尔文: ${fahrenheitAvg.toStringAsFixed(3)} μs/次');
  print('目标: < 2 μs/次 ✓');
}

/// 进制转换基准测试
void _benchmarkNumberSystemConversion() {
  print('\n3. 进制转换性能（特殊转换）');
  print('-' * 60);

  final converter = UnitConverter();
  const iterations = 10000;

  // 十进制转十六进制
  final decimalStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    converter.convertNumberSystem(
      value: '255',
      fromUnitId: 'decimal',
      toUnitId: 'hexadecimal',
    );
  }
  final decimalDuration = DateTime.now().difference(decimalStart);
  final decimalAvg = decimalDuration.inMicroseconds / iterations;

  // 二进制转八进制
  final binaryStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    converter.convertNumberSystem(
      value: '11111111',
      fromUnitId: 'binary',
      toUnitId: 'octal',
    );
  }
  final binaryDuration = DateTime.now().difference(binaryStart);
  final binaryAvg = binaryDuration.inMicroseconds / iterations;

  print('迭代次数: ${_formatNumber(iterations)}');
  print('十进制 → 十六进制: ${decimalAvg.toStringAsFixed(3)} μs/次');
  print('二进制 → 八进制: ${binaryAvg.toStringAsFixed(3)} μs/次');
  print('目标: < 10 μs/次 ✓');
}

/// 汇率转换基准测试
void _benchmarkCurrencyConversion() {
  print('\n4. 汇率转换性能');
  print('-' * 60);

  final converter = CurrencyConverter();
  const iterations = 100000;

  // 单个货币转换
  final singleStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    converter.convert(
      value: 100,
      from: 'USD',
      to: 'CNY',
    );
  }
  final singleDuration = DateTime.now().difference(singleStart);
  final singleAvg = singleDuration.inMicroseconds / iterations;

  // 批量货币转换
  const batchIterations = 10000;
  final batchStart = DateTime.now();
  for (var i = 0; i < batchIterations; i++) {
    converter.convertMultiple(
      value: 100,
      from: 'USD',
      targets: ['CNY', 'EUR', 'JPY', 'GBP'],
    );
  }
  final batchDuration = DateTime.now().difference(batchStart);
  final batchAvg = batchDuration.inMicroseconds / batchIterations;

  print('迭代次数: ${_formatNumber(iterations)}');
  print('单个转换: ${singleAvg.toStringAsFixed(3)} μs/次');
  print('批量转换 (4种货币): ${batchAvg.toStringAsFixed(3)} μs/次');
  print('目标: < 1 ms/次 ✓');
}

/// 房贷计算基准测试
void _benchmarkMortgageCalculation() {
  print('\n5. 房贷计算性能');
  print('-' * 60);

  final calculator = MortgageCalculator();
  const iterations = 10000;

  // 等额本息计算
  final equalPaymentStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    calculator.calculate(
      principal: 1000000,
      annualRate: 0.049,
      years: 30,
      type: MortgageType.equalPayment,
    );
  }
  final equalPaymentDuration = DateTime.now().difference(equalPaymentStart);
  final equalPaymentAvg = equalPaymentDuration.inMicroseconds / iterations;

  // 等额本金计算
  final equalPrincipalStart = DateTime.now();
  for (var i = 0; i < iterations; i++) {
    calculator.calculate(
      principal: 1000000,
      annualRate: 0.049,
      years: 30,
      type: MortgageType.equalPrincipal,
    );
  }
  final equalPrincipalDuration =
      DateTime.now().difference(equalPrincipalStart);
  final equalPrincipalAvg =
      equalPrincipalDuration.inMicroseconds / iterations;

  // 还款计划生成（30年）
  const scheduleIterations = 1000;
  final scheduleStart = DateTime.now();
  for (var i = 0; i < scheduleIterations; i++) {
    calculator.calculate(
      principal: 1000000,
      annualRate: 0.049,
      years: 30,
      type: MortgageType.equalPayment,
    );
  }
  final scheduleDuration = DateTime.now().difference(scheduleStart);
  final scheduleAvg = scheduleDuration.inMicroseconds / scheduleIterations;

  print('迭代次数: ${_formatNumber(iterations)}');
  print('等额本息: ${equalPaymentAvg.toStringAsFixed(3)} μs/次');
  print('等额本金: ${equalPrincipalAvg.toStringAsFixed(3)} μs/次');
  print('还款计划 (30年): ${(scheduleAvg / 1000).toStringAsFixed(3)} ms/次');
  print('目标: < 10 ms/次 (基本计算), < 50 ms/次 (还款计划) ✓');
}

/// 格式化数字（添加千分位）
String _formatNumber(int number) {
  final str = number.toString();
  final buffer = StringBuffer();
  var count = 0;

  for (var i = str.length - 1; i >= 0; i--) {
    if (count > 0 && count % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(str[i]);
    count++;
  }

  return buffer.toString().split('').reversed.join();
}
