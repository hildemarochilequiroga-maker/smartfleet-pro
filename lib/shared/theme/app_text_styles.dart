import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';

/// Application text styles using Google Fonts (Inter)
/// Following Material Design 3 typography scale
class AppTextStyles {
  AppTextStyles._();

  // ============ Headings ============

  /// Heading 1 - 24px Bold
  /// Used for: Page titles, main headings
  static TextStyle heading1({Color? color}) => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.5,
    color: color,
  );

  /// Heading 2 - 20px Bold
  /// Used for: Section titles, card headers
  static TextStyle heading2({Color? color}) => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.3,
    letterSpacing: -0.3,
    color: color,
  );

  /// Heading 3 - 18px Bold
  /// Used for: Subsection titles, list headers
  static TextStyle heading3({Color? color}) => GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.2,
    color: color,
  );

  /// Heading 4 - 16px Bold
  /// Used for: Small headings, emphasized text
  static TextStyle heading4({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: 0,
    color: color,
  );

  // ============ Body Text ============

  /// Body Large - 16px Regular
  /// Used for: Primary body text, descriptions
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
    color: color,
  );

  /// Body Large Medium - 16px Medium
  /// Used for: Emphasized body text
  static TextStyle bodyLargeMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
    color: color,
  );

  /// Body Medium - 14px Regular
  /// Used for: Secondary body text, labels
  static TextStyle bodyMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
    color: color,
  );

  /// Body Medium Medium - 14px Medium
  /// Used for: Emphasized labels, button text
  static TextStyle bodyMediumMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
    color: color,
  );

  // ============ Captions & Small Text ============

  /// Caption - 12px Regular
  /// Used for: Helper text, timestamps, metadata
  static TextStyle caption({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    letterSpacing: 0.1,
    color: color,
  );

  /// Caption Medium - 12px Medium
  /// Used for: Emphasized captions, badges
  static TextStyle captionMedium({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.1,
    color: color,
  );

  /// Overline - 11px Medium Uppercase
  /// Used for: Labels, category tags
  static TextStyle overline({Color? color}) =>
      GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 1.5,
        color: color,
      ).copyWith(
        // Apply uppercase transformation
        fontFeatures: [const FontFeature.enable('smcp')],
      );

  // ============ Specialized Text Styles ============

  /// Button Text - 14px Medium
  /// Used for: All button labels
  static TextStyle button({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.2,
    letterSpacing: 0.5,
    color: color,
  );

  /// Input Text - 16px Regular
  /// Used for: Text field input
  static TextStyle input({Color? color}) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: 0,
    color: color,
  );

  /// Input Label - 14px Medium
  /// Used for: Text field labels
  static TextStyle inputLabel({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0,
    color: color,
  );

  /// Input Error - 12px Regular
  /// Used for: Validation error messages
  static TextStyle inputError({Color? color}) => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.3,
    letterSpacing: 0,
    color: color ?? AppColors.error,
  );

  /// Link Text - 14px Medium
  /// Used for: Hyperlinks, clickable text
  static TextStyle link({Color? color}) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 1.5,
    letterSpacing: 0,
    color: color ?? AppColors.primary,
    decoration: TextDecoration.underline,
  );

  /// Number Display - 32px Bold (Monospace)
  /// Used for: Large numbers, statistics
  static TextStyle numberLarge({Color? color}) => GoogleFonts.robotoMono(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 1.2,
    letterSpacing: -1,
    color: color,
  );

  /// Number Small - 20px Bold (Monospace)
  /// Used for: Metrics, counters
  static TextStyle numberSmall({Color? color}) => GoogleFonts.robotoMono(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    letterSpacing: 0,
    color: color,
  );
}

/// Text style extensions for quick theming
extension TextStyleExtensions on TextStyle {
  /// Make text bold
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  /// Make text semi-bold
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Make text medium
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Make text regular
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  /// Make text light
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  /// Apply primary color
  TextStyle get primaryColor => copyWith(color: AppColors.primary);

  /// Apply secondary color
  TextStyle get secondaryColor => copyWith(color: AppColors.secondary);

  /// Apply error color
  TextStyle get errorColor => copyWith(color: AppColors.error);

  /// Apply warning color
  TextStyle get warningColor => copyWith(color: AppColors.warning);

  /// Make text italic
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  /// Add underline
  TextStyle get underline => copyWith(decoration: TextDecoration.underline);

  /// Add line-through
  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);
}
