import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';
import 'package:smartfleetpro/shared/widgets/buttons/primary_button.dart';

/// Empty state widget with optional action
class AppEmptyState extends StatelessWidget {
  /// Creates an empty state widget
  const AppEmptyState({
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  /// Empty state message
  final String message;

  /// Icon to display
  final IconData icon;

  /// Optional action button label
  final String? actionLabel;

  /// Optional action callback
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: AppIconSize.xxl,
              color: AppColors.textTertiaryLight,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTextStyles.bodyLarge(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(onPressed: onAction, label: actionLabel!),
            ],
          ],
        ),
      ),
    );
}
