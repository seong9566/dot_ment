import 'package:dot_ment/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/features/auth/presentation/views/auth_view.dart';
import 'package:dot_ment/features/auth/presentation/views/login_view.dart';
import 'package:dot_ment/features/auth/presentation/views/email_input_view.dart';
import 'package:dot_ment/features/auth/presentation/views/email_verification_view.dart';
import 'package:dot_ment/features/auth/presentation/views/password_setting_view.dart';
import 'package:dot_ment/features/auth/presentation/views/password_check_view.dart';

part 'app_router.g.dart';

/// 앱 라우터 설정
@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: RouterPath.auth,
    routes: [
      GoRoute(
        path: RouterPath.splash,
        name: 'splash',
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Splash Screen'))),
      ),
      GoRoute(
        path: RouterPath.auth,
        name: 'auth',
        builder: (context, state) => const AuthView(),
      ),
      GoRoute(
        path: RouterPath.home,
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: RouterPath.login,
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RouterPath.join,
        name: 'email_input',
        builder: (context, state) => const EmailInputView(),
      ),
      GoRoute(
        path: RouterPath.emailVerification,
        name: 'email_verification',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] as String?;
          final isJoin = extra?['isJoin'] as bool? ?? true;
          return EmailVerificationView(email: email, isJoin: isJoin);
        },
      ),
      GoRoute(
        path: RouterPath.passwordSetting,
        name: 'password_setting',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] as String?;
          final isJoin = extra?['isJoin'] as bool? ?? true;
          return PasswordSettingView(email: email, isJoin: isJoin);
        },
      ),
      GoRoute(
        path: RouterPath.passwordCheck,
        name: 'password_check',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          final email = extra?['email'] as String? ?? '';
          final originalPassword = extra?['originalPassword'] as String? ?? '';

          return PasswordCheckView(
            email: email,
            originalPassword: originalPassword,
          );
        },
      ),
    ],
  );
}
