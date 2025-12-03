// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ads_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdsStateController)
const adsStateControllerProvider = AdsStateControllerProvider._();

final class AdsStateControllerProvider
    extends $NotifierProvider<AdsStateController, List<AdsModel>> {
  const AdsStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'adsStateControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$adsStateControllerHash();

  @$internal
  @override
  AdsStateController create() => AdsStateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AdsModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AdsModel>>(value),
    );
  }
}

String _$adsStateControllerHash() =>
    r'f0c222cc5cb76c800f30814b05bf8454da6f6846';

abstract class _$AdsStateController extends $Notifier<List<AdsModel>> {
  List<AdsModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<AdsModel>, List<AdsModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AdsModel>, List<AdsModel>>,
              List<AdsModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
