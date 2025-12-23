import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_check_viewmodel.g.dart';

/// 비밀번호 재확인 화면 상태
class PasswordCheckState {
  const PasswordCheckState({
    this.confirmPassword = '',
    this.originalPassword = '',
    this.isLoading = false,
    this.hasError = false,
  });

  final String confirmPassword;
  final String originalPassword;
  final bool isLoading;
  final bool hasError;

  bool get isMatched => confirmPassword == originalPassword;

  PasswordCheckState copyWith({
    String? confirmPassword,
    String? originalPassword,
    bool? isLoading,
    bool? hasError,
  }) {
    return PasswordCheckState(
      confirmPassword: confirmPassword ?? this.confirmPassword,
      originalPassword: originalPassword ?? this.originalPassword,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}

/// 비밀번호 재확인 ViewModel
@riverpod
class PasswordCheckViewModel extends _$PasswordCheckViewModel {
  @override
  PasswordCheckState build() {
    return const PasswordCheckState();
  }

  void setOriginalPassword(String password) {
    state = state.copyWith(originalPassword: password);
  }

  void updateConfirmPassword(String password) {
    state = state.copyWith(confirmPassword: password, hasError: false);
  }

  Future<bool> submit() async {
    if (!state.isMatched) {
      state = state.copyWith(hasError: true);
      return false;
    }

    state = state.copyWith(isLoading: true, hasError: false);
    // TODO: 실제 회원가입 완료/비밀번호 변경 API 호출
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
    return true;
  }
}
