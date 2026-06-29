import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/account_verification_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/data/repo/otp_verification_repo.dart';
import 'package:neat_nest/providers/is_logged_in_state.dart';
import 'package:neat_nest/utilities/device_helper.dart';
import 'package:neat_nest/widget/app_confirmation_button.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';
import '../widget/app_notification.dart';

class SignInController {
  SignInController();
  final OtpVerificationRepo _otpVerificationRepo = OtpVerificationRepo();

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

    final deviceData = await DeviceHelper.getDeviceInfo();

    final loginData = LoginModel(
      email: email,
      password: password,
      deviceData: deviceData,
    );

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingScreen(),
    );
    print("I got here");
    try {
      await userNotifier.login(loginData);
      print("After ruinng to server");
      if (!context.mounted) return;
      ref.read(isLoggedInStateProvider.notifier).yesLogged(true);
      context.pop();
      showSuccessNotification(message: "Login Successful");
      AppNavigatorHelper.pushReplacement(context, AppRoute.bottomNavigation);
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      final errorMessage = e.toString().replaceFirst("Exception: ", "");
      showErrorNotification(
        message: errorMessage == "ACCOUNT_NOT_VERIFIED"
            ? "Please your email need to ve verify"
            : errorMessage,
      );
      if (errorMessage == "ACCOUNT_NOT_VERIFIED") {
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
              await _otpVerificationRepo.resendOTP(
                email: email,
                purpose: "signup",
              );
              if (!context.mounted) return;
              context.pop();
              AppNavigatorHelper.push(
                context,
                AppRoute.accountVerification,
                extra: VerificationCodeModel(
                  userMail: email,
                  verificationType: VerificationType.signUp,
                ),
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
}

class LoginModel {
  final String email;
  final String password;
  final Map<String, dynamic> deviceData;

  LoginModel({
    required this.email,
    required this.password,
    required this.deviceData,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (email.isNotEmpty) {
      data["email"] = email;
    }
    if (password.isNotEmpty) {
      data["password"] = password;
    }
    data["deviceData"] = deviceData;
    return data;
  }
}
