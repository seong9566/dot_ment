/// 인증 코드 확인 요청 DTO
class VerifyCodeReqDto {
  const VerifyCodeReqDto({required this.email, required this.code});

  final String email;
  final String code;

  Map<String, dynamic> toMap() {
    return {'email': email, 'code': code};
  }
}
