import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:neat_nest/screens/user/auth/signup/account_verification_screen.dart';

class PasswordResetController {
  PasswordResetController();

  TextEditingController passwordReset = TextEditingController();

  void submitMail(BuildContext context) {
    if (passwordReset.text.isEmpty) {
      debugPrint("Please fill in your mail");
    } else if (!EmailValidator.validate(passwordReset.text)) {
      debugPrint("Please enter a valid mail...");
    } else {
      debugPrint("Code Successfully sent");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AccountVerificationScreen(userMail: ''),
        ),
      );
    }
  }
}
