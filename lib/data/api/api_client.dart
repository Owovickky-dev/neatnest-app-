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

        onError: (DioException e, ErrorInterceptorHandler handler) async {
          final data = e.response?.data;

          String? message;
          int? backendStatusCode;
          String? backendMessage;

          // Safely parse response
          if (data is Map<String, dynamic>) {
            message = data["message"]?.toString();

            final error = data["error"];
            if (error is Map<String, dynamic>) {
              final code = error["statusCode"];

              if (code is int) {
                backendStatusCode = code;
              } else if (code is String) {
                backendStatusCode = int.tryParse(code);
              }
            }

            backendMessage = message?.trim().toLowerCase();
          } else if (data is String) {
            message = data;
            backendMessage = message.trim().toLowerCase();
          }

          // Only refresh token for genuine token-expiration/authentication errors.
          const tokenExpiredMessages = {
            "jwt expired",
            "your token has expired! please log in again.",
            "your token has expired! please log in again",
            "token expired",
            "invalid token",
            "jwt malformed",
            "invalid signature",
            "invalid token. please log in again!",
          };

          final isTokenExpired =
              backendMessage != null &&
              tokenExpiredMessages.contains(backendMessage);

          if (isTokenExpired) {
            final newToken = await _refreshToken();

            if (newToken != null) {
              e.requestOptions.headers["Authorization"] = "Bearer $newToken";

              try {
                final response = await dio.request(
                  e.requestOptions.path,
                  data: e.requestOptions.data,
                  queryParameters: e.requestOptions.queryParameters,
                  options: Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers,
                    responseType: e.requestOptions.responseType,
                    contentType: e.requestOptions.contentType,
                    sendTimeout: e.requestOptions.sendTimeout,
                    receiveTimeout: e.requestOptions.receiveTimeout,
                    extra: e.requestOptions.extra,
                  ),
                  cancelToken: e.requestOptions.cancelToken,
                  onSendProgress: e.requestOptions.onSendProgress,
                  onReceiveProgress: e.requestOptions.onReceiveProgress,
                );

                return handler.resolve(response);
              } on DioException {
                return handler.next(e);
              } catch (_) {
                return handler.next(e);
              }
            } else {
              await _logoutUser();
              return handler.next(e);
            }
          }

          // ===========================
          // DEBUG LOGS
          // ===========================
          print("========== API ERROR ==========");
          print("Type: ${e.type}");
          print("HTTP Status Code: ${e.response?.statusCode}");
          print("Backend Status Code: $backendStatusCode");
          print("Message: $message");
          print("Response Type: ${data.runtimeType}");
          print("Response Data: $data");
          print("Request Path: ${e.requestOptions.path}");
          print("===============================");

          // Convert Dio error into friendly message
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
    } on DioException catch (e) {
      print("====== REFRESH TOKEN ERROR ======");

      print("Status Code: ${e.response?.statusCode}");

      print("Response Body: ${e.response?.data}");

      print("Request Headers: ${e.requestOptions.headers}");

      print("=================================");

      return null;
    } catch (e, stackTrace) {
      print("UNEXPECTED REFRESH ERROR: $e");
      print(stackTrace);
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
