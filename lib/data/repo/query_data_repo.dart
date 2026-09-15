import 'package:dio/dio.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

import '../api/api_client.dart';

class QueryDataRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> getAllAds() async {
    return await _dio.get(ApiEndPoints.ads);
  }
}
