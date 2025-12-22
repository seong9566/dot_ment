import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_viewmodel.g.dart';

/// 로그인 화면 상태
class LoginState {
  const LoginState({
    this.email = '',
    this.agreeToTerms = false,
    this.isLoading = false,
  });

  final String email;
  final bool agreeToTerms;
  final bool isLoading;

  LoginState copyWith({String? email, bool? agreeToTerms, bool? isLoading}) {
    return LoginState(
      email: email ?? this.email,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 로그인 ViewModel
@riverpod
class LoginViewModel extends _$LoginViewModel {
  @override
  LoginState build() {
    return const LoginState();
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void toggleAgreeToTerms() {
    state = state.copyWith(agreeToTerms: !state.agreeToTerms);
  }

  Future<void> sendCode() async {
    if (!state.agreeToTerms) {
      // TODO: 에러 메시지 표시
      return;
    }

    state = state.copyWith(isLoading: true);
    // TODO: 실제 인증 코드 전송 로직 구현
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
  }
}
