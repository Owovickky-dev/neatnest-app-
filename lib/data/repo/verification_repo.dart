import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/models/verification_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class VerificationRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> uploadUserId(
    UserUploadVerificationModel verification,
  ) async {
    final response = await _dio.patch(
      ConstantData.USERVERIFICATION,
      data: verification.toFormData(),
    );
    return response;
  }

  Future<Response> getUserVerificationStatus() async {
    final response = await _dio.get(ConstantData.GETUSERVERIFICATION);
    return response;
  }

  Future<Response> getUserId() async {
    final response = await _dio.get(ConstantData.USERVERIFICATION);

    return response;
  }
}
