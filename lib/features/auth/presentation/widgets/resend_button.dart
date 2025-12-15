import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_radius.dart';

/// 재전송 버튼 위젯
class ResendButton extends StatelessWidget {
  const ResendButton({
    super.key,
    required this.isLoading,
    required this.canResend,
    required this.onPressed,
  });

  final bool isLoading;
  final bool canResend;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: (isLoading || !canResend) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary400,
          foregroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.md,
          ),
          disabledBackgroundColor: AppColors.primary400.withValues(alpha: 0.6),
          disabledForegroundColor: AppColors.textDisabled,
        ),
        child: Text(
          'Re Send',
          style: AppTextStyles.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

