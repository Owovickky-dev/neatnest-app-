import 'package:uuid/uuid.dart';

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime datetime;
  bool read;

  NotificationModel({
    required this.title,
    String? id,
    required this.datetime,
    required this.message,
    this.read = false,
  }) : id = id ?? Uuid().v4();

  NotificationModel copyWith({
    String? title,
    String? message,
    DateTime? datetime,
    bool? read,
    String? id,
  }) {
    return NotificationModel(
      title: title ?? this.title,
      message: message ?? this.message,
      datetime: datetime ?? this.datetime,
      read: read ?? this.read,
      id: id ?? this.id,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json["title"] ?? "",
      datetime: json["datetime"] ?? "",
      message: json["message"] ?? "",
      id: json["_id"] ?? "",
    );
  }
}
