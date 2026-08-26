import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_notification.dart';

import '../models/user_model.dart';
import '../widget/loading_screen.dart';

class EditProfileController {
  EditProfileController();

  final TextEditingController fNameController = TextEditingController();

  final TextEditingController otherNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController userPassword = TextEditingController();

  final TextEditingController phoneNosController = TextEditingController();

  UserModel? _originalUser;

  void verifiedDetails(WidgetRef ref) {
    final preData = ref.read(userControllerStateProvider);

    if (preData == null) return;

    _originalUser = preData;

    fNameController.text = preData.firstName;

    userNameController.text = preData.username;

    otherNameController.text = preData.otherName ?? "";

    lastNameController.text = preData.lastName;

    phoneNosController.text = preData.phoneNumber;
  }

  void saveData(WidgetRef ref, BuildContext context) async {
    if (_originalUser == null) {
      showErrorNotification(message: "Unable to load user information.");
      return;
    }

    final String firstName = fNameController.text.trim();

    final String otherName = otherNameController.text.trim();

    final String lastName = lastNameController.text.trim();

    final String userName = userNameController.text.trim();

    final String password = userPassword.text.trim();

    final String phoneNumber = phoneNosController.text.trim();

    final userData = EditProfileModel(
      password: password,

      firstName: firstName != _originalUser!.firstName ? firstName : null,

      lastName: lastName != _originalUser!.lastName ? lastName : null,

      otherName: otherName != (_originalUser!.otherName ?? "")
          ? otherName
          : null,

      userName: userName != _originalUser!.username ? userName : null,

      phoneNumber: phoneNumber != _originalUser!.phoneNumber
          ? phoneNumber
          : null,
    );

    // Nothing changed

    if (userData.firstName == null &&
        userData.lastName == null &&
        userData.otherName == null &&
        userData.userName == null &&
        userData.phoneNumber == null) {
      showErrorNotification(message: "No changes detected.");
      return;
    }

    if (!context.mounted) return;

    showDialog(
      context: context,

      barrierDismissible: false,

      builder: (_) => const LoadingScreen(),
    );

    try {
      await ref
          .read(userControllerStateProvider.notifier)
          .updateUserDetails(userData);

      if (!context.mounted) return;

      context.pop();

      userPassword.clear();

      showSuccessNotification(
        message: "Your details were updated successfully.",
      );

      AppNavigatorHelper.pushReplacement(context, AppRoute.editProfile);
    } catch (e) {
      if (!context.mounted) return;
      context.pop();

      if (e is Map<String, dynamic>) {
        final message = e["message"];
        final nextNameChange = e["nextChange"];
        if (message != null && nextNameChange != null) {
          final date = (DateTime.parse(nextNameChange)).toLocal();
          final dateFormat = DateFormat("dd/MM/yy    @  h:mm a").format(date);
          showErrorNotification(message: " $message $dateFormat");
        } else {
          showErrorNotification(message: message);
        }
      } else {
        final errorMessage = e.toString().replaceFirst("Exception: ", "");
        showErrorNotification(message: errorMessage);
      }
    }
  }

  void dispose() {
    fNameController.dispose();
    otherNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    userPassword.dispose();
    phoneNosController.dispose();
  }
}

class EditProfileModel {
  final String? firstName;
  final String? lastName;
  final String? otherName;
  final String? userName;
  final String? phoneNumber;
  final String password;

  EditProfileModel({
    this.firstName,
    this.lastName,
    this.otherName,
    this.userName,
    this.phoneNumber,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (firstName != null && firstName!.isNotEmpty) {
      data["firstName"] = firstName;
    }
    if (lastName != null && lastName!.isNotEmpty) {
      data["lastName"] = lastName;
    }
    if (userName != null && userName!.isNotEmpty) {
      data["username"] = userName;
    }
    if (otherName != null && otherName!.isNotEmpty) {
      data["otherName"] = otherName;
    }
    if (phoneNumber != null && phoneNumber!.isNotEmpty) {
      data["phoneNumber"] = phoneNumber;
    }
    if (password.isNotEmpty) {
      data["password"] = password;
    }
    return data;
  }
}
