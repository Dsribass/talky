enum GlobalRoutes {
  root('/'),
  auth('/auth'),
  profile('/profile'),
  chat('/chat');

  const GlobalRoutes(this.path);

  final String path;
}

abstract interface class InternalRoutes implements Enum {
  String get path;
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

abstract interface class RouteParameter implements Enum {}
