import 'package:dio/dio.dart';
import 'package:neat_nest/data/repo/booking_repo.dart';
import 'package:neat_nest/models/booking_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_state_controller.g.dart';

@riverpod
class BookingStateController extends _$BookingStateController {
  late BookingRepo _bookingRepo;
  @override
  Future<List<BookingModel>> build() async {
    _bookingRepo = BookingRepo();
    return [];
  }

  Future<Response> createBooking(BookingModel bookingData) async {
    try {
      final response = await _bookingRepo.createBooking(bookingData);
      return response;
    } catch (e) {
      print("The error got is : $e");
      rethrow;
    }
  }
}
