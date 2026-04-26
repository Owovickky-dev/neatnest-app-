import 'package:dio/dio.dart';
import 'package:neat_nest/models/booking_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

import '../api/api_client.dart';

class BookingRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> createBooking(BookingModel bookingData) async {
    final response = _dio.post(
      ConstantData.BOOKINGURL,
      data: bookingData.toJson(),
    );

    return response;
  }
}
