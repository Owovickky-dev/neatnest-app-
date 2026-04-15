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

      final List data = response.data["data"] ?? [];

      final chats = data.map((e) => ChatRoomModel.fromJson(e)).toList();

      state = AsyncData(chats);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
