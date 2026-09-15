import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/screens/user/model/user_location_model.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

class AddressDataRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> getCountries() async {
    try {
      print("🌍 Fetching countries from: ${ApiEndPoints.getCountries}");
      final response = await _dio.get(ApiEndPoints.getCountries);
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
        ApiEndPoints.getState,
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
      ApiEndPoints.address,
      data: userAddress.toJson(),
    );
    return response;
  }

  Future<Response> getUserAddress() async {
    final response = _dio.get(ApiEndPoints.address);
    return response;
  }

  Future<Response> deleteUserAddress(String id) async {
    final response = _dio.delete("${ApiEndPoints.address}/$id");
    return response;
  }

  Future<Response> updateAddressData(UserLocationModel updateData) async {
    final response = await _dio.patch(
      ApiEndPoints.address,
      data: updateData.toJson(),
    );
    return response;
  }
}
