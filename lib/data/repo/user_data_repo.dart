import 'package:dio/dio.dart';
import 'package:neat_nest/screens/user/model/user_payment_method_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

import '../api/api_client.dart';

class UserDataRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> savePaymentMethod(
    UserPaymentMethodModel userPaymentMethod,
  ) async {
    final response = await _dio.post(
      ConstantData.PAYMENTMETHOd,
      data: userPaymentMethod.toJson(),
    );

    return response;
  }

  Future<Response> getUserPaymentMethod() async {
    final response = await _dio.get(ConstantData.PAYMENTMETHOd);
    return response;
  }

  Future<Response> deleteUserPaymentMethod(
    UserPaymentMethodModel userPaymentModel,
  ) async {
    final response = await _dio.delete(
      ConstantData.PAYMENTMETHOd,
      data: userPaymentModel.toJson(),
    );
    return response;
  }

  Future<Response> updatePaymentMethod(
    UserPaymentMethodModel updatePayment,
  ) async {
    final response = await _dio.patch(
      ConstantData.PAYMENTMETHOd,
      data: updatePayment.toJson(),
    );

    return response;
  }
}
