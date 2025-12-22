import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'join_viewmodel.g.dart';

/// 회원가입 화면 상태
class JoinState {
  const JoinState({
    this.email = '',
    this.agreeToTerms = false,
    this.isLoading = false,
  });

  final String email;
  final bool agreeToTerms;
  final bool isLoading;

  JoinState copyWith({String? email, bool? agreeToTerms, bool? isLoading}) {
    return JoinState(
      email: email ?? this.email,
      agreeToTerms: agreeToTerms ?? this.agreeToTerms,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// 회원가입 ViewModel
@riverpod
class JoinViewModel extends _$JoinViewModel {
  @override
  JoinState build() {
    return const JoinState();
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
