import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';

/// Remember Me 체크박스 위젯
class RememberMeCheckbox extends StatelessWidget {
  const RememberMeCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: value,
          onChanged: (_) => onChanged(),
          activeColor: AppColors.primary,
          checkColor: Colors.white,
        ),
        Text(
          'Remember me',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

