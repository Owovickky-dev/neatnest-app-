// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MessagesState)
const messagesStateProvider = MessagesStateProvider._();

final class MessagesStateProvider
    extends $NotifierProvider<MessagesState, List<ChatMessageModel>> {
  const MessagesStateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'messagesStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$messagesStateHash();

  @$internal
  @override
  MessagesState create() => MessagesState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ChatMessageModel> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ChatMessageModel>>(value),
    );
  }
}

String _$messagesStateHash() => r'0eb63b564c126cbb00980ded8cb3e86aa09e2fe1';

abstract class _$MessagesState extends $Notifier<List<ChatMessageModel>> {
  List<ChatMessageModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<ChatMessageModel>, List<ChatMessageModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ChatMessageModel>, List<ChatMessageModel>>,
              List<ChatMessageModel>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
