# ConversionKit 性能基准测试

本目录包含 ConversionKit 的性能基准测试，用于评估核心功能的性能表现。

## 测试内容

### 1. 基本单位转换
- 长度、面积、重量等常规单位转换
- 目标: < 1 微秒/次

### 2. 温度转换
- 摄氏度、华氏度、开尔文之间的转换
- 非线性转换，需要特殊计算
- 目标: < 2 微秒/次

### 3. 进制转换
- 二进制、八进制、十进制、十六进制之间的转换
- 涉及字符串解析和转换
- 目标: < 10 微秒/次

### 4. 汇率转换
- 单个货币转换
- 批量货币转换
- 目标: < 1 毫秒/次

### 5. 房贷计算
- 等额本息计算
- 等额本金计算
- 还款计划生成（30年）
- 目标: < 10 毫秒/次（基本计算），< 50 毫秒/次（还款计划）

## 运行方式

### 使用 Dart VM 运行

```bash
dart run benchmark/conversion_benchmark.dart
```

### 使用 Flutter 运行

```bash
flutter run benchmark/conversion_benchmark.dart
```

## 性能目标

根据项目规划文档中的性能目标：

| 功能 | 目标性能 | 实际性能 |
|------|---------|---------|
| 基本转换 | < 1 μs | ✓ |
| 温度转换 | < 2 μs | ✓ |
| 进制转换 | < 10 μs | ✓ |
| 汇率查询 | < 1 ms | ✓ |
| 房贷计算 | < 10 ms | ✓ |
| 还款计划 | < 50 ms | ✓ |

## 测试环境

基准测试结果会受到以下因素影响：
- CPU 性能
- 内存速度
- Dart VM 版本
- 编译模式（Debug vs Release）

建议在 Release 模式下运行以获得最准确的性能数据：

```bash
dart compile exe benchmark/conversion_benchmark.dart -o benchmark.exe
./benchmark.exe
```

## 持续监控

建议在以下情况下运行基准测试：
- 添加新功能后
- 重构代码后
- 发布新版本前
- 性能优化后

确保性能不会退化，并验证优化效果。

## 结果解读

### 微秒 (μs)
- 1 微秒 = 0.001 毫秒
- 适用于快速计算操作

### 毫秒 (ms)
- 1 毫秒 = 1000 微秒
- 适用于复杂计算或批量操作

### 性能等级
- 优秀: < 目标值的 50%
- 良好: < 目标值
- 可接受: < 目标值的 150%
- 需优化: > 目标值的 150%

## 添加新的基准测试

在 `conversion_benchmark.dart` 中添加新的测试函数：

```dart
void _benchmarkNewFeature() {
  print('\n6. 新功能性能');
  print('-' * 60);

  const iterations = 10000;
  final start = DateTime.now();
  
  for (var i = 0; i < iterations; i++) {
    // 执行测试代码
  }
  
  final duration = DateTime.now().difference(start);
  final avg = duration.inMicroseconds / iterations;
  
  print('迭代次数: ${_formatNumber(iterations)}');
  print('平均耗时: ${avg.toStringAsFixed(3)} μs/次');
  print('目标: < X μs/次');
}
```

然后在 `main()` 函数中调用：

```dart
void main() {
  // ...
  _benchmarkNewFeature();
  // ...
}
```
