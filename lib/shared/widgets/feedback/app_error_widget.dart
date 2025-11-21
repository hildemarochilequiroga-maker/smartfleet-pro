import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';
import 'package:smartfleetpro/shared/widgets/buttons/primary_button.dart';

/// Error state widget with retry option
class AppErrorWidget extends StatelessWidget {
  /// Creates an error widget
  const AppErrorWidget({
    required this.message,
    this.onRetry,
    this.retryLabel = 'Reintentar',
    super.key,
  });

  /// Error message
  final String message;

  /// Retry callback
  final VoidCallback? onRetry;

  /// Retry button label
  final String retryLabel;

  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppIconSize.xxl,
              color: AppColors.error,
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Algo salió mal',
              style: AppTextStyles.heading3(color: AppColors.textPrimaryLight),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              message,
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppSpacing.xl),
              PrimaryButton(
                onPressed: onRetry,
                label: retryLabel,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
}
