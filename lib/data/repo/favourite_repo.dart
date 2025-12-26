import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class FavouriteRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> addFavourite(String adsId) async {
    final response = await _dio.post(
      ConstantData.FAVOURITE,
      data: {"adsId": adsId},
    );
    return response;
  }

  Future<Response> getFavourite() async {
    final response = await _dio.get(ConstantData.FAVOURITE);
    return response;
  }

  Future<Response> deleteFavourite(String id) async {
    final response = await _dio.delete("${ConstantData.FAVOURITE}/$id");
    return response;
  }
}
