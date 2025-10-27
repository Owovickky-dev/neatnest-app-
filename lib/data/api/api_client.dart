import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:neat_nest/data/storage/secure_storage_helper.dart';
import 'package:neat_nest/utilities/constant/constant_data.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ConstantData.BASE_URL,
      connectTimeout: Duration(seconds: 15),
      receiveTimeout: Duration(seconds: 15),
      headers: {"Content-Type": "application/json"},
    ),
  );

  DioClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageHelper.getToken();
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          if (kDebugMode) {
            print("🚀 Request → ${options.method} ${options.path}");
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print("❌ Error → ${e.message}");
          }
          return handler.next(e);
        },
      ),
    );
  }
  Dio get dio => _dio;
}

final dioClient = DioClient();
