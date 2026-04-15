// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_initializer_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppInitializerController)
const appInitializerControllerProvider = AppInitializerControllerProvider._();

final class AppInitializerControllerProvider
    extends $AsyncNotifierProvider<AppInitializerController, void> {
  const AppInitializerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appInitializerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appInitializerControllerHash();

  @$internal
  @override
  AppInitializerController create() => AppInitializerController();
}

String _$appInitializerControllerHash() =>
    r'ce3dd142866200d1f9d4e0ae0de1e9d254c270d1';

abstract class _$AppInitializerController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleValue(ref, null);
  }
}
