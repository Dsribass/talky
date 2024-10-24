import 'package:core/src/modular/router/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension TKRouterExtension on BuildContext {
  void navigateToGlobalRoute({
    required GlobalRoutes route,
    Map<RouteParameter, String> pathParameters = const {},
    Map<RouteParameter, dynamic> queryParameters = const {},
  }) =>
      goNamed(
        route.name,
        pathParameters: pathParameters.map(
          (key, value) => MapEntry(key.name, value),
        ),
        queryParameters: queryParameters.map(
          (key, value) => MapEntry(key.name, value),
        ),
      );

  void navigateToInternalRoute({
    required InternalRoutes route,
    Map<RouteParameter, String> pathParameters = const {},
    Map<RouteParameter, dynamic> queryParameters = const {},
  }) =>
      goNamed(
        route.name,
        pathParameters: pathParameters.map(
          (key, value) => MapEntry(key.name, value),
        ),
        queryParameters: queryParameters.map(
          (key, value) => MapEntry(key.name, value),
        ),
      );
}
