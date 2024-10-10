import 'package:get_it/get_it.dart';

T inject<T>() => GetIt.I.get();

abstract interface class ContainerModule {
  void registerDependencies(GetIt injector);
}
