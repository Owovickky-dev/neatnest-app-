import 'package:neat_nest/data/repo/ads_repo.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/models/filter_search_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'query_ads_state.g.dart';

@Riverpod(keepAlive: true)
class QueryAdsState extends _$QueryAdsState {
  late AdsRepo _adsRepo;

  @override
  AsyncValue<List<AdsModel>> build() {
    _adsRepo = AdsRepo();
    return const AsyncValue.data([]);
  }

  Future<void> queryAds(FilterSearchModel filterData) async {
    state = const AsyncValue.loading();

    try {
      final response = await _adsRepo.queryAds(filterData);

      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data["data"]["allAds"];

        final result = responseData
            .map((json) => AdsModel.fromJson(json))
            .toList();

        state = AsyncValue.data(result);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
