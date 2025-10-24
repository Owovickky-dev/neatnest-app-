// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'index_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IndexState)
const indexStateProvider = IndexStateProvider._();

final class IndexStateProvider extends $NotifierProvider<IndexState, int> {
  const IndexStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'indexStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$indexStateHash();

  @$internal
  @override
  IndexState create() => IndexState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$indexStateHash() => r'90c6cc13c1437df166bb7de0fa44e5f5748cc174';

abstract class _$IndexState extends $Notifier<int> {
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
