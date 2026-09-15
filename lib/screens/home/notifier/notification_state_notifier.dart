import 'package:neat_nest/data/repo/user_data_repo.dart';
import 'package:neat_nest/models/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_state_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationStateNotifier extends _$NotificationStateNotifier {
  late UserDataRepo _userDataRepo;

  bool _haInitialized = false;
  @override
  FutureOr<List<NotificationModel>> build() {
    _userDataRepo = UserDataRepo();
    return [];
  }

  Future<void> initializeNotification() async {
    if (_haInitialized) return;

    _haInitialized = true;
    await getUserNotification();
  }

  Future<void> getUserNotification() async {
    state = const AsyncLoading();
    try {
      final response = await _userDataRepo.getUserNotification();

      if (response.statusCode == 200) {
        final responseData = response.data["data"]["notifications"] as List;

        final userNotifications = responseData
            .map((notification) => NotificationModel.fromJson(notification))
            .toList();

        state = AsyncData(userNotifications);
      }
    } catch (error, stackTrace) {
      print(stackTrace);
      state = AsyncError(error, stackTrace);
    }
  }
}
