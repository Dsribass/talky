import 'package:core/src/modular/di/di.dart';
import 'package:core/src/modular/module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A `StatefulWidget` that initializes and configures a modular application.
///
/// The `ModularApp` class is responsible for setting up the application's
/// dependency injection container and providing the necessary configuration
/// for the app's modules. Also, it creates an instance of `AppBloc` and
/// provides it to the widget tree.
///
/// The `ModularApp` requires the following parameters:
/// - `modules`: A set of `Module` instances that define the app's features.
/// - `container`: An `InjectionContainer` used for dependency injection.
/// - `builder`: A function that builds the widget tree, given a `BuildContext`
///   and a `ModularAppConfiguration`.
///
/// The `ModularApp` also creates an instance of `ModularAppConfiguration`
/// using the provided modules.
///
/// Example usage:
/// ```dart
/// ModularApp(
///   modules: myModules,
///   container: myContainer,
///   builder: (context, config) => MyApp(config),
/// );
/// ```
///
/// See also:
/// - `Module` for defining app features.
/// - `InjectionContainer` for dependency injection setup.
/// - `ModularAppConfiguration` for app configuration details.
class ModularApp extends StatefulWidget {
  ModularApp({
    required this.modules,
    required this.container,
    required this.builder,
    super.key,
  }) : appConfiguration = ModularAppConfiguration(modules: modules);

  final Set<Module> modules;
  final Widget Function(BuildContext, ModularAppConfiguration) builder;
  final ModularAppConfiguration appConfiguration;
  final InjectionContainer container;

  @override
  State<ModularApp> createState() => _ModularAppState();
}

class _ModularAppState extends State<ModularApp> {
  @override
  void initState() {
    widget.container.setup(
      modules: widget.modules.map((module) => module.container).toSet(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.appConfiguration,
      );
}

/// Configuration class for a modular app.
///
/// This class holds the configuration for a modular app, including the
/// modules, localization delegates, supported locales, and router
/// configuration.
///
/// The [ModularAppConfiguration] class is immutable and requires a set of
/// [Module] instances to be provided during instantiation.
///
/// Properties:
/// - `localizationsDelegates`: A list of localization delegates aggregated
///   from all the provided modules.
/// - `supportedLocales`: A list of supported locales aggregated from all the
///   provided modules.
/// - `routes`: A list of routes aggregated from all the provided modules.
class ModularAppConfiguration {
  const ModularAppConfiguration({
    required Set<Module> modules,
  }) : _modules = modules;

  final Set<Module> _modules;

  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => _modules
      .expand((module) => module.localization.localizationsDelegates)
      .toList();

  List<Locale> get supportedLocales => _modules
      .expand((module) => module.localization.supportedLocales)
      .toList();

  List<RouteBase> get routes => _modules
      .map((module) => module.router)
      .expand((module) => module.configuration)
      .toList();
}
