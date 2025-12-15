// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_verification_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 이메일 코드 확인 ViewModel

@ProviderFor(EmailVerificationViewModel)
const emailVerificationViewModelProvider =
    EmailVerificationViewModelProvider._();

/// 이메일 코드 확인 ViewModel
final class EmailVerificationViewModelProvider
    extends
        $NotifierProvider<EmailVerificationViewModel, EmailVerificationState> {
  /// 이메일 코드 확인 ViewModel
  const EmailVerificationViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailVerificationViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailVerificationViewModelHash();

  @$internal
  @override
  EmailVerificationViewModel create() => EmailVerificationViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailVerificationState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailVerificationState>(value),
    );
  }
}

String _$emailVerificationViewModelHash() =>
    r'd334ccfac59fd0dd375ab45cdf65f53a8a107f08';

/// 이메일 코드 확인 ViewModel

abstract class _$EmailVerificationViewModel
    extends $Notifier<EmailVerificationState> {
  EmailVerificationState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<EmailVerificationState, EmailVerificationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmailVerificationState, EmailVerificationState>,
              EmailVerificationState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
