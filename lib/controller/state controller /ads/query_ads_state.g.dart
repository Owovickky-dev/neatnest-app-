// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_ads_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QueryAdsState)
const queryAdsStateProvider = QueryAdsStateProvider._();

final class QueryAdsStateProvider
    extends $NotifierProvider<QueryAdsState, AsyncValue<List<AdsModel>>> {
  const QueryAdsStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queryAdsStateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queryAdsStateHash();

  @$internal
  @override
  QueryAdsState create() => QueryAdsState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<AdsModel>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<AdsModel>>>(value),
    );
  }
}

String _$queryAdsStateHash() => r'154c2076087cf72e909157d67190c766b2eef59a';

abstract class _$QueryAdsState extends $Notifier<AsyncValue<List<AdsModel>>> {
  AsyncValue<List<AdsModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<List<AdsModel>>, AsyncValue<List<AdsModel>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<AdsModel>>,
                AsyncValue<List<AdsModel>>
              >,
              AsyncValue<List<AdsModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
