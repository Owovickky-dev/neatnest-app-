import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class AddressDataRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> getCountries() async {
    try {
      print("🌍 Fetching countries from: ${ConstantData.GETCOUNTRIES}");
      final response = await _dio.get(ConstantData.GETCOUNTRIES);
      print("✅ Countries fetched successfully");
      return response;
    } catch (e) {
      print("❌ Error fetching countries: $e");
      rethrow;
    }
  }

  Future<Response> getState({required String country}) async {
    try {
      print("🏙️ Fetching states for country: $country");
      final response = await _dio.post(
        ConstantData.GETSTATE,
        data: {"country": country},
      );
      print("✅ States fetched successfully");
      return response;
    } catch (e) {
      print("❌ Error fetching states: $e");
      rethrow;
    }
  }

  Future<Response> saveAddress(UserLocationModel userAddress) async {
    final response = await _dio.post(
      ConstantData.ADDRESS,
      data: userAddress.toJson(),
    );
    return response;
  }

  Future<Response> getUserAddress() async {
    final response = _dio.get(ConstantData.ADDRESS);
    return response;
  }
}
