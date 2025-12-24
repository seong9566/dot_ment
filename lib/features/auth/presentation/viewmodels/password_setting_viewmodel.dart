import 'package:dot_ment/features/auth/presentation/providers/auth_providers_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_setting_viewmodel.g.dart';

/// 비밀번호 설정 화면 상태
class PasswordSettingState {
  const PasswordSettingState({
    this.password = '',
    this.hasMinLength = false,
    this.hasLetter = false,
    this.hasNumber = false,
    this.hasSymbol = false,
    this.isLoading = false,
  });

  final String password;
  final bool hasMinLength;
  final bool hasLetter;
  final bool hasNumber;
  final bool hasSymbol;
  final bool isLoading;

  bool get isValid => hasMinLength && hasLetter && hasNumber && hasSymbol;

  PasswordSettingState copyWith({
    String? password,
    bool? hasMinLength,
    bool? hasLetter,
    bool? hasNumber,
    bool? hasSymbol,
    bool? isLoading,
  }) {
    return PasswordSettingState(
      password: password ?? this.password,
      hasMinLength: hasMinLength ?? this.hasMinLength,
      hasLetter: hasLetter ?? this.hasLetter,
      hasNumber: hasNumber ?? this.hasNumber,
      hasSymbol: hasSymbol ?? this.hasSymbol,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 비밀번호 설정 ViewModel
@riverpod
class PasswordSettingViewModel extends _$PasswordSettingViewModel {
  @override
  PasswordSettingState build() {
    return const PasswordSettingState();
  }

  void updatePassword(String password) {
    final hasMinLength = password.length >= 8;
    final hasLetter = password.contains(RegExp(r'[A-Za-z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*()]'));

    state = state.copyWith(
      password: password,
      hasMinLength: hasMinLength,
      hasLetter: hasLetter,
      hasNumber: hasNumber,
      hasSymbol: hasSymbol,
    );
  }

  Future<bool> submitPassword() async {
    if (!state.isValid) {
      return false;
    }

    state = state.copyWith(isLoading: true);
    // TODO: 실제 비밀번호 설정 로직 구현
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
    return true;
  }

  /// 로그인 API 호출 (Login 모드일 때 사용)
  Future<bool> login(String email) async {
    if (!state.isValid) return false;

    try {
      state = state.copyWith(isLoading: true);
      final usecase = ref.read(loginUsecaseProvider);
      final success = await usecase.call(email, state.password);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      rethrow;
    }
  }
}
