/// Benchmark tests for ConversionKit
/// 
/// Run with: dart run benchmark/conversion_benchmark.dart
import '../lib/conversion_kit.dart';

void main() {
  print('=== ConversionKit Performance Benchmark ===\n');
  
  // Warm up
  print('Warming up...');
  final converter = UnitConverter();
  for (int i = 0; i < 1000; i++) {
    converter.convert(
      value: 1.0,
      categoryId: 'length',
      fromUnitId: 'kilometer',
      toUnitId: 'meter',
    );
  }
  print('Warm up complete.\n');
  
  // Run benchmarks
  benchmarkBasicConversion();
  benchmarkTemperatureConversion();
  benchmarkNumberSystemConversion();
  benchmarkFormatting();
  benchmarkDataRetrieval();
  
  print('\n=== Benchmark Complete ===');
}

void benchmarkBasicConversion() {
  print('--- Basic Unit Conversion Benchmark ---');
  
  final converter = UnitConverter();
  final conversions = [
    {'category': 'length', 'from': 'kilometer', 'to': 'meter', 'value': 1.0},
    {'category': 'weight', 'from': 'kilogram', 'to': 'gram', 'value': 1.0},
    {'category': 'area', 'from': 'square_meter', 'to': 'square_kilometer', 'value': 1000000.0},
    {'category': 'volume', 'from': 'liter', 'to': 'milliliter', 'value': 1.0},
    {'category': 'speed', 'from': 'meter_per_second', 'to': 'kilometer_per_hour', 'value': 1.0},
  ];
  
  for (final conv in conversions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 100000;
    
    for (int i = 0; i < iterations; i++) {
      converter.convert(
        value: conv['value'] as double,
        categoryId: conv['category'] as String,
        fromUnitId: conv['from'] as String,
        toUnitId: conv['to'] as String,
      );
    }
    
    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  ${conv['category']}: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkTemperatureConversion() {
  print('--- Temperature Conversion Benchmark ---');
  
  final converter = UnitConverter();
  final conversions = [
    {'from': 'celsius', 'to': 'fahrenheit', 'value': 0.0},
    {'from': 'fahrenheit', 'to': 'celsius', 'value': 32.0},
    {'from': 'celsius', 'to': 'kelvin', 'value': 0.0},
    {'from': 'kelvin', 'to': 'celsius', 'value': 273.15},
  ];
  
  for (final conv in conversions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 100000;
    
    for (int i = 0; i < iterations; i++) {
      converter.convert(
        value: conv['value'] as double,
        categoryId: 'temperature',
        fromUnitId: conv['from'] as String,
        toUnitId: conv['to'] as String,
      );
    }
    
    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  ${conv['from']} → ${conv['to']}: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkNumberSystemConversion() {
  print('--- Number System Conversion Benchmark ---');
  
  final converter = UnitConverter();
  final conversions = [
    {'from': 'decimal', 'to': 'binary', 'value': '255'},
    {'from': 'binary', 'to': 'decimal', 'value': '11111111'},
    {'from': 'decimal', 'to': 'hexadecimal', 'value': '255'},
    {'from': 'hexadecimal', 'to': 'decimal', 'value': 'FF'},
  ];
  
  for (final conv in conversions) {
    final stopwatch = Stopwatch()..start();
    const iterations = 50000;
    
    for (int i = 0; i < iterations; i++) {
      converter.convertNumberSystem(
        value: conv['value'] as String,
        fromUnitId: conv['from'] as String,
        toUnitId: conv['to'] as String,
      );
    }
    
    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  ${conv['from']} → ${conv['to']}: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkFormatting() {
  print('--- Formatting Benchmark ---');
  
  final converter = UnitConverter();
  final values = [
    123.456,
    123.456000,
    0.00001,
    1234567.89,
    0.0,
  ];
  
  for (final value in values) {
    final stopwatch = Stopwatch()..start();
    const iterations = 100000;
    
    for (int i = 0; i < iterations; i++) {
      converter.formatResult(value);
    }
    
    stopwatch.stop();
    final avgTime = stopwatch.elapsedMicroseconds / iterations;
    print('  $value: ${avgTime.toStringAsFixed(2)} μs/op ($iterations ops)');
  }
  print('');
}

void benchmarkDataRetrieval() {
  print('--- Data Retrieval Benchmark ---');
  
  final converter = UnitConverter();
  
  // Get all categories
  var stopwatch = Stopwatch()..start();
  const iterations1 = 10000;
  for (int i = 0; i < iterations1; i++) {
    converter.getAllCategories();
  }
  stopwatch.stop();
  print('  getAllCategories: ${(stopwatch.elapsedMicroseconds / iterations1).toStringAsFixed(2)} μs/op ($iterations1 ops)');
  
  // Get category
  stopwatch = Stopwatch()..start();
  const iterations2 = 100000;
  for (int i = 0; i < iterations2; i++) {
    converter.getCategory('length');
  }
  stopwatch.stop();
  print('  getCategory: ${(stopwatch.elapsedMicroseconds / iterations2).toStringAsFixed(2)} μs/op ($iterations2 ops)');
  
  // Get units
  stopwatch = Stopwatch()..start();
  const iterations3 = 100000;
  for (int i = 0; i < iterations3; i++) {
    converter.getUnits('length');
  }
  stopwatch.stop();
  print('  getUnits: ${(stopwatch.elapsedMicroseconds / iterations3).toStringAsFixed(2)} μs/op ($iterations3 ops)');
  
  print('');
}
