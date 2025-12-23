import 'package:dot_ment/core/utils/error_handler.dart';
import 'package:dot_ment/features/auth/presentation/providers/auth_providers_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_check_viewmodel.g.dart';

/// 비밀번호 재확인 화면 상태
class PasswordCheckState {
  const PasswordCheckState({
    this.email = '',
    this.confirmPassword = '',
    this.originalPassword = '',
    this.isLoading = false,
    this.hasError = false,
    this.errorMessage,
  });

  final String email;
  final String confirmPassword;
  final String originalPassword;
  final bool isLoading;
  final bool hasError;
  final String? errorMessage;

  bool get isMatched => confirmPassword == originalPassword;

  PasswordCheckState copyWith({
    String? email,
    String? confirmPassword,
    String? originalPassword,
    bool? isLoading,
    bool? hasError,
    String? errorMessage,
  }) {
    return PasswordCheckState(
      email: email ?? this.email,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      originalPassword: originalPassword ?? this.originalPassword,
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
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

  void setInitialData({required String email, required String password}) {
    state = state.copyWith(email: email, originalPassword: password);
  }

  void updateConfirmPassword(String password) {
    state = state.copyWith(
      confirmPassword: password,
      hasError: false,
      errorMessage: null,
    );
  }

  /// 회원가입 완료 API 호출
  Future<bool> submit() async {
    if (!state.isMatched) {
      state = state.copyWith(hasError: true);
      return false;
    }

    try {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        errorMessage: null,
      );

      final usecase = ref.read(addUserUsecaseProvider);
      final success = await usecase.call(state.email, state.confirmPassword);

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        hasError: true,
        errorMessage: handleError(e),
      );
      return false;
    }
  }
}
