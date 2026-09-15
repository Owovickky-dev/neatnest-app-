import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/models/filter_search_model.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

class AdsRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> getAllAds() async {
    final response = await _dio.get(ApiEndPoints.ads);
    return response;
  }

  Future<Response> postAds(AdsModel adsData) async {
    final formData = await adsData.toFormData();
    final response = await _dio.post(ApiEndPoints.ads, data: formData);
    return response;
  }

  Future<Response> queryAds(FilterSearchModel queryData) async {
    final response = await _dio.get(
      ApiEndPoints.ads,
      queryParameters: queryData.toJson(),
    );
    return response;
  }

  Future<Response> getUserAds() async {
    final response = await _dio.get(ApiEndPoints.getUserAds);
    return response;
  }

  Future<Response> deleteAds(String adsId) async {
    final response = await _dio.delete("${ApiEndPoints.ads}/$adsId");
    return response;
  }

  Future<Response> updateAds(AdsModel updateData) async {
    final response = await _dio.patch(
      ApiEndPoints.getUserAds,
      data: updateData,
    );
    return response;
  }

  Future<Response> getPopularAds() async {
    final response = await _dio.get(ApiEndPoints.getPopularAds);
    return response;
  }

  Future<Response> activateAds(bool updateData, String adsId) async {
    final response = await _dio.patch(
      ApiEndPoints.getUserAds,
      data: {"isActive": updateData, "adsId": adsId},
    );
    return response;
  }
}
