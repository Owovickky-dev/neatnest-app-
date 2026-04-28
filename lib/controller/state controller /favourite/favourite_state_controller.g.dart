// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavouriteStateController)
const favouriteStateControllerProvider = FavouriteStateControllerProvider._();

final class FavouriteStateControllerProvider
    extends $NotifierProvider<FavouriteStateController, List<FavouriteModel>> {
  const FavouriteStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouriteStateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouriteStateControllerHash();

  @$internal
  @override
  FavouriteStateController create() => FavouriteStateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FavouriteModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FavouriteModel>>(value),
    );
  }
}

String _$favouriteStateControllerHash() =>
    r'0e75d5ee230e60f06f2bd28bfcfa845f598678c4';

abstract class _$FavouriteStateController
    extends $Notifier<List<FavouriteModel>> {
  List<FavouriteModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<FavouriteModel>, List<FavouriteModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FavouriteModel>, List<FavouriteModel>>,
              List<FavouriteModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
