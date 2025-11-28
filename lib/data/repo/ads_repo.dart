import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/models/ads_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class AdsRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> getAllAds() async {
    final response = await _dio.get(ConstantData.ADS);
    return response;
  }

  Future<Response> postAds(AdsModel adsData) async {
    final response = await _dio.post(ConstantData.ADS, data: adsData.toJson());
    return response;
  }

  Future<Response> queryAds(AdsModel queryData) async {
    final response = await _dio.get(
      ConstantData.ADS,
      queryParameters: queryData.toJson(),
    );
    return response;
  }
}
