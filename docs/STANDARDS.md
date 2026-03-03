# ConversionKit 规范化标准

本文档总结了 ConversionKit 项目的所有规范化标准和最佳实践。

## 目录

1. [代码规范](#代码规范)
2. [提交规范](#提交规范)
3. [测试规范](#测试规范)
4. [文档规范](#文档规范)
5. [架构规范](#架构规范)
6. [质量保证](#质量保证)

## 代码规范

### Lint 规则

项目使用严格的 Lint 规则，配置在 `analysis_options.yaml` 中：

- 基于 `package:flutter_lints/flutter.yaml`
- 启用 strict-casts、strict-inference、strict-raw-types
- 100+ 条 lint 规则确保代码质量

### 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 文件 | snake_case | `unit_converter.dart` |
| 类 | PascalCase | `UnitConverter` |
| 变量/方法 | camelCase | `convert()`, `isValid` |
| 常量 | lowerCamelCase | `const pi = 3.14` |
| 枚举 | PascalCase/camelCase | `enum Type { length }` |

### 代码格式

- 缩进：2 个空格
- 行长度：最多 80 字符
- 尾随逗号：多行参数必须使用
- 空行：类成员之间一个空行

### 类型注解

- 公共 API：必须显式声明类型
- 局部变量：可使用类型推断
- 优先使用 `final` 而不是 `var`
- 尽可能使用 `const`

## 提交规范

### Commit Message 格式

遵循 [Conventional Commits](https://www.conventionalcommits.org/)：

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type 类型

- `feat`: 新功能
- `fix`: 修复 bug
- `docs`: 文档变更
- `style`: 代码格式
- `refactor`: 重构
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建/工具变动
- `ci`: CI 配置变更

### Scope 范围

- `converter`: 转换器模块
- `calculator`: 计算器模块
- `model`: 数据模型
- `ui`: UI 组件
- `service`: 服务层
- `data`: 数据层

### 示例

```
feat(converter): 添加汇率转换器

- 实现 CurrencyConverter 类
- 支持实时汇率查询
- 添加离线缓存机制
- 包含完整的单元测试

Closes #15
```

## 测试规范

### 测试覆盖

- 每个公共 API 必须有测试
- 测试覆盖正常情况和边界情况
- 测试覆盖率目标：> 95%

### 测试命名

- 使用描述性的中文测试名称
- 说明测试的内容和期望结果

```dart
test('千米转米应该返回正确结果', () {
  // ...
});
```

### 测试组织

- 使用 `group` 组织相关测试
- 使用 `setUp` 和 `tearDown` 管理状态

```dart
group('UnitConverter', () {
  late UnitConverter converter;

  setUp(() {
    converter = UnitConverter();
  });

  group('长度转换', () {
    test('千米转米应该返回正确结果', () {
      // ...
    });
  });
});
```

## 文档规范

### 公共 API 文档

所有公共类、方法、属性必须有文档注释：

```dart
/// 单位转换器。
///
/// 提供统一的单位转换接口，支持多种类别的单位转换。
///
/// ## 使用示例
///
/// ```dart
/// final converter = UnitConverter();
/// final result = converter.convert(
///   value: 1,
///   categoryId: 'length',
///   fromUnitId: 'kilometer',
///   toUnitId: 'meter',
/// );
/// ```
class UnitConverter {
  /// 转换数值。
  ///
  /// 参数:
  /// - [value]: 要转换的数值
  /// - [categoryId]: 类别 ID
  /// - [fromUnitId]: 源单位 ID
  /// - [toUnitId]: 目标单位 ID
  ///
  /// 返回转换后的数值，如果转换失败返回原值。
  double convert({
    required double value,
    required String categoryId,
    required String fromUnitId,
    required String toUnitId,
  }) {
    // ...
  }
}
```

### 文档结构

- 第一行：简短描述（一句话）
- 详细说明：另起段落
- 使用示例：使用 `## 使用示例` 标题
- 参数说明：使用 `参数:` 列表
- 返回值：说明返回值含义
- 异常：说明可能抛出的异常

## 架构规范

### 目录结构

```
lib/
├── conversion_kit.dart              # 主导出文件
└── src/                             # 实现细节
    ├── models/                      # 数据模型
    ├── converters/                  # 转换器
    ├── calculators/                 # 计算器
    ├── data/                        # 数据定义
    ├── services/                    # 服务层
    ├── utils/                       # 工具类
    └── ui/                          # UI 组件
```

### 模块划分

- **models**: 数据模型，纯数据类
- **converters**: 转换器，处理单位转换
- **calculators**: 计算器，处理复杂计算
- **data**: 静态数据定义
- **services**: 服务层，处理 API 调用
- **utils**: 工具类，通用辅助函数
- **ui**: UI 组件，可复用的界面组件

### 依赖原则

- 最小依赖：核心功能零外部依赖
- 可选依赖：扩展功能使用可选依赖
- 版本约束：使用合理的版本约束

## 质量保证

### 提交前检查清单

- [ ] 代码通过 `flutter analyze`
- [ ] 代码通过 `dart format --output=none --set-exit-if-changed .`
- [ ] 所有测试通过 `flutter test`
- [ ] 公共 API 有文档注释
- [ ] 文档注释包含使用示例
- [ ] 测试覆盖正常和边界情况
- [ ] Commit message 符合规范
- [ ] 单次提交修改量适中（< 300 行核心代码）

### 自动化检查

项目使用 GitHub Actions 进行 CI/CD：

- 代码格式检查
- 代码分析
- 单元测试
- 测试覆盖率

配置文件：`.github/workflows/dart.yml`

### 工具命令

```bash
# 格式化代码
dart format .

# 代码分析
flutter analyze

# 自动修复
dart fix --apply

# 运行测试
flutter test

# 生成覆盖率
flutter test --coverage

# 查看覆盖率（需要 lcov）
genhtml coverage/lcov.info -o coverage/html
```

## 版本管理

### 语义化版本

遵循 [Semantic Versioning](https://semver.org/)：

- MAJOR: 不兼容的 API 变更
- MINOR: 向后兼容的功能新增
- PATCH: 向后兼容的问题修正

### CHANGELOG

每次发布更新 `CHANGELOG.md`：

```markdown
## 0.2.0 - 2026-03-10

### Added
- 汇率转换器
- 房贷计算器

### Changed
- 优化单位转换性能

### Fixed
- 修复温度转换精度问题
```

## 参考文档

- [代码风格指南](CODE_STYLE.md)
- [贡献指南](CONTRIBUTING.md)
- [项目计划](project-plan.md)
- [开发计划](development-plan.md)
- [Convert 包调研](convert-package-research.md)

---

**文档版本**: 1.0  
**更新日期**: 2026-03-03  
**维护者**: ZenKitX Team
