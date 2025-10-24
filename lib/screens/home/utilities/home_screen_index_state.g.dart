// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_index_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeScreenIndexState)
const homeScreenIndexStateProvider = HomeScreenIndexStateProvider._();

final class HomeScreenIndexStateProvider
    extends $NotifierProvider<HomeScreenIndexState, int> {
  const HomeScreenIndexStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeScreenIndexStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeScreenIndexStateHash();

  @$internal
  @override
  HomeScreenIndexState create() => HomeScreenIndexState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$homeScreenIndexStateHash() =>
    r'6d464eafe9082e898d06abb539760964de7b83cb';

abstract class _$HomeScreenIndexState extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
