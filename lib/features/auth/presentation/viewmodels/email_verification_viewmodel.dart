import 'dart:async';
import 'package:dot_ment/core/utils/error_handler.dart';
import 'package:dot_ment/features/auth/presentation/providers/auth_providers_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_verification_viewmodel.g.dart';

/// 이메일 코드 확인 화면 상태
class EmailVerificationState {
  const EmailVerificationState({
    this.code = '',
    this.email = '',
    this.isLoading = false,
    this.canResend = true,
    this.hasError = false,
    this.timerSeconds = 180, // 3분
    this.errorMessage,
  });

  final String code;
  final String email;
  final bool isLoading;
  final bool canResend;
  final bool hasError;
  final int timerSeconds;
  final String? errorMessage;

  EmailVerificationState copyWith({
    String? code,
    String? email,
    bool? isLoading,
    bool? canResend,
    bool? hasError,
    int? timerSeconds,
    String? errorMessage,
  }) {
    return EmailVerificationState(
      code: code ?? this.code,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      canResend: canResend ?? this.canResend,
      hasError: hasError ?? this.hasError,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// 이메일 코드 확인 ViewModel
@riverpod
class EmailVerificationViewModel extends _$EmailVerificationViewModel {
  Timer? _timer;

  @override
  EmailVerificationState build() {
    ref.onDispose(() => _timer?.cancel());
    return const EmailVerificationState();
  }

  void startTimer() {
    _timer?.cancel();
    state = state.copyWith(timerSeconds: 180, canResend: false);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        state = state.copyWith(timerSeconds: state.timerSeconds - 1);
      } else {
        _timer?.cancel();
        state = state.copyWith(canResend: true);
      }
    });
  }

  String get timerText {
    final minutes = state.timerSeconds ~/ 60;
    final seconds = state.timerSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
    startTimer();
  }

  void updateCode(String code) {
    state = state.copyWith(code: code, hasError: false, errorMessage: null);
  }

  /// 인증 코드 확인 API 호출
  Future<bool> verifyCode() async {
    if (state.code.length != 6) {
      state = state.copyWith(hasError: true);
      return false;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        errorMessage: null,
      );

      final usecase = ref.read(verifyCodeUsecaseProvider);
      final success = await usecase.call(state.email, state.code);

      if (!success) {
        state = state.copyWith(isLoading: false, hasError: true);
        return false;
      }

      state = state.copyWith(isLoading: false, hasError: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: handleError(e),
      );
      return false;
    }
  }

  /// 인증 코드 재전송 API 호출
  Future<void> resendCode() async {
    if (!state.canResend) {
      return;
    }

    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final usecase = ref.read(sendVerificationCodeUsecaseProvider);
      await usecase.call(state.email);

      state = state.copyWith(isLoading: false);
      startTimer();
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: handleError(e));
    }
  }
}
