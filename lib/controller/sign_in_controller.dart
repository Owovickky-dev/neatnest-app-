import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/widget/loading_screen.dart';
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

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing
      builder: (context) => LoadingScreen(),
    );

    try {
      final response = await authRepo.signIn(email: email, password: password);
      if (!context.mounted) return;
      context.pop();
      if (response.statusCode == 200) {
        final token = response.data['data']['token'];
        if (token != null) {
          await SecureStorageHelper.saveToken(token);

          if (!context.mounted) return;
          showSuccessNotification(
            context: context,
            message: "Successfully Signing In",
          );
          AppNavigatorHelper.go(
            context,
            AppRoute.bottomNavigation,
            extra: {'yesData': true}, // 👈 Pass yesData: true
          );
        } else {
          if (!context.mounted) return;
          showErrorNotification(
            context: context,
            message: "Failed to log you in",
          );
        }
      }
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          showErrorNotification(
            context: context,
            message: e.response?.data["message"],
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
