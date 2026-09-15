class NotificationModel {
  final String id;
  final String title;
  final String message;
  final bool isRead;
  final bool isDeleted;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.message,
    required this.isRead,
    required this.isDeleted,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"] as String,
      createdAt: DateTime.parse(json["createdAt"] as String),
      title: json["title"] as String,
      message: json["message"] as String,
      isRead: json["isRead"] as bool,
      isDeleted: json["isDeleted"] as bool,
    );
  }
}
