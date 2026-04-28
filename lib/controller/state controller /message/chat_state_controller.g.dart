// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatStateController)
const chatStateControllerProvider = ChatStateControllerProvider._();

final class ChatStateControllerProvider
    extends $AsyncNotifierProvider<ChatStateController, List<ChatRoomModel>> {
  const ChatStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatStateControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatStateControllerHash();

  @$internal
  @override
  ChatStateController create() => ChatStateController();
}

String _$chatStateControllerHash() =>
    r'f5d25ea04f6e16898beb07d3bdbf8a56a48db06b';

abstract class _$ChatStateController
    extends $AsyncNotifier<List<ChatRoomModel>> {
  FutureOr<List<ChatRoomModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<ChatRoomModel>>, List<ChatRoomModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ChatRoomModel>>, List<ChatRoomModel>>,
              AsyncValue<List<ChatRoomModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
