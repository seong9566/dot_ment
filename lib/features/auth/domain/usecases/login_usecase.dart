import 'package:dot_ment/features/auth/domain/repositories/auth_repository.dart';

/// 로그인 UseCase
class LoginUsecase {
  const LoginUsecase(this._repository);

  final AuthRepository _repository;

  Future<bool> call(String email, String password) async {
    return _repository.login(email, password);
  }
}
