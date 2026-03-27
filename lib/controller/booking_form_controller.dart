import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/screens/booking/notifiers/booking_time_state.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class BookingFormController {
  BookingFormController();

  TextEditingController bookingNameController = TextEditingController();
  TextEditingController bookingEmailController = TextEditingController();
  TextEditingController bookingUserAddress = TextEditingController();
  TextEditingController bookingNoteController = TextEditingController();
  TextEditingController bookingUserNos = TextEditingController();

  void onSubmit(WidgetRef ref, BuildContext context) {
    final name = bookingNameController.text.trim();
    final email = bookingEmailController.text.trim();
    final address = bookingUserAddress.text.trim();
    final phoneNumber = bookingUserNos.text.trim();
    final note = bookingNoteController.text.trim();
    final date = ref.read(bookingTimeStateProvider);

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
    if (date.isEmpty) {
      return showErrorNotification(message: "Please select available time");
    }
    if (note.isEmpty) {
      return showErrorNotification(
        message: "Please type in short details about the order",
      );
    }
    print("Form Booked");
  }
}
