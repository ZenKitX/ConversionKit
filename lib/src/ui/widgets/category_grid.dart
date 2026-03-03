import 'package:flutter/material.dart';
import '../../models/conversion_category.dart';

/// 类别网格样式配置
class CategoryGridStyle {
  /// 创建类别网格样式
  const CategoryGridStyle({
    this.spacing = 16,
    this.borderRadius = 12,
    this.cardColor,
    this.shadows,
    this.iconSize = 48,
    this.titleStyle,
    this.descriptionStyle,
  });

  /// 网格间距
  final double spacing;

  /// 卡片圆角
  final double borderRadius;

  /// 卡片背景色
  final Color? cardColor;

  /// 卡片阴影
  final List<BoxShadow>? shadows;

  /// 图标大小
  final double iconSize;

  /// 标题样式
  final TextStyle? titleStyle;

  /// 描述样式
  final TextStyle? descriptionStyle;
}

/// 类别网格组件
///
/// 显示所有换算类别的网格视图
class CategoryGrid extends StatelessWidget {
  /// 创建类别网格
  const CategoryGrid({
    required this.categories,
    required this.onCategorySelected,
    this.crossAxisCount = 3,
    this.style,
    super.key,
  });

  /// 类别列表
  final List<ConversionCategory> categories;

  /// 类别选择回调
  final void Function(ConversionCategory) onCategorySelected;

  /// 每行显示的列数
  final int crossAxisCount;

  /// 样式配置
  final CategoryGridStyle? style;

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = style ?? const CategoryGridStyle();
    final theme = Theme.of(context);

    return GridView.builder(
      padding: EdgeInsets.all(effectiveStyle.spacing),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: effectiveStyle.spacing,
        mainAxisSpacing: effectiveStyle.spacing,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(
          category: category,
          onTap: () => onCategorySelected(category),
          style: effectiveStyle,
          theme: theme,
        );
      },
    );
  }
}

/// 类别卡片
class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.category,
    required this.onTap,
    required this.style,
    required this.theme,
  });

  final ConversionCategory category;
  final VoidCallback onTap;
  final CategoryGridStyle style;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: style.cardColor ?? theme.cardColor,
      elevation: style.shadows != null ? 0 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(style.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(style.borderRadius),
        child: Container(
          decoration: style.shadows != null
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(style.borderRadius),
                  boxShadow: style.shadows,
                )
              : null,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getCategoryIcon(category.id),
                size: style.iconSize,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 8),
              Text(
                category.name,
                style: style.titleStyle ??
                    theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 获取类别图标
  IconData _getCategoryIcon(String categoryId) {
    switch (categoryId) {
      case 'length':
        return Icons.straighten;
      case 'area':
        return Icons.crop_square;
      case 'weight':
        return Icons.fitness_center;
      case 'temperature':
        return Icons.thermostat;
      case 'volume':
        return Icons.water_drop;
      case 'speed':
        return Icons.speed;
      case 'pressure':
        return Icons.compress;
      case 'power':
        return Icons.bolt;
      case 'number_system':
        return Icons.calculate;
      default:
        return Icons.category;
    }
  }
}
