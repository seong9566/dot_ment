import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:dot_ment/core/router/router_path.dart';
import 'package:dot_ment/features/auth/presentation/views/login_view.dart';
import 'package:dot_ment/features/auth/presentation/views/email_input_view.dart';
import 'package:dot_ment/features/auth/presentation/views/email_verification_view.dart';
import 'package:dot_ment/features/auth/presentation/views/password_setting_view.dart';

part 'app_router.g.dart';

/// 앱 라우터 설정
@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    initialLocation: RouterPath.login,
    routes: [
      GoRoute(
        path: RouterPath.splash,
        name: 'splash',
        builder: (context, state) => const Scaffold(
          body: Center(child: Text('Splash Screen')),
        ),
      ),
      GoRoute(
        path: RouterPath.login,
        name: 'login',
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RouterPath.emailInput,
        name: 'email-input',
        builder: (context, state) => const EmailInputView(),
      ),
      GoRoute(
        path: RouterPath.emailVerification,
        name: 'email-verification',
        builder: (context, state) {
          final email = state.uri.queryParameters['email'];
          return EmailVerificationView(email: email);
        },
      ),
      GoRoute(
        path: RouterPath.passwordSetting,
        name: 'password-setting',
        builder: (context, state) => const PasswordSettingView(),
      ),
    ],
  );
}

