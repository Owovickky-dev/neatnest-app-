import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neat_nest/utilities/route/app_route_names.dart';

class AppNavigatorHelper {
  //  Go (replace the entire navigation stack)
  static void go(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Object? extra,
    Map<String, dynamic>? queryParameters,
  }) {
    context.goNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  static void push(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Object? extra,
    Map<String, dynamic>? queryParameters,
  }) {
    context.pushNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  //  Replace
  static void replace(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Object? extra,
    Map<String, dynamic>? queryParameters,
  }) {
    context.replaceNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  //  Push Replacement
  static void pushReplacement(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Object? extra,
    Map<String, dynamic>? queryParameters,
  }) {
    context.pushReplacementNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
      extra: extra,
    );
  }

  //  Go back with optional result
  static void back(BuildContext context, [Object? result]) {
    context.pop(result);
  }

  //  Go back to specific route
  static void backTo(
    BuildContext context,
    AppRoute appRoute, {
    Map<String, String>? pathParameters,
    Map<String, dynamic>? queryParameters,
  }) {
    context.goNamed(
      appRoute.name,
      pathParameters: pathParameters ?? const {},
      queryParameters: queryParameters ?? const {},
    );
  }

  //  Check if can pop
  static bool canPop(BuildContext context) {
    return context.canPop();
  }
}
