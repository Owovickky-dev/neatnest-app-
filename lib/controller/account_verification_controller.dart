import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/data/repo/otp_verification_repo.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../utilities/bottom_nav/bottom_navigation_screen.dart';
import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';
import '../widget/loading_screen.dart';

class AccountVerificationController {
  AccountVerificationController();

  final OtpVerificationRepo _otpVerificationRepo = OtpVerificationRepo();

  TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();

  String? otpCode;
  String? userMail;

  void submitCode(BuildContext context) async {
    if (otpCode != null && otpCode!.length < 6) {
      showErrorNotification(message: "Please fill all the 6 digits code");
    } else {
      if (otpCode != null && userMail != null) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => LoadingScreen(),
        );
        try {
          final otp = await _otpVerificationRepo.otpMailVerification(
            email: userMail!,
            otpCode: otpCode!,
          );

          if (otp.statusCode == 200) {
            if (!context.mounted) return;
            context.pop();
            showSuccessNotification(
              message: "Verification Successful, Please kindly Login ",
            );
            AppNavigatorHelper.pushReplacement(context, AppRoute.signIn);
          } else {
            if (!context.mounted) return;
            context.pop();
            showErrorNotification(
              message: otp.data["message"] ?? "Something went wrong",
            );
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

  Future<void> resendCode(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingScreen(),
    );
    try {
      final response = await _otpVerificationRepo.resendOTP(
        email: userMail!,
        purpose: "signup",
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return;
        context.pop();
        showSuccessNotification(message: "OTP Successfully sent to mail");
      } else {
        if (!context.mounted) return;
        context.pop();
        showErrorNotification(
          message: response.data["message"] ?? "Failed to send OTP",
        );
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
