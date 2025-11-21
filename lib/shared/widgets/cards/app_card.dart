import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';

/// Custom card component with consistent styling
class AppCard extends StatelessWidget {
  /// Creates an app card
  const AppCard({
    required this.child,
    this.padding,
    this.margin,
    this.elevation,
    this.color,
    this.borderRadius,
    this.onTap,
    super.key,
  });

  /// Card content
  final Widget child;

  /// Internal padding
  final EdgeInsetsGeometry? padding;

  /// External margin
  final EdgeInsetsGeometry? margin;

  /// Card elevation
  final double? elevation;

  /// Card background color
  final Color? color;

  /// Border radius
  final double? borderRadius;

  /// Tap callback (makes card interactive)
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cardContent = Container(
      padding: padding ?? const EdgeInsets.all(AppSpacing.lg),
      child: child,
    );

    final card = Card(
      elevation: elevation ?? AppElevation.sm,
      color: color ?? AppColors.surfaceLight,
      shadowColor: AppColors.shadowLight,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.md),
      ),
      margin: margin ?? const EdgeInsets.all(AppSpacing.sm),
      child: cardContent,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius ?? AppRadius.md),
        child: card,
      );
    }

    return card;
  }
}
