import 'package:neat_nest/data/repo/ads_repo.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/models/user_ads_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_ads_state_controller.g.dart';

@riverpod
class UserAdsStateController extends _$UserAdsStateController {
  late AdsRepo _adsRepo;
  @override
  UserAdsModel? build() {
    _adsRepo = AdsRepo();
    return null;
  }

  Future<void> getUserAds() async {
    try {
      final response = await _adsRepo.getUserAds();
      if (response.statusCode == 200) {
        final List<dynamic> totalAdsResponseData =
            response.data["totalAds"]["totalUserAds"];
        final List<dynamic> totalActiveAdsResponseData =
            response.data["activeAds"]["totalActiveAds"];

        final getTotalAds = totalAdsResponseData
            .map((ads) => AdsModel.fromJson(ads))
            .toList();
        final getActiveAds = totalActiveAdsResponseData
            .map((activeAds) => AdsModel.fromJson(activeAds))
            .toList();

        print("The total ads is ${getTotalAds.length}");
        if (!ref.mounted) return;
        state = UserAdsModel(activeAds: getActiveAds, totalAds: getTotalAds);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshUserData() async {
    state = null;
    await getUserAds();
  }

  Future<void> deleteAds(String adsId) async {
    try {
      final response = await _adsRepo.deleteAds(adsId);
      if (response.statusCode == 201) {
        await getUserAds();
      }
    } catch (e) {
      rethrow;
    }
  }
}
