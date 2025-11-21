import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/widgets/feedback/app_empty_state.dart';
import 'package:smartfleetpro/shared/widgets/feedback/app_error_widget.dart';
import 'package:smartfleetpro/shared/widgets/feedback/app_loading_indicator.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(name: 'Default', type: AppLoadingIndicator)
Widget loadingDefault(BuildContext context) => const AppLoadingIndicator();

@widgetbook.UseCase(name: 'With Message', type: AppLoadingIndicator)
Widget loadingWithMessage(BuildContext context) => const AppLoadingIndicator(message: 'Loading vehicles...');

@widgetbook.UseCase(name: 'Large', type: AppLoadingIndicator)
Widget loadingLarge(BuildContext context) => const AppLoadingIndicator(message: 'Please wait', size: 64);

@widgetbook.UseCase(name: 'Default', type: AppErrorWidget)
Widget errorDefault(BuildContext context) => AppErrorWidget(
    message: 'Unable to load data. Please check your connection.',
    onRetry: () {
      debugPrint('Retry tapped');
    },
  );

@widgetbook.UseCase(name: 'Without Retry', type: AppErrorWidget)
Widget errorWithoutRetry(BuildContext context) => const AppErrorWidget(
    message: 'This feature is not available at the moment.',
  );

@widgetbook.UseCase(name: 'Network Error', type: AppErrorWidget)
Widget errorNetwork(BuildContext context) => AppErrorWidget(
    message: 'No internet connection. Please try again.',
    onRetry: () {
      debugPrint('Retry tapped');
    },
    retryLabel: 'Try Again',
  );

@widgetbook.UseCase(name: 'Default', type: AppEmptyState)
Widget emptyDefault(BuildContext context) => const AppEmptyState(message: 'No items found');

@widgetbook.UseCase(name: 'With Action', type: AppEmptyState)
Widget emptyWithAction(BuildContext context) => AppEmptyState(
    message: 'No vehicles registered yet',
    icon: Icons.directions_car_outlined,
    actionLabel: 'Add Vehicle',
    onAction: () {
      debugPrint('Add vehicle tapped');
    },
  );

@widgetbook.UseCase(name: 'Custom Icon', type: AppEmptyState)
Widget emptyCustomIcon(BuildContext context) => const AppEmptyState(
    message: 'No notifications',
    icon: Icons.notifications_none,
  );
