import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';

class EditProfileController {
  EditProfileController();

  TextEditingController fNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  DateTime lastEditedTime = DateTime.now();
  DateTime lastUserNameEdit = DateTime.now();
  late String updatedFullName;
  late String updatedUserName;
  late String updatedEmail;
  late String updatedPhoneNumber;

  void verifiedDetails(WidgetRef ref) {
    final preData = ref.watch(userControllerStateProvider);
    fNameController.text = preData!.name;
    userNameController.text = preData.username;
    emailController.text = preData.email;
    phoneNumberController.text = preData.phoneNumber;
  }

  bool canEditDetails() {
    final now = DateTime.now();
    final difference = now.difference(lastEditedTime);
    return difference.inSeconds >= 20;
  }

  bool canUserNameDetails() {
    final now = DateTime.now();
    final difference = now.difference(lastUserNameEdit);
    return difference.inSeconds >= 30;
  }

  int timeLeft() {
    final now = DateTime.now();
    final elapsedIn = now.difference(lastEditedTime).inSeconds;
    final resetIn = 20 - elapsedIn;
    return resetIn > 0 ? resetIn : 0;
  }

  int userNameTimeLeft() {
    final now = DateTime.now();
    final elapsedIn = now.difference(lastUserNameEdit).inSeconds;
    final resetIn = 30 - elapsedIn;
    return resetIn > 0 ? resetIn : 0;
  }

  void continueButton() {
    updatedFullName = fNameController.text.trim();
    updatedEmail = emailController.text.trim();
    updatedPhoneNumber = phoneNumberController.text.trim();
    updatedUserName = userNameController.text.trim();
  }
}
