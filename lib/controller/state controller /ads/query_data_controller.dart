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
    if (!ref.mounted) return;

    try {
      state = const AsyncValue.loading();
      await Future.delayed(Duration(milliseconds: 1500));
      Response response = await _queryDataRepo.getAllAds();
      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        final List<dynamic> data = responseData['data']['allAds'];
        print("Data received: ${data.length} ads");

        final List<AdsModel> adsList = data
            .map((el) => AdsModel.fromJson(el))
            .toList();

        print("✅ Successfully parsed ${adsList.length} ads");
        state = AsyncValue.data(adsList);
      } else {
        throw Exception("Failed to load ads: ${response.statusCode}");
      }
    } catch (e, stack) {
      print("❌ Error in getAdsData: $e");
      print("Stack trace: $stack");
      if (!ref.mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }
}
