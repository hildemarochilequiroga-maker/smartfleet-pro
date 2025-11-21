import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';
import 'package:smartfleetpro/shared/widgets/cards/app_card.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppCard)
Widget cardDefault(BuildContext context) => Center(
    child: AppCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Card Title', style: AppTextStyles.heading3()),
          const SizedBox(height: 8),
          Text(
            'This is a simple card with default styling.',
            style: AppTextStyles.bodyMedium(
              color: AppColors.textSecondaryLight,
            ),
          ),
        ],
      ),
    ),
  );

@widgetbook.UseCase(name: 'Interactive', type: AppCard)
Widget cardInteractive(BuildContext context) => Center(
    child: AppCard(
      onTap: () {
        debugPrint('Card tapped');
      },
      child: Row(
        children: [
          const Icon(Icons.notifications, color: AppColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Notification', style: AppTextStyles.heading4()),
                const SizedBox(height: 4),
                Text(
                  'Tap this card to see interaction',
                  style: AppTextStyles.bodyMedium(
                    color: AppColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.textTertiaryLight),
        ],
      ),
    ),
  );

@widgetbook.UseCase(name: 'With Custom Color', type: AppCard)
Widget cardCustomColor(BuildContext context) => Center(
    child: AppCard(
      color: AppColors.primaryLight,
      child: Text(
        'Custom colored card',
        style: AppTextStyles.bodyLarge(color: AppColors.primary),
      ),
    ),
  );

@widgetbook.UseCase(name: 'Elevated', type: AppCard)
Widget cardElevated(BuildContext context) => Center(
    child: AppCard(
      elevation: AppElevation.lg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.info_outline, size: 48, color: AppColors.info),
          const SizedBox(height: 12),
          Text('Elevated Card', style: AppTextStyles.heading3()),
          const SizedBox(height: 8),
          Text(
            'This card has higher elevation',
            style: AppTextStyles.bodyMedium(
              color: AppColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
