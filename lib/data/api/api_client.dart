import 'package:dio/dio.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/utilities/route/app_router_key.dart';
import 'package:neat_nest/widget/notificaiton_content.dart';

import '../../utilities/api_error_handler.dart';
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
          return status! < 500; // Allow 401, 403, 404 but not 500
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
            print("❌ Request without token");
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          // Check for token expiration
          if (e.response?.statusCode == 500) {
            final responseData = e.response?.data;
            final message = responseData?["message"];
            final error = responseData?["error"];

            if (message == "jwt expired" &&
                error is Map &&
                error["name"] == "TokenExpiredError") {
              final newToken = await _refreshToken();
              if (newToken != null) {
                print("✅ AUTO-REFRESH SUCCESSFUL");
                // Update the request with new token
                e.requestOptions.headers["Authorization"] = "Bearer $newToken";
                // Retry the original request
                try {
                  final response = await dio.request(
                    e.requestOptions.path,
                    data: e.requestOptions.data,
                    options: Options(
                      method: e.requestOptions.method,
                      headers: e.requestOptions.headers,
                    ),
                    queryParameters: e.requestOptions.queryParameters,
                  );
                  return handler.resolve(response);
                } catch (retryError) {
                  print("❌ Retry failed: $retryError");
                  return handler.next(e);
                }
              } else {
                print("❌ AUTO-REFRESH FAILED - Logging out");
                await _logoutUser();
                return handler.next(e);
              }
            }
          }

          // For all other errors
          final errorMessage = ApiErrorHandler.getErrorMessage(e);
          return handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              response: e.response,
              type: e.type,
              error: errorMessage,
            ),
          );
        },
      ),
    );
    return dio;
  }

  Future<String?> _refreshToken() async {
    try {
      final refreshToken = await SecureStorageHelper.getRefreshToken();
      final dio = Dio(
        BaseOptions(
          baseUrl: ConstantData.BASE_URL,
          headers: {"Content-Type": "application/json"},
        ),
      );

      final response = await dio.post(
        ConstantData.REFRESHTOKEN,
        options: Options(headers: {"Authorization": "Bearer $refreshToken"}),
      );

      if (response.statusCode == 200) {
        final newToken = response.data["token"];
        final newRefreshToken = response.data["refreshToken"];

        if (newToken != null) {
          await SecureStorageHelper.saveToken(newToken);
        }
        if (newRefreshToken != null) {
          await SecureStorageHelper.saveRefreshToken(newRefreshToken);
        }

        return newToken;
      } else {
        return null;
      }
    } catch (e) {
      print('❌ TOKEN REFRESH FAILED: $e');
      return null;
    } finally {
      print("=== REFRESH TOKEN PROCESS END ===");
    }
  }

  Future<void> _logoutUser() async {
    await SecureStorageHelper.deleteToken();
    await SecureStorageHelper.deleteRefreshToken();
    await SecureStorageHelper.deleteUserData();

    notificationTest(message: "Session expired, Please login again");

    if (AppRouterKey.navigatorKey.currentContext != null) {
      AppNavigatorHelper.go(
        AppRouterKey.navigatorKey.currentContext!,
        AppRoute.signIn,
      );
    }
  }
}
