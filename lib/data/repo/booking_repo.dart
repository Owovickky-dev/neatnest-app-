import 'package:dio/dio.dart';
import 'package:neat_nest/models/booking_model.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

import '../api/api_client.dart';

class BookingRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> createBooking(BookingModel bookingData) async {
    final response = _dio.post(
      ApiEndPoints.bookingUrl,
      data: bookingData.toJson(),
    );

    return response;
  }

  Future<Response> getUserBookings() async {
    final response = _dio.get(ApiEndPoints.bookingUrl);
    return response;
  }

  Future<Response> updateBooking({
    required BookingModel bookingData,
    required String bookingId,
  }) {
    final response = _dio.patch(
      "${ApiEndPoints.bookingUrl}/$bookingId",
      data: bookingData.toJson(),
    );

    return response;
  }
}
