import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state controller /booking/booking_state_controller.dart';
import 'package:neat_nest/controller/state controller /message/chat_state_controller.dart';
import 'package:neat_nest/models/booking_model.dart';
import 'package:neat_nest/models/message_model.dart';
import 'package:neat_nest/utilities/bottom_nav/widget/bottom_nav_notifiers.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../data/repo/texting_data_repo.dart';
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
      /// ================= CREATE BOOKING =================
      final serverResponse = await ref
          .read(bookingStateControllerProvider.notifier)
          .createBooking(userBooking);

      if (!context.mounted) return;

      print("Server response: ${serverResponse.data}");

      if (serverResponse.statusCode != 201) {
        _closeLoader(context);
        showErrorNotification(
          message: serverResponse.data["message"] ?? "Booking failed",
        );
        return;
      }

      final bookingData = serverResponse.data["data"]?["bookedOrder"];

      if (bookingData == null) {
        _closeLoader(context);
        showErrorNotification(message: "Invalid booking response");
        return;
      }

      final String? bookingId = bookingData["_id"];
      final String? recipientId = bookingData["service"]?["jobPoster"]?["_id"];

      if (bookingId == null || bookingId.isEmpty) {
        _closeLoader(context);
        showErrorNotification(message: "Failed to get booking ID");
        return;
      }

      if (recipientId == null || recipientId.isEmpty) {
        _closeLoader(context);
        showErrorNotification(message: "Failed to get recipient ID");
        return;
      }

      /// ================= CREATE CHAT =================
      final createChatRoom = await ref
          .read(chatStateControllerProvider.notifier)
          .createChatRoom(bookingId: bookingId, recipientId: recipientId);

      if (!context.mounted) return;

      if (createChatRoom.data["status"] != "success") {
        _closeLoader(context);
        showErrorNotification(
          message: createChatRoom.data["message"] ?? "Failed to create chat",
        );
        return;
      }

      final chatData = createChatRoom.data["data"]["chat"];
      final String? chatId = chatData?["_id"];

      if (chatId == null || chatId.isEmpty) {
        _closeLoader(context);
        showErrorNotification(message: "Chat ID missing");
        return;
      }

      /// ================= SEND MESSAGE =================

      final systemMessage = MessageModel(
        content:
            """
          New Booking Request

    Service: ${bookingData["service"]["title"]}
    Date: $preferredDate
    Time: $preferredTime
    Customer: $name
    Phone: $phoneNumber
    Address: $address
    'Price: \$${bookingData["service"]["basePrice"]}'
   """,
        recipientId: recipientId,
        chatId: chatId,
      );

      final systemResponse = await textingRepo.sendMessage(systemMessage);

      if (systemResponse.statusCode != 201) {
        if (!context.mounted) return;
        _closeLoader(context);
        showErrorNotification(message: "Failed to send system message");
        return;
      }

      final userResponse = await textingRepo.sendMessage(
        MessageModel(content: note, recipientId: recipientId, chatId: chatId),
      );

      if (!context.mounted) return;

      if (userResponse.statusCode != 201) {
        _closeLoader(context);
        showErrorNotification(message: "Failed to send user message");
        return;
      }

      /// ================= SUCCESS =================
      _closeLoader(context);

      if (!context.mounted) return;

      ref.read(bottomNavNotifiersProvider.notifier).indexUpdate(3);

      AppNavigatorHelper.go(context, AppRoute.bottomNavigation);
      showSuccessNotification(message: "Booking created successfully");
    } catch (e) {
      print("Unexpected error: $e");
      _closeLoader(context);
      showErrorNotification(message: "Something went wrong");
    }
  }

  void _closeLoader(BuildContext context) {
    if (context.mounted) {
      context.pop();
    }
  }
}
