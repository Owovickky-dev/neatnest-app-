import 'package:flutter/material.dart';
import 'package:neat_nest/screens/user/auth/signin/utilities/new_password_screen.dart';

import '../utilities/bottom_nav/bottom_navigation_screen.dart';

class AccountVerificationController {
  AccountVerificationController();

  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  void submitCode(BuildContext context) {
    String code;
    code = otpController.text;
    if (code.isEmpty || code.length < 4) {
      debugPrint("Please kindly enter the verification code");
    } else {
      debugPrint("The OTP enter is $code");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewPasswordScreen()),
      );
    }
  }

  void submitNewPassword(BuildContext context) {
    String newPassword;
    String confirmNewPassword;

    newPassword = newPasswordController.text;
    confirmNewPassword = confirmNewPasswordController.text;

    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      debugPrint("empty data cant be submit please fill in your details");
    } else if (newPassword.length < 8) {
      debugPrint("Password must be more than 8 characters");
    } else if (newPassword != confirmNewPassword) {
      debugPrint("Password don't match");
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNavigationScreen()),
      );
    }
  }
}
