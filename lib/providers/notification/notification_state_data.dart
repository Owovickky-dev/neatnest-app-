import 'package:neat_nest/models/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_state_data.g.dart';

@riverpod
class NotificationStateData extends _$NotificationStateData {
  @override
  List<NotificationModel> build() {
    return [];
  }

  void getNotificationData(NotificationModel notifications) {
    state = [...state, notifications];
  }
}
