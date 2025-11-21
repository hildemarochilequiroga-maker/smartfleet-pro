import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';

/// Secondary button component
/// Used for secondary actions and cancel buttons
class SecondaryButton extends StatelessWidget {
  /// Creates a secondary button
  const SecondaryButton({
    required this.onPressed,
    required this.label,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.color,
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

  /// Custom border/text color (defaults to primary)
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;

    final buttonChild = isLoading
        ? SizedBox(
            width: AppIconSize.sm,
            height: AppIconSize.sm,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
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

    final button = OutlinedButton(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: buttonColor,
        disabledForegroundColor: AppColors.textDisabledLight,
        side: BorderSide(color: buttonColor, width: 1.5),
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
