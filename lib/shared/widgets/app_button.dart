import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_radius.dart';

/// 버튼 타입
enum AppButtonType {
  primary,
  secondary,
  error,
}

/// 공용 버튼 위젯
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.isEnabled = true,
    this.height = 56,
    this.width,
  });

  final String text;
  final VoidCallback onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool isEnabled;
  final double height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final isDisabled = isLoading || !isEnabled;
    final buttonStyle = _getButtonStyle(isDisabled);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: buttonStyle,
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getForegroundColor(),
                  ),
                ),
              )
            : Text(
                text,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  color: _getForegroundColor(),
                ),
              ),
      ),
    );
  }

  ButtonStyle _getButtonStyle(bool isDisabled) {
    return ElevatedButton.styleFrom(
      backgroundColor: _getBackgroundColor(),
      foregroundColor: _getForegroundColor(),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.md,
      ),
      disabledBackgroundColor: _getBackgroundColor().withValues(alpha: 0.6),
      disabledForegroundColor: AppColors.textDisabled,
    );
  }

  Color _getBackgroundColor() {
    switch (type) {
      case AppButtonType.primary:
        return AppColors.primary;
      case AppButtonType.secondary:
        return AppColors.primary400;
      case AppButtonType.error:
        return AppColors.error;
    }
  }

  Color _getForegroundColor() {
    switch (type) {
      case AppButtonType.primary:
        return Colors.white;
      case AppButtonType.secondary:
        return AppColors.primary;
      case AppButtonType.error:
        return Colors.white;
    }
  }
}

