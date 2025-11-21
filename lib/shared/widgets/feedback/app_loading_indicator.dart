import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';

/// Loading indicator component
class AppLoadingIndicator extends StatelessWidget {
  /// Creates a loading indicator
  const AppLoadingIndicator({
    this.message,
    this.size = 48.0,
    this.color,
    super.key,
  });

  /// Optional loading message
  final String? message;

  /// Indicator size
  final double size;

  /// Indicator color
  final Color? color;

  @override
  Widget build(BuildContext context) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(
                color ?? AppColors.primary,
              ),
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Text(
              message!,
              style: AppTextStyles.bodyMedium(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
}
