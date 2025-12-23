import 'package:dot_ment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';

/// 약관 동의 텍스트 위젯
class TermsText extends StatelessWidget {
  const TermsText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // placeholder를 사용한 번역 문구 가져오기
    // 예: "회원가입 시, {tos} 및 {pp}에 동의합니다."
    final fullText = l10n.auth_terms_agreement(
      l10n.auth_terms_of_service,
      l10n.auth_privacy_policy,
    );

    // 색상 적용이 필요한 핵심 단어들
    final tos = l10n.auth_terms_of_service;
    final pp = l10n.auth_privacy_policy;

    // 단순화를 위해 텍스트 분리 로직 (실제 서비스에서는 언어별 패턴 매칭이 필요할 수 있음)
    // 여기서는 간단히 순차적으로 RichText 구성

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: _buildRichText(context, fullText, tos, pp),
    );
  }

  Widget _buildRichText(
    BuildContext context,
    String fullText,
    String tos,
    String pp,
  ) {
    final List<TextSpan> spans = [];

    // 언어별로 단어 위치가 다르므로 유연하게 처리
    String remaining = fullText;

    void addSpan(String text, bool isHighlight) {
      if (text.isEmpty) return;
      spans.add(
        TextSpan(
          text: text,
          style: AppTextStyles.bodySmall.copyWith(
            color: isHighlight ? AppColors.primary : AppColors.textPrimary,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      );
    }

    // TOS 찾기
    int tosIdx = remaining.indexOf(tos);
    if (tosIdx != -1) {
      addSpan(remaining.substring(0, tosIdx), false);
      addSpan(tos, true);
      remaining = remaining.substring(tosIdx + tos.length);
    }

    // PP 찾기
    int ppIdx = remaining.indexOf(pp);
    if (ppIdx != -1) {
      addSpan(remaining.substring(0, ppIdx), false);
      addSpan(pp, true);
      remaining = remaining.substring(ppIdx + pp.length);
    }

    // 남은 텍스트
    addSpan(remaining, false);

    return RichText(
      textAlign: TextAlign.left,
      text: TextSpan(children: spans),
    );
  }
}
