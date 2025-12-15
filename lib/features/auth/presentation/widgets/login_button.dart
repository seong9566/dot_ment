import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_radius.dart';

/// 로그인 화면 버튼 위젯
class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.text,
    required this.isPrimary,
    required this.isLoading,
    required this.onPressed,
  });

  final String text;
  final bool isPrimary;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : AppColors.primary400,
          foregroundColor: isPrimary ? Colors.white : AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.md,
          ),
          disabledBackgroundColor: isPrimary
              ? AppColors.primary.withValues(alpha: 0.6)
              : AppColors.primary400.withValues(alpha: 0.6),
        ),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                text,
                style: AppTextStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

