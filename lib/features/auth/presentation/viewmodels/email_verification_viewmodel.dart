import 'dart:async';
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
  });

  final String code;
  final String email;
  final bool isLoading;
  final bool canResend;
  final bool hasError;
  final int timerSeconds;

  EmailVerificationState copyWith({
    String? code,
    String? email,
    bool? isLoading,
    bool? canResend,
    bool? hasError,
    int? timerSeconds,
  }) {
    return EmailVerificationState(
      code: code ?? this.code,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      canResend: canResend ?? this.canResend,
      hasError: hasError ?? this.hasError,
      timerSeconds: timerSeconds ?? this.timerSeconds,
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
    // build 시점에 타이머를 자동으로 시작하고 싶지 않을 수 있으므로,
    // setEmail 등 초기화 시점에 호출하도록 할 수도 있습니다.
    // 여기서는 기본적으로 3분 타이머 상항을 가정합니다.
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
    startTimer(); // 이메일 설정 시 타이머 시작
  }

  void updateCode(String code) {
    state = state.copyWith(code: code, hasError: false);
  }

  Future<bool> verifyCode() async {
    if (state.code.length != 6) {
      state = state.copyWith(hasError: true);
      return false;
    }

    state = state.copyWith(isLoading: true, hasError: false);
    // TODO: 실제 인증 코드 확인 로직 구현
    await Future.delayed(const Duration(seconds: 1));

    // 실패 시뮬레이션 (실제로는 API 응답에 따라 결정)
    final isSuccess = true;

    if (!isSuccess) {
      state = state.copyWith(isLoading: false, hasError: true);
      return false;
    }

    state = state.copyWith(isLoading: false, hasError: false);
    return true;
  }

  Future<void> resendCode() async {
    if (!state.canResend) {
      return;
    }

    state = state.copyWith(isLoading: true);
    // TODO: 실제 인증 코드 재전송 로직 구현
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);

    // 타이머 재시작
    startTimer();
  }
}
