import 'package:dot_ment/core/utils/logger.dart';
import 'package:dot_ment/features/auth/presentation/providers/auth_providers_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_viewmodel.g.dart';

/// 로그인 화면 상태
class LoginState {
  const LoginState({
    this.email = '',
    this.password = '', // 비밀번호 필드 추가
    this.agreeToTerms = true,
    this.isLoading = false,
    this.errorMessage,
  });

  final String email;
  final String password;
  final bool agreeToTerms;
  final bool isLoading;
  final String? errorMessage;

  LoginState copyWith({
    String? email,
    String? password,
    bool? agreeToTerms,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
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

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void toggleAgreeToTerms() {
    state = state.copyWith(agreeToTerms: !state.agreeToTerms);
  }

  Future<bool> login() async {
    if (!state.agreeToTerms) {
      Logger.d('약관에 동의해주세요.');
      state = state.copyWith(errorMessage: '약관에 동의해주세요.');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final loginUsecase = ref.read(loginUsecaseProvider);
      final success = await loginUsecase(state.email, state.password);

      if (success) {
        state = state.copyWith(isLoading: false);
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: '로그인 정보가 올바르지 않습니다.',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: '로그인 중 오류가 발생했습니다. 다시 시도해주세요.',
      );
      return false;
    }
  }
}
