// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'query_data_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(QueryDataController)
const queryDataControllerProvider = QueryDataControllerProvider._();

final class QueryDataControllerProvider
    extends $AsyncNotifierProvider<QueryDataController, List<AdsModel>> {
  const QueryDataControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'queryDataControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$queryDataControllerHash();

  @$internal
  @override
  QueryDataController create() => QueryDataController();
}

String _$queryDataControllerHash() =>
    r'2bb0167bd0ac8dd4cfd100ba751ddc0c05211652';

abstract class _$QueryDataController extends $AsyncNotifier<List<AdsModel>> {
  FutureOr<List<AdsModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<AdsModel>>, List<AdsModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<AdsModel>>, List<AdsModel>>,
              AsyncValue<List<AdsModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
