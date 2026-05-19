import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state controller /booking/booking_state_controller.dart';
import 'package:neat_nest/models/booking_model.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../data/repo/texting_data_repo.dart';
import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';
import '../widget/loading_screen.dart';

class BookingFormController {
  BookingFormController();

  final textingRepo = TextingDataRepo();

  TextEditingController bookingNameController = TextEditingController();
  TextEditingController bookingEmailController = TextEditingController();
  TextEditingController bookingUserAddress = TextEditingController();
  TextEditingController bookingNoteController = TextEditingController();
  TextEditingController bookingUserNos = TextEditingController();

  String? serviceId;
  String? preferredDate;
  String? preferredTime;
  String? bookingStatus;

  void onSubmit(WidgetRef ref, BuildContext context) async {
    final name = bookingNameController.text.trim();
    final email = bookingEmailController.text.trim();
    final address = bookingUserAddress.text.trim();
    final phoneNumber = bookingUserNos.text.trim();
    final note = bookingNoteController.text.trim();

    /// ================= VALIDATION =================
    if (name.isEmpty) {
      return showErrorNotification(message: "Please enter your name");
    }
    if (email.isEmpty) {
      return showErrorNotification(message: "Please enter your email");
    }
    if (!EmailValidator.validate(email)) {
      return showErrorNotification(message: "Please enter a valid email");
    }
    if (phoneNumber.isEmpty) {
      return showErrorNotification(message: "Please enter your phone number");
    }
    if (address.isEmpty) {
      return showErrorNotification(message: "Please enter your address");
    }
    if (preferredTime == null || preferredTime!.isEmpty) {
      return showErrorNotification(message: "Please select a preferred time");
    }
    if (preferredDate == null || preferredDate!.isEmpty) {
      return showErrorNotification(message: "Please select a preferred date");
    }
    if (note.isEmpty) {
      return showErrorNotification(message: "Please enter a note");
    }
    if (note.length < 20) {
      return showErrorNotification(
        message: "Note must be at least 20 characters",
      );
    }
    if (serviceId == null || serviceId!.isEmpty) {
      return showErrorNotification(message: "Service ID is required");
    }

    final userBooking = BookingModel(
      serviceId: serviceId!,
      customerName: name,
      customerPhoneNumber: phoneNumber,
      customerAddress: address,
      customerEmail: email,
      customerNote: note,
      preferredDate: preferredDate!,
      preferredTime: preferredTime!,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Dialog(
        backgroundColor: Colors.transparent,
        child: LoadingScreen(),
      ),
    );

    try {
      /// ================= CREATE BOOKING ONLY =================
      final serverResponse = await ref
          .read(bookingStateControllerProvider.notifier)
          .createBooking(userBooking);

      if (!context.mounted) return;

      _closeLoader(context);

      /// ================= ERROR =================
      if (serverResponse.statusCode != 201) {
        showErrorNotification(
          message: serverResponse.data["message"] ?? "Booking failed",
        );
        return;
      }

      /// ================= SUCCESS =================
      final bookingData = serverResponse.data["data"];

      if (bookingData == null) {
        showErrorNotification(message: "Invalid booking response");
        return;
      }
      final bookingId = bookingData["id"];
      if (bookingId == null) {
        showErrorNotification(message: "Booking ID missing");
        return;
      }
      ref.invalidate(bookingStateControllerProvider);
      AppNavigatorHelper.pushReplacement(context, AppRoute.myBookingScreen);
      showSuccessNotification(
        message: "Booking sent. Waiting for provider response",
      );
    } catch (e) {
      print("Unexpected error: $e");
      _closeLoader(context);
      showErrorNotification(message: "Something went wrong");
    }
  }

  Future<void> updateBooking(
    WidgetRef ref,
    String bookingId,
    BuildContext context,
  ) async {
    final name = bookingNameController.text.trim();
    final email = bookingEmailController.text.trim();
    final address = bookingUserAddress.text.trim();
    final phoneNumber = bookingUserNos.text.trim();
    final note = bookingNoteController.text.trim();

    final updateBookingData = BookingModel(
      customerName: name,
      customerPhoneNumber: phoneNumber,
      customerAddress: address,
      customerEmail: email,
      customerNote: note,
      preferredDate: preferredDate,
      preferredTime: preferredTime,
      status: bookingStatus,
    );

    print("The booking status is $bookingStatus");
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Dialog(
        backgroundColor: Colors.transparent,
        child: LoadingScreen(),
      ),
    );

    try {
      final response = await ref
          .read(bookingStateControllerProvider.notifier)
          .updateBooking(updateData: updateBookingData, bookingId: bookingId);

      if (response.statusCode != 200) {
        if (!context.mounted) return;
        _closeLoader(context);
        showErrorNotification(message: response.data["message"]);
      } else {
        if (!context.mounted) return;
        _closeLoader(context);
        await ref
            .read(bookingStateControllerProvider.notifier)
            .getUserBookings();

        showSuccessNotification(message: "Successfully done");
      }
    } catch (e) {
      if (!context.mounted) return;
      _closeLoader(context);
      print(e.toString());
      showErrorNotification(message: "Something went wrong");
    }
  }

  void _closeLoader(BuildContext context) {
    if (context.mounted) {
      context.pop();
    }
  }
}
