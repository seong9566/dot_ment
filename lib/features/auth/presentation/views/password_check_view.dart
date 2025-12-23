import 'package:dot_ment/core/widgets/custom_app_bar.dart';
import 'package:dot_ment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/core/theme/app_radius.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/password_check_viewmodel.dart';
import 'package:dot_ment/features/auth/presentation/widgets/password_input_field.dart';

/// 비밀번호 재확인 화면
class PasswordCheckView extends ConsumerStatefulWidget {
  const PasswordCheckView({super.key, required this.originalPassword});

  final String originalPassword;

  @override
  ConsumerState<PasswordCheckView> createState() => _PasswordCheckViewState();
}

class _PasswordCheckViewState extends ConsumerState<PasswordCheckView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(passwordCheckViewModelProvider.notifier)
          .setOriginalPassword(widget.originalPassword);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(passwordCheckViewModelProvider.notifier);
    final state = ref.watch(passwordCheckViewModelProvider);
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
                const SizedBox(height: 74),
                PasswordInputField(
                  value: state.confirmPassword,
                  hintText: l10n.password_check_input_hint,
                  hasError: state.hasError,
                  errorText: l10n.password_check_error,
                  onChanged: (val) => viewModel.updateConfirmPassword(val),
                ),
                const SizedBox(height: 24),
                _buildFinishButton(context, l10n, viewModel, state),
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
      l10n.password_check_title,
      style: AppTextStyles.heading1.copyWith(
        fontSize: 40,
        color: AppColors.primary,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  Widget _buildInstructionText(AppLocalizations l10n) {
    return Text(
      l10n.password_check_subtitle,
      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
    );
  }

  Widget _buildFinishButton(
    BuildContext context,
    AppLocalizations l10n,
    PasswordCheckViewModel viewModel,
    PasswordCheckState state,
  ) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: state.confirmPassword.isEmpty || state.isLoading
            ? null
            : () async {
                FocusScope.of(context).unfocus();
                final success = await viewModel.submit();
                if (success && context.mounted) {
                  // 완료 처리 (예: 홈으로 이동 또는 성공 메시지)
                }
              },
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
                l10n.password_check_finish,
                style: AppTextStyles.heading3.copyWith(
                  fontWeight: FontWeight.normal,
                  color: AppColors.textOnPrimaryContainer,
                ),
              ),
      ),
    );
  }
}
