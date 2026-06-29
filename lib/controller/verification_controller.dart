import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_controller_state.dart';
import 'package:neat_nest/controller/state%20controller%20/user/user_verification_state.dart';
import 'package:neat_nest/data/repo/verification_repo.dart';
import 'package:neat_nest/models/verification_model.dart';

import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';
import '../widget/app_notification.dart';
import '../widget/loading_screen.dart';

class VerificationController {
  VerificationController();

  final VerificationRepo _verificationRepo = VerificationRepo();

  String? idType;
  File? frontImage;
  File? backImage;

  void submitData(BuildContext context) async {
    if (idType != null && idType!.isNotEmpty && frontImage != null) {
      final uploadData = UserUploadVerificationModel(
        idType: idType!,
        frontImage: frontImage,
        backImage: backImage,
      );

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Dialog(
          backgroundColor: Colors.transparent,
          child: LoadingScreen(),
        ),
      );

      try {
        final response = await _verificationRepo.uploadUserId(uploadData);

        if (response.statusCode == 200) {
          if (!context.mounted) return;
          final container = ProviderScope.containerOf(context);
          if (!context.mounted) return;
          container.invalidate(userVerificationStateProvider);
          showSuccessNotification(
            message: "$idType successfully submit for verification",
          );

          await container
              .read(userControllerStateProvider.notifier)
              .updateVerificationStarted(true);

          if (!context.mounted) return;
          AppNavigatorHelper.pushReplacement(
            context,
            AppRoute.verificationMethodScreen,
          );
        } else {
          if (!context.mounted) return;
          final errorMessage = response.data["message"];
          showErrorNotification(message: errorMessage);
          context.pop();
        }
      } on DioException catch (e) {
        if (!context.mounted) return;
        context.pop();
        rethrow;
      } catch (e, stack) {
        if (!context.mounted) return;
        context.pop();
        showErrorNotification(
          message: e.toString().replaceFirst("Exception ", ""),
        );
        print(e.toString());
        print(stack);
      }
    } else {
      showErrorNotification(
        message: "Please note that empty data cant be submit",
      );
    }
  }
}
