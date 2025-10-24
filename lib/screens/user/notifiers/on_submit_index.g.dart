// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'on_submit_index.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(OnSubmitIndex)
const onSubmitIndexProvider = OnSubmitIndexProvider._();

final class OnSubmitIndexProvider
    extends $NotifierProvider<OnSubmitIndex, int> {
  const OnSubmitIndexProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'onSubmitIndexProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$onSubmitIndexHash();

  @$internal
  @override
  OnSubmitIndex create() => OnSubmitIndex();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$onSubmitIndexHash() => r'b92af277a2cff7f92549df96e19cb7441ce25f6c';

abstract class _$OnSubmitIndex extends $Notifier<int> {
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
