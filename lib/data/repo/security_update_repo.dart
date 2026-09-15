import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/screens/user/model/security_update_model.dart';
import 'package:neat_nest/utilities/constant/api_end_points.dart';

class SecurityUpdateRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> updatePassword(SecurityUpdateModel newData) async {
    final response = _dio.patch(
      ApiEndPoints.updatePassword,
      data: newData.toJson(),
    );
    return response;
  }

  Future<Response> updateEmail(SecurityUpdateModel newData) async {
    final response = _dio.patch(
      ApiEndPoints.updateEmail,
      data: newData.toJson(),
    );
    return response;
  }

  Future<Response> updatePhone(SecurityUpdateModel newData) async {
    final response = _dio.patch(
      ApiEndPoints.updatePhone,
      data: newData.toJson(),
    );
    return response;
  }
}
