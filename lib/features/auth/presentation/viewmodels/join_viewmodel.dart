import 'package:dot_ment/core/utils/error_handler.dart';
import 'package:dot_ment/features/auth/presentation/providers/auth_providers_di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'join_viewmodel.g.dart';

/// 회원가입 화면 상태
class JoinState {
  const JoinState({this.email = '', this.isLoading = false, this.errorMessage});

  final String email;
  final bool isLoading;
  final String? errorMessage;

  JoinState copyWith({String? email, bool? isLoading, String? errorMessage}) {
    return JoinState(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
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
    state = state.copyWith(email: email, errorMessage: null);
  }

  /// 인증 코드 전송 API 호출
  Future<bool> sendCode() async {
    try {
      state = state.copyWith(isLoading: true, errorMessage: null);

      final usecase = ref.read(sendVerificationCodeUsecaseProvider);
      final success = await usecase.call(state.email);

      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: handleError(e));
      return false;
    }
  }
}
