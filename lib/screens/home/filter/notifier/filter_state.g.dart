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

String _$filterStateHash() => r'badb5bdfd891076d6b4a975dc92ab3fe4bd75c2b';

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
