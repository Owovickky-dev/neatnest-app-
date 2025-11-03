import 'package:neat_nest/models/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_state_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationStateNotifier extends _$NotificationStateNotifier {
  @override
  List<NotificationModel> build() {
    return [];
  }

  // this is used as a default data testing....
  void defaultData() {
    if (state.isEmpty) {
      state = [
        NotificationModel(
          title: "Welcome!",
          message: "Texting today fata for me 🎉",
          datetime: DateTime.now(),
        ),
        NotificationModel(
          title: "Offer",
          message: "You got 20% discount!",
          datetime: DateTime.now().subtract(Duration(hours: 5)),
        ),
        NotificationModel(
          title: "Reminder",
          message: "Your subscription expires soon.",
          datetime: DateTime.now().subtract(Duration(days: 1)),
        ),
        NotificationModel(
          title: "Update",
          message: "New features are available.",
          datetime: DateTime.now().subtract(Duration(days: 4)),
        ),
        NotificationModel(
          title: "Update",
          message: "New features are available.",
          datetime: DateTime.now().subtract(Duration(days: 10)),
        ),
      ];
    }
  }

  // ✅ Add new notification
  void addNotification(NotificationModel notif) {
    state = [...state, notif];
  }

  void markAsRead(String id) {
    // state = [
    //   for (int i = 0; i < state.length; i++)
    //     if (i == index) state[i].copyWith(read: true) else state[i],
    // ]; this is used when using indexof...
    state = [
      for (final notif in state)
        if (notif.id == id) notif.copyWith(read: true) else notif,
    ];
  }

  void delete(String id) {
    // state = [
    //   for (int i = 0; i < state.length; i++)
    //     if (i != index)
    //       state[i], // this work by checking the condition if it true included in the list and if false it not included in the list
    // ];
    state = state.where((n) => n.id != id).toList();
  }

  void markAllAsRead() {
    state = [for (final n in state) n.copyWith(read: true)];
  }

  void emptyNotification() {
    state = [];
  }
}
