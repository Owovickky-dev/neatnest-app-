import 'package:dio/dio.dart';
import 'package:neat_nest/data/repo/query_data_repo.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'query_data_controller.g.dart';

@riverpod
class QueryDataController extends _$QueryDataController {
  late QueryDataRepo _queryDataRepo;
  @override
  Future<List<AdsModel>> build() async {
    _queryDataRepo = QueryDataRepo();
    return [];
  }

  Future<void> getAdsData() async {
    try {
      state = const AsyncValue.loading();
      Response response = await _queryDataRepo.getAllAds();
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        final List<AdsModel> adsList = data
            .map((el) => AdsModel.fromJson(el))
            .toList();
        state = AsyncValue.data(adsList);
      } else {
        throw Exception("Failed to load ads: ${response.statusCode}");
      }
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}
