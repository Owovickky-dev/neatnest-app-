import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/ads_state_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../widget/loading_screen.dart';

class AdsController {
  AdsController();

  TextEditingController adsTitleController = TextEditingController();
  TextEditingController adsPriceController = TextEditingController();
  TextEditingController adsAboutController = TextEditingController();
  TextEditingController adsImageController = TextEditingController();

  String? category;
  bool? status;
  String? country;
  String? state;

  void updateStatus(String isActive) {
    if (isActive == "True") {
      status = true;
    } else if (isActive == "False") {
      status = false;
    }
  }

  Future<void> getAllAds(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(adsStateControllerProvider.notifier).getAllAds();
      if (!context.mounted) return;
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }

  Future<void> postAds(BuildContext context, WidgetRef ref) async {
    final String title;
    final String price;
    final String imagePath;
    final String aboutAds;

    title = adsTitleController.text.trim();
    price = adsPriceController.text.trim();
    imagePath = adsImageController.text.trim();
    aboutAds = adsAboutController.text.trim();
    print("$category and $status");
    if (category == null || category!.isEmpty || status == null) {
      return showErrorNotification(message: "All field must be filed");
    }

    final newAds = AdsModel(
      title: title,
      about: aboutAds,
      basePrice: int.parse(price),
      category: category!.toLowerCase(),
      country: country,
      state: state,
      image: imagePath,
      isActive: status!,
    );

    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: LoadingScreen(), // Your custom loading screen
        );
      },
    );
    try {
      final response = await ref
          .read(adsStateControllerProvider.notifier)
          .postAds(newAds);
      if (response.statusCode == 201) {
        showSuccessNotification(message: "Ads Successfully Posted");
        if (!context.mounted) return;
        context.pop();
      } else {
        final errorMessage = response.data["message"];
        showErrorNotification(message: errorMessage);
        if (!context.mounted) return;
        context.pop();
      }
      // AppNavigatorHelper.go(context, AppRoute.bottomNavigation);
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }
}
