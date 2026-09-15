import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

class FavouriteRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> addFavourite(String adsId) async {
    final response = await _dio.post(
      ApiEndPoints.favourite,
      data: {"adsId": adsId},
    );
    return response;
  }

  Future<Response> getFavourite() async {
    final response = await _dio.get(ApiEndPoints.favourite);
    return response;
  }

  Future<Response> deleteFavourite(String id) async {
    final response = await _dio.delete("${ApiEndPoints.favourite}/$id");
    return response;
  }
}
