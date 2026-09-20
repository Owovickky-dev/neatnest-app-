import 'package:neat_nest/data/socket/app_socket_service.dart';

class ChatSocketService {
  ChatSocketService._() {
    _socket.addConnectionListener(_handleSocketConnected);
  }

  static final ChatSocketService instance = ChatSocketService._();

  final AppSocketService _socket = AppSocketService.instance;

  String? _activeChatId;

  String? get activeChatId => _activeChatId;

  bool get isConnected => _socket.isConnected;

  Future<void> connect() {
    return _socket.connect();
  }

  Future<void> connectToChat(String chatId) async {
    _activeChatId = chatId;

    /*
     * The connection listener handles joining the chat.
     *
     * This also means the same method handles:
     *
     * 1. Initial connection
     * 2. Socket reconnect
     * 3. Access-token reconnect
     */
    await _socket.connect();
  }

  void _handleSocketConnected() {
    _joinActiveChat();
  }

  void _joinActiveChat() {
    final chatId = _activeChatId;

    if (chatId == null || chatId.isEmpty) {
      return;
    }

    if (!_socket.isConnected) {
      return;
    }

    _socket.emit("join chat", chatId);
  }

  void joinChat(String chatId) {
    _activeChatId = chatId;

    if (!_socket.isConnected) {
      return;
    }

    _joinActiveChat();
  }

  void leaveChat(String chatId) {
    if (_socket.isConnected) {
      _socket.emit("leave chat", chatId);
    }

    if (_activeChatId == chatId) {
      _activeChatId = null;
    }
  }

  void sendMessage(Map<String, dynamic> message) {
    _socket.emit("new message", message);
  }

  void sendTyping(String chatId) {
    _socket.emit("typing", chatId);
  }

  void sendStopTyping(String chatId) {
    _socket.emit("stop typing", chatId);
  }

  void listenForMessages(void Function(dynamic data) callback) {
    _socket.on("message received", callback);
  }

  void listenForTyping(void Function(dynamic data) callback) {
    _socket.on("typing", callback);
  }

  void listenForStopTyping(void Function(dynamic data) callback) {
    _socket.on("stop typing", callback);
  }

  void listenForOnlineUsers(void Function(dynamic data) callback) {
    _socket.on("online-users", callback);
  }

  void listenForOfflineUser(void Function(dynamic data) callback) {
    _socket.on("offline-user", callback);
  }

  void stopListeningForMessages(void Function(dynamic data) callback) {
    _socket.off("message received", callback);
  }

  void stopListeningForTyping(void Function(dynamic data) callback) {
    _socket.off("typing", callback);
  }

  void stopListeningForStopTyping(void Function(dynamic data) callback) {
    _socket.off("stop typing", callback);
  }

  void stopListeningForOnlineUsers(void Function(dynamic data) callback) {
    _socket.off("online-users", callback);
  }

  void stopListeningForOfflineUser(void Function(dynamic data) callback) {
    _socket.off("offline-user", callback);
  }

  void dispose() {
    _socket.removeConnectionListener(_handleSocketConnected);

    _activeChatId = null;
  }
}
