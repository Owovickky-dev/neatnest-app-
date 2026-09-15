import 'package:dio/dio.dart';
import 'package:neat_nest/models/message_model.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

import '../api/api_client.dart';

class TextingDataRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> createChatRoom({
    required String bookingId,
    required String recipientId,
  }) async {
    final response = await _dio.post(
      ApiEndPoints.chatUrl,
      data: {"recipientId": recipientId, "bookingId": bookingId},
    );
    return response;
  }

  Future<Response> sendMessage(MessageModel messageData) async {
    final response = await _dio.post(
      ApiEndPoints.messageUrl,
      data: messageData.toJson(),
    );
    return response;
  }

  Future<Response> getAllChatRoomList() async {
    final response = await _dio.get(ApiEndPoints.chatUrl);
    return response;
  }

  Future<Response> getMessages(String chatId, {int page = 1}) async {
    final response = await _dio.get(
      "${ApiEndPoints.messageUrl}/$chatId?page=$page",
    );
    return response;
  }
}
