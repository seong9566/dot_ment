import 'package:dot_ment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/core/theme/app_radius.dart';
import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/core/widgets/custom_app_bar.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/email_verification_viewmodel.dart';
import 'package:dot_ment/features/auth/presentation/widgets/verification_code_input.dart';

/// 이메일 코드 확인 화면
class EmailVerificationView extends ConsumerStatefulWidget {
  const EmailVerificationView({super.key, this.email, this.isJoin = true});

  final String? email;
  final bool isJoin;

  @override
  ConsumerState<EmailVerificationView> createState() =>
      _EmailVerificationViewState();
}

class _EmailVerificationViewState extends ConsumerState<EmailVerificationView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.email != null) {
        ref
            .read(emailVerificationViewModelProvider.notifier)
            .setEmail(widget.email!);
      }
    });
  }

  Future<void> _handleVerifyCode(
    BuildContext context,
    EmailVerificationViewModel viewModel,
    String email,
  ) async {
    FocusScope.of(context).unfocus();

    final isSuccess = await viewModel.verifyCode();

    if (!context.mounted) return;

    if (isSuccess) {
      context.push(
        RouterPath.passwordSetting,
        extra: {'email': email, 'isJoin': widget.isJoin},
      );
    } else {
      final state = ref.read(emailVerificationViewModelProvider);
      if (state.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(emailVerificationViewModelProvider.notifier);
    final state = ref.watch(emailVerificationViewModelProvider);
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
                _buildInstructionText(state.email, l10n),
                const SizedBox(height: 64),
                _buildTimer(viewModel.timerText),
                const SizedBox(height: 8),
                VerificationCodeInput(
                  code: state.code,
                  hasError: state.hasError,
                  onCodeChanged: (code) => viewModel.updateCode(code),
                ),
                const SizedBox(height: 8),
                _buildResendPrompt(viewModel, state.canResend, l10n),
                const SizedBox(height: 8),
                _buildNextButton(
                  context,
                  viewModel,
                  state.isLoading,
                  state.email,
                  l10n,
                ),
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
      l10n.email_verify_title,
      style: AppTextStyles.heading1.copyWith(
        fontSize: 40,
        color: AppColors.primary,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildInstructionText(String email, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          email.isEmpty ? l10n.email_verify_missing_email : email,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.email_verify_instruction,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildTimer(String timerText) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        timerText,
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildResendPrompt(
    EmailVerificationViewModel viewModel,
    bool canResend,
    AppLocalizations l10n,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.email_verify_resend_prompt,
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        GestureDetector(
          onTap: canResend ? () => viewModel.resendCode() : null,
          child: Text(
            l10n.email_verify_resend_button,
            style: AppTextStyles.bodyMedium.copyWith(
              color: canResend ? AppColors.primary : AppColors.textDisabled,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton(
    BuildContext context,
    EmailVerificationViewModel viewModel,
    bool isLoading,
    String email,
    AppLocalizations l10n,
  ) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: isLoading
            ? null
            : () => _handleVerifyCode(context, viewModel, email),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimaryContainer,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: AppRadius.rd10),
        ),
        child: Text(
          l10n.email_verify_next_button,
          style: AppTextStyles.heading3.copyWith(
            fontWeight: FontWeight.normal,
            color: AppColors.textOnPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
