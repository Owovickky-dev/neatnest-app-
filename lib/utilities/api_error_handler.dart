import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String getErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return "Connection timeout. Please try again.";

      case DioExceptionType.connectionError:
        return "No internet connection.";

      case DioExceptionType.cancel:
        return "Request cancelled.";

      default:
        return "Something went wrong. Please try again.";
    }
  }
}
