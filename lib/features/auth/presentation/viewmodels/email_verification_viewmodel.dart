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
  });

  final String code;
  final String email;
  final bool isLoading;
  final bool canResend;
  final bool hasError;

  EmailVerificationState copyWith({
    String? code,
    String? email,
    bool? isLoading,
    bool? canResend,
    bool? hasError,
  }) {
    return EmailVerificationState(
      code: code ?? this.code,
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      canResend: canResend ?? this.canResend,
      hasError: hasError ?? this.hasError,
    );
  }
}

/// 이메일 코드 확인 ViewModel
@riverpod
class EmailVerificationViewModel extends _$EmailVerificationViewModel {
  @override
  EmailVerificationState build() {
    return const EmailVerificationState();
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
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
    // TODO: 실제 검증 결과로 변경
    final isSuccess = true;
    
    if (!isSuccess) {
      state = state.copyWith(isLoading: false, hasError: true);
      return false;
    }
    
    // 성공 시 (TODO: 실제 API 연동 후 활성화)
    // ignore: dead_code
    state = state.copyWith(isLoading: false, hasError: false);
    return true;
  }

  Future<void> resendCode() async {
    if (!state.canResend) {
      return;
    }

    state = state.copyWith(isLoading: true, canResend: false);
    // TODO: 실제 인증 코드 재전송 로직 구현
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
    
    // 60초 후 재전송 가능
    Future.delayed(const Duration(seconds: 60), () {
      state = state.copyWith(canResend: true);
    });
  }
}

