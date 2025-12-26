import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:neat_nest/controller/state%20controller%20/favourite/favourite_state_controller.dart';

import '../widget/notificaiton_content.dart';

class FavouriteController {
  FavouriteController();

  Future<void> addFavourite(
    BuildContext context,
    String adsId,
    WidgetRef ref,
  ) async {
    try {
      final response = await ref
          .read(favouriteStateControllerProvider.notifier)
          .addFavourite(adsId);
      if (response.statusCode == 201) {
        if (!context.mounted) return;
        showSuccessNotification(message: "Added to your favourite");
      } else if (response.statusCode == 401) {
        if (!context.mounted) return;
        final errorText = response.data["message"];
        showErrorNotification(message: errorText);
      } else {
        if (!context.mounted) return;
        showErrorNotification(message: "Failed to add to your favourite");
      }
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }

  Future<void> removeFavourite(
    BuildContext context,
    String favouriteId,
    WidgetRef ref,
  ) async {
    try {
      final response = await ref
          .read(favouriteStateControllerProvider.notifier)
          .removeFavourite(favouriteId);
      if (response.statusCode == 200) {
        if (!context.mounted) return;
        showSuccessNotification(message: "Successfully removed from favourite");
      } else if (response.statusCode == 400) {
        final errorText = response.data;
        print(errorText);
      } else {
        showErrorNotification(message: "Failed to remove from favourite");
      }
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }
}
