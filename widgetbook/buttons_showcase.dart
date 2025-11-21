import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/widgets/buttons/app_text_button.dart';
import 'package:smartfleetpro/shared/widgets/buttons/primary_button.dart';
import 'package:smartfleetpro/shared/widgets/buttons/secondary_button.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: PrimaryButton)
Widget primaryButtonDefault(BuildContext context) => Center(
    child: PrimaryButton(onPressed: () {}, label: 'Primary Button'),
  );

@widgetbook.UseCase(name: 'With Icon', type: PrimaryButton)
Widget primaryButtonWithIcon(BuildContext context) => Center(
    child: PrimaryButton(onPressed: () {}, label: 'Add Item', icon: Icons.add),
  );

@widgetbook.UseCase(name: 'Loading', type: PrimaryButton)
Widget primaryButtonLoading(BuildContext context) => Center(
    child: PrimaryButton(
      onPressed: () {},
      label: 'Loading...',
      isLoading: true,
    ),
  );

@widgetbook.UseCase(name: 'Disabled', type: PrimaryButton)
Widget primaryButtonDisabled(BuildContext context) => const Center(
    child: PrimaryButton(onPressed: null, label: 'Disabled Button'),
  );

@widgetbook.UseCase(name: 'Full Width', type: PrimaryButton)
Widget primaryButtonFullWidth(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: PrimaryButton(
      onPressed: () {},
      label: 'Full Width Button',
      isFullWidth: true,
    ),
  );

@widgetbook.UseCase(name: 'Default', type: SecondaryButton)
Widget secondaryButtonDefault(BuildContext context) => Center(
    child: SecondaryButton(onPressed: () {}, label: 'Secondary Button'),
  );

@widgetbook.UseCase(name: 'With Icon', type: SecondaryButton)
Widget secondaryButtonWithIcon(BuildContext context) => Center(
    child: SecondaryButton(
      onPressed: () {},
      label: 'Cancel',
      icon: Icons.close,
    ),
  );

@widgetbook.UseCase(name: 'Loading', type: SecondaryButton)
Widget secondaryButtonLoading(BuildContext context) => Center(
    child: SecondaryButton(
      onPressed: () {},
      label: 'Processing...',
      isLoading: true,
    ),
  );

@widgetbook.UseCase(name: 'Default', type: AppTextButton)
Widget textButtonDefault(BuildContext context) => Center(
    child: AppTextButton(onPressed: () {}, label: 'Text Button'),
  );

@widgetbook.UseCase(name: 'With Underline', type: AppTextButton)
Widget textButtonUnderlined(BuildContext context) => Center(
    child: AppTextButton(
      onPressed: () {},
      label: 'Learn More',
      isUnderlined: true,
    ),
  );

@widgetbook.UseCase(name: 'With Icon', type: AppTextButton)
Widget textButtonWithIcon(BuildContext context) => Center(
    child: AppTextButton(
      onPressed: () {},
      label: 'Settings',
      icon: Icons.settings,
    ),
  );

@widgetbook.UseCase(name: 'Custom Color', type: AppTextButton)
Widget textButtonCustomColor(BuildContext context) => Center(
    child: AppTextButton(
      onPressed: () {},
      label: 'Danger Action',
      color: AppColors.error,
    ),
  );
