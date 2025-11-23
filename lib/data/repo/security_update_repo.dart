import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/screens/user/model/security_update_model.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class SecurityUpdateRepo {
  final Dio _dio = DioClient().createDio();

  Future<Response> updatePassword(SecurityUpdateModel newData) async {
    final response = _dio.patch(
      ConstantData.UPDATEPASSWORD,
      data: newData.toJson(),
    );
    return response;
  }

  Future<Response> updateEmail(SecurityUpdateModel newData) async {
    final response = _dio.patch(
      ConstantData.UPDATEEMAIL,
      data: newData.toJson(),
    );
    return response;
  }

  Future<Response> updatePhone(SecurityUpdateModel newData) async {
    final response = _dio.patch(
      ConstantData.UPDATEPPHONE,
      data: newData.toJson(),
    );
    return response;
  }
}
