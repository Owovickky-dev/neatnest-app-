import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/data/repo/booking_repo.dart';
import 'package:neat_nest/models/booking_model.dart';
import 'package:neat_nest/widget/loading_screen.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class BookingFormController {
  BookingFormController();

  BookingRepo _bookingRepo = BookingRepo();

  TextEditingController bookingNameController = TextEditingController();
  TextEditingController bookingEmailController = TextEditingController();
  TextEditingController bookingUserAddress = TextEditingController();
  TextEditingController bookingNoteController = TextEditingController();
  TextEditingController bookingUserNos = TextEditingController();

  late String? serviceId;
  late String? preferredDate;
  late String? preferredTime;

  void onSubmit(WidgetRef ref, BuildContext context) async {
    final name = bookingNameController.text.trim();
    final email = bookingEmailController.text.trim();
    final address = bookingUserAddress.text.trim();
    final phoneNumber = bookingUserNos.text.trim();
    final note = bookingNoteController.text.trim();

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
      return showErrorNotification(
        message: "Please your prefer time from list of time",
      );
    }
    if (preferredDate == null || preferredDate!.isEmpty) {
      return showErrorNotification(
        message: "Please your prefer time from list of date",
      );
    }
    if (note.isEmpty) {
      return showErrorNotification(
        message: "Please type in short details about the order",
      );
    }
    if (serviceId == null || serviceId!.isEmpty) {
      return showErrorNotification(message: "service Id is required");
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

    LoadingScreen();
    try {
      final response = await _bookingRepo.createBooking(userBooking);
      context.pop();
      if (response.statusCode == 201) {
        showSuccessNotification(message: "Booking successfully created");
        print("Booking created");
      } else {
        final reply = response.data["message"];
        showErrorNotification(message: reply);
        print(reply);
      }
    } catch (e) {
      showErrorNotification(message: e.toString());
      print("The error that occur is $e");
    }
    print("Form Booked");
  }
}
