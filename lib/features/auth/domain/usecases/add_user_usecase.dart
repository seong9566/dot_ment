import 'package:dot_ment/features/auth/domain/repositories/auth_repository.dart';

/// 회원가입을 완료(사용자 추가)하는 UseCase
class AddUserUsecase {
  const AddUserUsecase(this._repository);

  final AuthRepository _repository;

  /// [email]과 [password]로 사용자를 등록합니다. 성공 시 true를 반환합니다.
  Future<bool> call(String email, String password) async {
    return _repository.addUser(email, password);
  }
}
