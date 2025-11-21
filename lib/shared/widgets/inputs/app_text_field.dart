import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smartfleetpro/shared/theme/app_colors.dart';
import 'package:smartfleetpro/shared/theme/app_text_styles.dart';

/// Custom text field component with validation and states
class AppTextField extends StatefulWidget {
  /// Creates an app text field
  const AppTextField({
    required this.label,
    this.controller,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.autocorrect = true,
    this.autofocus = false,
    super.key,
  });

  /// Label text
  final String label;

  /// Text editing controller
  final TextEditingController? controller;

  /// Hint text
  final String? hintText;

  /// Helper text shown below field
  final String? helperText;

  /// Error text shown below field
  final String? errorText;

  /// Leading icon
  final IconData? prefixIcon;

  /// Trailing icon or widget
  final Widget? suffixIcon;

  /// Validation function
  final String? Function(String?)? validator;

  /// Called when text changes
  final ValueChanged<String>? onChanged;

  /// Called when user submits
  final ValueChanged<String>? onSubmitted;

  /// Keyboard type
  final TextInputType? keyboardType;

  /// Text input action
  final TextInputAction? textInputAction;

  /// Hide text (for passwords)
  final bool obscureText;

  /// Enable/disable field
  final bool enabled;

  /// Read-only mode
  final bool readOnly;

  /// Maximum lines
  final int maxLines;

  /// Maximum character length
  final int? maxLength;

  /// Input formatters
  final List<TextInputFormatter>? inputFormatters;

  /// Enable autocorrect
  final bool autocorrect;

  /// Auto focus on mount
  final bool autofocus;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscureText = false;
  bool _isFocused = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _errorText = widget.errorText;
  }

  @override
  void didUpdateWidget(AppTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      setState(() {
        _errorText = widget.errorText;
      });
    }
  }

  void _validate(String? value) {
    if (widget.validator != null) {
      setState(() {
        _errorText = widget.validator!(value);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _errorText != null && _errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Focus(
          onFocusChange: (focused) {
            setState(() {
              _isFocused = focused;
            });
            if (!focused && widget.controller != null) {
              _validate(widget.controller!.text);
            }
          },
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hintText,
              helperText: hasError ? null : widget.helperText,
              errorText: _errorText,
              prefixIcon: widget.prefixIcon != null
                  ? Icon(
                      widget.prefixIcon,
                      color: hasError
                          ? AppColors.error
                          : _isFocused
                          ? AppColors.primary
                          : AppColors.textSecondaryLight,
                    )
                  : null,
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: AppColors.textSecondaryLight,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : widget.suffixIcon,
              filled: true,
              fillColor: widget.enabled
                  ? AppColors.surfaceLight
                  : AppColors.dividerLight,
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
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
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
                color: hasError
                    ? AppColors.error
                    : _isFocused
                    ? AppColors.primary
                    : AppColors.textSecondaryLight,
              ),
              hintStyle: AppTextStyles.bodyMedium(
                color: AppColors.textTertiaryLight,
              ),
              errorStyle: AppTextStyles.inputError(),
              helperStyle: AppTextStyles.caption(
                color: AppColors.textSecondaryLight,
              ),
            ),
            style: AppTextStyles.input(color: AppColors.textPrimaryLight),
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: _obscureText,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            autocorrect: widget.autocorrect,
            autofocus: widget.autofocus,
            onChanged: (value) {
              if (hasError) {
                _validate(value);
              }
              widget.onChanged?.call(value);
            },
            onSubmitted: widget.onSubmitted,
          ),
        ),
      ],
    );
  }
}
