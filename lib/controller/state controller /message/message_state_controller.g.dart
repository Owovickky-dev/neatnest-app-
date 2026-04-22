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
    extends $AsyncNotifierProvider<MessageStateController, List<MessageModel>> {
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
    r'963160f4dedb828ef8905ebd20914dc8891f5bb7';

abstract class _$MessageStateController
    extends $AsyncNotifier<List<MessageModel>> {
  FutureOr<List<MessageModel>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<AsyncValue<List<MessageModel>>, List<MessageModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<MessageModel>>, List<MessageModel>>,
              AsyncValue<List<MessageModel>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
