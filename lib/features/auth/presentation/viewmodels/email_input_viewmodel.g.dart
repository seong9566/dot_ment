// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email_input_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 이메일 입력 ViewModel

@ProviderFor(EmailInputViewModel)
const emailInputViewModelProvider = EmailInputViewModelProvider._();

/// 이메일 입력 ViewModel
final class EmailInputViewModelProvider
    extends $NotifierProvider<EmailInputViewModel, EmailInputState> {
  /// 이메일 입력 ViewModel
  const EmailInputViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'emailInputViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$emailInputViewModelHash();

  @$internal
  @override
  EmailInputViewModel create() => EmailInputViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EmailInputState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EmailInputState>(value),
    );
  }
}

String _$emailInputViewModelHash() =>
    r'dce60f9191cc18f8e0c5723e3c0b84bbb83fed12';

/// 이메일 입력 ViewModel

abstract class _$EmailInputViewModel extends $Notifier<EmailInputState> {
  EmailInputState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EmailInputState, EmailInputState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EmailInputState, EmailInputState>,
              EmailInputState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
