import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

class AppNavigatorHelper {
  // ✅ Go (replace the entire navigation stack)
  static void go(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    Map<String, String>? queryParameters,
  }) {
    context.goNamed(
      appRoute.name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  // ✅ Push (add new screen on top)
  static void push(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    Map<String, String>? queryParameters,
  }) {
    context.pushNamed(
      appRoute.name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  // ✅ Replace (replace current screen)
  static void replace(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    Map<String, String>? queryParameters,
  }) {
    context.replaceNamed(
      appRoute.name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  // ✅ Push Replacement (replace current screen with new one)
  static void pushReplacement(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? extra,
    Map<String, String>? queryParameters,
  }) {
    context.pushReplacementNamed(
      appRoute.name,
      pathParameters: pathParameters ?? {},
      queryParameters: queryParameters ?? {},
      extra: extra,
    );
  }

  // ✅ Go back
  static void back(BuildContext context) {
    context.pop();
  }
}
