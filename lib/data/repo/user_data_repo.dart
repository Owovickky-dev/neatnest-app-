import 'package:dio/dio.dart';
import 'package:neat_nest/screens/user/model/user_payment_method_model.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

import '../api/api_client.dart';

class UserDataRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> savePaymentMethod(
    UserPaymentMethodModel userPaymentMethod,
  ) async {
    final response = await _dio.post(
      ApiEndPoints.paymentMethod,
      data: userPaymentMethod.toJson(),
    );

    return response;
  }

  Future<Response> getUserPaymentMethod() async {
    final response = await _dio.get(ApiEndPoints.paymentMethod);
    return response;
  }

  Future<Response> deleteUserPaymentMethod(
    UserPaymentMethodModel userPaymentModel,
  ) async {
    final response = await _dio.delete(
      ApiEndPoints.paymentMethod,
      data: userPaymentModel.toJson(),
    );
    return response;
  }

  Future<Response> getSkillsAvailable() async {
    final response = await _dio.get(ApiEndPoints.serviceCategories);
    return response;
  }

  Future<Response> updatePaymentMethod(
    UserPaymentMethodModel updatePayment,
  ) async {
    final response = await _dio.patch(
      ApiEndPoints.paymentMethod,
      data: updatePayment.toJson(),
    );
    return response;
  }

  Future<Response> uploadProfilePics(String picPath) async {
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        picPath,
        filename: picPath.split("/").last,
      ),
    });
    final response = await _dio.patch(ApiEndPoints.profilePics, data: formData);
    return response;
  }

  Future<Response> getUserNotification() async {
    final response = await _dio.get(ApiEndPoints.getUserNotifications);

    return response;
  }
}
