# 当前更改的提交建议

根据 `git status` 和 `git diff --stat` 的分析，当前有大量的重构和重组工作。建议将这些更改分成多个逻辑提交：

## 提交 1: 重构项目结构

```text
refactor: 重构项目结构和代码组织

- 将 calculators 合并到 converters 模块
- 重命名 utils 为 converters 子模块
- 统一数据文件命名（conversion_data -> conversions, currency_data -> currencies）
- 重命名服务文件（currency_api_service -> currency_api）
- 移除冗余的文档文件

这次重构简化了项目结构，提高了代码的可维护性和一致性。
```

**包含的文件：**
- 删除: `lib/src/calculators/mortgage_calculator.dart`
- 删除: `lib/src/utils/conversion_logic.dart`
- 删除: `lib/src/utils/mortgage_logic.dart`
- 删除: `lib/src/data/conversion_data.dart`
- 删除: `lib/src/data/currency_data.dart`
- 删除: `lib/src/services/currency_api_service.dart`
- 新增: `lib/src/converters/conversion_logic.dart`
- 新增: `lib/src/converters/mortgage_converter.dart`
- 新增: `lib/src/converters/mortgage_logic.dart`
- 新增: `lib/src/data/conversions.dart`
- 新增: `lib/src/data/currencies.dart`
- 新增: `lib/src/services/currency_api.dart`
- 修改: `lib/conversion_kit.dart`
- 修改: `lib/src/converters/currency_converter.dart`
- 修改: `lib/src/converters/unit_converter.dart`

**Git 命令：**
```bash
# 添加删除的文件
git add -u lib/src/calculators/
git add -u lib/src/utils/
git add -u lib/src/data/conversion_data.dart
git add -u lib/src/data/currency_data.dart
git add -u lib/src/services/currency_api_service.dart

# 添加新文件
git add lib/src/converters/conversion_logic.dart
git add lib/src/converters/mortgage_converter.dart
git add lib/src/converters/mortgage_logic.dart
git add lib/src/data/conversions.dart
git add lib/src/data/currencies.dart
git add lib/src/services/currency_api.dart

# 添加修改的文件
git add lib/conversion_kit.dart
git add lib/src/converters/currency_converter.dart
git add lib/src/converters/unit_converter.dart
```

---

## 提交 2: 重构测试结构

```text
test: 重构测试结构以匹配新的代码组织

- 移除 calculators 和 utils 测试目录
- 将测试移动到 converters 目录
- 添加边界情况测试
- 更新测试导入路径

测试结构现在与源代码结构保持一致。
```

**包含的文件：**
- 删除: `test/calculators/mortgage_calculator_test.dart`
- 删除: `test/utils/conversion_logic_test.dart`
- 新增: `test/converters/mortgage_converter_test.dart`
- 新增: `test/converters/conversion_logic_test.dart`
- 新增: `test/converters/conversion_logic_edge_cases_test.dart`
- 新增: `test/converters/unit_converter_edge_cases_test.dart`
- 新增: `test/edge_cases_validation.dart`
- 修改: `test/data/currency_data_test.dart`

**Git 命令：**
```bash
git add -u test/calculators/
git add -u test/utils/
git add test/converters/
git add test/edge_cases_validation.dart
git add test/data/currency_data_test.dart
```

---

## 提交 3: 添加示例应用

```text
feat(example): 添加独立的示例应用

- 创建独立的 Flutter 示例应用
- 添加示例应用的 pubspec 配置
- 添加示例应用的 README 文档

示例应用展示了如何在实际项目中使用 ConversionKit。
```

**包含的文件：**
- 新增: `example/lib/`
- 新增: `example/pubspec.yaml`
- 新增: `example/pubspec.lock`
- 新增: `example/README.md`

**Git 命令：**
```bash
git add example/lib/
git add example/pubspec.yaml
git add example/pubspec.lock
git add example/README.md
```

---

## 提交 4: 清理文档

```text
docs: 清理和重组文档

- 移除过时的研究文档
- 移除开发计划文档（已完成）
- 移除重命名报告
- 将 CONTRIBUTING.md 移到根目录
- 添加边界情况测试文档

文档现在更加简洁，只保留必要的内容。
```

**包含的文件：**
- 删除: `doc/CONTRIBUTING.md`
- 删除: `doc/conversion-kit-research.md`
- 删除: `doc/convert-package-research.md`
- 删除: `doc/development-plan.md`
- 删除: `doc/project-plan.md`
- 删除: `doc/rename-report.md`
- 新增: `CONTRIBUTING.md`
- 新增: `doc/EDGE_CASES_TESTING.md`

**Git 命令：**
```bash
git add -u doc/
git add CONTRIBUTING.md
git add doc/EDGE_CASES_TESTING.md
```

---

## 提交 5: 更新配置和元数据

```text
chore: 更新项目配置和元数据

- 更新 .gitignore 添加新的忽略规则
- 更新 LICENSE 年份
- 添加 AUTHORS 文件
- 更新 README 添加新功能说明
- 更新 pubspec.yaml 依赖和版本
- 优化 benchmark 代码

这些更改改进了项目的配置和文档。
```

