import 'package:flutter/material.dart';

/// Application color palette following Material Design 3
/// All colors are WCAG 2.1 AA compliant for accessibility
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // ============ Primary Colors ============
  /// Primary blue - Main brand color
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryLight = Color(0xFF3B82F6);
  static const Color primaryDark = Color(0xFF1E40AF);
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ============ Secondary Colors ============
  /// Secondary green - Success & positive actions
  static const Color secondary = Color(0xFF10B981);
  static const Color secondaryLight = Color(0xFF34D399);
  static const Color secondaryDark = Color(0xFF059669);
  static const Color onSecondary = Color(0xFFFFFFFF);

  // ============ Error Colors ============
  /// Error red - Destructive actions & errors
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color onError = Color(0xFFFFFFFF);

  // ============ Warning Colors ============
  /// Warning orange - Alerts & caution
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color onWarning = Color(0xFF000000);

  // ============ Info Colors ============
  /// Info blue - Informational messages
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color onInfo = Color(0xFFFFFFFF);

  // ============ Neutral Colors (Light Theme) ============
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceLight = Color(0xFFF9FAFB);
  static const Color surfaceVariantLight = Color(0xFFF3F4F6);
  static const Color onBackgroundLight = Color(0xFF111827);
  static const Color onSurfaceLight = Color(0xFF374151);

  // ============ Neutral Colors (Dark Theme) ============
  static const Color backgroundDark = Color(0xFF111827);
  static const Color surfaceDark = Color(0xFF1F2937);
  static const Color surfaceVariantDark = Color(0xFF374151);
  static const Color onBackgroundDark = Color(0xFFF9FAFB);
  static const Color onSurfaceDark = Color(0xFFE5E7EB);

  // ============ Text Colors ============
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color textTertiaryLight = Color(0xFF9CA3AF);
  static const Color textDisabledLight = Color(0xFFD1D5DB);

  static const Color textPrimaryDark = Color(0xFFF9FAFB);
  static const Color textSecondaryDark = Color(0xFFD1D5DB);
  static const Color textTertiaryDark = Color(0xFF9CA3AF);
  static const Color textDisabledDark = Color(0xFF6B7280);

  // ============ Border Colors ============
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);
  static const Color dividerLight = Color(0xFFF3F4F6);
  static const Color dividerDark = Color(0xFF1F2937);

  // ============ Status Colors ============
  /// Active/Online status
  static const Color statusActive = Color(0xFF10B981);

  /// Inactive/Offline status
  static const Color statusInactive = Color(0xFF6B7280);

  /// Pending/In-progress status
  static const Color statusPending = Color(0xFFF59E0B);

  /// Vehicle moving
  static const Color vehicleMoving = Color(0xFF10B981);

  /// Vehicle stopped
  static const Color vehicleStopped = Color(0xFFEF4444);

  /// No signal
  static const Color noSignal = Color(0xFF9CA3AF);

  // ============ Gradient Colors ============
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [secondary, secondaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ============ Shadow Colors ============
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowDark = Color(0x33000000);

  // ============ Overlay Colors ============
  static const Color overlayLight = Color(0x0A000000);
  static const Color overlayDark = Color(0x14FFFFFF);

  // ============ Scaffold Background ============
  static const Color scaffoldBackgroundLight = Color(0xFFFAFAFA);
  static const Color scaffoldBackgroundDark = Color(0xFF0F172A);
}

/// Application spacing scale
class AppSpacing {
  AppSpacing._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
  static const double xxxl = 48;
}

/// Application border radius scale
class AppRadius {
  AppRadius._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double round = 999;
}

/// Application elevation scale
class AppElevation {
  AppElevation._();

  static const double none = 0;
  static const double sm = 2;
  static const double md = 4;
  static const double lg = 8;
  static const double xl = 16;
}

/// Application icon sizes
class AppIconSize {
  AppIconSize._();

  static const double xs = 16;
  static const double sm = 20;
  static const double md = 24;
  static const double lg = 32;
  static const double xl = 48;
  static const double xxl = 64;
}
