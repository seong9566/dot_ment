import 'package:dot_ment/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:dot_ment/core/theme/app_colors.dart';
import 'package:dot_ment/core/theme/app_text_styles.dart';
import 'package:dot_ment/core/theme/app_spacing.dart';
import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:dot_ment/features/auth/presentation/widgets/login_feature_list.dart';
import 'package:dot_ment/features/auth/presentation/widgets/auth_button.dart';
import 'package:dot_ment/features/auth/presentation/widgets/remember_me_checkbox.dart';
import 'package:dot_ment/features/auth/presentation/widgets/terms_text.dart';

/// 인증 선택 화면
class AuthView extends ConsumerWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(authViewModelProvider.notifier);
    final state = ref.watch(authViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.pd30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: AppSpacing.xxl),
                _buildBrandHeader(),
                const Spacer(flex: 1),
                const LoginFeatureList(),
                const SizedBox(height: AppSpacing.pd40),
                AuthButton(
                  text: l10n.auth_join,
                  isPrimary: true,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context.push(RouterPath.join);
                  },
                ),
                const SizedBox(height: AppSpacing.pd40),
                AuthButton(
                  text: l10n.auth_login,
                  isPrimary: false,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    context.push(RouterPath.login);
                  },
                ),
                const SizedBox(height: 26),
                RememberMeCheckbox(
                  value: state.rememberMe,
                  onChanged: () => viewModel.toggleRememberMe(),
                ),
                const Spacer(flex: 1),
                const TermsText(),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Text(
      'DOTMENT',
      style: AppTextStyles.heading1.copyWith(
        fontSize: 64,
        color: AppColors.primary,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
    );
  }
}
