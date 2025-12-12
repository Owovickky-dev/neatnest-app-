// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_ads_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserAdsStateController)
const userAdsStateControllerProvider = UserAdsStateControllerProvider._();

final class UserAdsStateControllerProvider
    extends $NotifierProvider<UserAdsStateController, UserAdsModel?> {
  const UserAdsStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userAdsStateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userAdsStateControllerHash();

  @$internal
  @override
  UserAdsStateController create() => UserAdsStateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserAdsModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserAdsModel?>(value),
    );
  }
}

String _$userAdsStateControllerHash() =>
    r'9939071678c1e2cee82917a79ee941a0d0e7f9ca';

abstract class _$UserAdsStateController extends $Notifier<UserAdsModel?> {
  UserAdsModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserAdsModel?, UserAdsModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserAdsModel?, UserAdsModel?>,
              UserAdsModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
