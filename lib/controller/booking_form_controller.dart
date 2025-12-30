import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/screens/booking/notifiers/booking_date_state.dart';
import 'package:neat_nest/screens/booking/notifiers/booking_time_state.dart';
import 'package:neat_nest/screens/booking/widgets/select_rooms.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class BookingFormController {
  BookingFormController();

  TextEditingController bookingNameController = TextEditingController();
  TextEditingController bookingEmailController = TextEditingController();
  TextEditingController bookingUserAddress = TextEditingController();
  TextEditingController bookingNoteController = TextEditingController();

  void onSubmit(WidgetRef ref, BuildContext context) {
    String name;
    String email;
    DateTime date;
    String time;
    String note;

    name = bookingNameController.text;
    email = bookingEmailController.text;
    note = bookingNoteController.text;
    time = ref.watch(bookingTimeStateProvider);
    date = ref.watch(bookingDateStateProvider);

    if (name.isEmpty || email.isEmpty || time.isEmpty) {
      if (!context.mounted) return;
      showErrorNotification(message: "Please kindly supply your information");
    } else if (!EmailValidator.validate(email)) {
      if (!context.mounted) return;
      showErrorNotification(message: "Please enter a valid mail");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SelectRooms()),
      );
    }
  }
}
