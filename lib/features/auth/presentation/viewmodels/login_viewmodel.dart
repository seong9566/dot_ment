import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_viewmodel.g.dart';

/// 로그인 화면 상태
class LoginState {
  const LoginState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isLoading = false,
  });

  final String email;
  final String password;
  final bool rememberMe;
  final bool isLoading;

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isLoading,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
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

  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  void toggleRememberMe() {
    state = state.copyWith(rememberMe: !state.rememberMe);
  }

  Future<void> login() async {
    state = state.copyWith(isLoading: true);
    // TODO: 실제 로그인 로직 구현
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
  }

  Future<void> join() async {
    state = state.copyWith(isLoading: true);
    // TODO: 실제 회원가입 로직 구현
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
  }
}

