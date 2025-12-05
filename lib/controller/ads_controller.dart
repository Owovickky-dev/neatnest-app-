import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/ads_state_controller.dart';
import 'package:neat_nest/controller/state%20controller%20/ads/user_ads_state_controller.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../utilities/route/app_naviation_helper.dart';
import '../utilities/route/app_route_names.dart';
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
    print("$country and $state");
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
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: EdgeInsets.zero,
          child: LoadingScreen(),
        );
      },
    );
    try {
      final response = await ref
          .read(adsStateControllerProvider.notifier)
          .postAds(newAds);
      if (response.statusCode == 201) {
        if (!context.mounted) return;
        AppNavigatorHelper.go(context, AppRoute.bottomNavigation);
        showSuccessNotification(message: "Ads Successfully Posted");
      } else {
        final errorMessage = response.data["message"];
        if (!context.mounted) return;
        AppNavigatorHelper.go(context, AppRoute.bottomNavigation);
        showErrorNotification(message: errorMessage);
      }
    } catch (e) {
      if (!context.mounted) return;
      AppNavigatorHelper.go(context, AppRoute.bottomNavigation);
      if (e is DioException) {
        print(e.error);
        showErrorNotification(message: e.error.toString());
      }
    }
  }

  Future<void> deleteAds(WidgetRef ref, String adsId) async {
    try {
      await ref.read(userAdsStateControllerProvider.notifier).deleteAds(adsId);
      showSuccessNotification(message: "Ads successfully deleted");
    } catch (e) {
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }
}
