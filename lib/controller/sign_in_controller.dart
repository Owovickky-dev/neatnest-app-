import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';

class SignInController {
  SignInController();
  AuthRepo authRepo = AuthRepo();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isChecked = false;

  void setChecked(bool val) {
    isChecked = val;
    if (kDebugMode) {
      print('the value of val is:  $val');
    }
  }

  void submitData(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    bool success = await authRepo.signIn(email: email, password: password);

    if (!context.mounted) return;

    if (success) {
      showSuccessNotification(
        context: context,
        message: "Successfully Signin In",
      );
      AppNavigatorHelper.go(
        context,
        AppRoute.bottomNavigation,
        extra: {'yesData': true}, // 👈 Pass yesData: true
      );
    } else {
      showErrorNotification(context: context, message: "Failed to login");
    }
  }
}
