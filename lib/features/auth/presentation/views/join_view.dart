import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/join_viewmodel.dart';
import 'package:dot_ment/features/auth/presentation/widgets/email_input_field.dart';
import 'package:dot_ment/features/auth/presentation/widgets/terms_checkbox.dart';
import 'package:dot_ment/features/auth/presentation/widgets/send_code_button.dart';

/// 회원가입 화면
class JoinView extends ConsumerWidget {
  const JoinView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(joinViewModelProvider.notifier);
    final state = ref.watch(joinViewModelProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSpacing.xxl),
                      _buildHeader(),
                      const SizedBox(height: AppSpacing.xxl),
                      EmailInputField(
                        value: state.email,
                        onChanged: (email) => viewModel.updateEmail(email),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      TermsCheckbox(
                        value: state.agreeToTerms,
                        onChanged: () => viewModel.toggleAgreeToTerms(),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      SendCodeButton(
                        isLoading: state.isLoading,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          await viewModel.sendCode();
                          if (state.email.isNotEmpty && context.mounted) {
                            context.push(
                              '${RouterPath.emailVerification}?email=${Uri.encodeComponent(state.email)}',
                            );
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom > 0
                            ? MediaQuery.of(context).viewInsets.bottom +
                                  AppSpacing.md
                            : AppSpacing.xl,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Join',
          style: AppTextStyles.heading1.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Create your account',
          style: AppTextStyles.bodyLarge.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
