// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_update_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserDataUpdateState)
const userDataUpdateStateProvider = UserDataUpdateStateProvider._();

final class UserDataUpdateStateProvider
    extends $NotifierProvider<UserDataUpdateState, EditUserInfoModel?> {
  const UserDataUpdateStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userDataUpdateStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userDataUpdateStateHash();

  @$internal
  @override
  UserDataUpdateState create() => UserDataUpdateState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EditUserInfoModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EditUserInfoModel?>(value),
    );
  }
}

String _$userDataUpdateStateHash() =>
    r'4ca6c36e2427298c94274d05caab9b46368c5f47';

abstract class _$UserDataUpdateState extends $Notifier<EditUserInfoModel?> {
  EditUserInfoModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<EditUserInfoModel?, EditUserInfoModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<EditUserInfoModel?, EditUserInfoModel?>,
              EditUserInfoModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
