import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:conversion_kit/src/models/conversion_category.dart';
import 'package:conversion_kit/src/ui/widgets/category_grid.dart';

void main() {
  group('CategoryGrid', () {
    final testCategories = <ConversionCategory>[
      const ConversionCategory(
        id: 'length',
        name: '长度',
        units: [],
      ),
      const ConversionCategory(
        id: 'area',
        name: '面积',
        units: [],
      ),
      const ConversionCategory(
        id: 'weight',
        name: '重量',
        units: [],
      ),
    ];

    testWidgets('应该显示所有类别', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryGrid(
              categories: testCategories,
              onCategorySelected: (_) {},
            ),
          ),
        ),
      );

      // 验证所有类别都显示
      expect(find.text('长度'), findsOneWidget);
      expect(find.text('面积'), findsOneWidget);
      expect(find.text('重量'), findsOneWidget);
    });

    testWidgets('点击类别应该触发回调', (tester) async {
      ConversionCategory? selectedCategory;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryGrid(
              categories: testCategories,
              onCategorySelected: (category) {
                selectedCategory = category;
              },
            ),
          ),
        ),
      );

      // 点击第一个类别
      await tester.tap(find.text('长度'));
      await tester.pumpAndSettle();

      // 验证回调被触发
      expect(selectedCategory, isNotNull);
      expect(selectedCategory?.id, equals('length'));
    });

    testWidgets('应该使用自定义列数', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryGrid(
              categories: testCategories,
              onCategorySelected: (_) {},
              crossAxisCount: 2,
            ),
          ),
        ),
      );

      // 验证网格正常显示
      expect(find.byType(GridView), findsOneWidget);
    });

    testWidgets('应该应用自定义样式', (tester) async {
      const customStyle = CategoryGridStyle(
        spacing: 20.0,
        borderRadius: 16.0,
        iconSize: 64.0,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryGrid(
              categories: testCategories,
              onCategorySelected: (_) {},
              style: customStyle,
            ),
          ),
        ),
      );

      // 验证组件正常渲染
      expect(find.byType(CategoryGrid), findsOneWidget);
    });

    testWidgets('空类别列表应该正常显示', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CategoryGrid(
              categories: const [],
              onCategorySelected: (_) {},
            ),
          ),
        ),
      );

      // 验证不会崩溃
      expect(find.byType(GridView), findsOneWidget);
    });
  });

  group('CategoryGridStyle', () {
    test('应该使用默认值', () {
      const style = CategoryGridStyle();

      expect(style.spacing, equals(16.0));
      expect(style.borderRadius, equals(12.0));
      expect(style.iconSize, equals(48.0));
      expect(style.cardColor, isNull);
      expect(style.shadows, isNull);
      expect(style.titleStyle, isNull);
      expect(style.descriptionStyle, isNull);
    });

    test('应该使用自定义值', () {
      const style = CategoryGridStyle(
        spacing: 20.0,
        borderRadius: 16.0,
        iconSize: 64.0,
        cardColor: Colors.blue,
      );

      expect(style.spacing, equals(20.0));
      expect(style.borderRadius, equals(16.0));
      expect(style.iconSize, equals(64.0));
      expect(style.cardColor, equals(Colors.blue));
    });
  });
}
