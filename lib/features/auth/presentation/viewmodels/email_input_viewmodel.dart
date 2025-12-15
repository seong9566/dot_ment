import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'email_input_viewmodel.g.dart';

/// 이메일 입력 화면 상태
class EmailInputState {
  const EmailInputState({
    this.email = '',
    this.agreeToTerms = false,
    this.isLoading = false,
  });

  final String email;
  final bool agreeToTerms;
  final bool isLoading;

  EmailInputState copyWith({
    String? email,
    bool? agreeToTerms,
    bool? isLoading,
  }) {
    return EmailInputState(
      email: email ?? this.email,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 이메일 입력 ViewModel
@riverpod
class EmailInputViewModel extends _$EmailInputViewModel {
  @override
  EmailInputState build() {
    return const EmailInputState();
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

