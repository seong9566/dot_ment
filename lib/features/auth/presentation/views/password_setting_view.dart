import 'package:dot_ment/core/widgets/custom_app_bar.dart';
import 'package:dot_ment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/core/theme/app_radius.dart';
import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/password_setting_viewmodel.dart';
import 'package:dot_ment/features/auth/presentation/widgets/password_input_field.dart';
import 'package:dot_ment/features/auth/presentation/widgets/password_requirement_item.dart';

/// 비밀번호 설정 화면
class PasswordSettingView extends ConsumerWidget {
  const PasswordSettingView({super.key, this.email, this.isJoin = true});

  final String? email;
  final bool isJoin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(passwordSettingViewModelProvider.notifier);
    final state = ref.watch(passwordSettingViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar.leftBack(),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pd30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xl),
                _buildHeader(l10n),
                const SizedBox(height: AppSpacing.pd16),
                _buildInstructionText(l10n),
                const SizedBox(height: 16),
                _buildRequirementTitle(l10n),
                const SizedBox(height: 12),
                _buildRequirements(l10n, state),
                const SizedBox(height: 24),
                _buildInputLabel(l10n),
                const SizedBox(height: 8),
                PasswordInputField(
                  value: state.password,
                  hintText: l10n.password_setting_input_hint,
                  onChanged: (val) => viewModel.updatePassword(val),
                ),
                const SizedBox(height: 24),
                _buildFinalStepButton(context, l10n, viewModel, state),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom > 0
                      ? MediaQuery.of(context).viewInsets.bottom + AppSpacing.md
                      : AppSpacing.xl,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppLocalizations l10n) {
    return Text(
      l10n.password_setting_title,
      style: AppTextStyles.heading1.copyWith(
        fontSize: 40,
        color: AppColors.primary,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildInstructionText(AppLocalizations l10n) {
    return Text(
      l10n.password_setting_subtitle,
      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
    );
  }

  Widget _buildRequirementTitle(AppLocalizations l10n) {
    return Text(
      l10n.password_setting_requirement_title,
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRequirements(AppLocalizations l10n, PasswordSettingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordRequirementItem(
          text: l10n.password_setting_requirement_min_length,
          isMet: state.hasMinLength,
        ),
        const SizedBox(height: 8),
        PasswordRequirementItem(
          text: l10n.password_setting_requirement_letter,
          isMet: state.hasLetter,
        ),
        const SizedBox(height: 8),
        PasswordRequirementItem(
          text: l10n.password_setting_requirement_number,
          isMet: state.hasNumber,
        ),
        const SizedBox(height: 8),
        PasswordRequirementItem(
          text: l10n.password_setting_requirement_special,
          isMet: state.hasSymbol,
        ),
      ],
    );
  }

  Widget _buildInputLabel(AppLocalizations l10n) {
    return Text(
      l10n.password_setting_input_label,
      style: AppTextStyles.bodyMedium.copyWith(
        fontSize: 14,
        color: AppColors.textPrimary,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildFinalStepButton(
    BuildContext context,
    AppLocalizations l10n,
    PasswordSettingViewModel viewModel,
    PasswordSettingState state,
  ) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: state.isValid && !state.isLoading
            ? () async {
                FocusScope.of(context).unfocus();
                if (isJoin) {
                  // 회원가입 모드: 비밀번호 확인 화면으로 이동
                  context.push(
                    RouterPath.passwordCheck,
                    extra: {
                      'email': email ?? '',
                      'originalPassword': state.password,
                    },
                  );
                } else {
                  // 로그인 모드: 로그인 API 호출 후 홈으로 이동
                  final success = await viewModel.login(email ?? '');
                  if (success && context.mounted) {
                    context.go(RouterPath.channelList);
                  } else if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('로그인에 실패했습니다.')),
                    );
                  }
                }
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.rd10),
        ),
        child: state.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                isJoin ? l10n.password_setting_final_step : l10n.auth_login,
                style: AppTextStyles.heading3.copyWith(
                  fontWeight: FontWeight.normal,
                  color: AppColors.textOnPrimaryContainer,
                ),
              ),
      ),
    );
  }
}
