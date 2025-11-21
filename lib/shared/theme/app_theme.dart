import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';

/// Application theme configuration with Material Design 3
class AppTheme {
  AppTheme._();

  /// Light theme configuration
  static ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,

      // ============ Color Scheme ============
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.onPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondaryLight,
        onSecondaryContainer: AppColors.onSecondary,
        tertiary: AppColors.info,
        onTertiary: AppColors.onInfo,
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: AppColors.errorLight,
        onErrorContainer: AppColors.onError,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.onSurfaceLight,
        surfaceContainerHighest: AppColors.surfaceVariantLight,
        outline: AppColors.borderLight,
        outlineVariant: AppColors.dividerLight,
        shadow: AppColors.shadowLight,
        scrim: AppColors.overlayLight,
      ),

      // ============ Scaffold ============
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundLight,

      // ============ AppBar ============
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: AppElevation.sm,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTextStyles.heading3(color: AppColors.onPrimary),
        toolbarHeight: 56,
        iconTheme: const IconThemeData(
          color: AppColors.onPrimary,
          size: AppIconSize.md,
        ),
      ),

      // ============ Elevated Button ============
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
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
      ),

      // ============ Text Button ============
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          minimumSize: const Size(48, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          textStyle: AppTextStyles.button(),
        ),
      ),

      // ============ Outlined Button ============
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
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
      ),

      // ============ Input Decoration ============
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.dividerLight),
        ),
        labelStyle: AppTextStyles.inputLabel(
          color: AppColors.textSecondaryLight,
        ),
        hintStyle: AppTextStyles.bodyMedium(color: AppColors.textTertiaryLight),
        errorStyle: AppTextStyles.inputError(),
        helperStyle: AppTextStyles.caption(color: AppColors.textSecondaryLight),
      ),

      // ============ Card ============
      cardTheme: CardThemeData(
        elevation: AppElevation.sm,
        color: AppColors.surfaceLight,
        shadowColor: AppColors.shadowLight,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        margin: const EdgeInsets.all(AppSpacing.sm),
      ),

      // ============ Divider ============
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
        space: 1,
      ),

      // ============ Icon ============
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryLight,
        size: AppIconSize.md,
      ),

      // ============ Chip ============
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariantLight,
        deleteIconColor: AppColors.textSecondaryLight,
        disabledColor: AppColors.dividerLight,
        selectedColor: AppColors.primaryLight,
        secondarySelectedColor: AppColors.secondaryLight,
        labelPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        labelStyle: AppTextStyles.captionMedium(),
        secondaryLabelStyle: AppTextStyles.captionMedium(),
        brightness: Brightness.light,
      ),

      // ============ Dialog ============
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceLight,
        elevation: AppElevation.lg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        titleTextStyle: AppTextStyles.heading3(
          color: AppColors.textPrimaryLight,
        ),
        contentTextStyle: AppTextStyles.bodyMedium(
          color: AppColors.textSecondaryLight,
        ),
      ),

      // ============ Bottom Sheet ============
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceLight,
        elevation: AppElevation.lg,
        modalElevation: AppElevation.xl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.lg),
          ),
        ),
      ),

      // ============ Snackbar ============
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        contentTextStyle: AppTextStyles.bodyMedium(
          color: AppColors.onSurfaceDark,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
        ),
        behavior: SnackBarBehavior.floating,
        elevation: AppElevation.md,
      ),

      // ============ Progress Indicator ============
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.dividerLight,
        circularTrackColor: AppColors.dividerLight,
      ),

      // ============ Switch ============
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textTertiaryLight;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primaryLight;
          }
          return AppColors.dividerLight;
        }),
      ),

      // ============ Checkbox ============
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.onPrimary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.xs),
        ),
      ),

      // ============ Radio ============
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textSecondaryLight;
        }),
      ),

      // ============ Floating Action Button ============
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: AppElevation.md,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
      ),

      // ============ Navigation Bar ============
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        indicatorColor: AppColors.primaryLight,
        elevation: AppElevation.sm,
        labelTextStyle: WidgetStateProperty.all(
          AppTextStyles.caption(color: AppColors.textSecondaryLight),
        ),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary);
          }
          return const IconThemeData(color: AppColors.textSecondaryLight);
        }),
      ),

      // ============ Text Theme ============
      textTheme: TextTheme(
        displayLarge: AppTextStyles.heading1(),
        displayMedium: AppTextStyles.heading2(),
        displaySmall: AppTextStyles.heading3(),
        headlineMedium: AppTextStyles.heading3(),
        headlineSmall: AppTextStyles.heading4(),
        titleLarge: AppTextStyles.heading3(),
        titleMedium: AppTextStyles.heading4(),
        titleSmall: AppTextStyles.bodyLargeMedium(),
        bodyLarge: AppTextStyles.bodyLarge(),
        bodyMedium: AppTextStyles.bodyMedium(),
        bodySmall: AppTextStyles.caption(),
        labelLarge: AppTextStyles.button(),
        labelMedium: AppTextStyles.captionMedium(),
        labelSmall: AppTextStyles.caption(),
      ),
    );

  /// Dark theme configuration
  static ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,

      // ============ Color Scheme ============
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryLight,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primary,
        onPrimaryContainer: AppColors.onPrimary,
        secondary: AppColors.secondaryLight,
        onSecondary: AppColors.onSecondary,
        secondaryContainer: AppColors.secondary,
        onSecondaryContainer: AppColors.onSecondary,
        tertiary: AppColors.infoLight,
        onTertiary: AppColors.onInfo,
        error: AppColors.errorLight,
        onError: AppColors.onError,
        errorContainer: AppColors.error,
        onErrorContainer: AppColors.onError,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.onSurfaceDark,
        surfaceContainerHighest: AppColors.surfaceVariantDark,
        outline: AppColors.borderDark,
        outlineVariant: AppColors.dividerDark,
        shadow: AppColors.shadowDark,
        scrim: AppColors.overlayDark,
      ),

      // ============ Scaffold ============
      scaffoldBackgroundColor: AppColors.scaffoldBackgroundDark,

      // ============ AppBar ============
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: AppElevation.sm,
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.onSurfaceDark,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTextStyles.heading3(color: AppColors.onSurfaceDark),
        toolbarHeight: 56,
        iconTheme: const IconThemeData(
          color: AppColors.onSurfaceDark,
          size: AppIconSize.md,
        ),
      ),

      // ============ Card ============
      cardTheme: CardThemeData(
        elevation: AppElevation.sm,
        color: AppColors.surfaceDark,
        shadowColor: AppColors.shadowDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        margin: const EdgeInsets.all(AppSpacing.sm),
      ),

      // ============ Divider ============
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),

      // ============ Icon ============
      iconTheme: const IconThemeData(
        color: AppColors.textPrimaryDark,
        size: AppIconSize.md,
      ),

      // ============ Input Decoration ============
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariantDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.errorLight),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.sm),
          borderSide: const BorderSide(color: AppColors.errorLight, width: 2),
        ),
        labelStyle: AppTextStyles.inputLabel(
          color: AppColors.textSecondaryDark,
        ),
        hintStyle: AppTextStyles.bodyMedium(color: AppColors.textTertiaryDark),
        errorStyle: AppTextStyles.inputError(color: AppColors.errorLight),
      ),

      // ============ Text Theme ============
      textTheme: TextTheme(
        displayLarge: AppTextStyles.heading1(color: AppColors.textPrimaryDark),
        displayMedium: AppTextStyles.heading2(color: AppColors.textPrimaryDark),
        displaySmall: AppTextStyles.heading3(color: AppColors.textPrimaryDark),
        headlineMedium: AppTextStyles.heading3(
          color: AppColors.textPrimaryDark,
        ),
        headlineSmall: AppTextStyles.heading4(color: AppColors.textPrimaryDark),
        titleLarge: AppTextStyles.heading3(color: AppColors.textPrimaryDark),
        titleMedium: AppTextStyles.heading4(color: AppColors.textPrimaryDark),
        titleSmall: AppTextStyles.bodyLargeMedium(
          color: AppColors.textPrimaryDark,
        ),
        bodyLarge: AppTextStyles.bodyLarge(color: AppColors.textPrimaryDark),
        bodyMedium: AppTextStyles.bodyMedium(
          color: AppColors.textSecondaryDark,
        ),
        bodySmall: AppTextStyles.caption(color: AppColors.textTertiaryDark),
        labelLarge: AppTextStyles.button(),
        labelMedium: AppTextStyles.captionMedium(),
        labelSmall: AppTextStyles.caption(),
      ),
    );
}
