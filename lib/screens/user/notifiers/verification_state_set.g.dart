// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_state_set.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VerificationStateSet)
const verificationStateSetProvider = VerificationStateSetProvider._();

final class VerificationStateSetProvider
    extends
        $NotifierProvider<VerificationStateSet, List<VerificationStateModel>> {
  const VerificationStateSetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'verificationStateSetProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$verificationStateSetHash();

  @$internal
  @override
  VerificationStateSet create() => VerificationStateSet();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<VerificationStateModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<VerificationStateModel>>(value),
    );
  }
}

String _$verificationStateSetHash() =>
    r'31db7ceacf2e55398d23707c631ddf07577bcfdb';

abstract class _$VerificationStateSet
    extends $Notifier<List<VerificationStateModel>> {
  List<VerificationStateModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<List<VerificationStateModel>, List<VerificationStateModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                List<VerificationStateModel>,
                List<VerificationStateModel>
              >,
              List<VerificationStateModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
