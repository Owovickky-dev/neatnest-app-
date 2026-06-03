import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/data/repo/otp_verification_repo.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';
import '../widget/loading_screen.dart';

class AccountVerificationController {
  AccountVerificationController();

  final OtpVerificationRepo _otpVerificationRepo = OtpVerificationRepo();

  TextEditingController otpController = TextEditingController();

  String? otpCode;
  String? userMail;

  void mailVerification(BuildContext context) async {
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

  void verifyPasswordOtp(BuildContext context) async {
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
          final otp = await _otpVerificationRepo.verifyPasswordOtp(
            email: userMail!,
            otpCode: otpCode!,
          );

          if (otp.statusCode == 200) {
            if (!context.mounted) return;
            context.pop();
            final resetToken = otp.data["resetToken"];
            if (resetToken != null && resetToken.toString().isNotEmpty) {
              await SecureStorageHelper.savePasswordResetToken(resetToken);
              showSuccessNotification(message: "Verification Successful");
              if (!context.mounted) return;
              AppNavigatorHelper.pushReplacement(
                context,
                AppRoute.newPasswordScreen,
                extra: userMail,
              );
            }
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

  Future<bool> resendCode(BuildContext context, String purpose) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => LoadingScreen(),
    );
    try {
      final response = await _otpVerificationRepo.resendOTP(
        email: userMail!,
        purpose: purpose,
      );

      if (response.statusCode == 200) {
        if (!context.mounted) return false;
        context.pop();
        showSuccessNotification(message: "OTP Successfully sent to mail");
        return true;
      } else {
        if (!context.mounted) return false;
        context.pop();
        showErrorNotification(
          message: response.data["message"] ?? "Failed to send OTP",
        );
        return false;
      }
    } on DioException catch (e) {
      if (!context.mounted) return false;
      context.pop();
      showErrorNotification(
        message:
            e.response?.data["message"] ??
            e.message ??
            "Network error occurred",
      );
      return false;
    } catch (e) {
      if (!context.mounted) return false;
      context.pop();
      showErrorNotification(
        message: e.toString().replaceFirst("Exception: ", ""),
      );
      return false;
    }
  }
}

enum VerificationType {
  signUp,
  resetPassword,
  emailChange,
  payment,
  withdrawal,
  phoneChange,
}

class VerificationCodeModel {
  final String userMail;
  final VerificationType verificationType;

  VerificationCodeModel({
    required this.userMail,
    required this.verificationType,
  });
}
