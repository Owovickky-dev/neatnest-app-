import 'package:flutter/foundation.dart';
import 'package:neat_nest/data/socket/app_socket_service.dart';

class NotificationSocketService {
  NotificationSocketService._();

  static final NotificationSocketService instance =
      NotificationSocketService._();

  final AppSocketService _socket = AppSocketService.instance;

  void startListening(void Function(dynamic data) onNotification) {
    _socket.on("new notification", onNotification);

    debugPrint("Notification socket listener started");
  }

  void stopListening(void Function(dynamic data) onNotification) {
    _socket.off("new notification", onNotification);

    debugPrint("Notification socket listener stopped");
  }
}
