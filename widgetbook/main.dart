import 'package:flutter/material.dart';
import 'package:smartfleetpro/shared/theme/app_theme.dart';
import 'package:smartfleetpro/shared/widgets/buttons/app_text_button.dart';
import 'package:smartfleetpro/shared/widgets/buttons/primary_button.dart';
import 'package:smartfleetpro/shared/widgets/buttons/secondary_button.dart';
import 'package:smartfleetpro/shared/widgets/cards/app_card.dart';
import 'package:smartfleetpro/shared/widgets/feedback/app_empty_state.dart';
import 'package:smartfleetpro/shared/widgets/feedback/app_error_widget.dart';
import 'package:smartfleetpro/shared/widgets/feedback/app_loading_indicator.dart';
import 'package:smartfleetpro/shared/widgets/inputs/app_text_field.dart';

void main() {
  runApp(const WidgetbookApp());
}

/// Widgetbook showcase application
class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'SmartFleet Pro - Design System',
    theme: AppTheme.lightTheme,
    darkTheme: AppTheme.darkTheme,
    debugShowCheckedModeBanner: false,
    home: const WidgetbookHome(),
  );
}

/// Home screen with component showcase
class WidgetbookHome extends StatefulWidget {
  const WidgetbookHome({super.key});

  @override
  State<WidgetbookHome> createState() => _WidgetbookHomeState();
}

class _WidgetbookHomeState extends State<WidgetbookHome> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ButtonsShowcase(),
    InputsShowcase(),
    CardsShowcase(),
    FeedbackShowcase(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('SmartFleet Pro Design System'),
      actions: [
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: () {
            // Toggle theme (simplified)
          },
        ),
      ],
    ),
    body: _pages[_selectedIndex],
    bottomNavigationBar: NavigationBar(
      selectedIndex: _selectedIndex,
      onDestinationSelected: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.smart_button), label: 'Buttons'),
        NavigationDestination(icon: Icon(Icons.input), label: 'Inputs'),
        NavigationDestination(
          icon: Icon(Icons.card_membership),
          label: 'Cards',
        ),
        NavigationDestination(icon: Icon(Icons.feedback), label: 'Feedback'),
      ],
    ),
  );
}

/// Buttons showcase page
class ButtonsShowcase extends StatelessWidget {
  const ButtonsShowcase({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text('Primary Buttons', style: TextStyle(fontSize: 20)),
      const SizedBox(height: 16),
      PrimaryButton(onPressed: () {}, label: 'Default'),
      const SizedBox(height: 8),
      PrimaryButton(onPressed: () {}, label: 'With Icon', icon: Icons.add),
      const SizedBox(height: 8),
      PrimaryButton(onPressed: () {}, label: 'Loading', isLoading: true),
      const SizedBox(height: 24),
      const Text('Secondary Buttons', style: TextStyle(fontSize: 20)),
      const SizedBox(height: 16),
      SecondaryButton(onPressed: () {}, label: 'Default'),
      const SizedBox(height: 8),
      SecondaryButton(onPressed: () {}, label: 'Cancel', icon: Icons.close),
      const SizedBox(height: 24),
      const Text('Text Buttons', style: TextStyle(fontSize: 20)),
      const SizedBox(height: 16),
      AppTextButton(onPressed: () {}, label: 'Text Button'),
      AppTextButton(onPressed: () {}, label: 'Underlined', isUnderlined: true),
    ],
  );
}

/// Inputs showcase page
class InputsShowcase extends StatelessWidget {
  const InputsShowcase({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: const [
      Text('Text Fields', style: TextStyle(fontSize: 20)),
      SizedBox(height: 16),
      AppTextField(label: 'Email', hintText: 'Enter your email'),
      SizedBox(height: 16),
      AppTextField(
        label: 'Password',
        obscureText: true,
        prefixIcon: Icons.lock,
      ),
      SizedBox(height: 16),
      AppTextField(label: 'Error State', errorText: 'This field is required'),
    ],
  );
}

/// Cards showcase page
class CardsShowcase extends StatelessWidget {
  const CardsShowcase({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text('Cards', style: TextStyle(fontSize: 20)),
      const SizedBox(height: 16),
      const AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Default Card', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('This is a card with default styling'),
          ],
        ),
      ),
      AppCard(onTap: () {}, child: const Text('Interactive Card (tap me)')),
    ],
  );
}

/// Feedback showcase page
class FeedbackShowcase extends StatelessWidget {
  const FeedbackShowcase({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      const Text('Feedback Components', style: TextStyle(fontSize: 20)),
      const SizedBox(height: 16),
      const AppLoadingIndicator(message: 'Loading...'),
      const SizedBox(height: 32),
      AppErrorWidget(message: 'Something went wrong', onRetry: () {}),
      const SizedBox(height: 32),
      AppEmptyState(
        message: 'No items found',
        actionLabel: 'Add Item',
        onAction: () {},
      ),
    ],
  );
}
