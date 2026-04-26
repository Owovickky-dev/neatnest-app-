// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_service_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PopularServiceController)
const popularServiceControllerProvider = PopularServiceControllerProvider._();

final class PopularServiceControllerProvider
    extends $NotifierProvider<PopularServiceController, List<AdsModel>> {
  const PopularServiceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popularServiceControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popularServiceControllerHash();

  @$internal
  @override
  PopularServiceController create() => PopularServiceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AdsModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AdsModel>>(value),
    );
  }
}

String _$popularServiceControllerHash() =>
    r'3185d7224339e18b05b1d1c449ee792b3d28b4e5';

abstract class _$PopularServiceController extends $Notifier<List<AdsModel>> {
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
