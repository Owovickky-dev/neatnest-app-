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
}
