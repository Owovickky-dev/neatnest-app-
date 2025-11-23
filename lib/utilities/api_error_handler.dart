import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ApiErrorHandler {
  static String getErrorMessage(DioException e) {
    // 🚫 No internet
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.unknown) {
      return "No internet connection. Please check your network.";
    }

    // ⏳ Timeout
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return "Request timed out. Please try again.";
    }

    final status = e.response?.statusCode;
    final message = e.response?.data["message"];

    // 🔙 Specific server errors
    if (status != null) {
      if (status == 400) {
        return message ?? "Bad request.";
      }
      if (status == 401) {
        final errorMessage = e.response?.data;
        final extraData = errorMessage["error"]['extra']['nextAllowedDate'];
        if (errorMessage != null && extraData != null) {
          final date = DateTime.parse(extraData).toLocal();
          final nextUpdateDate = DateFormat("dd/MM/yy hh:mm a").format(date);
          return "${errorMessage["message"]} $nextUpdateDate";
        } else {
          return message ?? "Unauthorized. Please login again.";
        }
      }
      if (status == 403) {
        return message ?? "Forbidden: You do not have permission.";
      }
      if (status == 404) {
        return message ?? "Resource not found.";
      }
      if (status == 500) {
        return message ?? "Server error. Please try again later.";
      }
    }
    return "Something went wrong. Please try again.";
  }
}
