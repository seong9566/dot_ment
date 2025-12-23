import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
  ];

  /// No description provided for @auth_feature_business_channel.
  ///
  /// In en, this message translates to:
  /// **'Build\nYour Channel'**
  String get auth_feature_business_channel;

  /// No description provided for @auth_feature_easy_management.
  ///
  /// In en, this message translates to:
  /// **'Edit Design\non Mobile'**
  String get auth_feature_easy_management;

  /// No description provided for @auth_feature_free_page.
  ///
  /// In en, this message translates to:
  /// **'Free Page'**
  String get auth_feature_free_page;

  /// No description provided for @auth_join.
  ///
  /// In en, this message translates to:
  /// **'Join'**
  String get auth_join;

  /// No description provided for @auth_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get auth_login;

  /// No description provided for @auth_auto_login.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get auth_auto_login;

  /// No description provided for @auth_terms_agreement.
  ///
  /// In en, this message translates to:
  /// **'By signing up, you agree to the {tos} and {pp}.'**
  String auth_terms_agreement(String tos, String pp);

  /// No description provided for @auth_terms_of_service.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get auth_terms_of_service;

  /// No description provided for @auth_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get auth_privacy_policy;

  /// No description provided for @email_input_title.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_input_title;

  /// No description provided for @email_input_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get email_input_subtitle;

  /// No description provided for @email_input_label.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email_input_label;

  /// No description provided for @email_input_hint.
  ///
  /// In en, this message translates to:
  /// **'please enter your email address'**
  String get email_input_hint;

  /// No description provided for @email_input_send_code.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get email_input_send_code;

  /// No description provided for @email_input_login_prompt_prefix.
  ///
  /// In en, this message translates to:
  /// **'Do you have account already? '**
  String get email_input_login_prompt_prefix;

  /// No description provided for @email_verify_title.
  ///
  /// In en, this message translates to:
  /// **'Check your Email'**
  String get email_verify_title;

  /// No description provided for @email_verify_instruction.
  ///
  /// In en, this message translates to:
  /// **'We sent a verify code,\nplease check your mail box'**
  String get email_verify_instruction;

  /// No description provided for @email_verify_resend_prompt.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t have a Verify Code? '**
  String get email_verify_resend_prompt;

  /// No description provided for @email_verify_resend_button.
  ///
  /// In en, this message translates to:
  /// **'Re Send'**
  String get email_verify_resend_button;

  /// No description provided for @email_verify_next_button.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get email_verify_next_button;

  /// No description provided for @email_verify_missing_email.
  ///
  /// In en, this message translates to:
  /// **'No email provided'**
  String get email_verify_missing_email;

  /// No description provided for @password_setting_title.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_setting_title;

  /// No description provided for @password_setting_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please setting your save password'**
  String get password_setting_subtitle;

  /// No description provided for @password_setting_requirement_title.
  ///
  /// In en, this message translates to:
  /// **'Password requirements'**
  String get password_setting_requirement_title;

  /// No description provided for @password_setting_requirement_min_length.
  ///
  /// In en, this message translates to:
  /// **'Minimum 8 characters'**
  String get password_setting_requirement_min_length;

  /// No description provided for @password_setting_requirement_letter.
  ///
  /// In en, this message translates to:
  /// **'Minimum one letter [ A-Z ]'**
  String get password_setting_requirement_letter;

  /// No description provided for @password_setting_requirement_number.
  ///
  /// In en, this message translates to:
  /// **'Minimum one number [ 0-9 ]'**
  String get password_setting_requirement_number;

  /// No description provided for @password_setting_requirement_special.
  ///
  /// In en, this message translates to:
  /// **'Minimum one special character [ ! @ # \$ % ^ & * ( ) ]'**
  String get password_setting_requirement_special;

  /// No description provided for @password_setting_input_label.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password_setting_input_label;

  /// No description provided for @password_setting_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get password_setting_input_hint;

  /// No description provided for @password_setting_final_step.
  ///
  /// In en, this message translates to:
  /// **'Final step'**
  String get password_setting_final_step;

  /// No description provided for @password_check_title.
  ///
  /// In en, this message translates to:
  /// **'Password Check'**
  String get password_check_title;

  /// No description provided for @password_check_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password again'**
  String get password_check_subtitle;

  /// No description provided for @password_check_input_hint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get password_check_input_hint;

  /// No description provided for @password_check_error.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get password_check_error;

  /// No description provided for @password_check_finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get password_check_finish;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
