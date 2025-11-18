import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class AddressDataRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> getCountries() async {
    final response = await _dio.get(ConstantData.GETCOUNTRIES);
    return response;
  }

  Future<Response> getState({required String country}) async {
    final response = await _dio.post(
      ConstantData.GETSTATE,
      data: {"country": country},
    );

    return response;
  }
}
