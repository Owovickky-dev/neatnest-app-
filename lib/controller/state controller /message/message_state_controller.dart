// import 'package:neat_nest/models/message_model.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
//
// import '../../../data/repo/texting_data_repo.dart';
//
// part 'message_state_controller.g.dart';
//
// @riverpod
// class MessageStateController extends _$MessageStateController {
//   late TextingDataRepo _textingDataRepo;
//
//   @override
//   Future<List<MessageModel>> build() async {
//     _textingDataRepo = TextingDataRepo();
//     return [];
//   }
//
//   Future<List<MessageModel>> _fetchMessages(String chatId) async {
//     final response = await _textingDataRepo.getMessages(chatId);
//
//     final List data = response.data["messages"] ?? [];
//
//     return data.map((e) => MessageModel.fromJson(e)).toList();
//   }
//
//   Future<void> loadMessages(String chatId) async {
//     state = const AsyncLoading();
//     try {
//       final messages = await _fetchMessages(chatId);
//       if (!ref.mounted) return;
//       state = AsyncData(messages);
//     } catch (e, st) {
//       if (!ref.mounted) return;
//       state = AsyncError(e, st);
//     }
//   }
//
//   Future<void> refreshMessages(String chatId) async {
//     try {
//       final messages = await _fetchMessages(chatId);
//       if (!ref.mounted) return;
//       state = AsyncData(messages);
//     } catch (e, st) {
//       if (!ref.mounted) return;
//       state = AsyncError(e, st);
//     }
//   }
//
//   Future<MessageModel?> sendMessage(MessageModel messageData) async {
//     final sentTempId = "temp_${DateTime.now().microsecondsSinceEpoch}";
//
//     final pendingMessage = MessageModel(
//       messageId: sentTempId,
//       content: messageData.content,
//       chatId: messageData.chatId,
//       recipientId: messageData.recipientId,
//       sendAt: DateTime.now().toIso8601String(),
//       isMe: true,
//       sentStatus: MessageStatus.pending,
//     );
//
//     addNewMessage(pendingMessage);
//     try {
//       final response = await _textingDataRepo.sendMessage(messageData);
//
//       if (response.statusCode == 201) {
//         final data = response.data["data"];
//
//         final confirmedSentMessage = MessageModel(
//           messageId: data["id"],
//           content: data["content"],
//           chatId: data["chatId"],
//           sendAt: data["sentAt"],
//           type: data["messageType"],
//           isMe: true,
//           recipientId: data["recipientId"],
//           sentStatus: MessageStatus.sent,
//         );
//
//         _replaceMessage(sentTempId, confirmedSentMessage);
//         print("Message successfully sent");
//         return confirmedSentMessage;
//       } else {
//         _markMessageFailed(sentTempId);
//         print("Message failed: ${response.data["error"]}");
//         return null;
//       }
//     } catch (e) {
//       _markMessageFailed(sentTempId);
//       rethrow;
//     }
//   }
//
//   void addNewMessage(MessageModel newMessage) {
//     final currentState = state;
//
//     if (currentState is! AsyncData<List<MessageModel>>) return;
//
//     final messages = currentState.value;
//
//     final exists = messages.any((msg) => msg.messageId == newMessage.messageId);
//
//     if (exists) return;
//     if (!ref.mounted) return;
//     state = AsyncData([...messages, newMessage]);
//   }
//
//   void _replaceMessage(String tempId, MessageModel confirmed) {
//     final currentState = state;
//     if (currentState is! AsyncData<List<MessageModel>>) return;
//     if (!ref.mounted) return;
//
//     state = AsyncData(
//       currentState.value.map((msg) {
//         return msg.messageId == tempId ? confirmed : msg;
//       }).toList(),
//     );
//   }
//
//   void _removeMessage(String tempId) {
//     final currentState = state;
//     if (currentState is! AsyncData<List<MessageModel>>) return;
//     if (!ref.mounted) return;
//
//     state = AsyncData(
//       currentState.value.where((msg) => msg.messageId != tempId).toList(),
//     );
//   }
//
//   // Create a copy of the message but change its status to failed
//   void _markMessageFailed(String tempId) {
//     final currentState = state;
//     if (currentState is! AsyncData<List<MessageModel>>) return;
//     if (!ref.mounted) return;
//
//     state = AsyncData(
//       currentState.value.map((msg) {
//         if (msg.messageId == tempId) {
//           return MessageModel(
//             messageId: msg.messageId,
//             content: msg.content,
//             chatId: msg.chatId,
//             recipientId: msg.recipientId,
//             sendAt: msg.sendAt,
//             isMe: msg.isMe,
//             sentStatus: MessageStatus.failed,
//           );
//         }
//         return msg;
//       }).toList(),
//     );
//   }
//
//   // this help us to resend the message by deleting the old failed message and replace with the new copy updated status message
//   Future<MessageModel?> resendMessage(MessageModel failedMessage) async {
//     _removeMessage(failedMessage.messageId!);
//     return sendMessage(failedMessage);
//   }
// }

import 'package:neat_nest/models/message_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/repo/texting_data_repo.dart';

part 'message_state_controller.g.dart';

