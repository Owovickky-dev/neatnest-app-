import 'package:dio/dio.dart';
import 'package:neat_nest/data/repo/texting_data_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/chat_room_model.dart';

part 'chat_state_controller.g.dart';

@Riverpod(keepAlive: true)
class ChatStateController extends _$ChatStateController {
  late TextingDataRepo _textingDataRepo;

  @override
  Future<List<ChatRoomModel>> build() async {
    _textingDataRepo = TextingDataRepo();
    return state.value ?? [];
  }

  Future<Response> createChatRoom({
    required String bookingId,
    required String recipientId,
  }) async {
    try {
      final response = await _textingDataRepo.createChatRoom(
        bookingId: bookingId,
        recipientId: recipientId,
      );
      return response;
    } catch (e) {
      print("The error message is $e");
      rethrow;
    }
  }

  Future<void> getChatRooms() async {
    state = const AsyncLoading();

    try {
      final response = await _textingDataRepo.getAllChatRoomList();
      if (response.data is! Map<String, dynamic>) {
        throw Exception("Invalid response format: ${response.data}");
      }
      final List data = response.data["data"] ?? [];
      final chats = data.map((e) => ChatRoomModel.fromJson(e)).toList();

      state = AsyncData(chats);
    } catch (e, st) {
      print(e);
      state = AsyncError(e, st);
    }
  }

  Future<void> updateLastMessage({
    required String chatId,
    required LastMessage newMessage,
  }) async {
    state = state.whenData((chats) {
      final updatedChats = chats.map((chat) {
        if (chat.chatId == chatId) {
          return chat.copyWith(lastMessage: newMessage);
        }
        return chat;
      }).toList();
      updatedChats.sort((a, b) {
        final aTime = a.lastMessage?.sentAt ?? "";
        final bTime = b.lastMessage?.sentAt ?? "";
        return bTime.compareTo(aTime);
      });
      return updatedChats;
    });
  }
}
