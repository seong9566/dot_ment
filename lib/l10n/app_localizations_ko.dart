// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get auth_feature_business_channel => '나만의\n비즈니스 채널';

  @override
  String get auth_feature_easy_management => '스마트폰으로\n간편하게 관리';

  @override
  String get auth_feature_free_page => '무료 페이지 제공';

  @override
  String get auth_join => '회원 가입';

  @override
  String get auth_login => '로그인';

  @override
  String get auth_auto_login => '자동 로그인';

  @override
  String auth_terms_agreement(String tos, String pp) {
    return '회원가입 시, $tos 및 $pp에 동의합니다.';
  }

  @override
  String get auth_terms_of_service => '서비스 약관';

  @override
  String get auth_privacy_policy => '개인정보 보호정책';

  @override
  String get email_input_title => '이메일';

  @override
  String get email_input_subtitle => '이메일로 시작하기';

  @override
  String get email_input_label => '이메일';

  @override
  String get email_input_hint => '이메일을 입력해주세요';

  @override
  String get email_input_send_code => '인증코드 전송';

  @override
  String get email_input_login_prompt_prefix => '이미 계정이 있으신가요? ';

  @override
  String get email_verify_title => '이메일 인증';

  @override
  String get email_verify_instruction => '이메일로 전송된\n6자리 인증코드를 입력해주세요.';

  @override
  String get email_verify_resend_prompt => '인증코드를 받지 못했나요? ';

  @override
  String get email_verify_resend_button => '재전송';

  @override
  String get email_verify_next_button => '확인';

  @override
  String get email_verify_missing_email => '이메일이 없어요';

  @override
  String get password_setting_title => '비밀번호';

  @override
  String get password_setting_subtitle => '사용하실 비밀번호를 설정해주세요';

  @override
  String get password_setting_requirement_title => '비밀번호 요구사항';

  @override
  String get password_setting_requirement_min_length => '최소 8자 이상';

  @override
  String get password_setting_requirement_letter => '영문자 포함 [ A-Z ]';

  @override
  String get password_setting_requirement_number => '숫자 포함 [ 0-9 ]';

  @override
  String get password_setting_requirement_special =>
      '특수문자 포함 [ ! @ # \$ % ^ & * ( ) ]';

  @override
  String get password_setting_input_label => '비밀번호';

  @override
  String get password_setting_input_hint => '비밀번호를 입력해주세요';

  @override
  String get password_setting_final_step => '다음 단계';

  @override
  String get password_check_title => '비밀번호 확인';

  @override
  String get password_check_subtitle => '비밀번호를 한번 더 입력해주세요';

  @override
  String get password_check_input_hint => '비밀번호를 입력해 주세요';

  @override
  String get password_check_error => '비밀번호가 일치하지 않습니다';

  @override
  String get password_check_finish => '가입완료';
}