@Riverpod(keepAlive: true)
class MessageStateController extends _$MessageStateController {
  late TextingDataRepo _textingDataRepo;

  @override
  Future<MessagePaginationState> build() async {
    _textingDataRepo = TextingDataRepo();
    return MessagePaginationState.initial();
  }

  Future<MessageModel?> sendMessage(MessageModel messageData) async {
    final sentTempId = "temp_${DateTime.now().microsecondsSinceEpoch}";

    final pendingMessage = MessageModel(
      messageId: sentTempId,
      content: messageData.content,
      chatId: messageData.chatId,
      recipientId: messageData.recipientId,
      sendAt: DateTime.now().toIso8601String(),
      isMe: true,
      sentStatus: MessageStatus.pending,
    );

    addNewMessage(pendingMessage);

    try {
      final response = await _textingDataRepo.sendMessage(messageData);
      if (response.statusCode == 201) {
        final data = response.data["data"];

        final confirmedSentMessage = MessageModel(
          messageId: data["id"],
          content: data["content"],
          chatId: data["chatId"],
          sendAt: data["sentAt"],
          type: data["messageType"],
          isMe: true,
          recipientId: data["recipientId"],
          sentStatus: MessageStatus.sent,
        );

        _replaceMessage(sentTempId, confirmedSentMessage);

        return confirmedSentMessage;
      } else {
        _markMessageFailed(sentTempId);
        return null;
      }
    } catch (e) {
      _markMessageFailed(sentTempId);
      return null;
    }
  }

  Future<void> loadMessages(String chatId) async {
    state = const AsyncLoading();
    try {
      final response = await _textingDataRepo.getMessages(chatId, page: 1);

      final List data = response.data["messages"] ?? [];

      final messages = data.map((e) => MessageModel.fromJson(e)).toList();

      final hasMore = response.data["hasMore"] ?? false;

      if (!ref.mounted) return;

      state = AsyncData(
        MessagePaginationState(
          messages: messages,
          page: 1,
          hasMore: hasMore,
          isLoading: false,
          isLoadingMore: false,
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> loadMoreMessages(String chatId) async {
    final currentState = state.value;

    if (currentState == null) return;
    if (currentState.isLoadingMore || !currentState.hasMore) return;

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.page + 1;

      final response = await _textingDataRepo.getMessages(
        chatId,
        page: nextPage,
      );

      final List data = response.data["messages"] ?? [];

      final newMessages = data.map((e) => MessageModel.fromJson(e)).toList();

      final hasMore = response.data["hasMore"] ?? false;

      state = AsyncData(
        currentState.copyWith(
          messages: [...currentState.messages, ...newMessages],
          page: nextPage,
          hasMore: hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> refreshMessages(String chatId) async {
    try {
      final response = await _textingDataRepo.getMessages(chatId, page: 1);

      final List data = response.data["messages"] ?? [];

      final messages = data.map((e) => MessageModel.fromJson(e)).toList();

      final hasMore = response.data["hasMore"] ?? false;

      if (!ref.mounted) return;

      state = AsyncData(
        MessagePaginationState(
          messages: messages,
          page: 1,
          hasMore: hasMore,
          isLoading: false,
          isLoadingMore: false,
        ),
      );
    } catch (e, st) {
      if (!ref.mounted) return;
      state = AsyncError(e, st);
    }
  }

  void addNewMessage(MessageModel newMessage) {
    final currentState = state.value;

    if (currentState == null) return;

    final messages = currentState.messages;

    final exists = messages.any((msg) => msg.messageId == newMessage.messageId);

    if (exists) return;
    if (!ref.mounted) return;

    state = AsyncData(
      currentState.copyWith(messages: [newMessage, ...messages]),
    );
  }

  void _replaceMessage(String tempId, MessageModel confirmed) {
    final currentState = state.value;

    if (currentState == null) return;
    if (!ref.mounted) return;

    state = AsyncData(
      currentState.copyWith(
        messages: currentState.messages.map((msg) {
          return msg.messageId == tempId ? confirmed : msg;
        }).toList(),
      ),
    );
  }

  void _removeMessage(String tempId) {
    final currentState = state.value;

    if (currentState == null) return;
    if (!ref.mounted) return;

    state = AsyncData(
      currentState.copyWith(
        messages: currentState.messages
            .where((msg) => msg.messageId != tempId)
            .toList(),
      ),
    );
  }

  void _markMessageFailed(String tempId) {
    final currentState = state.value;

    if (currentState == null) return;
    if (!ref.mounted) return;

    state = AsyncData(
      currentState.copyWith(
        messages: currentState.messages.map((msg) {
          if (msg.messageId == tempId) {
            return MessageModel(
              messageId: msg.messageId,
              content: msg.content,
              chatId: msg.chatId,
              recipientId: msg.recipientId,
              sendAt: msg.sendAt,
              isMe: msg.isMe,
              sentStatus: MessageStatus.failed,
            );
          }
          return msg;
        }).toList(),
      ),
    );
  }

  Future<MessageModel?> resendMessage(MessageModel failedMessage) async {
    _removeMessage(failedMessage.messageId!);
    return sendMessage(failedMessage);
  }
}
