import 'package:core/src/modular/router/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

extension TKRouterExtension on BuildContext {
  void navigateToGlobalRoute({
    required GlobalRoutes route,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) =>
      goNamed(
        route.name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );

  void navigateToInternalRoute({
    required InternalRoutes route,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
  }) =>
      goNamed(
        route.name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
      );
}
