// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_list_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddressListState)
const addressListStateProvider = AddressListStateProvider._();

final class AddressListStateProvider
    extends $NotifierProvider<AddressListState, List<AddressAddingModel>> {
  const AddressListStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addressListStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addressListStateHash();

  @$internal
  @override
  AddressListState create() => AddressListState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<AddressAddingModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<AddressAddingModel>>(value),
    );
  }
}

String _$addressListStateHash() => r'73c1327d12bbc3efeeadcf6efe4f36726aa7c6f1';

abstract class _$AddressListState extends $Notifier<List<AddressAddingModel>> {
  List<AddressAddingModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<AddressAddingModel>, List<AddressAddingModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<AddressAddingModel>, List<AddressAddingModel>>,
              List<AddressAddingModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
