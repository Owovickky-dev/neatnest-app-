import 'package:dio/dio.dart';
import 'package:neat_nest/data/repo/favourite_repo.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/models/favourite_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favourite_state_controller.g.dart';

@riverpod
class FavouriteStateController extends _$FavouriteStateController {
  late FavouriteRepo _favouriteRepo;
  @override
  List<FavouriteModel> build() {
    _favouriteRepo = FavouriteRepo();
    return [];
  }

  Future<void> getUserFavourite() async {
    final token = await SecureStorageHelper.getToken();
    if (token == null || token.isEmpty) {
      print("Token is empty cant get the favourite");
    } else {
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
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<Response> addFavourite(String adsId) async {
    try {
      final response = await _favouriteRepo.addFavourite(adsId);
      if (response.statusCode == 201) {
        await getUserFavourite();
        return response;
      } else {
        return response;
      }
    } catch (e) {
      rethrow;
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
