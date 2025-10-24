// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_add_index_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedAddIndexState)
const selectedAddIndexStateProvider = SelectedAddIndexStateProvider._();

final class SelectedAddIndexStateProvider
    extends $NotifierProvider<SelectedAddIndexState, int> {
  const SelectedAddIndexStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedAddIndexStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedAddIndexStateHash();

  @$internal
  @override
  SelectedAddIndexState create() => SelectedAddIndexState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedAddIndexStateHash() =>
    r'90bc0ef3b3747a98037d5f76c9073c10c42c40c4';

abstract class _$SelectedAddIndexState extends $Notifier<int> {
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
