// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_flow_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DataFlowState)
const dataFlowStateProvider = DataFlowStateProvider._();

final class DataFlowStateProvider
    extends $NotifierProvider<DataFlowState, List<DataflowModel>> {
  const DataFlowStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataFlowStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataFlowStateHash();

  @$internal
  @override
  DataFlowState create() => DataFlowState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<DataflowModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<DataflowModel>>(value),
    );
  }
}

String _$dataFlowStateHash() => r'4bf0de17312e2315323aa1845315f0b4a876b001';

abstract class _$DataFlowState extends $Notifier<List<DataflowModel>> {
  List<DataflowModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<DataflowModel>, List<DataflowModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<DataflowModel>, List<DataflowModel>>,
              List<DataflowModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
