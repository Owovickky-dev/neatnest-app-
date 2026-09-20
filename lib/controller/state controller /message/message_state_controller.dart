import 'package:flutter/foundation.dart';
import 'package:neat_nest/data/repo/texting_data_repo.dart';
import 'package:neat_nest/data/socket/chat_socket_service.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/models/message_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_state_controller.g.dart';

@Riverpod(keepAlive: true)
class MessageStateController extends _$MessageStateController {
  late TextingDataRepo _textingDataRepo;

  final ChatSocketService _chatSocket = ChatSocketService.instance;

  bool _hasInitializeCount = false;

  String? _activeChatId;
  String? _recipientId;
  String? _currentUserId;

  @override
  Future<MessagePaginationState> build() async {
    _textingDataRepo = TextingDataRepo();

    await _loadCurrentUserId();

    ref.onDispose(() {
      _stopChatSocket();
    });

    return MessagePaginationState.initial();
  }

  Future<void> _loadCurrentUserId() async {
    try {
      final user = await SecureStorageHelper.getUserData();

      _currentUserId = user?.id;

      debugPrint("Current authenticated user ID: $_currentUserId");
    } catch (error, stackTrace) {
      debugPrint("Failed to load current user ID: $error");

      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> initializeChat(String chatId, String recipientId) async {
    if (_activeChatId == chatId && _recipientId == recipientId) {
      return;
    }

    _stopChatSocket();

    _activeChatId = chatId;
    _recipientId = recipientId;

    if (_currentUserId == null) {
      await _loadCurrentUserId();
    }

    await _startChatSocket(chatId);

    if (!ref.mounted) {
      return;
    }

    await loadMessages(chatId);
  }

  Future<void> _startChatSocket(String chatId) async {
    _chatSocket.listenForMessages(_handleIncomingMessage);

    _chatSocket.listenForTyping(_handleTyping);

    _chatSocket.listenForStopTyping(_handleStopTyping);

    _chatSocket.listenForOnlineUsers(_handleOnlineUsers);

    _chatSocket.listenForOfflineUser(_handleOfflineUser);

    await _chatSocket.connectToChat(chatId);
  }

  void _stopChatSocket() {
    if (_activeChatId != null) {
      _chatSocket.leaveChat(_activeChatId!);
    }

    _chatSocket.stopListeningForMessages(_handleIncomingMessage);

    _chatSocket.stopListeningForTyping(_handleTyping);

    _chatSocket.stopListeningForStopTyping(_handleStopTyping);

    _chatSocket.stopListeningForOnlineUsers(_handleOnlineUsers);

    _chatSocket.stopListeningForOfflineUser(_handleOfflineUser);

    _activeChatId = null;
    _recipientId = null;
  }

  MessageModel _mapMessage(
    Map<String, dynamic> json, {
    bool? forceIsMe,
    MessageStatus? forceStatus,
  }) {
    final rawMessage = MessageModel.fromJson(json);

    final senderId = rawMessage.senderId;

    bool? isMe = forceIsMe;

    if (isMe == null && senderId != null) {
      final currentUserId = _currentUserId;

      if (currentUserId != null) {
        isMe = senderId == currentUserId;
      }
    }

    MessageStatus? status = forceStatus;

    if (status == null && isMe == true) {
      status = MessageStatus.sent;
    }

    return rawMessage.copyWith(isMe: isMe, sentStatus: status);
  }

  void _handleIncomingMessage(dynamic data) {
    try {
      if (data is! Map) {
        debugPrint("Invalid socket message data: $data");
        return;
      }

      final messageData = Map<String, dynamic>.from(data);

      final message = _mapMessage(messageData);

      debugPrint(
        "📨 Incoming message: "
        "${message.messageId}",
      );

      if (message.chatId != _activeChatId) {
        debugPrint(
          "Ignoring message from another chat: "
          "${message.chatId}",
        );
        return;
      }

      /*
       * The backend broadcasts the message to everyone
       * in the chat room, including the sender.
       *
       * Therefore this event can contain our own message.
       *
       * We still process it, but addNewMessage() prevents
       * duplicate IDs.
       */
      addNewMessage(message);
    } catch (error, stackTrace) {
      debugPrint("Failed to process incoming message: $error");

      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void _handleTyping(dynamic data) {
    if (!ref.mounted) {
      return;
    }

    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (!_eventBelongsToRecipient(data)) {
      return;
    }

    state = AsyncData(currentState.copyWith(isRecipientTyping: true));
  }

  void _handleStopTyping(dynamic data) {
    if (!ref.mounted) {
      return;
    }

    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (!_eventBelongsToRecipient(data)) {
      return;
    }

    state = AsyncData(currentState.copyWith(isRecipientTyping: false));
  }

  void _handleOnlineUsers(dynamic data) {
    if (!ref.mounted) {
      return;
    }

    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (!_eventContainsRecipient(data)) {
      return;
    }

    state = AsyncData(currentState.copyWith(isRecipientOnline: true));
  }

  void _handleOfflineUser(dynamic data) {
    if (!ref.mounted) {
      return;
    }

    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (!_eventContainsRecipient(data)) {
      return;
    }

    state = AsyncData(
      currentState.copyWith(isRecipientOnline: false, isRecipientTyping: false),
    );
  }

  bool _eventBelongsToRecipient(dynamic data) {
    return _eventContainsRecipient(data);
  }

  bool _eventContainsRecipient(dynamic data) {
    final recipientId = _recipientId;

    if (recipientId == null) {
      return false;
    }

    if (data == null) {
      return false;
    }

    if (data is String) {
      return data == recipientId;
    }

    if (data is Map) {
      final possibleIds = [
        data["userId"],
        data["user_id"],
        data["senderId"],
        data["sender_id"],
        data["id"],
        data["_id"],
      ];

      return possibleIds.any((id) => id?.toString() == recipientId);
    }

    if (data is List) {
      return data.any((item) => _eventContainsRecipient(item));
    }

    return false;
  }

  void sendTyping(String chatId) {
    _chatSocket.sendTyping(chatId);
  }

  void sendStopTyping(String chatId) {
    _chatSocket.sendStopTyping(chatId);
  }

  Future<MessageModel?> sendMessage(MessageModel messageData) async {
    final sentTempId = "temp_${DateTime.now().microsecondsSinceEpoch}";

    final pendingMessage = MessageModel(
      messageId: sentTempId,
      content: messageData.content,
      chatId: messageData.chatId,
      senderId: _currentUserId,
      recipientId: messageData.recipientId,
      type: messageData.type ?? "text",
      sendAt: DateTime.now().toIso8601String(),
      isMe: true,
      sentStatus: MessageStatus.pending,
    );

    addNewMessage(pendingMessage);

    try {
      final response = await _textingDataRepo.sendMessage(messageData);

      if (response.statusCode == 201) {
        final data = response.data["data"];

        if (data is! Map) {
          _markMessageFailed(sentTempId);

          debugPrint("Invalid message response from server.");

          return null;
        }

        final responseData = Map<String, dynamic>.from(data);

        final confirmedSentMessage = _mapMessage(
          responseData,
          forceIsMe: true,
          forceStatus: MessageStatus.sent,
        );

        /*
         * The socket event may have already arrived before
         * the REST response.
         *
         * If that happened, remove the temporary message
         * and keep the server-confirmed message only once.
         */
        _replaceOrAddConfirmedMessage(sentTempId, confirmedSentMessage);

        return confirmedSentMessage;
      }

      _markMessageFailed(sentTempId);

      debugPrint(
        "Message was not sent by server: "
        "${response.data["message"]}",
      );

      return null;
    } catch (error, stackTrace) {
      _markMessageFailed(sentTempId);

      debugPrint("Message failed inside app: $error");

      debugPrintStack(stackTrace: stackTrace);

      return null;
    }
  }

  Future<void> loadMessages(String chatId) async {
    final currentState = state.value;

    state = const AsyncLoading();

    try {
      if (_currentUserId == null) {
        await _loadCurrentUserId();
      }

      final response = await _textingDataRepo.getMessages(chatId, page: 1);

      final List data = response.data["messages"] ?? [];

      final messages = data
          .whereType<Map>()
          .map((message) => _mapMessage(Map<String, dynamic>.from(message)))
          .toList();

      final hasMore = response.data["hasMore"] ?? false;

      if (!ref.mounted) {
        return;
      }

      state = AsyncData(
        MessagePaginationState(
          messages: messages,
          page: 1,
          hasMore: hasMore,
          isLoading: false,
          isLoadingMore: false,
          isRecipientOnline: currentState?.isRecipientOnline ?? false,
          isRecipientTyping: currentState?.isRecipientTyping ?? false,
          unreadMessageCount: currentState?.unreadMessageCount ?? 0,
        ),
      );
    } catch (error, stackTrace) {
      if (!ref.mounted) {
        return;
      }

      debugPrint("Failed to load messages: $error");

      debugPrintStack(stackTrace: stackTrace);

      state = AsyncError(error, stackTrace);
    }
  }

  Future<void> loadMoreMessages(String chatId) async {
    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (currentState.isLoadingMore || !currentState.hasMore) {
      return;
    }

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.page + 1;

      final response = await _textingDataRepo.getMessages(
        chatId,
        page: nextPage,
      );

      final List data = response.data["messages"] ?? [];

      final newMessages = data
          .whereType<Map>()
          .map((message) => _mapMessage(Map<String, dynamic>.from(message)))
          .toList();

      final hasMore = response.data["hasMore"] ?? false;

      if (!ref.mounted) {
        return;
      }

      final latestState = state.value;

      if (latestState == null) {
        return;
      }

      final mergedMessages = [...latestState.messages, ...newMessages];

      state = AsyncData(
        latestState.copyWith(
          messages: _removeDuplicateMessages(mergedMessages),
          page: nextPage,
          hasMore: hasMore,
          isLoadingMore: false,
        ),
      );
    } catch (error, stackTrace) {
      if (!ref.mounted) {
        return;
      }

      debugPrint("Failed to load more messages: $error");

      debugPrintStack(stackTrace: stackTrace);

      final latestState = state.value;

      if (latestState == null) {
        return;
      }

      state = AsyncData(latestState.copyWith(isLoadingMore: false));
    }
  }

  Future<void> refreshMessages(String chatId) async {
    try {
      if (_currentUserId == null) {
        await _loadCurrentUserId();
      }

      final response = await _textingDataRepo.getMessages(chatId, page: 1);

      final List data = response.data["messages"] ?? [];

      final messages = data
          .whereType<Map>()
          .map((message) => _mapMessage(Map<String, dynamic>.from(message)))
          .toList();

      final hasMore = response.data["hasMore"] ?? false;

      if (!ref.mounted) {
        return;
      }

      final currentState = state.value;

      state = AsyncData(
        MessagePaginationState(
          messages: messages,
          page: 1,
          hasMore: hasMore,
          isLoading: false,
          isLoadingMore: false,
          isRecipientOnline: currentState?.isRecipientOnline ?? false,
          isRecipientTyping: currentState?.isRecipientTyping ?? false,
          unreadMessageCount: currentState?.unreadMessageCount ?? 0,
        ),
      );
    } catch (error, stackTrace) {
      if (!ref.mounted) {
        return;
      }

      debugPrint("Failed to refresh messages: $error");

      debugPrintStack(stackTrace: stackTrace);

      state = AsyncError(error, stackTrace);
    }
  }

  Future<bool> markAsRead(String chatId) async {
    try {
      final response = await _textingDataRepo.markAsRead(chatId);

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  void addNewMessage(MessageModel newMessage) {
    final currentState = state.value;

    if (currentState == null || !ref.mounted) {
      return;
    }

    final newMessageId = newMessage.messageId;

    if (newMessageId != null && newMessageId.isNotEmpty) {
      final exists = currentState.messages.any(
        (message) => message.messageId == newMessageId,
      );

      if (exists) {
        return;
      }
    }

    final activeChatId = ChatSocketService.instance.activeChatId;
    final isIncomingMessage = newMessage.isMe != true;

    final isActiveChat =
        newMessage.chatId != null && newMessage.chatId == activeChatId;

    int unreadMessageCount = currentState.unreadMessageCount;

    if (isIncomingMessage && !isActiveChat) {
      unreadMessageCount++;
    }

    state = AsyncData(
      currentState.copyWith(
        messages: [newMessage, ...currentState.messages],
        unreadMessageCount: unreadMessageCount,
      ),
    );

    if (isIncomingMessage && isActiveChat) {
      markAsRead(newMessage.chatId!);
    }
  }

  Future<void> getUnreadMessage() async {
    if (_hasInitializeCount) return;
    try {
      final response = await _textingDataRepo.getUnreadMessage();

      if (response.statusCode == 200) {
        _hasInitializeCount = true;
        final unreadCount = response.data["unreadCount"];
        print("Success gotten the unread text $unreadCount");
        state = AsyncData(
          state.value!.copyWith(unreadMessageCount: unreadCount),
        );
      }
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stack);
    }
  }

  void _replaceOrAddConfirmedMessage(
    String tempId,
    MessageModel confirmedMessage,
  ) {
    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (!ref.mounted) {
      return;
    }

    final confirmedId = confirmedMessage.messageId;

    final alreadyExists =
        confirmedId != null &&
        currentState.messages.any(
          (message) => message.messageId == confirmedId,
        );

    /*
     * Remove the temporary pending message.
     */
    final messages = currentState.messages
        .where((message) => message.messageId != tempId)
        .toList();

    /*
     * If the socket event already inserted the confirmed
     * server message, don't insert it again.
     */
    if (!alreadyExists) {
      messages.insert(0, confirmedMessage);
    }

    state = AsyncData(currentState.copyWith(messages: messages));
  }

  void _replaceMessage(String tempId, MessageModel confirmedMessage) {
    _replaceOrAddConfirmedMessage(tempId, confirmedMessage);
  }

  void _markMessageFailed(String tempId) {
    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (!ref.mounted) {
      return;
    }

    state = AsyncData(
      currentState.copyWith(
        messages: currentState.messages.map((message) {
          if (message.messageId == tempId) {
            return message.copyWith(
              sentStatus: MessageStatus.failed,
              isMe: true,
            );
          }

          return message;
        }).toList(),
      ),
    );
  }

  void _removeFailedMessage(String messageId) {
    final currentState = state.value;

    if (currentState == null) {
      return;
    }

    if (!ref.mounted) {
      return;
    }

    state = AsyncData(
      currentState.copyWith(
        messages: currentState.messages
            .where((message) => message.messageId != messageId)
            .toList(),
      ),
    );
  }

  Future<MessageModel?> resendMessage(MessageModel failedMessage) async {
    final messageId = failedMessage.messageId;

    if (messageId == null) {
      return null;
    }

    _removeFailedMessage(messageId);

    return sendMessage(
      failedMessage.copyWith(
        senderId: _currentUserId,
        isMe: true,
        sentStatus: null,
      ),
    );
  }

  List<MessageModel> _removeDuplicateMessages(List<MessageModel> messages) {
    final seenIds = <String>{};
    final result = <MessageModel>[];

    for (final message in messages) {
      final id = message.messageId;

      if (id == null || id.isEmpty) {
        result.add(message);
        continue;
      }

      if (seenIds.contains(id)) {
        continue;
      }

      seenIds.add(id);
      result.add(message);
    }

    return result;
  }
}
