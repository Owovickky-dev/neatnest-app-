// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms_count_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RoomsCountState)
const roomsCountStateProvider = RoomsCountStateFamily._();

final class RoomsCountStateProvider
    extends $NotifierProvider<RoomsCountState, int> {
  const RoomsCountStateProvider._({
    required RoomsCountStateFamily super.from,
    required int super.argument,
  }) : super(
         retry: null,
         name: r'roomsCountStateProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$roomsCountStateHash();

  @override
  String toString() {
    return r'roomsCountStateProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  RoomsCountState create() => RoomsCountState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is RoomsCountStateProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$roomsCountStateHash() => r'f605cc3f52d844bf6641cf1748ded64bdd8c640b';

final class RoomsCountStateFamily extends $Family
    with $ClassFamilyOverride<RoomsCountState, int, int, int, int> {
  const RoomsCountStateFamily._()
    : super(
        retry: null,
        name: r'roomsCountStateProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  RoomsCountStateProvider call(int index) =>
      RoomsCountStateProvider._(argument: index, from: this);

  @override
  String toString() => r'roomsCountStateProvider';
}

abstract class _$RoomsCountState extends $Notifier<int> {
  late final _$args = ref.$arg as int;
  int get index => _$args;

  int build(int index);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
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
