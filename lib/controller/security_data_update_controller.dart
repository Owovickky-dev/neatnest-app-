import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/controller/sign_in_controller.dart';
import 'package:neat_nest/data/repo/security_update_repo.dart';
import 'package:neat_nest/screens/user/model/security_update_model.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class SecurityDataUpdateController {
  SecurityDataUpdateController();

  final SecurityUpdateRepo _securityUpdateRepo = SecurityUpdateRepo();
  final SignInController _signInController = SignInController();

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController oldEmailController = TextEditingController();
  TextEditingController oldPhoneController = TextEditingController();
  TextEditingController newEmailController = TextEditingController();
  TextEditingController newPhoneController = TextEditingController();

  Future<void> updatePassword(BuildContext context, WidgetRef ref) async {
    String newPassword;
    String confirmPassword;
    String oldPassword;

    newPassword = newPasswordController.text.trim();
    confirmPassword = confirmPasswordController.text.trim();
    oldPassword = oldPasswordController.text.trim();

    final newLogin = SecurityUpdateModel(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      oldPassword: oldPassword,
    );

    try {
      final response = await _securityUpdateRepo.updatePassword(newLogin);

      if (response.statusCode == 201) {
        if (!context.mounted) return;
        _signInController.logout(context, ref, update: "update");
        if (!context.mounted) return;
        showSuccessNotification(
          context: context,
          message: "Password Successfully updated, Please login again",
        );
      } else {
        final errorMessage =
            response.data['message'] ?? 'Failed to  update password';
        if (!context.mounted) return;
        showErrorNotification(context: context, message: errorMessage);
      }
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          final errorMessage = e.response?.data["message"];
          showErrorNotification(context: context, message: errorMessage);
        }
      }
    }
  }

  Future<void> updateMail(BuildContext context, WidgetRef ref) async {
    String newMail;
    String password;
    String oldMail;

    newMail = newEmailController.text.trim();
    password = newPasswordController.text.trim();
    oldMail = oldEmailController.text.trim();

    final updateData = SecurityUpdateModel(
      password: password,
      oldEmail: oldMail,
      newMail: newMail,
    );

    try {
      final response = await _securityUpdateRepo.updateEmail(updateData);
      if (response.statusCode == 200) {
        final responseData = response.data["message"];
        if (!context.mounted) return;
        showSuccessNotification(
          context: context,
          message: "${responseData.toString()}, Pleases login again  ",
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(context: context, message: e.error.toString());
      }
    }
  }

  Future<void> updatePhoneNumber(BuildContext context, WidgetRef ref) async {
    String newPhone;
    String password;
    String oldPhone;

    newPhone = newPhoneController.text.trim();
    password = newPasswordController.text.trim();
    oldPhone = oldPhoneController.text.trim();

    final updateData = SecurityUpdateModel(
      password: password,
      oldPhoneNumber: oldPhone,
      newPhoneNumber: newPhone,
    );

    try {
      final response = await _securityUpdateRepo.updatePhone(updateData);
      if (response.statusCode == 200) {
        final responseData = response.data["message"];
        if (!context.mounted) return;
        showSuccessNotification(
          context: context,
          message: "${responseData.toString()}, Pleases login again  ",
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(context: context, message: e.error.toString());
      }
    }
  }
}