**包含的文件：**
- 修改: `.gitignore`
- 修改: `LICENSE`
- 新增: `AUTHORS`
- 修改: `README.md`
- 修改: `pubspec.yaml`
- 修改: `benchmark/conversion_benchmark.dart`

**Git 命令：**
```bash
git add .gitignore
git add LICENSE
git add AUTHORS
git add README.md
git add pubspec.yaml
git add benchmark/conversion_benchmark.dart
```

---

## 提交 6: 添加 Git 规范和工具

```text
chore(git): 添加提交规范和 Git hooks

- 添加提交信息规范文档
- 创建提交信息模板
- 添加 commit-msg hook 检查提交格式
- 添加 prepare-commit-msg hook 自动添加 issue 引用
- 提供 hooks 安装脚本

这些工具帮助团队保持一致的提交风格。
```

**包含的文件：**
- 新增: `.github/COMMIT_CONVENTION.md`
- 新增: `.gitmessage`
- 新增: `.github/hooks/commit-msg`
- 新增: `.github/hooks/prepare-commit-msg`
- 新增: `.github/hooks/install-hooks.sh`
- 新增: `.github/hooks/install-hooks.ps1`
- 新增: `.github/hooks/README.md`

**Git 命令：**
```bash
git add .github/COMMIT_CONVENTION.md
git add .gitmessage
git add .github/hooks/
```

---

## 执行顺序

建议按照以下顺序执行提交：

1. 提交 1（重构项目结构）- 最重要的结构性变更
2. 提交 2（重构测试结构）- 测试跟随代码结构
3. 提交 3（添加示例应用）- 新功能
4. 提交 4（清理文档）- 文档整理
5. 提交 5（更新配置和元数据）- 配置更新
6. 提交 6（添加 Git 规范和工具）- 开发工具

## 快速执行脚本

如果你想一次性完成所有提交，可以使用以下脚本：

```bash
# 提交 1
git add -u lib/src/calculators/ lib/src/utils/ lib/src/data/conversion_data.dart lib/src/data/currency_data.dart lib/src/services/currency_api_service.dart
git add lib/src/converters/conversion_logic.dart lib/src/converters/mortgage_converter.dart lib/src/converters/mortgage_logic.dart lib/src/data/conversions.dart lib/src/data/currencies.dart lib/src/services/currency_api.dart
git add lib/conversion_kit.dart lib/src/converters/currency_converter.dart lib/src/converters/unit_converter.dart
git commit -m "refactor: 重构项目结构和代码组织

- 将 calculators 合并到 converters 模块
- 重命名 utils 为 converters 子模块
- 统一数据文件命名（conversion_data -> conversions, currency_data -> currencies）
- 重命名服务文件（currency_api_service -> currency_api）
- 移除冗余的文档文件

这次重构简化了项目结构，提高了代码的可维护性和一致性。"

# 提交 2
git add -u test/calculators/ test/utils/
git add test/converters/ test/edge_cases_validation.dart test/data/currency_data_test.dart
git commit -m "test: 重构测试结构以匹配新的代码组织

- 移除 calculators 和 utils 测试目录
- 将测试移动到 converters 目录
- 添加边界情况测试
- 更新测试导入路径

测试结构现在与源代码结构保持一致。"

# 提交 3
git add example/lib/ example/pubspec.yaml example/pubspec.lock example/README.md
git commit -m "feat(example): 添加独立的示例应用

- 创建独立的 Flutter 示例应用
- 添加示例应用的 pubspec 配置
- 添加示例应用的 README 文档

示例应用展示了如何在实际项目中使用 ConversionKit。"

# 提交 4
git add -u doc/
git add CONTRIBUTING.md doc/EDGE_CASES_TESTING.md
git commit -m "docs: 清理和重组文档

- 移除过时的研究文档
- 移除开发计划文档（已完成）
- 移除重命名报告
- 将 CONTRIBUTING.md 移到根目录
- 添加边界情况测试文档

文档现在更加简洁，只保留必要的内容。"

# 提交 5
git add .gitignore LICENSE AUTHORS README.md pubspec.yaml benchmark/conversion_benchmark.dart
git commit -m "chore: 更新项目配置和元数据

- 更新 .gitignore 添加新的忽略规则
- 更新 LICENSE 年份
- 添加 AUTHORS 文件
- 更新 README 添加新功能说明
- 更新 pubspec.yaml 依赖和版本
- 优化 benchmark 代码

这些更改改进了项目的配置和文档。"

# 提交 6
git add .github/COMMIT_CONVENTION.md .gitmessage .github/hooks/
git commit -m "chore(git): 添加提交规范和 Git hooks

- 添加提交信息规范文档
- 创建提交信息模板
- 添加 commit-msg hook 检查提交格式
- 添加 prepare-commit-msg hook 自动添加 issue 引用
- 提供 hooks 安装脚本

这些工具帮助团队保持一致的提交风格。"
```

## 注意事项

1. 在执行提交前，请先运行测试确保代码正常工作：
   ```bash
   flutter test
   ```

2. 如果某些文件不存在，请跳过相应的 `git add` 命令

3. 可以根据实际情况调整提交信息的详细描述

4. 建议在每次提交后运行 `git status` 确认提交内容正确
