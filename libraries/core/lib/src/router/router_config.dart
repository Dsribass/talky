import 'package:core/src/router/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

abstract class RouterModule {
  List<GoRoute> get configuration;
}

extension TKRouterConfig on GoRouter {
  static GoRouter createRouter(List<RouterModule> modules) {
    return GoRouter(
      routes: modules.expand((module) => module.configuration).toList(),
    );
  }
}

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
