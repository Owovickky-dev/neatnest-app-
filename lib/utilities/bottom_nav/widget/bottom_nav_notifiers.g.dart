// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bottom_nav_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BottomNavNotifiers)
const bottomNavNotifiersProvider = BottomNavNotifiersProvider._();

final class BottomNavNotifiersProvider
    extends $NotifierProvider<BottomNavNotifiers, int> {
  const BottomNavNotifiersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bottomNavNotifiersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bottomNavNotifiersHash();

  @$internal
  @override
  BottomNavNotifiers create() => BottomNavNotifiers();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$bottomNavNotifiersHash() =>
    r'5d76edd1a74e153de340e17bbc309f1997cd6e07';

abstract class _$BottomNavNotifiers extends $Notifier<int> {
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
