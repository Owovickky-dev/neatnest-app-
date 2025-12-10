import 'package:dio/dio.dart';
import 'package:neat_nest/data/repo/ads_repo.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ads_state_controller.g.dart';

@Riverpod(keepAlive: true)
class AdsStateController extends _$AdsStateController {
  late AdsRepo _adsRepo;
  @override
  List<AdsModel> build() {
    _adsRepo = AdsRepo();
    return [];
  }

  Future<void> getAllAds() async {
    try {
      final response = await _adsRepo.getAllAds();
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"]["allAds"];
        final List<AdsModel> adsData = responseData
            .map((ad) => AdsModel.fromJson(ad))
            .toList();
        adsData.sort((a, b) {
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return b.createdAt!.compareTo(a.createdAt!);
        });
        state = adsData;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> postAds(AdsModel adsData) async {
    try {
      final response = await _adsRepo.postAds(adsData);
      return response;
    } catch (e) {
      print("The server error is $e");
      if (e is DioException && e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }
}
