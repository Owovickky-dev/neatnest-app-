import 'package:flutter/cupertino.dart';

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

  void verifiedDetails() {
    fNameController.text = "Owolola Adedeji";
    userNameController.text = "Owovickky";
    emailController.text = "owovickky@gmail.com";
    phoneNumberController.text = "08911177171717";
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
    print(
      "$updatedPhoneNumber , $updatedUserName, $updatedEmail, $updatedFullName",
    );
  }
}
