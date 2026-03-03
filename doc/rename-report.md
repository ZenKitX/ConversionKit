重命名完成
已成功将 zen_convert 重命名为 conversion_kit，所有修改如下：

文件夹重命名：zen_convert/ → conversion_kit/
主库文件重命名：zen_convert.dart → conversion_kit.dart
更新 pubspec.yaml 中的包名、描述和 URLs
更新 README.md 中所有引用（包名、import 语句、示例代码）
更新 CHANGELOG.md 中的 GitHub 链接
更新 
example.dart
 中的 import 语句和标题
更新所有测试文件（5个）中的 import 语句
重命名 .iml 文件：zen_convert.iml → conversion_kit.iml
重命名调研文档：zen-convert-research.md → conversion-kit-research.md
更新调研文档中所有项目名称和引用
运行结果：

flutter pub get ✅ 成功
flutter test ✅ 所有 63 个测试通过
flutter analyze ✅ 无问题