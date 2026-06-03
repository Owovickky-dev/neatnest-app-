import 'package:dio/dio.dart';
import 'package:neat_nest/data/api/api_client.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class OtpVerificationRepo {
  final _dio = DioClient().createDio();

  Future<Response> otpMailVerification({
    required String email,
    required String otpCode,
  }) {
    final response = _dio.patch(
      ConstantData.OTPMAILVERIFICATION,
      data: {"email": email, "otp": otpCode},
    );
    return response;
  }

  Future<Response> verifyPasswordOtp({
    required String email,
    required String otpCode,
  }) async {
    final response = await _dio.post(
      ConstantData.PASSWORDCODEVERIFICATION,
      data: {"email": email, "otp": otpCode},
    );

    return response;
  }

  Future<Response> resendOTP({required String email, required String purpose}) {
    final response = _dio.post(
      ConstantData.RESENDMAILOTP,
      data: {"email": email, "purpose": purpose},
    );
    return response;
  }
}
