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
    print("The favourite button is clicked");

    try {
      final response = await ref
          .read(favouriteStateControllerProvider.notifier)
          .addFavourite(adsId);
      if (response.statusCode == 201) {
        if (!context.mounted) return;
        showSuccessNotification(message: "Added to your favourite");
      } else {
        if (!context.mounted) return;
        print(response.data);
        showErrorNotification(message: "Failed to add to your favourite");
      }
    } catch (e) {
      if (!context.mounted) return;
      if (e is DioException) {
        showErrorNotification(message: e.error.toString());
      }
    }
  }
}
