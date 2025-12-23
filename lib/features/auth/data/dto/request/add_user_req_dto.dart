/// 회원가입 완료(사용자 추가) 요청 DTO
class AddUserReqDto {
  const AddUserReqDto({required this.loginId, required this.loginPw});

  final String loginId;
  final String loginPw;

  Map<String, dynamic> toMap() {
    return {'loginId': loginId, 'loginPw': loginPw};
  }
}
