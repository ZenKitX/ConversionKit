# Git 规范快速设置指南

## 一键安装（推荐）

### Windows (PowerShell)

```powershell
# 运行安装脚本
.\.github\hooks\install-hooks.ps1

# 验证安装
git config --get commit.template
```

### macOS/Linux (Bash)

```bash
# 添加执行权限
chmod +x .github/hooks/install-hooks.sh

# 运行安装脚本
bash .github/hooks/install-hooks.sh

# 验证安装
git config --get commit.template
```

## 手动安装

如果自动安装脚本失败，可以手动执行以下步骤：

### 1. 配置提交模板

```bash
git config commit.template .gitmessage
```

### 2. 安装 Git Hooks

**Windows (PowerShell):**
```powershell
# 复制 hooks
Copy-Item -Path .github/hooks/commit-msg -Destination .git/hooks/commit-msg -Force
Copy-Item -Path .github/hooks/prepare-commit-msg -Destination .git/hooks/prepare-commit-msg -Force
```

**macOS/Linux:**
```bash
# 复制 hooks
cp .github/hooks/commit-msg .git/hooks/commit-msg
cp .github/hooks/prepare-commit-msg .git/hooks/prepare-commit-msg

# 添加执行权限
chmod +x .git/hooks/commit-msg
chmod +x .git/hooks/prepare-commit-msg
```

## 验证安装

### 测试提交模板

```bash
# 创建一个测试提交（不要真的提交）
git commit

# 你应该看到提交模板内容
# 按 Ctrl+C 或 :q 退出
```

### 测试 Commit Hook

```bash
# 尝试一个不符合规范的提交
git commit --allow-empty -m "test"

# 应该看到错误提示：
# ❌ 提交信息格式错误！
```

```bash
# 尝试一个符合规范的提交
git commit --allow-empty -m "test: 测试提交规范"

# 应该看到成功提示：
# ✅ 提交信息格式正确
```

## 使用指南

### 基本提交流程

1. **暂存更改**
   ```bash
   git add <files>
   ```

2. **提交更改**
   ```bash
   git commit
   ```

3. **编写提交信息**
   - 编辑器会自动打开，显示提交模板
   - 按照模板填写提交信息
   - 保存并关闭编辑器

4. **自动检查**
   - commit-msg hook 会自动检查格式
   - 如果格式不正确，提交会被拒绝
   - 修改后重新提交

### 快速提交（命令行）

```bash
# 简单提交
git commit -m "feat(converter): 添加温度转换功能"

# 带详细描述的提交
git commit -m "feat(converter): 添加温度转换功能" -m "- 支持摄氏度、华氏度、开尔文互转
- 添加温度转换测试
- 更新文档"
```

### 跳过 Hook 检查

在特殊情况下（不推荐），可以跳过 hook 检查：

```bash
git commit --no-verify -m "your message"
```

## 提交信息格式

### 基本格式

```
<类型>(<范围>): <简短描述>

[详细描述]

[Footer]
```

### 类型列表

| 类型 | 说明 |
|------|------|
| `feat` | 新功能 |
| `fix` | 修复 bug |
| `docs` | 文档变更 |
| `style` | 代码格式 |
| `refactor` | 重构 |
| `perf` | 性能优化 |
| `test` | 测试相关 |
| `chore` | 构建/工具变动 |
| `build` | 构建系统 |
| `ci` | CI 配置 |

### 示例

```text
feat(converter): 添加温度转换功能

- 支持摄氏度、华氏度、开尔文互转
- 实现特殊的温度转换算法
- 添加完整的单元测试

这个功能扩展了转换器的能力，满足了用户对温度转换的需求。

Closes #42
```

## 常见问题

### Q1: 提交模板没有显示？

**A:** 检查配置是否正确：
```bash
git config --get commit.template
# 应该输出：.gitmessage
```

如果没有输出，重新配置：
```bash
git config commit.template .gitmessage
```

### Q2: Hook 没有执行？

**A:** 检查 hook 文件是否存在且有执行权限：

**Windows:**
```powershell
Test-Path .git/hooks/commit-msg
# 应该输出：True
```

**macOS/Linux:**
```bash
ls -la .git/hooks/commit-msg
# 应该看到 -rwxr-xr-x（有执行权限）
```

如果没有执行权限：
```bash
chmod +x .git/hooks/commit-msg
chmod +x .git/hooks/prepare-commit-msg
```

### Q3: 如何临时禁用 Hook？

**A:** 使用 `--no-verify` 参数：
```bash
git commit --no-verify -m "your message"
```

### Q4: 如何卸载？

**A:** 删除 hooks 和配置：
```bash
# 删除 hooks
rm .git/hooks/commit-msg
rm .git/hooks/prepare-commit-msg

# 取消提交模板配置
git config --unset commit.template
```

## 下一步

1. ✅ 安装完成后，阅读完整的提交规范：`.github/COMMIT_CONVENTION.md`
2. ✅ 查看当前更改的提交建议：`COMMIT_SUGGESTIONS.md`
3. ✅ 查看提交历史分析：`GIT_HISTORY_ANALYSIS.md`
4. ✅ 开始使用规范化的提交流程

## 获取帮助

- 查看提交规范：`.github/COMMIT_CONVENTION.md`
- 查看 Hook 文档：`.github/hooks/README.md`
- 提交建议文档：`COMMIT_SUGGESTIONS.md`
- 历史分析文档：`GIT_HISTORY_ANALYSIS.md`

## 团队协作

确保所有团队成员都：

1. 安装了 Git hooks
2. 配置了提交模板
3. 阅读了提交规范
4. 理解了提交原则

这样可以保持整个团队的提交风格一致，提高代码审查效率。
