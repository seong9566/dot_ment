import 'package:dot_ment/features/auth/domain/repositories/auth_repository.dart';

/// 이메일 인증 코드를 전송하는 UseCase
class SendVerificationCodeUsecase {
  const SendVerificationCodeUsecase(this._repository);

  final AuthRepository _repository;

  /// [email]로 인증 코드를 전송합니다. 성공 시 true를 반환합니다.
  Future<bool> call(String email) async {
    return _repository.sendVerificationCode(email);
  }
}
