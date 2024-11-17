enum GlobalRoutes {
  root('/'),
  profile('/profile'),
  chat('/chat');

  const GlobalRoutes(this.path);

  final String path;
}

abstract interface class InternalRoutes {
  String get path;
  String get name;
}

extension RoutePathBuilder on InternalRoutes {
  String pathWithParameters(List<RouteParameter> parameters) {
    if (parameters.isEmpty) {
      return path;
    }

    final pathParamNames = parameters.map((param) => '/:${param.name}').join();
    return '$path$pathParamNames';
  }
}

abstract interface class RouteParameter {
  String get name;
}
