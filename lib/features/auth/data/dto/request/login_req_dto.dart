/// 로그인 요청 DTO
class LoginReqDto {
  const LoginReqDto({required this.loginId, required this.loginPw});

  final String loginId;
  final String loginPw;

  Map<String, dynamic> toMap() {
    return {'loginId': loginId, 'loginPw': loginPw};
  }
}
