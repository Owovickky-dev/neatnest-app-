import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/models/verification_model.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

class VerificationRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> uploadUserId(
    UserUploadVerificationModel verification,
  ) async {
    final formData = await verification.toFormData();

    final response = await _dio.patch(
      ApiEndPoints.userVerification,
      data: formData,
    );
    return response;
  }

  Future<Response> getUserVerificationStatus() async {
    final response = await _dio.get(ApiEndPoints.getUserVerification);
    return response;
  }

  Future<Response> getUserId() async {
    final response = await _dio.get(ApiEndPoints.userVerification);
    return response;
  }
}
