import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppSocketService {
  AppSocketService._();

  static final AppSocketService instance = AppSocketService._();

  IO.Socket? _socket;

  Completer<void>? _connectionCompleter;

  final List<void Function()> _connectionListeners = [];

  final Map<String, Map<Function, void Function(dynamic)>> _eventListeners = {};

  IO.Socket? get socket => _socket;

  bool get isConnected => _socket?.connected ?? false;

  Future<void> connect() async {
    if (_socket?.connected == true) {
      debugPrint("Socket already connected.");
      return;
    }

    if (_socket != null) {
      debugPrint("Socket exists but is not connected.");

      _connectionCompleter = Completer<void>();

      _socket!.connect();

      try {
        await _connectionCompleter!.future;
      } catch (error) {
        debugPrint("Socket reconnection failed: $error");
      }

      return;
    }

    final token = await SecureStorageHelper.getToken();

    if (token == null || token.isEmpty) {
      debugPrint("No access token. Socket connection skipped.");
      return;
    }

    debugPrint("Creating Socket.IO connection...");

    _connectionCompleter = Completer<void>();

    _socket = IO.io(
      ApiEndPoints.socketIo,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setPath('/socket.io')
          .setAuth({"token": token})
          .disableAutoConnect()
          .build(),
    );

    _registerSocketListeners();

    _attachPendingEventListeners();

    _socket!.connect();

    try {
      await _connectionCompleter!.future;
    } catch (error) {
      debugPrint("Socket connection failed: $error");
    }
  }

  void _registerSocketListeners() {
    _socket?.onConnect((_) {
      debugPrint("🟢 Socket connected");

      for (final listener in List<void Function()>.from(_connectionListeners)) {
        try {
          listener();
        } catch (error, stackTrace) {
          debugPrint("Socket connection listener error: $error");

          debugPrintStack(stackTrace: stackTrace);
        }
      }

      if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
        _connectionCompleter!.complete();
      }
    });

    _socket?.onDisconnect((reason) {
      debugPrint("🔴 Socket disconnected: $reason");
    });

    _socket?.onConnectError((error) {
      debugPrint("🔴 Socket connection error: $error");

      if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
        _connectionCompleter!.completeError(
          Exception("Socket connection failed: $error"),
        );
      }
    });

    _socket?.onError((error) {
      debugPrint("🔴 Socket error: $error");
    });
  }

  void _attachPendingEventListeners() {
    if (_socket == null) {
      return;
    }

    for (final entry in _eventListeners.entries) {
      final event = entry.key;

      for (final wrappedCallback in entry.value.values) {
        _socket!.on(event, wrappedCallback);
      }

      debugPrint("🟢 Attached pending listeners for: $event");
    }
  }

  void addConnectionListener(void Function() listener) {
    if (_connectionListeners.contains(listener)) {
      return;
    }

    _connectionListeners.add(listener);
  }

  void removeConnectionListener(void Function() listener) {
    _connectionListeners.remove(listener);
  }

  Future<void> updateTokenAndReconnect(String newToken) async {
    if (_socket == null) {
      debugPrint(
        "Cannot update socket token. "
        "Socket has not been created.",
      );
      return;
    }

    debugPrint("🔄 Updating socket access token...");

    _socket!.auth = {"token": newToken};

    _connectionCompleter = Completer<void>();

    _socket!.disconnect();
    _socket!.connect();

    try {
      await _connectionCompleter!.future;

      debugPrint("🟢 Socket reconnected with new access token.");
    } catch (error) {
      debugPrint("🔴 Socket reconnect with new token failed: $error");
    }
  }

  void emit(String event, dynamic data) {
    if (!isConnected) {
      debugPrint(
        "Socket emit skipped. "
        "Socket is not connected: $event",
      );
      return;
    }

    debugPrint("📤 Socket emit: $event");
    debugPrint("📤 Socket data: $data");

    _socket!.emit(event, data);
  }

  void on(String event, Function(dynamic) callback) {
    debugPrint("🟡 Registering socket listener: $event");

    void wrappedCallback(dynamic data) {
      debugPrint("🟢 SOCKET EVENT RECEIVED: $event");

      debugPrint("🟢 SOCKET EVENT DATA: $data");

      callback(data);
    }

    _eventListeners.putIfAbsent(
      event,
      () => <Function, void Function(dynamic)>{},
    );

    _eventListeners[event]![callback] = wrappedCallback;

    if (_socket != null) {
      _socket!.on(event, wrappedCallback);
    } else {
      debugPrint(
        "⏳ Socket not created yet. "
        "Listener queued: $event",
      );
    }
  }

  void off(String event, [Function(dynamic)? callback]) {
    debugPrint("🔴 Removing socket listener: $event");

    final listeners = _eventListeners[event];

    if (listeners == null) {
      return;
    }

    if (callback != null) {
      final wrappedCallback = listeners.remove(callback);

      if (wrappedCallback != null) {
        _socket?.off(event, wrappedCallback);
      }
    } else {
      for (final wrappedCallback in listeners.values) {
        _socket?.off(event, wrappedCallback);
      }

      listeners.clear();
    }

    if (listeners.isEmpty) {
      _eventListeners.remove(event);
    }
  }

  void dispose() {
    _connectionListeners.clear();

    _socket?.disconnect();
    _socket?.dispose();

    _socket = null;

    _eventListeners.clear();

    _connectionCompleter = null;
  }
}
