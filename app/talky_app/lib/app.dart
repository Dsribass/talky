import 'package:core/modular.dart';
import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class App extends StatelessWidget {
  const App({
    required this.configuration,
    super.key,
  });

  final ModularAppConfiguration configuration;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: TalkyThemeData.lightTheme,
      routerConfig: configuration.routerConfig,
      localizationsDelegates: configuration.localizationsDelegates,
      supportedLocales: configuration.supportedLocales,
    );
  }
}
