import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_radius.dart';

/// 로그인 화면 버튼 위젯
class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.isPrimary,
    required this.onPressed,
  });

  final String text;
  final bool isPrimary;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary : AppColors.onPrimary,
          foregroundColor: isPrimary
              ? AppColors.textOnPrimaryContainer
              : AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.rd10),
        ),
        child: Text(
          text,
          style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
