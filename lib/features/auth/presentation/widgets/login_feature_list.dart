import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';

/// 로그인 화면 기능 목록 위젯
class LoginFeatureList extends StatelessWidget {
  const LoginFeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFeatureItem('Build\nYour Channel'),
        const SizedBox(width: AppSpacing.sm),
        _buildDivider(),  
        const SizedBox(width: AppSpacing.sm),
        _buildFeatureItem('Edit Design\non Mobile'),
        const SizedBox(width: AppSpacing.sm),
        _buildDivider(),
        const SizedBox(width: AppSpacing.sm),
        _buildFeatureItem('Free Page'),
      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Flexible(
      child: Text(
        text,
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDivider() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: 2,
        height: 24,
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        color: AppColors.divider,
      ),
    );
  }
}

