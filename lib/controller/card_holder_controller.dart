import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/screens/booking/notifiers/booking_date_state.dart';

import '../screens/booking/widgets/review_summary_screen.dart';

class CardHolderController {
  CardHolderController();

  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cardExpiryDateController = TextEditingController();
  TextEditingController cardCvvController = TextEditingController();

  bool isChecked = false;

  void setChecked(bool val) {
    isChecked = val;
  }

  void onSubmit(BuildContext context, WidgetRef ref) {
    final date = ref.watch(bookingDateStateProvider);

    final String name;
    final String number;
    final String expiryDate;
    final String cvv;

    name = cardHolderNameController.text;
    number = cardNumberController.text;
    expiryDate = DateFormat('MM/dd/yyyy').format(date);
    cvv = cardCvvController.text;

    if (name.isEmpty ||
        number.isEmpty ||
        expiryDate.isEmpty ||
        isChecked == false) {
      debugPrint("Please supply the required details");
    } else if (number.length < 16) {
      debugPrint("card number is 16 digits, please kindly complete it");
    } else if (cvv.length < 3) {
      debugPrint("CVV number is 3 digits please complete it");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ReviewSummaryScreen(index: 1)),
      );
      cardCvvController.clear();
      cardNumberController.clear();
      cardHolderNameController.clear();
      cardExpiryDateController.clear();
      ref.read(bookingDateStateProvider.notifier).pickedDate(DateTime.now());
    }
  }
}
