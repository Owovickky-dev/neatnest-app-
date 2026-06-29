import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:neat_nest/data/repo/favourite_repo.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/models/favourite_model.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/widget/app_confirmation_button.dart';
import 'package:neat_nest/widget/app_notification.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favourite_state_controller.g.dart';

@riverpod
class FavouriteStateController extends _$FavouriteStateController {
  late FavouriteRepo _favouriteRepo;
  @override
  List<FavouriteModel> build() {
    _favouriteRepo = FavouriteRepo();
    _initialize();
    return [];
  }

  Future<void> _initialize() async {
    if (!await SecureStorageHelper.isLoggedIn()) {
      return;
    }
    await getUserFavourite();
  }

  Future<void> getUserFavourite() async {
    try {
      final response = await _favouriteRepo.getFavourite();
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"];
        final favourite = responseData
            .map((fav) => FavouriteModel.fromJson(fav))
            .toList();
        favourite.sort((a, b) {
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return b.createdAt!.compareTo(a.createdAt!);
        });
        if (!ref.mounted) return;
        state = favourite;
      } else {
        final errorText = response.data["message"];
        print("The get error text is $errorText");
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> addFavourite(String adsId, BuildContext context) async {
    final loggedIn = await SecureStorageHelper.isLoggedIn();
    if (loggedIn) {
      try {
        final response = await _favouriteRepo.addFavourite(adsId);
        if (response.statusCode == 201) {
          await getUserFavourite();
          return response;
        } else {
          return response;
        }
      } catch (e) {
        print("The favourite error message is ${e.toString()}");
        rethrow;
      }
    } else {
      showErrorNotification(
        message: "Please kindly logged in to add to your favourite",
      );
      if (!context.mounted) return;
      appConfirmationButton(
        context: context,
        title: "Sign In",
        subTitle:
            "In other to add the ads to your favourite you need to login. Do you want to ?",
        textButtonTextLeft: "Cancel",
        textButtonTextRight: "Yes",
        functionRight: () {
          AppNavigatorHelper.pushReplacement(context, AppRoute.signIn);
        },
      );
    }
  }

  Future<Response> removeFavourite(String favouriteId) async {
    try {
      final response = await _favouriteRepo.deleteFavourite(favouriteId);
      if (response.statusCode == 200) {
        await getUserFavourite();
        return response;
      } else {
        return response;
      }
    } catch (e) {
      rethrow;
    }
  }
}
