// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AddressStateController)
const addressStateControllerProvider = AddressStateControllerProvider._();

final class AddressStateControllerProvider
    extends $NotifierProvider<AddressStateController, List<UserLocationModel>> {
  const AddressStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'addressStateControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$addressStateControllerHash();

  @$internal
  @override
  AddressStateController create() => AddressStateController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<UserLocationModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<UserLocationModel>>(value),
    );
  }
}

String _$addressStateControllerHash() =>
    r'5c6eb859b80eb7db36dbe3ab237eb70b0d0d1365';

abstract class _$AddressStateController
    extends $Notifier<List<UserLocationModel>> {
  List<UserLocationModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<UserLocationModel>, List<UserLocationModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<UserLocationModel>, List<UserLocationModel>>,
              List<UserLocationModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
