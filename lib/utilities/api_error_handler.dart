import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class ApiErrorHandler {
  static String getErrorMessage(DioException e) {
    // 🚫 Network-related errors
    if (e.type == DioExceptionType.connectionError ||
        e.type == DioExceptionType.unknown) {
      return "No internet connection. Please check your network.";
    }

    // ⏳ Timeout errors
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return "Request timed out. Please try again.";
    }

    final status = e.response?.statusCode;
    final responseData = e.response?.data;

    if (responseData["error"]["statusCode"] == 400 &&
        responseData["message"] != null) {
      return responseData["message"] ?? "An error has occurred";
    }
    // 🔙 Safe extraction of message
    String getMessage() {
      if (responseData is Map && responseData.containsKey('message')) {
        return responseData['message']?.toString() ?? "Something went wrong";
      }
      return "Something went wrong";
    }

    // Status-based handling
    if (status != null) {
      switch (status) {
        case 400:
          return getMessage();
        case 401:
          final message = getMessage();
          try {
            final extraData =
                responseData?['error']?['extra']?['nextAllowedDate']
                    ?.toString();
            if (extraData != null && extraData.isNotEmpty) {
              final date = DateTime.parse(extraData).toLocal();
              final nextUpdateDate = DateFormat(
                "dd/MM/yy hh:mm a",
              ).format(date);
              return "$message $nextUpdateDate";
            }
          } catch (e) {
            print('⚠️ Extra data parsing failed: $e');
          }
          return message;

        case 403:
          return getMessage();

        case 404:
          return getMessage();

        case 500:
          // ✅ SAFE: Only check for duplicate email if the structure exists
          try {
            final duplicateEmail = responseData?['error']?['keyValue']?['email']
                ?.toString();
            if (duplicateEmail != null) {
              return "Email $duplicateEmail already used by another user";
            }
          } catch (e) {
            print('⚠️ Duplicate email parsing failed: $e');
          }
          return getMessage();

        default:
          return getMessage();
      }
    }

    return "Something went wrong. Please try again.";
  }
}
