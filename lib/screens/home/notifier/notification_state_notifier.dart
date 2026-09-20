import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:neat_nest/data/repo/user_data_repo.dart';
import 'package:neat_nest/data/socket/notification_socket_service.dart';
import 'package:neat_nest/models/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'notification_state_notifier.g.dart';

@Riverpod(keepAlive: true)
class NotificationStateNotifier extends _$NotificationStateNotifier {
  late UserDataRepo _userDataRepo;

  final NotificationSocketService _notificationSocket =
      NotificationSocketService.instance;

  bool _hasInitialized = false;

  @override
  FutureOr<List<NotificationModel>> build() {
    _userDataRepo = UserDataRepo();

    ref.onDispose(() {
      _stopNotificationSocket();
    });

    return [];
  }

  Future<void> initializeNotification() async {
    if (_hasInitialized) return;

    _hasInitialized = true;

    // Start listening first so we don't miss a notification
    // while the initial API request is running.
    _startNotificationSocket();

    // Load existing notifications from the API.
    await getUserNotification();
  }

  // ============================================================
  // GET EXISTING NOTIFICATIONS
  // ============================================================

  Future<void> getUserNotification() async {
    // Only show loading when we don't already have notifications.
    if (state.value == null || state.value!.isEmpty) {
      state = const AsyncLoading();
    }

    try {
      final response = await _userDataRepo.getUserNotification();

      if (response.statusCode != 200) {
        return;
      }

      final responseData = response.data["data"]["notifications"] as List;

      final userNotifications = responseData
          .map((notification) => NotificationModel.fromJson(notification))
          .toList();

      // Keep any notifications that arrived through the socket
      // while the API request was running.
      final currentNotifications = state.value ?? [];

      final mergedNotifications = <NotificationModel>[...currentNotifications];

      for (final notification in userNotifications) {
        final alreadyExists = mergedNotifications.any(
          (item) => item.id == notification.id,
        );

        if (!alreadyExists) {
          mergedNotifications.add(notification);
        }
      }

      state = AsyncData(mergedNotifications);
    } catch (error, stackTrace) {
      debugPrint("Failed to get notifications: $error");
      debugPrintStack(stackTrace: stackTrace);

      state = AsyncError(error, stackTrace);
    }
  }

  // ============================================================
  // SOCKET
  // ============================================================

  void _startNotificationSocket() {
    _notificationSocket.startListening(_handleNewNotification);
  }

  void _stopNotificationSocket() {
    _notificationSocket.stopListening(_handleNewNotification);
  }

  // ============================================================
  // NEW NOTIFICATION FROM SOCKET
  // ============================================================

  void _handleNewNotification(dynamic data) {
    try {
      final notification = NotificationModel.fromJson(data);

      addNotification(notification);
    } catch (error, stackTrace) {
      debugPrint("Failed to process socket notification: $error");

      debugPrintStack(stackTrace: stackTrace);
    }
  }

  // ============================================================
  // ADD NOTIFICATION
  // ============================================================

  void addNotification(NotificationModel notification) {
    final currentNotifications = state.value ?? [];

    final alreadyExists = currentNotifications.any(
      (item) => item.id == notification.id,
    );

    if (alreadyExists) {
      return;
    }

    state = AsyncData([notification, ...currentNotifications]);
  }

  // ============================================================
  // MARK AS READ
  // ============================================================

  void markAsRead(String notificationId) {
    final currentNotifications = state.value ?? [];

    state = AsyncData(
      currentNotifications.map((notification) {
        if (notification.id == notificationId) {
          // Update this once NotificationModel has copyWith().
          // return notification.copyWith(isRead: true);
        }

        return notification;
      }).toList(),
    );
  }

  // ============================================================
  // REMOVE NOTIFICATION
  // ============================================================

  void removeNotification(String notificationId) {
    final currentNotifications = state.value ?? [];

    state = AsyncData(
      currentNotifications
          .where((notification) => notification.id != notificationId)
          .toList(),
    );
  }
}
