// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:neat_nest/data/storage/secure_storage_helper.dart';
// import 'package:neat_nest/utilities/constant/constant_data.dart';
//
// class DioClient {
//   final Dio _dio = Dio(
//     BaseOptions(
//       baseUrl: ConstantData.BASE_URL,
//       connectTimeout: Duration(seconds: 15),
//       receiveTimeout: Duration(seconds: 15),
//       headers: {"Content-Type": "application/json"},
//     ),
//   );
//
//   DioClient() {
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           final token = await SecureStorageHelper.getToken();
//           print("🔑 Retrieved Token: $token");
//           if (token != null) {
//             options.headers["Authorization"] = "Bearer $token";
//           }
//           if (kDebugMode) {
//             print("🚀 Headers → ${options.headers}");
//             print("🚀 Request → ${options.method} ${options.path}");
//           }
//           return handler.next(options);
//         },
//         onResponse: (response, handler) {
//           if (kDebugMode) {
//             print("✅ Response → ${response.statusCode}");
//             print("📥 Data: ${response.data}");
//           }
//           return handler.next(response);
//         },
//         onError: (DioException e, handler) {
//           if (kDebugMode) {
//             print("❌ Error → ${e.message}");
//           }
//           return handler.next(e);
//         },
//       ),
//     );
//   }
//   Dio get dio => _dio;
// }
//
// final dioClient = DioClient();

import 'package:dio/dio.dart';

import '../../utilities/constant/constant_data.dart';
import '../storage/secure_storage_helper.dart';

class DioClient {
  Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ConstantData.BASE_URL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        validateStatus: (status) {
          return status! < 500; // Consider status codes < 500 as valid
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageHelper.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          } else {
            print("ℹ️ No token found");
          }

          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          print("❌ DIO ERROR TYPE: ${e.type}");
          print("❌ DIO ERROR MESSAGE: ${e.message}");
          print("❌ RESPONSE STATUS: ${e.response?.statusCode}");
          print("❌ RESPONSE DATA: ${e.response?.data}");
          print("❌ REQUEST URL: ${e.requestOptions.path}");
          print(
            "❌ FULL URL: ${e.requestOptions.baseUrl}${e.requestOptions.path}",
          );

          return handler.next(e);
        },
      ),
    );

    return dio;
  }
}
