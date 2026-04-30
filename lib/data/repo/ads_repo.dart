import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/models/filter_search_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class AdsRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> getAllAds() async {
    final response = await _dio.get(ConstantData.ADS);
    return response;
  }

  Future<Response> postAds(AdsModel adsData) async {
    final formData = await adsData.toFormData();
    final response = await _dio.post(ConstantData.ADS, data: formData);
    return response;
  }

  Future<Response> queryAds(FilterSearchModel queryData) async {
    final response = await _dio.get(
      ConstantData.ADS,
      queryParameters: queryData.toJson(),
    );
    return response;
  }

  Future<Response> getUserAds() async {
    final response = await _dio.get(ConstantData.GETUSERADS);
    return response;
  }

  Future<Response> deleteAds(String adsId) async {
    final response = await _dio.delete("${ConstantData.ADS}/$adsId");
    return response;
  }

  Future<Response> updateAds(AdsModel updateData) async {
    final response = await _dio.patch(
      ConstantData.GETUSERADS,
      data: updateData,
    );
    return response;
  }

  Future<Response> getPopularAds() async {
    final response = await _dio.get(ConstantData.GETPOPULARADS);
    return response;
  }

  Future<Response> activateAds(bool updateData, String adsId) async {
    final response = await _dio.patch(
      ConstantData.GETUSERADS,
      data: {"isActive": updateData, "adsId": adsId},
    );
    return response;
  }
}
