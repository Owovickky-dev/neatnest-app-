enum MessageStatus { pending, sent, failed }

class MessageModel {
  final String content;
  final String? chatId;
  final String? senderId;
  final String? recipientId;
  final Sender? sender;
  final String? type;
  final String? sendAt;
  final String? messageId;
  final bool? hasMore;
  final int? page;
  final bool? isMe;
  final MessageStatus? sentStatus;

  MessageModel({
    this.recipientId,
    this.senderId,
    this.chatId,
    required this.content,
    this.sender,
    this.type,
    this.sendAt,
    this.messageId,
    this.isMe,
    this.sentStatus,
    this.hasMore,
    this.page,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    data["content"] = content;
    data["type"] = type ?? "text";

    if (chatId != null && chatId!.isNotEmpty) {
      data["chatId"] = chatId;
    }

    if (recipientId != null && recipientId!.isNotEmpty) {
      data["recipientId"] = recipientId;
    }

    if (sendAt != null && sendAt!.isNotEmpty) {
      data["sentAt"] = sendAt;
    }

    if (messageId != null && messageId!.isNotEmpty) {
      data["messageId"] = messageId;
    }

    return data;
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    final senderData = json["sender"];

    MessageStatus? status;

    if (json["sentStatus"] == "pending") {
      status = MessageStatus.pending;
    } else if (json["sentStatus"] == "sent") {
      status = MessageStatus.sent;
    } else if (json["sentStatus"] == "failed") {
      status = MessageStatus.failed;
    } else if (json["isMe"] == true) {
      status = MessageStatus.sent;
    }

    return MessageModel(
      messageId:
          json["id"]?.toString() ??
          json["_id"]?.toString() ??
          json["messageId"]?.toString(),

      content: json["content"]?.toString() ?? "",

      chatId: json["chatId"]?.toString(),

      senderId: json["senderId"]?.toString(),

      recipientId: json["recipientId"]?.toString(),

      type: json["type"]?.toString() ?? "text",

      sendAt: json["sentAt"]?.toString() ?? json["sendAt"]?.toString(),

      isMe: json["isMe"] == true
          ? true
          : json["isMe"] == false
          ? false
          : null,

      sender: senderData is Map
          ? Sender.fromJson(Map<String, dynamic>.from(senderData))
          : null,

      sentStatus: status,
    );
  }

  MessageModel copyWith({
    String? content,
    String? chatId,
    String? senderId,
    String? recipientId,
    Sender? sender,
    String? type,
    String? sendAt,
    String? messageId,
    bool? isMe,
    MessageStatus? sentStatus,
    bool? hasMore,
    int? page,
  }) {
    return MessageModel(
      content: content ?? this.content,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      recipientId: recipientId ?? this.recipientId,
      sender: sender ?? this.sender,
      type: type ?? this.type,
      sendAt: sendAt ?? this.sendAt,
      messageId: messageId ?? this.messageId,
      isMe: isMe ?? this.isMe,
      sentStatus: sentStatus ?? this.sentStatus,
      hasMore: hasMore ?? this.hasMore,
      page: page ?? this.page,
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
      senderId:
          json["id"]?.toString() ??
          json["_id"]?.toString() ??
          json["senderId"]?.toString() ??
          "",

      name: json["name"]?.toString() ?? json["firstName"]?.toString() ?? "",

      userName: json["username"]?.toString() ?? "",
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

class MessagePaginationState {
  final List<MessageModel> messages;
  final int page;
  final bool hasMore;
  final bool isLoading;
  final bool isLoadingMore;

  final bool isRecipientOnline;
  final bool isRecipientTyping;

  final int unreadMessageCount;

  MessagePaginationState({
    required this.messages,
    required this.page,
    required this.hasMore,
    required this.isLoading,
    required this.isLoadingMore,
    required this.isRecipientOnline,
    required this.isRecipientTyping,
    required this.unreadMessageCount,
  });

  factory MessagePaginationState.initial() {
    return MessagePaginationState(
      messages: [],
      page: 1,
      hasMore: true,
      isLoading: false,
      isLoadingMore: false,
      isRecipientOnline: false,
      isRecipientTyping: false,
      unreadMessageCount: 0,
    );
  }

  MessagePaginationState copyWith({
    List<MessageModel>? messages,
    int? page,
    bool? hasMore,
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRecipientOnline,
    bool? isRecipientTyping,
    int? unreadMessageCount,
  }) {
    return MessagePaginationState(
      messages: messages ?? this.messages,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRecipientOnline: isRecipientOnline ?? this.isRecipientOnline,
      isRecipientTyping: isRecipientTyping ?? this.isRecipientTyping,
      unreadMessageCount: unreadMessageCount ?? this.unreadMessageCount,
    );
  }
}
