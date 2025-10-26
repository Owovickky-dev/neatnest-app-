import 'package:dio/dio.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

import '../api/api_client.dart';

class QueryDataRepo {
  final Dio _dio = dioClient.dio;

  Future<Response> getAllAds() async {
    return await _dio.get(ConstantData.QUERY);
  }
}
