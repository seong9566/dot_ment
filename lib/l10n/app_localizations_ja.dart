// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get auth_feature_business_channel => '自分専用のビジネスチャネル';

  @override
  String get auth_feature_easy_management => 'スマートフォンで簡単に管理';

  @override
  String get auth_feature_free_page => '無料ページ提供';

  @override
  String get auth_join => '会員登録';

  @override
  String get auth_login => 'ログイン';

  @override
  String get auth_auto_login => '自動ログイン';

  @override
  String auth_terms_agreement(String tos, String pp) {
    return '会員登録により、$tosおよび$pp에동의したものとみなされます。';
  }

  @override
  String get auth_terms_of_service => '利用規約';

  @override
  String get auth_privacy_policy => 'プライバシーポリシー';

  @override
  String get email_input_title => 'DOTMENT';

  @override
  String get email_input_subtitle => 'メールで始める';

  @override
  String get email_input_label => 'メール';

  @override
  String get email_input_hint => 'メールアドレスを入力してください';

  @override
  String get email_input_send_code => '認証코드送信';

  @override
  String get email_input_login_prompt_prefix => '既にアカウントをお持ちですか？ ';

  @override
  String get email_input_login_prompt_button => 'ログイン';

  @override
  String get email_verify_title => 'メール認証';

  @override
  String get email_verify_instruction => 'メールに送信された\n6桁の認証コードを入力してください。';

  @override
  String get email_verify_resend_prompt => '認証コードが届きませんか？ ';

  @override
  String get email_verify_resend_button => '再送信';

  @override
  String get email_verify_next_button => '確認';

  @override
  String get email_verify_missing_email => 'メールアドレス가ありません';

  @override
  String get password_setting_title => 'パスワード';

  @override
  String get password_setting_subtitle => '使用するパスワードを設定してください';

  @override
  String get password_setting_requirement_title => 'パスワード要件';

  @override
  String get password_setting_requirement_min_length => '少なくとも8文字以上';

  @override
  String get password_setting_requirement_letter => '英字を含める [ A-Z ]';

  @override
  String get password_setting_requirement_number => '숫자を含める [ 0-9 ]';

  @override
  String get password_setting_requirement_special =>
      '記号を含める [ ! @ # \$ % ^ & * ( ) ]';

  @override
  String get password_setting_input_label => 'パスワード';

  @override
  String get password_setting_input_hint => 'パスワードを入力してください';

  @override
  String get password_setting_final_step => '最終ステップ';

  @override
  String get password_check_title => 'パスワード確認';

  @override
  String get password_check_subtitle => 'パスワードをもう一度入力してください';

  @override
  String get password_check_input_hint => 'パスワードの再入力';

  @override
  String get password_check_error => 'パスワードが一致しません';

  @override
  String get password_check_finish => '完了';
}
