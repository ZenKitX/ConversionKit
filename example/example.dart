import 'package:conversion_kit/conversion_kit.dart';

void main() {
  final converter = UnitConverter();

  print('=== ConversionKit 示例 ===\n');

  // 1. 长度转换
  print('1. 长度转换');
  final meters = converter.convert(
    value: 1.0,
    categoryId: 'length',
    fromUnitId: 'kilometer',
    toUnitId: 'meter',
  );
  print('1 千米 = $meters 米');

  final feet = converter.convert(
    value: 1.0,
    categoryId: 'length',
    fromUnitId: 'meter',
    toUnitId: 'foot',
  );
  print('1 米 = ${converter.formatResult(feet)} 英尺\n');

  // 2. 重量转换
  print('2. 重量转换');
  final grams = converter.convert(
    value: 1.0,
    categoryId: 'weight',
    fromUnitId: 'kilogram',
    toUnitId: 'gram',
  );
  print('1 千克 = $grams 克');

  final jin = converter.convert(
    value: 1.0,
    categoryId: 'weight',
    fromUnitId: 'kilogram',
    toUnitId: 'jin',
  );
  print('1 千克 = $jin 斤\n');

  // 3. 温度转换
  print('3. 温度转换');
  final fahrenheit = converter.convert(
    value: 0,
    categoryId: 'temperature',
    fromUnitId: 'celsius',
    toUnitId: 'fahrenheit',
  );
  print('0 摄氏度 = $fahrenheit 华氏度');

  final kelvin = converter.convert(
    value: 100,
    categoryId: 'temperature',
    fromUnitId: 'celsius',
    toUnitId: 'kelvin',
  );
  print('100 摄氏度 = $kelvin 开尔文\n');

  // 4. 面积转换
  print('4. 面积转换');
  final squareMeters = converter.convert(
    value: 1.0,
    categoryId: 'area',
    fromUnitId: 'hectare',
    toUnitId: 'square_meter',
  );
  print('1 公顷 = $squareMeters 平方米');

  final mu = converter.convert(
    value: 1.0,
    categoryId: 'area',
    fromUnitId: 'hectare',
    toUnitId: 'mu',
  );
  print('1 公顷 = ${converter.formatResult(mu)} 亩\n');

  // 5. 体积转换
  print('5. 体积转换');
  final liters = converter.convert(
    value: 1.0,
    categoryId: 'volume',
    fromUnitId: 'cubic_meter',
    toUnitId: 'liter',
  );
  print('1 立方米 = $liters 升');

  final gallons = converter.convert(
    value: 1.0,
    categoryId: 'volume',
    fromUnitId: 'liter',
    toUnitId: 'gallon',
  );
  print('1 升 = ${converter.formatResult(gallons)} 加仑\n');

  // 6. 速度转换
  print('6. 速度转换');
  final kmh = converter.convert(
    value: 1.0,
    categoryId: 'speed',
    fromUnitId: 'meter_per_second',
    toUnitId: 'kilometer_per_hour',
  );
  print('1 米/秒 = ${converter.formatResult(kmh)} 千米/时');

  final mph = converter.convert(
    value: 100,
    categoryId: 'speed',
    fromUnitId: 'kilometer_per_hour',
    toUnitId: 'mile_per_hour',
  );
  print('100 千米/时 = ${converter.formatResult(mph)} 英里/时\n');

  // 7. 压强转换
  print('7. 压强转换');
  final kpa = converter.convert(
    value: 1.0,
    categoryId: 'pressure',
    fromUnitId: 'bar',
    toUnitId: 'kilopascal',
  );
  print('1 巴 = $kpa 千帕');

  final atm = converter.convert(
    value: 1.0,
    categoryId: 'pressure',
    fromUnitId: 'bar',
    toUnitId: 'atmosphere',
  );
  print('1 巴 = ${converter.formatResult(atm)} 大气压\n');

  // 8. 功率转换
  print('8. 功率转换');
  final kw = converter.convert(
    value: 1000,
    categoryId: 'power',
    fromUnitId: 'watt',
    toUnitId: 'kilowatt',
  );
  print('1000 瓦特 = $kw 千瓦');

  final hp = converter.convert(
    value: 1.0,
    categoryId: 'power',
    fromUnitId: 'kilowatt',
    toUnitId: 'horsepower',
  );
  print('1 千瓦 = ${converter.formatResult(hp)} 马力\n');

  // 9. 进制转换
  print('9. 进制转换');
  final hex = converter.convertNumberSystem(
    value: '255',
    fromUnitId: 'decimal',
    toUnitId: 'hexadecimal',
  );
  print('255 (十进制) = $hex (十六进制)');

  final binary = converter.convertNumberSystem(
    value: 'FF',
    fromUnitId: 'hexadecimal',
    toUnitId: 'binary',
  );
  print('FF (十六进制) = $binary (二进制)');

  final octal = converter.convertNumberSystem(
    value: '11111111',
    fromUnitId: 'binary',
    toUnitId: 'octal',
  );
  print('11111111 (二进制) = $octal (八进制)\n');

  // 10. 获取所有类别
  print('10. 所有支持的类别');
  final categories = converter.getAllCategories();
  for (final category in categories) {
    final units = category.units;
    print('${category.name}: ${units.length} 个单位');
  }
}
