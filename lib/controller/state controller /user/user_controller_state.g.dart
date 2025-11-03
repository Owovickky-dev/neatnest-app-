// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserControllerState)
const userControllerStateProvider = UserControllerStateProvider._();

final class UserControllerStateProvider
    extends $NotifierProvider<UserControllerState, UserModel?> {
  const UserControllerStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userControllerStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userControllerStateHash();

  @$internal
  @override
  UserControllerState create() => UserControllerState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserModel?>(value),
    );
  }
}

String _$userControllerStateHash() =>
    r'ab3b8990bed4e7732c8987483585e693fe7fcd92';

abstract class _$UserControllerState extends $Notifier<UserModel?> {
  UserModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserModel?, UserModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserModel?, UserModel?>,
              UserModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
