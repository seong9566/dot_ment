// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get auth_feature_business_channel => 'Build\nYour Channel';

  @override
  String get auth_feature_easy_management => 'Edit Design\non Mobile';

  @override
  String get auth_feature_free_page => 'Free Page';

  @override
  String get auth_join => 'Join';

  @override
  String get auth_login => 'Login';

  @override
  String get auth_auto_login => 'Remember me';

  @override
  String auth_terms_agreement(String tos, String pp) {
    return 'By signing up, you agree to the $tos and $pp.';
  }

  @override
  String get auth_terms_of_service => 'Terms of Service';

  @override
  String get auth_privacy_policy => 'Privacy Policy';

  @override
  String get email_input_title => 'Email';

  @override
  String get email_input_subtitle => 'Enter your email';

  @override
  String get email_input_label => 'Email';

  @override
  String get email_input_hint => 'please enter your email address';

  @override
  String get email_input_send_code => 'Send Code';

  @override
  String get email_input_login_prompt_prefix => 'Do you have account already? ';

  @override
  String get email_verify_title => 'Check your Email';

  @override
  String get email_verify_instruction =>
      'We sent a verify code,\nplease check your mail box';

  @override
  String get email_verify_resend_prompt => 'Couldn\'t have a Verify Code? ';

  @override
  String get email_verify_resend_button => 'Re Send';

  @override
  String get email_verify_next_button => 'Next';

  @override
  String get email_verify_missing_email => 'No email provided';

  @override
  String get password_setting_title => 'Password';

  @override
  String get password_setting_subtitle => 'Please setting your save password';

  @override
  String get password_setting_requirement_title => 'Password requirements';

  @override
  String get password_setting_requirement_min_length => 'Minimum 8 characters';

  @override
  String get password_setting_requirement_letter =>
      'Minimum one letter [ A-Z ]';

  @override
  String get password_setting_requirement_number =>
      'Minimum one number [ 0-9 ]';

  @override
  String get password_setting_requirement_special =>
      'Minimum one special character [ ! @ # \$ % ^ & * ( ) ]';

  @override
  String get password_setting_input_label => 'Password';

  @override
  String get password_setting_input_hint => 'Please enter your password';

  @override
  String get password_setting_final_step => 'Final step';

  @override
  String get password_check_title => 'Password Check';

  @override
  String get password_check_subtitle => 'Please enter your password again';

  @override
  String get password_check_input_hint => 'Confirm Password';

  @override
  String get password_check_error => 'Passwords do not match';

  @override
  String get password_check_finish => 'Finish';
}
