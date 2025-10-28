import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:neat_nest/providers/is_logged_in_state.dart';
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

  void submitData(BuildContext context, WidgetRef ref) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    final userNotifier = ref.read(userControllerStateProvider.notifier);

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing
      builder: (context) => LoadingScreen(),
    );

    try {
      await userNotifier.login(email, password);
      if (!context.mounted) return;
      ref.read(isLoggedInStateProvider.notifier).yesLogged(true);
      context.pop();
      if (!context.mounted) return;
      showSuccessNotification(context: context, message: "Login Successful");
      if (!context.mounted) return;
      AppNavigatorHelper.pushReplacement(context, AppRoute.bottomNavigation);
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

  void logout(BuildContext context, WidgetRef ref) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingScreen(),
    );
    try {
      await ref.read(userControllerStateProvider.notifier).logOut();
      if (!context.mounted) return;
      showSuccessNotification(
        context: context,
        message: "Successfully logged out",
      );
      ref.read(isLoggedInStateProvider.notifier).yesLogged(false);
      if (!context.mounted) return;
      AppNavigatorHelper.pushReplacement(context, AppRoute.bottomNavigation);
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      showErrorNotification(context: context, message: "Logout failed");
    }
  }
}
