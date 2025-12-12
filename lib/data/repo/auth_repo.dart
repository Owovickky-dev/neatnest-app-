import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/models/user_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class AuthRepo {
  final Dio _dio = DioClient().createDio();

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

  Future<Response> signUp(UserModel userModel) async {
    final response = await _dio.post(
      ConstantData.REGISTER,
      data: userModel.toJson(),
    );
    return response;
  }

  Future<Response> updateAboutMe(String aboutMe) async {
    final response = await _dio.patch(
      ConstantData.ABOUTME,
      data: {"aboutMe": aboutMe},
    );
    return response;
  }

  Future<Response> getAboutMe() async {
    final response = await _dio.get(ConstantData.ABOUTME);
    return response;
  }

  Future<Response> deleAboutMe() async {
    final response = await _dio.delete(ConstantData.ABOUTME);
    return response;
  }
}
