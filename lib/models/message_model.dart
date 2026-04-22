enum MessageStatus { pending, sent, failed }

class MessageModel {
  final String content;
  final String? chatId;
  final String? recipientId;
  final Sender? sender;
  final String? type;
  final String? sendAt;
  final String? messageId;
  final bool? isMe;
  final MessageStatus? sentStatus;

  MessageModel({
    this.recipientId,
    this.chatId,
    required this.content,
    this.sender,
    this.type,
    this.sendAt,
    this.messageId,
    this.isMe,
    this.sentStatus,
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

    if (sendAt != null && sendAt!.isNotEmpty) {
      data["sentAt"] = sendAt;
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
      isMe: json["isMe"],
      sender: json["sender"] != null ? Sender.fromJson(json["sender"]) : null,
      sentStatus: json["isMe"] == true ? MessageStatus.sent : null,
    );
  }
}

class Sender {
  final String senderId;
  final String name;
  final String userName;

  Sender({required this.senderId, required this.name, required this.userName});

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      senderId: json["id"] ?? "",
      name: json["name"] ?? "",
      userName: json["username"] ?? "",
    );
  }
}

class ChattingScreenPreData {
  final String chatId;
  final String senderUserName;
  final String recipientId;

  ChattingScreenPreData({
    required this.chatId,
    required this.senderUserName,
    required this.recipientId,
  });
}
