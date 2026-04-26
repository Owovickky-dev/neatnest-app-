import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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

  String? category;
  bool? status;
  String? country;
  String? state;
  File? imageSelected;
  String? id;
  List<WorkerAvailableInfoModel>? timeAvailable;

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
    print("the selected image details is $imageSelected");
    final String title;
    final String price;
    final String aboutAds;

    title = adsTitleController.text.trim();
    price = adsPriceController.text.trim();

    aboutAds = adsAboutController.text.trim();
    if (category == null || category!.isEmpty || status == null) {
      return showErrorNotification(message: "All field must be filed");
    }
    if (timeAvailable == null || timeAvailable!.isEmpty) {
      return showErrorNotification(
        message: "Please kindly pick your available time",
      );
    }

    final newAds = AdsModel(
      title: title,
      about: aboutAds,
      basePrice: int.parse(price),
      category: category!.toLowerCase(),
      country: country,
      state: state,
      image: imageSelected,
      isActive: status!,
      availableSchedule: timeAvailable,
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
    print(timeAvailable);
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
        context.pop();
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

  Future<void> getUserAds(BuildContext context, WidgetRef ref) async {
    try {
      await ref.read(userAdsStateControllerProvider.notifier).getUserAds();
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }

  Future<void> updateAds(
    BuildContext context,
    WidgetRef ref,
    AdsModel currentAds,
  ) async {
    final String? title;
    final String? price;
    final String? aboutAds;

    title = adsTitleController.text.trim();
    price = adsPriceController.text.trim();
    aboutAds = adsAboutController.text.trim();

    final updateData = AdsModel(
      title: (title == currentAds.title && title.isNotEmpty) ? null : title,
      basePrice: (int.parse(price) == currentAds.basePrice && price.isNotEmpty)
          ? null
          : int.parse(price),
      about: (aboutAds == currentAds.about && aboutAds.isNotEmpty)
          ? null
          : aboutAds,
      country: (country == currentAds.country && country == null)
          ? null
          : country,
      state: (state == currentAds.state && state == null) ? null : state,
      category: (category == currentAds.category && category == null)
          ? null
          : category,
      isActive: status == currentAds.isActive ? null : status,
      id: id,
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
          .read(userAdsStateControllerProvider.notifier)
          .updateAds(updateData);

      if (response.statusCode == 200) {
        await ref.read(userAdsStateControllerProvider.notifier).getUserAds();
        if (!context.mounted) return;
        AppNavigatorHelper.go(context, AppRoute.viewAdsScreen);
        showSuccessNotification(message: "Ads Successfully updated");
      } else {
        final errorMessage = response.data["message"];
        final nextTime = response.data["error"]["extra"]["nextUpdateTime"];
        final local = DateTime.parse(nextTime).toLocal();
        final newDateFormat = DateFormat("dd/MM/yy hh:mm a").format(local);
        if (!context.mounted) return;
        AppNavigatorHelper.go(context, AppRoute.viewAdsScreen);
        showErrorNotification(message: "$errorMessage $newDateFormat");
      }
    } catch (e) {
      if (!context.mounted) return;
      context.pop();
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }

  Future<void> activate(
    BuildContext context,
    bool active,
    WidgetRef ref,
    String adsId,
  ) async {
    print("The new ads Status is $active");
    print("The ID of the ads is $adsId");

    try {
      final response = await ref
          .read(userAdsStateControllerProvider.notifier)
          .activateAds(active, adsId);

      if (response.statusCode == 200) {
        if (!context.mounted) return;
        await ref.read(userAdsStateControllerProvider.notifier).getUserAds();
        showSuccessNotification(
          message: active
              ? "Ads successfully Activate"
              : "Ads successfully deactivate",
        );
      } else {
        final errorMessage = response.data["message"];
        showErrorNotification(message: errorMessage);
      }
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }
}
