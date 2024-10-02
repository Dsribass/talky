enum GlobalRoutes {
  root('/');

  const GlobalRoutes(this.path);

  final String path;
}

abstract interface class InternalRoutes {
  String get path;
  String get name; 
}
