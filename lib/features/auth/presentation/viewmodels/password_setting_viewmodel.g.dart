// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_setting_viewmodel.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// 비밀번호 설정 ViewModel

@ProviderFor(PasswordSettingViewModel)
const passwordSettingViewModelProvider = PasswordSettingViewModelProvider._();

/// 비밀번호 설정 ViewModel
final class PasswordSettingViewModelProvider
    extends $NotifierProvider<PasswordSettingViewModel, PasswordSettingState> {
  /// 비밀번호 설정 ViewModel
  const PasswordSettingViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'passwordSettingViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$passwordSettingViewModelHash();

  @$internal
  @override
  PasswordSettingViewModel create() => PasswordSettingViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PasswordSettingState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PasswordSettingState>(value),
    );
  }
}

String _$passwordSettingViewModelHash() =>
    r'673899186c9959368d91dc0d84b7cdb36868b43a';

/// 비밀번호 설정 ViewModel

abstract class _$PasswordSettingViewModel
    extends $Notifier<PasswordSettingState> {
  PasswordSettingState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PasswordSettingState, PasswordSettingState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PasswordSettingState, PasswordSettingState>,
              PasswordSettingState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
