import 'package:core/src/modular/di/di.dart';
import 'package:core/src/modular/module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ModularApp extends StatefulWidget {
  ModularApp({
    required this.modules,
    required this.builder,
    required this.injectionContainer,
    super.key,
  }) : appConfiguration = ModularAppConfiguration(modules: modules);

  final Set<Module> modules;
  final Widget Function(BuildContext, ModularAppConfiguration) builder;
  final ModularAppConfiguration appConfiguration;
  final InjectionContainer injectionContainer;

  @override
  State<ModularApp> createState() => _ModularAppState();
}

class _ModularAppState extends State<ModularApp> {
  @override
  void initState() {
    widget.injectionContainer.setup(
      modules: widget.modules.map((module) => module.container).toSet(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      widget.builder(context, widget.appConfiguration);
}

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

  RouterConfig<Object> get routerConfig => GoRouter(
        routes: _modules
            .map((module) => module.router)
            .expand((module) => module.configuration)
            .toList(),
      );
}
