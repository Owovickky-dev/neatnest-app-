// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_display_data_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeDisplayDataState)
const homeDisplayDataStateProvider = HomeDisplayDataStateProvider._();

final class HomeDisplayDataStateProvider
    extends $NotifierProvider<HomeDisplayDataState, bool> {
  const HomeDisplayDataStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeDisplayDataStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeDisplayDataStateHash();

  @$internal
  @override
  HomeDisplayDataState create() => HomeDisplayDataState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$homeDisplayDataStateHash() =>
    r'd5be014501952501ae2cde831b2ddc15d63b7ab8';

abstract class _$HomeDisplayDataState extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
