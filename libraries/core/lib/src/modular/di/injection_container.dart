import 'package:core/src/modular/di/container_module.dart';
import 'package:get_it/get_it.dart';

/// An abstract base class that defines the structure for an injection container
/// responsible for registering dependencies in the application.
///
/// The `InjectionContainer` class provides methods to register main dependencies
/// and module-specific dependencies using the `GetIt` service locator.
///
/// Methods:
/// - `registerMainDependencies(GetIt injector)`: Registers the main dependencies
///   for the application. This method is called before registering module-specific
///   dependencies.
/// - `setup({required Set<ContainerModule> modules})`: Sets up the injection container
///   by registering the main dependencies and then registering the module-specific
///   dependencies.
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
