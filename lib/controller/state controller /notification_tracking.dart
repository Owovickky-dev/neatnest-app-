import 'package:neat_nest/screens/home/notifier/notification_state_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_tracking.g.dart';

@riverpod
int notificationTracking(Ref ref) {
  final notifications = ref.watch(notificationStateProvider);

  return notifications.when(
    loading: () => 0,
    error: (_, _) => 0,
    data: (items) {
      return items
          .where(
            (notification) => !notification.isRead && !notification.isDeleted,
          )
          .length;
    },
  );
}
