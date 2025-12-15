import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';

/// 비밀번호 요구사항 항목 위젯
class PasswordRequirementItem extends StatelessWidget {
  const PasswordRequirementItem({
    super.key,
    required this.text,
    required this.isMet,
  });

  final String text;
  final bool isMet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          size: 16,
          color: isMet ? AppColors.success : AppColors.textDisabled,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isMet ? AppColors.textPrimary : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

