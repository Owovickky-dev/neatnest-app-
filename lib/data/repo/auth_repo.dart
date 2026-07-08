import 'package:dio/dio.dart';
import 'package:neat_nest/controller/sign_in_controller.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/models/update_personal_profile_model.dart';
import 'package:neat_nest/models/user_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class AuthRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> signIn(LoginModel data) async {
    final response = await _dio.post(ConstantData.LOGIN, data: data.toJson());
    return response;
  }

  Future<Response> signOut() async {
    final response = await _dio.post(ConstantData.LOGOUT);
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

  Future<Response> updateMyPersonal(
    UpdatePersonalProfileModel updatePInfo,
  ) async {
    final response = await _dio.patch(
      ConstantData.UPDATEPERSONALINFO,
      data: updatePInfo.toJson(),
    );
    return response;
  }

  Future<Response> forgotPassword(String email) async {
    final response = await _dio.post(
      ConstantData.FORGOTPASSWORD,
      data: {"email": email},
    );
    return response;
  }

  Future<Response> resetPassword({
    required String resetToken,
    required String password,
    required String confirmPassword,
    required String email,
  }) async {
    final response = await _dio.patch(
      ConstantData.RESETPASSWORD,
      data: {
        "resetToken": resetToken,
        "password": password,
        "confirmPassword": confirmPassword,
        "email": email,
      },
    );

    return response;
  }
}
