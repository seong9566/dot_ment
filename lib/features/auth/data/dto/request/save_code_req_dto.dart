/// 인증 코드 전송 요청 DTO
class SaveCodeReqDto {
  const SaveCodeReqDto({required this.email});

  final String email;

  Map<String, dynamic> toMap() {
    return {'email': email};
  }
}
