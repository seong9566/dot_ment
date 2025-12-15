import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_setting_viewmodel.g.dart';

/// 비밀번호 설정 화면 상태
class PasswordSettingState {
  const PasswordSettingState({
    this.password = '',
    this.hasCapitalLetter = false,
    this.hasNumber = false,
    this.hasSymbol = false,
    this.isLoading = false,
  });

  final String password;
  final bool hasCapitalLetter;
  final bool hasNumber;
  final bool hasSymbol;
  final bool isLoading;

  bool get isValid => hasCapitalLetter && hasNumber && hasSymbol;

  PasswordSettingState copyWith({
    String? password,
    bool? hasCapitalLetter,
    bool? hasNumber,
    bool? hasSymbol,
    bool? isLoading,
  }) {
    return PasswordSettingState(
      password: password ?? this.password,
      hasCapitalLetter: hasCapitalLetter ?? this.hasCapitalLetter,
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
    final hasCapitalLetter = password.contains(RegExp(r'[A-Z]'));
    final hasNumber = password.contains(RegExp(r'[0-9]'));
    final hasSymbol = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    state = state.copyWith(
      password: password,
      hasCapitalLetter: hasCapitalLetter,
      hasNumber: hasNumber,
      hasSymbol: hasSymbol,
    );
  }

  Future<bool> submitPassword() async {
    if (!state.isValid) {
      // TODO: 에러 메시지 표시
      return false;
    }

    state = state.copyWith(isLoading: true);
    // TODO: 실제 비밀번호 설정 로직 구현
    await Future.delayed(const Duration(seconds: 1));
    state = state.copyWith(isLoading: false);
    return true;
  }
}

