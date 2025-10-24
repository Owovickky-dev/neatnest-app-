// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FilterState)
const filterStateProvider = FilterStateProvider._();

final class FilterStateProvider
    extends $NotifierProvider<FilterState, FilterSearchModel?> {
  const FilterStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filterStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filterStateHash();

  @$internal
  @override
  FilterState create() => FilterState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FilterSearchModel? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FilterSearchModel?>(value),
    );
  }
}

String _$filterStateHash() => r'e8800b925a5ecb1f942e76da4f267bbdb089d0bd';

abstract class _$FilterState extends $Notifier<FilterSearchModel?> {
  FilterSearchModel? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<FilterSearchModel?, FilterSearchModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FilterSearchModel?, FilterSearchModel?>,
              FilterSearchModel?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
