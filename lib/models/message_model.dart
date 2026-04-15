class MessageModel {
  final String content;
  final String? chatId;
  final String? recipientId;
  final Sender? sender;
  final String? type;
  final String? sendAt;
  final String? messageId;

  MessageModel({
    this.recipientId,
    this.chatId,
    required this.content,
    this.sender,
    this.type,
    this.sendAt,
    this.messageId,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data["content"] = content;

    if (chatId != null && chatId!.isNotEmpty) {
      data["chatId"] = chatId;
    }

    if (recipientId != null && recipientId!.isNotEmpty) {
      data["recipientId"] = recipientId;
    }

    if (type != null && type!.isNotEmpty) {
      data["type"] = type;
    }

    return data;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      messageId: json["id"] ?? "",
      content: json["content"] ?? "",
      type: json["type"] ?? "",
      sendAt: json["sentAt"] ?? "",

      sender: json["sender"] != null ? Sender.fromJson(json["sender"]) : null,
    );
  }
}

class Sender {
  final String id;
  final String name;
  final String userName;

  Sender({required this.id, required this.name, required this.userName});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      userName: json["username"] ?? "",
    );
  }
}
