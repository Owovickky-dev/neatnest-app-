import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/account_verification_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/models/user_model.dart';
import 'package:neat_nest/models/user_skills_model.dart';

import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';
import '../widget/app_notification.dart';
import '../widget/loading_screen.dart';

class SignUpController {
  SignUpController();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController otherNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  bool isChecked = false;
  String? role;
  String? gender;
  List<UserSkillModel>? userSkills;

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
    final String firstName;
    final String username;
    final String phoneNumber;
    final String lastName;
    final String otherName;

    mail = emailController.text.trim();
    password = passwordController.text.trim();
    firstName = firstNameController.text.trim();
    confirmPassword = confirmPasswordController.text.trim();
    username = userNameController.text.trim();
    phoneNumber = phoneNumberController.text.trim();
    lastName = lastNameController.text.trim();
    otherName = otherNameController.text.trim();

    if (role == null || role!.isEmpty) {
      showErrorNotification(message: "Please kindly select a role ");
    } else if (gender == null || gender!.isEmpty) {
      showErrorNotification(message: "Please select gender");
    } else if ((userSkills == null || userSkills!.isEmpty) &&
        (role == "Worker")) {
      showErrorNotification(message: "Atleast one skill is required");
    } else if (!isChecked) {
      showErrorNotification(message: "Please agree to the terms");
    } else {
      final user = UserModel(
        firstName: firstName,
        password: password,
        passwordConfirm: confirmPassword,
        email: mail,
        gender: gender!,
        role: role!,
        username: username,
        phoneNumber: phoneNumber,
        userSkills: userSkills,
        lastName: lastName,
        otherName: otherName,
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => LoadingScreen(),
      );
      try {
        await ref.read(userControllerStateProvider.notifier).register(user);
        if (!context.mounted) return;
        context.pop();
        showSuccessNotification(message: "Verification Code sent to your mail");
        AppNavigatorHelper.pushReplacement(
          context,
          AppRoute.accountVerification,
          extra: VerificationCodeModel(
            userMail: mail,
            verificationType: VerificationType.signUp,
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        context.pop();
        showErrorNotification(
          message: e.toString().replaceFirst("Exception: ", ""),
        );
        if (e is DioException) {
          showErrorNotification(
            message: e.error.toString().replaceFirst("Exception: ", ""),
          );
        }
      }
    }
  }
}
