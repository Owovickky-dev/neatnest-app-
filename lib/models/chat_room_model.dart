class ChatRoomModel {
  final String? chatId;
  final String? chatName;
  final String? chatType;
  final List<Participant>? participants;
  final bool? isDispute;
  final String? status;
  final LastMessage? lastMessage;
  final String? bookingId;
  final String? recipientId;
  final String? partnerUsername;

  ChatRoomModel({
    this.chatId,
    this.chatName,
    this.chatType,
    this.participants,
    this.isDispute,
    this.status,
    this.lastMessage,
    this.recipientId,
    this.bookingId,
    this.partnerUsername,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (bookingId != null && bookingId!.isNotEmpty) {
      data["bookingId"] = bookingId;
    }
    if (recipientId != null && recipientId!.isNotEmpty) {
      data["recipientId"] = recipientId;
    }
    if (chatType != null && chatType!.isNotEmpty) {
      data["chatType"] = chatType;
    }
    if (isDispute != null) {
      data["isDispute"] = isDispute;
    }
    if (status != null) {
      data["status"] = status;
    }
    return data;
  }

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      chatId: json["chatId"] ?? "",
      chatName: json["chatName"] ?? "",
      chatType: json["chatType"] ?? "",
      status: json["status"],
      isDispute: json["dispute"]?["isDispute"] ?? false,
      partnerUsername: json["partnerUsername"] ?? "",
      recipientId: json["partnerId"] ?? "",

      participants: (json["participants"] as List<dynamic>?)
          ?.map((p) => Participant.fromJson(p))
          .toList(),

      lastMessage: json["lastMessage"] != null
          ? LastMessage.fromJson(json["lastMessage"])
          : null,
    );
  }
}

class LastMessage {
  final String content;
  final String senderId;
  final String senderRole;
  final String sentAt;
  final String messageType;
  final bool isMe;

  LastMessage({
    required this.content,
    required this.senderId,
    required this.senderRole,
    required this.sentAt,
    required this.messageType,
    required this.isMe,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      content: json["content"] ?? "",
      senderId: json["senderId"] ?? json["sender"] ?? "",
      senderRole: json["senderRole"] ?? "",
      sentAt: json["sentAt"] ?? "",
      messageType: json["messageType"] ?? "",
      isMe: json["isMe"],
    );
  }
}

class Participant {
  final String id;
  final String name;
  final String username;
  final String role;
  final String joinedAt;

  Participant({
    required this.id,
    required this.name,
    required this.username,
    required this.role,
    required this.joinedAt,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      username: json["username"] ?? "",
      role: json["role"] ?? "",
      joinedAt: json["joinedAt"] ?? "",
    );
  }
}
