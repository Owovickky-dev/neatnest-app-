import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class AuthRepo {
  final Dio _dio = dioClient.dio;

  Future<Response> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ConstantData.LOGIN,
      data: {"email": email, "password": password},
    );
    return response;
  }

  Future<void> signOut() async {
    await SecureStorageHelper.deleteToken();
    print("Logged out successfully");
  }
}
