import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_viewmodel.g.dart';

/// 인증 화면 상태
class AuthState {
  const AuthState({
    this.email = '',
    this.password = '',
    this.rememberMe = false,
    this.isLoading = false,
  });

  final String email;
  final String password;
  final bool rememberMe;
  final bool isLoading;

  AuthState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
    bool? isLoading,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberMe: rememberMe ?? this.rememberMe,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 인증 ViewModel
@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AuthState build() {
    return const AuthState();
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
