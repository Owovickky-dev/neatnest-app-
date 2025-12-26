import 'package:dio/dio.dart';
import 'package:neat_nest/data/repo/favourite_repo.dart';
import 'package:neat_nest/models/favourite_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favourite_state_controller.g.dart';

@riverpod
class FavouriteStateController extends _$FavouriteStateController {
  late FavouriteRepo _favouriteRepo;
  @override
  List<FavouriteModel> build() {
    _favouriteRepo = FavouriteRepo();
    Future(() => getUserFavourite());
    return [];
  }

  Future<void> getUserFavourite() async {
    try {
      final response = await _favouriteRepo.getFavourite();
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"];
        final favourite = responseData
            .map((fav) => FavouriteModel.fromJson(fav))
            .toList();
        if (!ref.mounted) return;
        state = favourite;
      }
    } catch (e) {
      rethrow;
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
