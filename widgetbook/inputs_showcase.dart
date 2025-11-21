import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/widgets/inputs/app_text_field.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppTextField)
Widget textFieldDefault(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: AppTextField(label: 'Email', hintText: 'Enter your email'),
  );

@widgetbook.UseCase(name: 'With Icon', type: AppTextField)
Widget textFieldWithIcon(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: AppTextField(
      label: 'Search',
      hintText: 'Search vehicles...',
      prefixIcon: Icons.search,
    ),
  );

@widgetbook.UseCase(name: 'Password', type: AppTextField)
Widget textFieldPassword(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: AppTextField(
      label: 'Password',
      hintText: 'Enter your password',
      obscureText: true,
      prefixIcon: Icons.lock,
    ),
  );

@widgetbook.UseCase(name: 'With Helper Text', type: AppTextField)
Widget textFieldWithHelper(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: AppTextField(
      label: 'Username',
      hintText: 'Enter username',
      helperText: 'Minimum 4 characters',
    ),
  );

@widgetbook.UseCase(name: 'With Error', type: AppTextField)
Widget textFieldWithError(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: AppTextField(
      label: 'Email',
      hintText: 'Enter your email',
      errorText: 'Invalid email address',
      prefixIcon: Icons.email,
    ),
  );

@widgetbook.UseCase(name: 'Disabled', type: AppTextField)
Widget textFieldDisabled(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: AppTextField(
      label: 'Disabled Field',
      hintText: 'Cannot edit',
      enabled: false,
    ),
  );

@widgetbook.UseCase(name: 'Multiline', type: AppTextField)
Widget textFieldMultiline(BuildContext context) => const Padding(
    padding: EdgeInsets.all(16),
    child: AppTextField(
      label: 'Description',
      hintText: 'Enter description...',
      maxLines: 4,
    ),
  );
