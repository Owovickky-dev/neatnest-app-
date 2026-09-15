import 'package:dio/dio.dart';
import 'package:neat_nest/controller/edit_profile_controller.dart';
import 'package:neat_nest/controller/sign_in_controller.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/models/user_model.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

class AuthRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> signIn(LoginModel data) async {
    final response = await _dio.post(ApiEndPoints.login, data: data.toJson());
    return response;
  }

  Future<Response> signOut() async {
    final response = await _dio.post(ApiEndPoints.logout);
    return response;
  }

  Future<Response> signUp(UserModel userModel) async {
    final response = await _dio.post(
      ApiEndPoints.register,
      data: userModel.toJson(),
    );
    return response;
  }

  Future<Response> forgotPassword(String email) async {
    final response = await _dio.post(
      ApiEndPoints.forgotPassword,
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
      ApiEndPoints.resetPassword,
      data: {
        "resetToken": resetToken,
        "password": password,
        "confirmPassword": confirmPassword,
        "email": email,
      },
    );

    return response;
  }

  Future<Response> updateDetails(EditProfileModel editedData) async {
    final response = await _dio.patch(
      ApiEndPoints.updateUserDetails,
      data: editedData.toJson(),
    );
    return response;
  }

  Future<Response> updateAboutMe(String aboutMe) async {
    final response = await _dio.patch(
      ApiEndPoints.aboutMe,
      data: {"aboutMe": aboutMe},
    );
    return response;
  }

  Future<Response> getAboutMe() async {
    final response = await _dio.get(ApiEndPoints.aboutMe);
    return response;
  }

  Future<Response> deleAboutMe() async {
    final response = await _dio.delete(ApiEndPoints.aboutMe);
    return response;
  }
}
