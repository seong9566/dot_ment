import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/email_verification_viewmodel.dart';
import 'package:dot_ment/features/auth/presentation/widgets/verification_code_input.dart';
import 'package:dot_ment/features/auth/presentation/widgets/resend_button.dart';
import 'package:dot_ment/features/auth/presentation/widgets/checked_button.dart';

/// 이메일 코드 확인 화면
class EmailVerificationView extends ConsumerStatefulWidget {
  const EmailVerificationView({
    super.key,
    this.email,
  });

  final String? email;

  @override
  ConsumerState<EmailVerificationView> createState() =>
      _EmailVerificationViewState();
}

class _EmailVerificationViewState
    extends ConsumerState<EmailVerificationView> {
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

  @override
  Widget build(BuildContext context) {
    final viewModel =
        ref.watch(emailVerificationViewModelProvider.notifier);
    final state = ref.watch(emailVerificationViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              _buildHeader(),
              const SizedBox(height: AppSpacing.md),
              _buildInstructionText(state.email),
              const SizedBox(height: AppSpacing.xxl),
              VerificationCodeInput(
                code: state.code,
                hasError: state.hasError,
                onCodeChanged: (code) => viewModel.updateCode(code),
              ),
              if (state.hasError) ...[
                const SizedBox(height: AppSpacing.sm),
                _buildErrorMessage(),
              ],
              const SizedBox(height: AppSpacing.xl),
              ResendButton(
                isLoading: state.isLoading,
                canResend: state.canResend,
                onPressed: () => viewModel.resendCode(),
              ),
              const SizedBox(height: AppSpacing.md),
              CheckedButton(
                isLoading: state.isLoading,
                onPressed: () => _handleVerifyCode(context, viewModel),
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

  Widget _buildHeader() {
    return Text(
      'Check Email Box',
      style: AppTextStyles.heading1.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildInstructionText(String email) {
    return RichText(
      text: TextSpan(
        style: AppTextStyles.bodyLarge.copyWith(
          color: AppColors.textSecondary,
        ),
        children: [
          const TextSpan(text: 'We sent to '),
          TextSpan(
            text: email.isEmpty ? 'your email' : email,
            style: AppTextStyles.bodyLarge.copyWith(
              color: AppColors.textPrimary,
              decoration: TextDecoration.underline,
            ),
          ),
          const TextSpan(text: ' a verify code please check your mail box'),
        ],
      ),
    );
  }

  Future<void> _handleVerifyCode(
    BuildContext context,
    EmailVerificationViewModel viewModel,
  ) async {
    // Focus 해제
    FocusScope.of(context).unfocus();
    
    final isSuccess = await viewModel.verifyCode();
    
    if (!context.mounted) return;

    if (isSuccess) {
      // 성공 Dialog 표시
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 64,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Success',
                  style: AppTextStyles.heading3.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // 1초 후 Dialog 닫고 비밀번호 입력 화면으로 이동
      await Future.delayed(const Duration(seconds: 1));
      
      if (!context.mounted) return;
      
      Navigator.of(context).pop(); // Dialog 닫기
      context.push(RouterPath.passwordSetting);
    }
    // 실패 시 에러 상태는 이미 ViewModel에서 설정됨
  }

  Widget _buildErrorMessage() {
    return Text(
      'Authentication failed. Please try again.',
      style: AppTextStyles.bodyMedium.copyWith(
        color: AppColors.error,
      ),
      textAlign: TextAlign.center,
    );
  }
}

