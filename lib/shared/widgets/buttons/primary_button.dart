import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';

/// Primary button component
/// Used for main CTAs and important actions
class PrimaryButton extends StatelessWidget {
  /// Creates a primary button
  const PrimaryButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    super.key,
  });

  /// Callback when button is pressed
  final VoidCallback? onPressed;

  /// Button label text
  final String label;

  /// Optional leading icon
  final IconData? icon;

  /// Shows loading indicator instead of label
  final bool isLoading;

  /// Makes button expand to full width
  final bool isFullWidth;

  /// Custom background color (defaults to primary)
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final buttonChild = isLoading
        ? const SizedBox(
            width: AppIconSize.sm,
            height: AppIconSize.sm,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.onPrimary),
            ),
          )
        : icon != null
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: AppIconSize.sm),
              const SizedBox(width: AppSpacing.sm),
              Text(label),
            ],
          )
        : Text(label);

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.dividerLight,
        disabledForegroundColor: AppColors.textDisabledLight,
        elevation: AppElevation.sm,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.lg,
        ),
        minimumSize: const Size(88, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        textStyle: AppTextStyles.button(),
      ),
      child: buttonChild,
    );

    if (isFullWidth) {
      return SizedBox(width: double.infinity, child: button);
    }

    return button;
  }
}
