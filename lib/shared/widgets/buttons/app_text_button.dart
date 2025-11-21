import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';

/// Text button component
/// Used for tertiary actions and inline links
class AppTextButton extends StatelessWidget {
  /// Creates a text button
  const AppTextButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.color,
    this.isUnderlined = false,
    super.key,
  });

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Button label text
  final String label;

  /// Optional leading icon
  final IconData? icon;

  /// Custom text color (defaults to primary)
  final Color? color;

  /// Show underline decoration
  final bool isUnderlined;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;

    final buttonChild = icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: AppIconSize.sm),
              const SizedBox(width: AppSpacing.xs),
              Text(
                label,
                style: isUnderlined
                    ? const TextStyle(decoration: TextDecoration.underline)
                    : null,
              ),
            ],
          )
        : Text(
            label,
            style: isUnderlined
                ? const TextStyle(decoration: TextDecoration.underline)
                : null,
          );

    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: buttonColor,
        disabledForegroundColor: AppColors.textDisabledLight,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        minimumSize: const Size(48, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
        textStyle: AppTextStyles.button(),
      ),
      child: buttonChild,
    );
  }
}
