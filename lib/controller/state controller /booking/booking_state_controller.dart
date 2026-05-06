import 'package:dio/dio.dart';
import 'package:neat_nest/data/repo/booking_repo.dart';
import 'package:neat_nest/models/booking_model.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_state_controller.g.dart';

@riverpod
class BookingStateController extends _$BookingStateController {
  late BookingRepo _bookingRepo;

  @override
  Future<GroupedBookings> build() async {
    _bookingRepo = BookingRepo();
    final response = await _bookingRepo.getUserBookings();
    final responseData = response.data["data"]["grouped"];

    return GroupedBookings.fromJson(responseData);
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

  Future<void> getUserBookings() async {
    try {
      state = const AsyncLoading();

      final response = await _bookingRepo.getUserBookings();

      if (response.statusCode != 200) {
        final responseMessage = response.data["message"];
        showErrorNotification(message: responseMessage);
        if (!ref.mounted) return;
        state = AsyncError(responseMessage, StackTrace.current);
        return;
      }
      final responseData = response.data["data"]["grouped"];
      final groupBooking = GroupedBookings.fromJson(responseData);

      if (!ref.mounted) return;
      state = AsyncData(groupBooking);
    } catch (e, stackTrace) {
      if (!ref.mounted) return;
      print(e);
      print(stackTrace);
      state = AsyncError(e, stackTrace);
    }
  }
}
