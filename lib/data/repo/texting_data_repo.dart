import 'package:dio/dio.dart';
import 'package:neat_nest/models/message_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

import '../../models/chat_room_model.dart';
import '../api/api_client.dart';

class TextingDataRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> createChatRoom(ChatRoomModel chatRoomData) async {
    final response = await _dio.post(
      ConstantData.CHATURL,
      data: chatRoomData.toJson(),
    );
    return response;
  }

  Future<Response> sendMessage(MessageModel messageData) async {
    final response = await _dio.post(
      ConstantData.MESSAGEURL,
      data: messageData.toJson(),
    );
    return response;
  }

  Future<Response> getAllChatRoomList() async {
    final response = await _dio.get(ConstantData.CHATURL);
    return response;
  }

  Future<Response> getMessages(String chatId) async {
    final response = await _dio.get("${ConstantData.MESSAGEURL}/$chatId");
    return response;
  }
}
