// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_logged_in_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IsLoggedInState)
const isLoggedInStateProvider = IsLoggedInStateProvider._();

final class IsLoggedInStateProvider
    extends $NotifierProvider<IsLoggedInState, bool> {
  const IsLoggedInStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoggedInStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoggedInStateHash();

  @$internal
  @override
  IsLoggedInState create() => IsLoggedInState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoggedInStateHash() => r'5e1f28fa0f886c975f6f5aa628c4ac3d679138b4';

abstract class _$IsLoggedInState extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
