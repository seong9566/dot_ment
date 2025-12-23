import 'package:dot_ment/features/auth/domain/repositories/auth_repository.dart';

/// 이메일 인증 코드를 확인하는 UseCase
class VerifyCodeUsecase {
  const VerifyCodeUsecase(this._repository);

  final AuthRepository _repository;

  /// [email]과 [code]를 확인합니다. 성공 시 true를 반환합니다.
  Future<bool> call(String email, String code) async {
    return _repository.verifyCode(email, code);
  }
}
