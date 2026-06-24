import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/account_verification_controller.dart';
import 'package:neat_nest/data/repo/auth_repo.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

import '../widget/app_notification.dart';
import '../widget/loading_screen.dart';

class PasswordController {
  PasswordController();

  final AuthRepo _authRepo = AuthRepo();

  TextEditingController passwordReset = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String? userMail;

  void forgotPassword(BuildContext context) async {
    final email = passwordReset.text.trim();
    if (email.isEmpty) {
      showErrorNotification(message: "Please fill in your mail");
    } else if (!EmailValidator.validate(email)) {
      showErrorNotification(message: "Please enter a valid mail...");
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingScreen(),
      );
      try {
        final response = await _authRepo.forgotPassword(email);

        if (response.statusCode == 200) {
          if (!context.mounted) return;
          context.pop();
          showSuccessNotification(message: response.data["message"]);
          AppNavigatorHelper.push(
            context,
            AppRoute.accountVerification,
            extra: VerificationCodeModel(
              userMail: email,
              verificationType: VerificationType.resetPassword,
            ),
          );
        } else {
          final responseData = response.data["message"];
          if (!context.mounted) return;
          context.pop();
          showErrorNotification(message: responseData);
        }
      } catch (e) {
        if (!context.mounted) return;
        context.pop();
        showErrorNotification(
          message: e.toString().replaceFirst("Exception: ", ""),
        );
      }
    }
  }

  void submitNewPassword(BuildContext context) async {
    String newPassword;
    String confirmNewPassword;

    newPassword = newPasswordController.text;
    confirmNewPassword = confirmNewPasswordController.text;

    if (newPassword.isEmpty || confirmNewPassword.isEmpty) {
      showErrorNotification(
        message: "empty data cant be submit please fill in your details",
      );
    } else if (newPassword != confirmNewPassword) {
      showErrorNotification(message: "Password don't match");
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingScreen(),
      );

      final resetToken = await SecureStorageHelper.getResetPasswordToken();

      try {
        if (resetToken != null &&
            resetToken.isNotEmpty &&
            userMail != null &&
            userMail!.isNotEmpty) {
          final response = await _authRepo.resetPassword(
            resetToken: resetToken,
            password: newPassword,
            confirmPassword: confirmNewPassword,
            email: userMail!,
          );

          if (response.statusCode == 201) {
            if (!context.mounted) return;
            context.pop();
            showSuccessNotification(message: response.data["message"]);
            AppNavigatorHelper.pushReplacement(context, AppRoute.signIn);
          } else {
            if (!context.mounted) return;
            context.pop();
            showErrorNotification(message: response.data["message"]);
          }
        }
      } on DioException catch (e) {
        if (!context.mounted) return;
        context.pop();
        showErrorNotification(
          message:
              e.response?.data["message"] ??
              e.message ??
              "Network error occurred",
        );
      } catch (e) {
        if (!context.mounted) return;
        context.pop();
        showErrorNotification(
          message: e.toString().replaceFirst("Exception: ", ""),
        );
      }
    }
  }

  void changePassword() {}
}
