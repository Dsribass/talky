import 'package:core/src/modular/di/container_module.dart';
import 'package:core/src/modular/localization/localization_module.dart';
import 'package:core/src/modular/router/router_module.dart';

/// An abstract base class representing a module in the application.
/// 
/// This class is intended to be extended by a feature module
/// 
/// The `Module` class requires three parameters:
/// 
/// - `router`: An instance of `RouterModule` responsible for handling
///   the routing logic.
/// - `container`: An instance of `ContainerModule` responsible for
///   dependency injection and service management.
/// - `localization`: An instance of `LocalizationModule` responsible
///   for managing localization and internationalization.
/// 
/// All parameters are required and must be provided during the
/// instantiation of a subclass.
/// 
/// Example usage:
/// ```dart
/// class MyModule extends Module {
///   MyModule() : super(
///     router: MyRouterModule(),
///     container: MyContainerModule(),
///     localization: MyLocalizationModule(),
///   );
/// }
/// ```
abstract base class Module {
  const Module({
    required this.router,
    required this.container,
    required this.localization,
  });

  final RouterModule router;
  final ContainerModule container;
  final LocalizationModule localization;
}
