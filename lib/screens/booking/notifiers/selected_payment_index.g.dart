// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_payment_index.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedPaymentIndex)
const selectedPaymentIndexProvider = SelectedPaymentIndexProvider._();

final class SelectedPaymentIndexProvider
    extends $NotifierProvider<SelectedPaymentIndex, int> {
  const SelectedPaymentIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPaymentIndexProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPaymentIndexHash();

  @$internal
  @override
  SelectedPaymentIndex create() => SelectedPaymentIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$selectedPaymentIndexHash() =>
    r'1d63e357b3dab25db113010b9bcbe5bdc60a446a';

abstract class _$SelectedPaymentIndex extends $Notifier<int> {
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
