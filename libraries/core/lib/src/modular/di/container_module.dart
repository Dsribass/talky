import 'package:get_it/get_it.dart';

T inject<T extends Object>() => GetIt.instance.get<T>();

abstract interface class ContainerModule {
  void registerDependencies(GetIt injector);
}
