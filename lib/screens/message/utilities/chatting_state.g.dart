// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chatting_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChattingState)
const chattingStateProvider = ChattingStateProvider._();

final class ChattingStateProvider
    extends $NotifierProvider<ChattingState, bool> {
  const ChattingStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chattingStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chattingStateHash();

  @$internal
  @override
  ChattingState create() => ChattingState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$chattingStateHash() => r'47223a9b4b0d38805d97e2837f0e37503f652f1b';

abstract class _$ChattingState extends $Notifier<bool> {
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
