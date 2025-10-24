import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class AuthRepo {
  final Dio _dio = dioClient.dio;

  Future<bool> signIn({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        ConstantData.LOGIN,
        data: {"email": email, "password": password},
      );
      final token = response.data['data']['token'];

      if (token != null) {
        await SecureStorageHelper.saveToken(token);
        print("Token Saved Succesfully, $token");
        return true;
      } else {
        throw Exception("Token not found in response");
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await SecureStorageHelper.deleteToken();
    print("Logged out successfully");
  }
}
