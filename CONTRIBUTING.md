# ConversionKit 贡献指南

感谢您对 ConversionKit 的关注！本文档将指导您如何为项目做出贡献。

## 目录

1. [行为准则](#行为准则)
2. [如何贡献](#如何贡献)
3. [开发环境设置](#开发环境设置)
4. [提交规范](#提交规范)
5. [代码审查](#代码审查)
6. [发布流程](#发布流程)

## 行为准则

### 我们的承诺

为了营造一个开放和友好的环境，我们承诺：

- 使用友好和包容的语言
- 尊重不同的观点和经验
- 优雅地接受建设性批评
- 关注对社区最有利的事情
- 对其他社区成员表示同理心

### 我们的标准

**积极行为示例:**

- 使用友好和包容的语言
- 尊重不同的观点和经验
- 优雅地接受建设性批评
- 关注对社区最有利的事情

**不可接受的行为示例:**

- 使用性化的语言或图像
- 侮辱性/贬损性评论和人身攻击
- 公开或私下骚扰
- 未经许可发布他人的私人信息

## 如何贡献

### 报告 Bug

在提交 Bug 报告之前：

1. 检查[现有 Issues](https://github.com/ZenKitX/ConversionKit/issues) 确保问题未被报告
2. 确保您使用的是最新版本
3. 收集相关信息（版本号、错误信息、复现步骤）

**Bug 报告应包含:**

- 清晰的标题和描述
- 复现步骤
- 预期行为
- 实际行为
- 环境信息（Dart/Flutter 版本、操作系统）
- 相关代码示例或截图

**Bug 报告模板:**

```markdown
## 描述
简要描述问题。

## 复现步骤
1. 执行 '...'
2. 调用 '...'
3. 看到错误

## 预期行为
应该发生什么。

## 实际行为
实际发生了什么。

## 环境
- ConversionKit 版本: 0.2.0
- Dart 版本: 3.11.0
- Flutter 版本: 3.41.0
- 操作系统: macOS 13.0

## 代码示例
```dart
final converter = UnitConverter();
final result = converter.convert(
  value: 1.0,
  categoryId: 'length',
  fromUnitId: 'invalid_unit',
  toUnitId: 'meter',
);
// 期望: 返回 null 或错误提示
// 实际: 抛出异常
```
```

### 建议新功能

在提交功能建议之前：

1. 检查[现有 Issues](https://github.com/ZenKitX/ConversionKit/issues) 确保功能未被建议
2. 考虑功能是否符合项目目标
3. 提供详细的用例和示例

**功能建议应包含:**

- 清晰的标题和描述
- 功能的动机和用例
- 建议的 API 设计
- 可能的实现方案
- 替代方案

**功能建议模板:**

```markdown
## 功能描述
简要描述建议的功能。

## 动机
为什么需要这个功能？它解决什么问题？

## 建议的 API
\`\`\`dart
// 示例 API
final result = calculator.newFeature(/* ... */);
\`\`\`

## 用例
```dart
// 使用示例
final converter = UnitConverter();
final result = converter.convert(
  value: 100,
  categoryId: 'energy',
  fromUnitId: 'joule',
  toUnitId: 'calorie',
);
print(result); // 23.9006
```

## 替代方案
是否有其他实现方式？
```

### 提交 Pull Request

#### 准备工作

1. Fork 项目仓库
2. 创建功能分支：`git checkout -b feature/my-feature`
3. 进行更改
4. 提交更改：`git commit -m "feat: add new feature"`
5. 推送到分支：`git push origin feature/my-feature`
6. 创建 Pull Request

#### Pull Request 检查清单

在提交 PR 之前，确保：

- [ ] 代码通过 `flutter analyze`
- [ ] 代码通过 `dart format --output=none --set-exit-if-changed .`
- [ ] 所有测试通过 `flutter test`
- [ ] 添加了新功能的测试
- [ ] 更新了相关文档
- [ ] Commit message 符合规范
- [ ] PR 描述清晰，说明了更改内容

#### Pull Request 模板

```markdown
## 更改类型
- [ ] Bug 修复
- [ ] 新功能
- [ ] 重构
- [ ] 文档更新
- [ ] 性能优化

## 描述
简要描述此 PR 的更改。

## 相关 Issue
Closes #123

## 更改内容
- 添加了 XXX 功能
- 修复了 YYY 问题
- 重构了 ZZZ 模块

## 测试
- [ ] 添加了单元测试
- [ ] 添加了集成测试
- [ ] 手动测试通过

## 截图（如适用）
添加截图以帮助解释您的更改。

## 检查清单
- [ ] 代码通过 lint 检查
- [ ] 代码格式正确
- [ ] 所有测试通过
- [ ] 文档已更新
```

## 开发环境设置

### 前置要求

- Dart SDK >= 3.0.0
- Flutter SDK >= 3.10.0（如果需要运行 Flutter 测试）
- Git

### 克隆仓库

```bash
git clone https://github.com/ZenKitX/ConversionKit.git
cd ConversionKit
```

### 安装依赖

```bash
flutter pub get
```

### 运行测试

```bash
# 运行所有测试
flutter test

# 运行特定测试
flutter test test/converters/unit_converter_test.dart

# 生成覆盖率报告
flutter test --coverage
```

### 代码检查

```bash
# 代码分析
flutter analyze

# 代码格式化
dart format .

# 自动修复
dart fix --apply
```

### 项目结构

```text
ConversionKit/
├── lib/
│   ├── conversion_kit.dart        # 主导出文件
│   └── src/
│       ├── calculators/            # 计算器（房贷计算器）
│       ├── converters/             # 转换器（单位、汇率）
│       ├── data/                   # 数据定义
│       ├── models/                 # 数据模型
│       ├── services/               # 服务（API）
│       └── utils/                  # 工具类
├── test/                           # 测试
├── doc/                            # 文档
├── example/                        # 示例
├── pubspec.yaml                    # 包配置
├── README.md                       # 项目说明
├── CHANGELOG.md                    # 更新日志
└── LICENSE                         # 许可证
```

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
- `style`: 代码格式（不影响代码运行）
- `refactor`: 重构（既不是新功能也不是修复 bug）
- `perf`: 性能优化
- `test`: 测试相关
- `chore`: 构建/工具变动
- `ci`: CI 配置变更

### Scope 范围

- `converter`: 转换器模块
- `calculator`: 计算器模块
- `currency`: 汇率相关
- `mortgage`: 房贷相关
- `data`: 数据定义
- `model`: 数据模型
- `test`: 测试
- `doc`: 文档

### Subject 主题

- 使用祈使句，现在时："add" 而不是 "added" 或 "adds"
- 不要大写首字母
- 不要以句号结尾
- 限制在 50 个字符以内

### Body 正文

- 使用祈使句，现在时
- 包含更改的动机和与之前行为的对比
- 每行限制在 72 个字符以内

### Footer 页脚

- 引用相关 Issue：`Closes #123`
- 说明破坏性变更：`BREAKING CHANGE: description`

### 示例

```text
feat(converter): 添加能量单位转换功能

- 实现焦耳、卡路里、千瓦时等单位
- 添加能量类别数据定义
- 添加完整的单元测试

Closes #45
```

```text
fix(currency): 修复汇率 API 超时处理

之前 API 超时会抛出异常，现在返回 null，
与其他错误情况保持一致。

Closes #67
```

```text
docs(api): 更新 API 文档

- 添加更多使用示例
- 修正参数说明
- 更新返回值描述
```

## 代码审查

### 审查标准

代码审查将关注以下方面：

1. **功能性**: 代码是否实现了预期功能？
2. **正确性**: 代码是否正确？是否有 bug？
3. **测试**: 是否有足够的测试覆盖？
4. **可读性**: 代码是否易于理解？
5. **可维护性**: 代码是否易于维护？
6. **性能**: 是否有性能问题？
7. **安全性**: 是否有安全隐患？
8. **文档**: 是否有适当的文档？

### 审查流程

1. 提交者创建 Pull Request
2. CI 自动运行测试和检查
3. 审查者审查代码并提供反馈
4. 提交者根据反馈进行修改
5. 审查者批准 PR
6. 维护者合并 PR

### 审查礼仪

**作为审查者:**

- 保持友好和建设性
- 解释为什么需要更改
- 提供具体的建议
- 认可好的代码

**作为提交者:**

- 不要把批评当作个人攻击
- 解释您的设计决策
- 感谢审查者的时间和反馈
- 及时响应反馈

## 发布流程

### 版本号

遵循 [Semantic Versioning](https://semver.org/)：

- MAJOR: 不兼容的 API 变更
- MINOR: 向后兼容的功能新增
- PATCH: 向后兼容的问题修正

### 发布步骤

1. 更新版本号（`pubspec.yaml`）
2. 更新 CHANGELOG.md
3. 提交更改：`git commit -m "chore: release v0.4.0"`
4. 创建标签：`git tag v0.4.0`
5. 推送标签：`git push origin v0.4.0`
6. 发布到 pub.dev：`flutter pub publish`

### CHANGELOG 格式

```markdown
## 0.3.0 - 2026-03-10

### Added
- 能量单位转换功能
- 数据单位转换功能

### Changed
- 优化汇率 API 性能

### Fixed
- 修复温度转换精度问题
- 修复房贷计算边界情况

### Deprecated
- `oldMethod()` 已弃用，请使用 `newMethod()`

### Removed
- 移除已弃用的 `deprecatedMethod()`

### Security
- 修复潜在的安全漏洞
```

## 开发指南

### 添加新单位类别

参考 [ARCHITECTURE.md](doc/ARCHITECTURE.md#添加新单位类别) 中的详细步骤。

### 添加新单位

参考 [ARCHITECTURE.md](doc/ARCHITECTURE.md#添加新单位) 中的详细步骤。

### 编写测试

```dart
group('NewFeature', () {
  test('正常情况', () {
    // 测试正常情况
  });

  test('边界情况', () {
    // 测试边界情况
  });

  test('错误情况', () {
    // 测试错误情况
  });
});
```

### 编写文档

- 所有公共 API 必须有文档注释
- 文档注释应包含使用示例
- 更新 README.md 和 API.md

## 获取帮助

如果您有任何问题：

1. 查看[文档](doc/)
2. 搜索[现有 Issues](https://github.com/ZenKitX/ConversionKit/issues)
3. 创建新 Issue 提问
4. 加入我们的[讨论区](https://github.com/ZenKitX/ConversionKit/discussions)

## 致谢

感谢所有为 ConversionKit 做出贡献的人！

### 贡献者

- **H1S97X** - 项目创建者和主要维护者

### 特别感谢

- Flutter 社区 - 提供优秀的开发框架
- Dart 团队 - 提供强大的编程语言

---

再次感谢您的贡献！

**文档版本**: 1.0  
**创建日期**: 2026-03-06  
**作者**: ZenKitX Team

