import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:neat_nest/data/repo/user_data_repo.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/models/user_model.dart';
import 'package:neat_nest/providers/is_logged_in_state.dart';
import 'package:neat_nest/widget/app_confirmation_button.dart';
import 'package:neat_nest/widget/loading_screen.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';

class SignInController {
  SignInController();
  AuthRepo authRepo = AuthRepo();
  UserDataRepo userDataRepo = UserDataRepo();

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
      barrierDismissible: false,
      builder: (context) => LoadingScreen(),
    );

    try {
      await userNotifier.login(email, password);
      if (!context.mounted) return;
      ref.read(isLoggedInStateProvider.notifier).yesLogged(true);
      context.pop();
      showSuccessNotification(message: "Login Successful");
      AppNavigatorHelper.pushReplacement(context, AppRoute.bottomNavigation);
    } catch (e) {
      String verifyMessage = "Please kindly verify your account";
      if (!context.mounted) return;
      context.pop();
      showErrorNotification(
        message: e.toString().replaceFirst("Exception: ", ""),
      );
      if (e.toString().replaceFirst("Exception: ", "") == verifyMessage) {
        appConfirmationButton(
          context: context,
          title: "Verify Account",
          subTitle: "Do you want to verify your account now",
          textButtonTextLeft: "Cancel",
          textButtonTextRight: "Yes",
          functionRight: () async {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => LoadingScreen(),
            );

            try {
              await userNotifier.reSendOtp(email, "signup");
              if (!context.mounted) return;
              context.pop();
              AppNavigatorHelper.pushReplacement(
                context,
                AppRoute.accountVerification,
                extra: email,
              );
            } catch (e) {
              if (!context.mounted) return;
              context.pop();
              showErrorNotification(
                message: e.toString().replaceFirst("Exception: ", ""),
              );
            }
          },
        );
      }
    }
  }

  void logout(BuildContext context, WidgetRef ref, {String? update}) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingScreen(),
    );
    try {
      await ref.read(userControllerStateProvider.notifier).logOut();
      if (!context.mounted) return;
      update == null
          ? showSuccessNotification(message: "Successfully logged out")
          : null;
      ref.read(isLoggedInStateProvider.notifier).yesLogged(false);
      if (!context.mounted) return;
      AppNavigatorHelper.pushReplacement(context, AppRoute.signIn);
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      showErrorNotification(message: "Logout failed");
    }
  }

  Future<UserModel?> uploadProfilePic(String picPath) async {
    try {
      final response = await userDataRepo.uploadProfilePics(picPath);

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(response.data["data"]);
        await SecureStorageHelper.saveUserData(updatedUser);
        return updatedUser;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      rethrow;
    }
  }
}
