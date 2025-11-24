import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/ads_state_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/widget/loading_screen.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

class AdsController {
  AdsController();

  TextEditingController adsTitleController = TextEditingController();
  TextEditingController adsPriceController = TextEditingController();
  TextEditingController adsAboutController = TextEditingController();
  TextEditingController adsImageController = TextEditingController();

  String? category;
  bool? status;

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
      category: category!,
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
      await ref.read(adsStateControllerProvider.notifier).postAds(newAds);
      if (!context.mounted) return;
      context.pop();
      showSuccessNotification(message: "Ads successfully posted");
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }
}
