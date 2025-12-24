import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/core/widgets/custom_app_bar.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/email_verification_viewmodel.dart';
import 'package:dot_ment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/join_viewmodel.dart';
import 'package:dot_ment/features/auth/presentation/widgets/email_input_field.dart';
import 'package:dot_ment/features/auth/presentation/widgets/terms_text.dart';
import 'package:dot_ment/features/auth/presentation/widgets/send_code_button.dart';
import 'package:go_router/go_router.dart';

/// 회원가입 화면
class EmailInputView extends ConsumerWidget {
  const EmailInputView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(joinViewModelProvider.notifier);
    final emailVerificationViewModel = ref.read(
      emailVerificationViewModelProvider.notifier,
    );
    final state = ref.watch(joinViewModelProvider);
    final emailVerificationState = ref.watch(
      emailVerificationViewModelProvider,
    );
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar.leftBack(),
      // 키보드가 올라와도 화면이 밀려 올라가지 않도록 설정
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Stack(
            children: [
              // 메인 컨텐츠 영역 (스크롤 가능)
              Positioned.fill(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSpacing.xl),
                      _buildHeader(l10n),
                      const SizedBox(height: AppSpacing.xxl),
                      Text(
                        l10n.email_input_label,
                        style: AppTextStyles.bodyMedium.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      EmailInputField(
                        value: state.email,
                        hintText: l10n.email_input_hint,
                        onChanged: (email) => viewModel.updateEmail(email),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      SendCodeButton(
                        onPressed: state.email.isNotEmpty
                            ? () async {
                                FocusScope.of(context).unfocus();
                                final success = await emailVerificationViewModel
                                    .sendCode(state.email);
                                if (success && context.mounted) {
                                  context.push(
                                    RouterPath.emailVerification,
                                    extra: {
                                      'email': state.email,
                                      'isJoin': true,
                                    },
                                  );
                                } else if (emailVerificationState
                                            .errorMessage !=
                                        null &&
                                    context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        emailVerificationState.errorMessage!,
                                      ),
                                    ),
                                  );
                                }
                              }
                            : () {},
                      ),
                      const SizedBox(height: 4),
                      _buildLoginPrompt(context, l10n),
                      // 하단 약관 텍스트를 위한 여백
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
              // 하단 고정 약관 텍스트
              const Positioned(
                bottom: AppSpacing.lg,
                left: 0,
                right: 0,
                child: TermsText(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.email_input_title,
          style: AppTextStyles.heading1.copyWith(
            fontSize: 40,
            color: AppColors.primary,
            fontWeight: FontWeight.normal,
          ),
        ),
        const SizedBox(height: AppSpacing.pd16),
        Text(
          l10n.email_input_subtitle,
          style: AppTextStyles.bodyLarge.copyWith(
            fontSize: 18,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildLoginPrompt(BuildContext context, AppLocalizations l10n) {
    return Center(
      child: GestureDetector(
        onTap: () {
          //포커스
          FocusScope.of(context).unfocus();
          context.replace(RouterPath.login);
        },
        child: RichText(
          text: TextSpan(
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
            children: [
              TextSpan(text: l10n.email_input_login_prompt_prefix),
              TextSpan(
                text: l10n.email_input_login_prompt_button,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
