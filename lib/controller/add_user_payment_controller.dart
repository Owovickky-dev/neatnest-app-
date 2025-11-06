import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/screens/user/model/user_payment_method_model.dart';
import 'package:neat_nest/screens/user/notifiers/user_payment_method_state.dart';
import 'package:neat_nest/utilities/app_data.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class AddUserPaymentController {
  final Ref ref;

  AddUserPaymentController({required this.ref});

  // Method to validate and save payment method
  Future<void> savePaymentMethod({
    required BuildContext context,
    required String? selectedCountry,
    required Map<String, TextEditingController> controllers,
  }) async {
    if (selectedCountry == null) {
      showErrorNotification(
        context: context,
        message: "Please select a payment method",
      );
      return;
    }

    // Validate required fields for selected country
    final requiredFields = AppData.desireMethod[selectedCountry]!;
    for (var field in requiredFields) {
      if (controllers[field]!.text.trim().isEmpty) {
        showErrorNotification(
          context: context,
          message: 'Please fill in $field',
        );
        return;
      }
    }

    try {
      final paymentMethod = UserPaymentMethodModel(
        paymentType: selectedCountry,
        accountNumber: _getFieldValue(controllers, "Account Number"),
        bankAddress: _getFieldValue(controllers, "Bank Address"),
        iban: _getFieldValue(controllers, "IBAN"),
        payPalMail: _getFieldValue(controllers, "Email"),
        routingNumber: _getFieldValue(controllers, "Routing Number"),
        sortCode: _getFieldValue(controllers, "Sort Code"),
        swiftCode: _getFieldValue(controllers, "SWIFT Code"),
      );

      if (paymentMethod.payPalMail != null &&
          !EmailValidator.validate(paymentMethod.payPalMail!)) {
        showErrorNotification(
          context: context,
          message: "Invalid Email address",
        );
        return;
      }

      await ref
          .read(userPaymentMethodStateProvider.notifier)
          .saveUserPaymentInfo(paymentMethod);

      if (!context.mounted) return;
      showSuccessNotification(
        context: context,
        message: 'Payment method saved successfully',
      );

      // Close the screen
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      showErrorNotification(context: context, message: errorMessage);
    }
  }

  Future<void> deleteUserPaymentMethod({
    required BuildContext context,
    required String methodId,
  }) async {
    try {
      final deleteMethod = UserPaymentMethodModel(id: methodId);
      await ref
          .read(userPaymentMethodStateProvider.notifier)
          .deleteUserPayment(deleteMethod);

      if (!context.mounted) return;
      showSuccessNotification(
        context: context,
        message: 'Payment method removed successfully',
      );
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      showErrorNotification(context: context, message: errorMessage);
    }
  }

  // field collectors ...
  String? _getFieldValue(
    Map<String, TextEditingController> controllers,
    String field,
  ) {
    return controllers[field]?.text.trim().isNotEmpty == true
        ? controllers[field]!.text.trim()
        : null;
  }
}

// Provider for the controller
final addUserPaymentControllerProvider = Provider<AddUserPaymentController>(
  (ref) => AddUserPaymentController(ref: ref),
);
