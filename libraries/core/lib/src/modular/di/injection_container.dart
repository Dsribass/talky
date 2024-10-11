import 'package:core/src/modular/di/container_module.dart';
import 'package:get_it/get_it.dart';

abstract base class InjectionContainer {
  /// Registers the main dependencies for the application.
  ///
  /// This method is called before registering module-specific dependencies.
  void registerMainDependencies(GetIt injector);

  void setup({required Set<ContainerModule> modules}) {
    final injector = GetIt.instance;

    registerMainDependencies(injector);
    _registerModuleDependencies(injector, modules: modules);
  }

  void _registerModuleDependencies(
    GetIt injector, {
    required Set<ContainerModule> modules,
  }) {
    for (final module in modules) {
      module.registerDependencies(injector);
    }
  }
}
