import 'package:dio/dio.dart';
import 'package:neat_nest/utilities/route/app_naviation_helper.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';
import 'package:neat_nest/utilities/route/app_router_key.dart';

import '../../utilities/api_error_handler.dart';
import '../../utilities/constant/constant_data.dart';
import '../../widget/app_notification.dart';
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
          return status != null && status < 400;
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await SecureStorageHelper.getToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },

        onResponse: (response, handler) {
          return handler.next(response);
        },

        onError: (DioException e, handler) async {
          final statusCode = e.response?.statusCode;
          final data = e.response?.data;
          final backendStatusCode = data?["error"]?["statusCode"];

          final isTokenExpired = statusCode == 401 || backendStatusCode == 401;

          //  HANDLE TOKEN EXPIRY
          if (isTokenExpired) {
            final newToken = await _refreshToken();

            if (newToken != null) {
              // retry request with new token
              e.requestOptions.headers["Authorization"] = "Bearer $newToken";

              try {
                final response = await dio.request(
                  e.requestOptions.path,
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters,
                  options: Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers,
                  ),
                );

                return handler.resolve(response);
              } catch (retryError) {
                return handler.next(e);
              }
            } else {
              await _logoutUser();
              return handler.next(e);
            }
          }

          //  OTHER ERRORS
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
      }

      return null;
    } catch (e) {
      print(" TOKEN REFRESH FAILED: $e");
      return null;
    }
  }

  Future<void> _logoutUser() async {
    await SecureStorageHelper.deleteToken();
    await SecureStorageHelper.deleteRefreshToken();
    await SecureStorageHelper.deleteUserData();

    showErrorNotification(message: "Session expired, Please login again");

    if (AppRouterKey.navigatorKey.currentContext != null) {
      AppNavigatorHelper.go(
        AppRouterKey.navigatorKey.currentContext!,
        AppRoute.signIn,
      );
    }
  }
}
