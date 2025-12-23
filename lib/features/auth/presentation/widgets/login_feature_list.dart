import 'package:dot_ment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';

/// 로그인 화면 기능 목록 위젯
class LoginFeatureList extends StatelessWidget {
  const LoginFeatureList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildFeatureItem(l10n.auth_feature_business_channel),
        const SizedBox(width: AppSpacing.sm),
        _buildDivider(),
        const SizedBox(width: AppSpacing.sm),
        _buildFeatureItem(l10n.auth_feature_easy_management),
        const SizedBox(width: AppSpacing.sm),
        _buildDivider(),
        const SizedBox(width: AppSpacing.sm),
        _buildFeatureItem(l10n.auth_feature_free_page),
      ],
    );
  }

  Widget _buildFeatureItem(String text) {
    return Flexible(
      child: Text(
        text,
        style: AppTextStyles.bodySmall.copyWith(
          // 텍스트가 많아졌으므로 bodySmall 권장
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
          fontSize: 12, // 이미지 비율에 맞춤
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDivider() {
    return Container(width: 1, height: 20, color: AppColors.divider);
  }
}
