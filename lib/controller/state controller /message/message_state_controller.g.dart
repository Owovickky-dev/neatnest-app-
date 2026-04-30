// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_state_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MessageStateController)
const messageStateControllerProvider = MessageStateControllerProvider._();

final class MessageStateControllerProvider
    extends
        $AsyncNotifierProvider<MessageStateController, MessagePaginationState> {
  const MessageStateControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'messageStateControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$messageStateControllerHash();

  @$internal
  @override
  MessageStateController create() => MessageStateController();
}

String _$messageStateControllerHash() =>
    r'2ebe4b53a3adfc5144b17949bb38d7dfe8a843f8';

abstract class _$MessageStateController
    extends $AsyncNotifier<MessagePaginationState> {
  FutureOr<MessagePaginationState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref
            as $Ref<AsyncValue<MessagePaginationState>, MessagePaginationState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<MessagePaginationState>,
                MessagePaginationState
              >,
              AsyncValue<MessagePaginationState>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
