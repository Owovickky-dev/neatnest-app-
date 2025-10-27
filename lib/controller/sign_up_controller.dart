import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/models/user_model.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';
import '../widget/loading_screen.dart';

class SignUpController {
  SignUpController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool isChecked = false;
  String? role;
  String? gender;

  void setChecked(bool val) {
    isChecked = val;
  }

  void setRole(String value) {
    role = value;
  }

  void setGender(String value) {
    gender = value;
  }

  void submit(BuildContext context, WidgetRef ref) async {
    final String mail;
    final String password;
    final String confirmPassword;
    final String name;
    final String username;

    mail = emailController.text;
    password = passwordController.text;
    name = nameController.text;
    confirmPassword = confirmPasswordController.text;
    username = userNameController.text;

    if (role == null || role!.isEmpty) {
      showErrorNotification(
        context: context,
        message: "Please kindly select a role ",
      );
    } else if (gender == null || gender!.isEmpty) {
      showErrorNotification(context: context, message: "Please select gender");
    } else if (!isChecked) {
      showErrorNotification(
        context: context,
        message: "Please agree to the terms",
      );
    } else {
      final user = UserModel(
        name: name,
        password: password,
        passwordConfirm: confirmPassword,
        email: mail,
        gender: gender!,
        role: role!,
        username: username,
      );
      showDialog(
        context: context,
        barrierDismissible: false, // Prevent user from dismissing
        builder: (context) => LoadingScreen(),
      );
      try {
        await ref.read(userControllerStateProvider.notifier).register(user);
        if (!context.mounted) return;

        context.pop();
        if (!context.mounted) return;
        showSuccessNotification(
          context: context,
          message: "Registration Successful",
        );

        AppNavigatorHelper.go(
          context,
          AppRoute.bottomNavigation,
          extra: {'yesData': true},
        );
      } catch (e) {
        if (!context.mounted) return;
        context.pop();
        if (e is DioException) {
          if (e.response?.statusCode == 500) {
            showErrorNotification(
              context: context,
              message: e.response?.data["message"],
            );
          } else if (e.response?.statusCode == 500 &&
              e.response?.data["error"]["errorResponse"]["code"] == 11000) {
            showErrorNotification(
              context: context,
              message: "$mail already exist please register with another mail ",
            );
          } else {
            showErrorNotification(context: context, message: "Network error");
            if (kDebugMode) {
              print(e.message);
            }
          }
        }
      }
    }
  }
}
