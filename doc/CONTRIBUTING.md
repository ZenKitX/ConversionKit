# 贡献指南

感谢你对 ConversionKit 的关注！本文档将帮助你了解如何为项目做出贡献。

## 开发环境

### 要求

- Flutter SDK >= 3.41.0
- Dart SDK >= 3.11.0
- Git

### 设置

```bash
# 克隆仓库
git clone https://github.com/ZenKitX/ConversionKit.git
cd ConversionKit

# 安装依赖
flutter pub get

# 运行测试
flutter test

# 代码分析
flutter analyze

# 格式化代码
dart format .
```

## 开发流程

### 1. 创建分支

```bash
# 功能分支
git checkout -b feat/your-feature-name

# 修复分支
git checkout -b fix/your-bug-fix

# 文档分支
git checkout -b doc/your-doc-update
```

### 2. 编写代码

#### 代码风格

- 使用 `dart format` 格式化代码
- 遵循 `analysis_options.yaml` 中的规则
- 所有公共 API 必须有文档注释
- 使用 `///` 三斜线注释
- 优先使用 `const` 构造函数
- 使用 `final` 声明不可变变量

#### 文档注释示例

```dart
/// 单位转换器。
///
/// 提供统一的单位转换接口，支持多种类别的单位转换。
///
/// ## 使用示例
///
/// ```dart
/// final converter = UnitConverter();
///
/// // 长度转换
/// final result = converter.convert(
///   value: 1.0,
///   categoryId: 'length',
///   fromUnitId: 'kilometer',
///   toUnitId: 'meter',
/// ); // 返回 1000.0
/// ```
///
/// ## 支持的类别
///
/// - 长度 (length)
/// - 面积 (area)
/// - 重量 (weight)
/// - 温度 (temperature)
/// - 体积 (volume)
/// - 速度 (speed)
/// - 压强 (pressure)
/// - 功率 (power)
/// - 进制 (number_system)
class UnitConverter {
  // ...
}
```

### 3. 编写测试

- 每个功能必须有对应的测试
- 测试文件命名：`lib/src/feature.dart` → `test/feature_test.dart`
- 测试覆盖正常情况和边界情况
- 使用描述性的测试名称

#### 测试示例

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:conversion_kit/conversion_kit.dart';

void main() {
  group('UnitConverter', () {
    late UnitConverter converter;

    setUp(() {
      converter = UnitConverter();
    });

    group('长度转换', () {
      test('千米转米应该返回正确结果', () {
        final result = converter.convert(
          value: 1.0,
          categoryId: 'length',
          fromUnitId: 'kilometer',
          toUnitId: 'meter',
        );

        expect(result, 1000.0);
      });

      test('相同单位转换应该返回原值', () {
        final result = converter.convert(
          value: 100.0,
          categoryId: 'length',
          fromUnitId: 'meter',
          toUnitId: 'meter',
        );

        expect(result, 100.0);
      });

      test('无效类别应该返回原值', () {
        final result = converter.convert(
          value: 100.0,
          categoryId: 'invalid',
          fromUnitId: 'meter',
          toUnitId: 'kilometer',
        );

        expect(result, 100.0);
      });
    });
  });
}
```

### 4. 提交代码

#### Commit Message 规范

遵循 [Conventional Commits](https://www.conventionalcommits.org/) 规范：

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Type 类型**：

- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档变更
- `style`: 代码格式（不影响代码运行）
- `refactor`: 重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建过程或辅助工具的变动
- `ci`: CI 配置变更

**Scope 范围**（可选）：

- `converter`: 转换器模块
- `calculator`: 计算器模块
- `model`: 数据模型
- `ui`: UI 组件
- `service`: 服务层
- `data`: 数据层

**示例**：

```
feat(converter): 添加汇率转换器

- 实现 CurrencyConverter 类
- 支持实时汇率查询
- 添加离线缓存机制
- 包含完整的单元测试

Closes #15
```

```
fix(calculator): 修复房贷计算精度问题

修复等额本息计算中的浮点数精度问题，
使用 Decimal 类型进行高精度计算。

Fixes #23
```

```
docs: 更新 README 添加使用示例

添加汇率换算和房贷计算的使用示例。
```

#### 提交前检查清单

- [ ] 代码通过 `flutter analyze`
- [ ] 代码通过 `dart format --output=none --set-exit-if-changed .`
- [ ] 所有测试通过 `flutter test`
- [ ] 公共 API 有文档注释
- [ ] 文档注释包含使用示例
- [ ] 测试覆盖正常和边界情况
- [ ] Commit message 符合规范
- [ ] 单次提交修改量适中（核心代码 < 300 行）

### 5. 推送并创建 Pull Request

```bash
# 推送分支
git push origin feat/your-feature-name

# 在 GitHub 上创建 Pull Request
```

#### Pull Request 要求

- 标题清晰描述变更内容
- 描述中说明变更原因和实现方式
- 关联相关的 Issue
- 确保 CI 检查通过
- 等待代码审查

## 代码审查

### 审查标准

1. **功能正确性**
   - 代码实现符合需求
   - 边界情况处理正确
   - 无明显 bug

2. **代码质量**
   - 遵循项目代码风格
   - 命名清晰易懂
   - 逻辑简洁明了
   - 无重复代码

3. **测试覆盖**
   - 测试充分覆盖功能
   - 测试用例清晰
   - 测试可维护

4. **文档完整**
   - 公共 API 有文档注释
   - 复杂逻辑有注释说明
   - README 和 CHANGELOG 已更新

### 审查流程

1. 提交者创建 PR
2. CI 自动运行测试和检查
3. 审查者进行代码审查
4. 提交者根据反馈修改
5. 审查者批准 PR
6. 合并到主分支

## 发布流程

### 版本号规范

遵循 [语义化版本](https://semver.org/lang/zh-CN/)：

- MAJOR: 不兼容的 API 变更
- MINOR: 向后兼容的功能新增
- PATCH: 向后兼容的问题修正

### 发布步骤

1. 更新版本号（`pubspec.yaml`）
2. 更新 CHANGELOG.md
3. 创建 Git tag
4. 推送到远程仓库
5. 发布到 pub.dev（如果适用）

## 问题反馈

### 报告 Bug

使用 [Bug Report 模板](https://github.com/ZenKitX/ConversionKit/issues/new?template=bug_report.md)：

- 清晰的标题
- 详细的问题描述
- 复现步骤
- 期望行为
- 实际行为
- 环境信息（Flutter 版本、设备等）
- 相关截图或日志

### 功能建议

使用 [Feature Request 模板](https://github.com/ZenKitX/ConversionKit/issues/new?template=feature_request.md)：

- 清晰的标题
- 功能描述
- 使用场景
- 期望的 API 设计
- 可选的实现方案

## 社区准则

- 尊重他人
- 建设性反馈
- 保持专业
- 欢迎新手

## 许可证

通过贡献代码，你同意你的贡献将在 MIT 许可证下发布。

## 联系方式

- GitHub Issues: https://github.com/ZenKitX/ConversionKit/issues
- Email: [your-email@example.com]

---

再次感谢你的贡献！🎉
