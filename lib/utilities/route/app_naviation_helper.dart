import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

class AppNavigatorHelper {
  // ✅ Go (replace the entire navigation stack)
  static void go(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Object? extra,
    Map<String, dynamic>?
    queryParameters, // Changed to dynamic to handle various types
  }) {
    _debugLog('GO', appRoute.name, extra);
    context.goNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  // ✅ Push (add new screen on top)
  static void push(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Object? extra,
    Map<String, dynamic>? queryParameters, // Changed to dynamic
  }) {
    _debugLog('PUSH', appRoute.name, extra);
    context.pushNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  // ✅ Replace
  static void replace(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Object? extra,
    Map<String, dynamic>? queryParameters, // Changed to dynamic
  }) {
    _debugLog('REPLACE', appRoute.name, extra);
    context.replaceNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  // ✅ Push Replacement
  static void pushReplacement(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Object? extra,
    Map<String, dynamic>? queryParameters, // Changed to dynamic
  }) {
    _debugLog('PUSH_REPLACEMENT', appRoute.name, extra);
    context.pushReplacementNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  // ✅ Go back with optional result
  static void back(BuildContext context, [Object? result]) {
    _debugLog('BACK', 'previous', result);
    context.pop(result);
  }

  // ✅ Go back to specific route
  static void backTo(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
  }) {
    _debugLog('BACK_TO', appRoute.name, null);
    context.goNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
    );
  }

  // ✅ Check if can pop
  static bool canPop(BuildContext context) {
    return context.canPop();
  }

  // ✅ Debug logging (can be disabled in production)
  static void _debugLog(String action, String routeName, Object? extra) {
    // Comment out or remove these prints for production
    print('🧭 NAVIGATION: $action -> $routeName');
    if (extra != null) {
      print('🧭 EXTRA: $extra (${extra.runtimeType})');
    }
  }
}
