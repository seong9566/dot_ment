/// 인증 관련 Repository 인터페이스
abstract class AuthRepository {
  /// 이메일로 인증 코드 전송
  Future<bool> sendVerificationCode(String email);

  /// 인증 코드 확인
  Future<bool> verifyCode(String email, String code);

  /// 회원가입
  Future<bool> addUser(String email, String password);

  /// 로그인
  Future<bool> login(String email, String password);
}
