# ConversionKit 演示应用

这是一个展示 ConversionKit 功能的 Flutter 图形化界面演示应用。

## 功能

- 📱 **单位换算** - 支持 9 大类别 60+ 单位的转换
- 💱 **汇率换算** - 12 种主流货币的实时汇率转换
- 🏠 **房贷计算** - 等额本息、等额本金、还款计划表

## 运行应用

### 前提条件

确保已安装 Flutter SDK (>=3.41.0)

### 安装依赖

```bash
cd example
flutter pub get
```

### 运行应用

在不同平台上运行：

```bash
# 在 Windows 上运行
flutter run -d windows

# 在 Web 浏览器中运行
flutter run -d chrome

# 在 Android 设备/模拟器上运行
flutter run -d android

# 在 iOS 设备/模拟器上运行（需要 macOS）
flutter run -d ios
```

### 查看可用设备

```bash
flutter devices
```

## 应用截图

应用包含三个主要功能界面：

1. **单位换算界面** - 选择类别、输入数值、选择单位进行转换
2. **汇率换算界面** - 输入金额、选择货币进行汇率转换
3. **房贷计算界面** - 输入贷款信息、选择还款方式、查看还款计划

## 项目结构

```
example/
├── lib/
│   ├── main.dart                           # 应用入口和主页
│   └── screens/
│       ├── unit_converter_screen.dart      # 单位换算界面
│       ├── currency_converter_screen.dart  # 汇率换算界面
│       └── mortgage_calculator_screen.dart # 房贷计算界面
├── pubspec.yaml                            # 依赖配置
└── README.md                               # 本文件
```

## 技术栈

- Flutter 3.41.0+
- Material Design 3
- ConversionKit 0.2.0

## 注意事项

- 汇率数据来自模拟 API，仅供演示使用
- 房贷计算结果仅供参考，实际以银行为准
