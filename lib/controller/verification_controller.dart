import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/data/repo/verification_repo.dart';
import 'package:neat_nest/models/verification_model.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/loading_screen.dart';

import '../widget/app_notification.dart';

class VerificationController {
  VerificationController();

  final VerificationRepo _verificationRepo = VerificationRepo();

  String? idType;
  File? frontImage;
  File? backImage;

  void submitData(BuildContext context) async {
    if (idType != null && idType!.isNotEmpty) {
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
      final response = await _verificationRepo.uploadUserId(uploadData);

      if (response.statusCode == 200) {
        if (!context.mounted) return;
        showSuccessNotification(
          message: "$idType successfully submit for verification",
        );
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
    } else {
      showErrorNotification(
        message: "Please kindly select Id type for verification",
      );
    }
  }

  // Future<void> getUserIds() async {
  //   final response = await _verificationRepo.getUserId();
  //
  //   if (response.statusCode == 200) {
  //     final responseData = response.data["data"];
  //     final ids = DisplayDataModel.fromJson(responseData);
  //     await SecureStorageHelper.saveUserId(ids);
  //   }
  // }
}
