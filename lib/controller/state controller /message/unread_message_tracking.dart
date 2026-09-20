import 'package:neat_nest/controller/state%20controller%20/message/message_state_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'unread_message_tracking.g.dart';

@riverpod
int unreadMessageTracking(Ref ref) {
  final unreadMessages = ref.watch(messageStateControllerProvider);

  return unreadMessages.when(
    loading: () => 0,
    error: (_, _) => 0,
    data: (message) {
      return message.unreadMessageCount;
    },
  );
}
