import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/password_setting_viewmodel.dart';
import 'package:dot_ment/features/auth/presentation/widgets/password_input_field.dart';
import 'package:dot_ment/features/auth/presentation/widgets/password_requirement_item.dart';
import 'package:dot_ment/features/auth/presentation/widgets/next_button.dart';

/// 비밀번호 설정 화면
class PasswordSettingView extends ConsumerWidget {
  const PasswordSettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel =
        ref.watch(passwordSettingViewModelProvider.notifier);
    final state = ref.watch(passwordSettingViewModelProvider);

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
              _buildInstructionText(),
              const SizedBox(height: AppSpacing.md),
              _buildRequirements(state),
              const SizedBox(height: AppSpacing.xl),
              PasswordInputField(
                value: state.password,
                onChanged: (password) => viewModel.updatePassword(password),
              ),
              const SizedBox(height: AppSpacing.xl),
              NextButton(
                isLoading: state.isLoading,
                isValid: state.isValid,
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final isSuccess = await viewModel.submitPassword();
                  if (isSuccess && context.mounted) {
                    context.go(RouterPath.login);
                  }
                },
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
      'Password Setting',
      style: AppTextStyles.heading1.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget _buildInstructionText() {
    return Text(
      'Enter your password',
      style: AppTextStyles.bodyLarge.copyWith(
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildRequirements(PasswordSettingState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PasswordRequirementItem(
          text: 'Capital letter',
          isMet: state.hasCapitalLetter,
        ),
        const SizedBox(height: AppSpacing.xs),
        PasswordRequirementItem(
          text: 'Number',
          isMet: state.hasNumber,
        ),
        const SizedBox(height: AppSpacing.xs),
        PasswordRequirementItem(
          text: 'Symbol',
          isMet: state.hasSymbol,
        ),
      ],
    );
  }
}

