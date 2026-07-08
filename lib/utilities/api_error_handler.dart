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

      case DioExceptionType.badResponse:
        return _handleBadResponse(e);

      case DioExceptionType.cancel:
        return "Request cancelled.";

      case DioExceptionType.badCertificate:
        return "Invalid server certificate.";

      case DioExceptionType.unknown:
        return "An unexpected error occurred.";
    }
  }

  static String _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final data = e.response?.data;

    // Handle ngrok errors
    if (data is String) {
      if (data.contains("ERR_NGROK_8012")) {
        return "Backend server is currently unavailable.";
      }

      return data;
    }

    // Handle backend JSON response
    if (data is Map<String, dynamic>) {
      if (data["message"] != null) {
        return data["message"].toString();
      }
    }

    switch (statusCode) {
      case 400:
        return "Bad request.";

      case 401:
        return "Unauthorized access.";

      case 403:
        return "Access denied.";

      case 404:
        return "Resource not found.";

      case 409:
        return "Conflict occurred.";

      case 422:
        return "Validation failed.";

      case 429:
        return "Too many requests. Please try again later.";

      case 500:
        return "Internal server error.";

      case 502:
        return "Backend server is currently unavailable.";

      case 503:
        return "Service temporarily unavailable.";

      case 504:
        return "Gateway timeout.";

      default:
        return "Server error.";
    }
  }
}
