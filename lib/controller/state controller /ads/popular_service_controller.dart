import 'package:neat_nest/data/repo/ads_repo.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'popular_service_controller.g.dart';

@Riverpod(keepAlive: true)
class PopularServiceController extends _$PopularServiceController {
  late AdsRepo _adsRepo;

  @override
  List<AdsModel> build() {
    _adsRepo = AdsRepo();
    return [];
  }

  Future<void> getPopularAds() async {
    try {
      final response = await _adsRepo.getPopularAds();
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data["data"];
        final List<AdsModel> popularServiceData = responseData
            .map((el) => AdsModel.fromJson(el))
            .toList();
        if (!ref.mounted) return;
        state = popularServiceData;
      }
    } catch (e) {
      rethrow;
    }
  }
}
