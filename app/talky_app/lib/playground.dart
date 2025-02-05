import 'package:chat/chat.dart';
import 'package:core/env.dart';
import 'package:core/modular.dart';
import 'package:flutter/material.dart';
import 'package:talky_app/app/app_container.dart';
import 'package:talky_app/bootstrap.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

void main() async {
  await Environment.init(FlavorEnv.dev);

  return bootstrap(
    (modules) => ModularApp(
      modules: modules,
      builder: (context, configuration) => _Playground(
        modularConfig: configuration,
      ),
      container: AppContainer(),
    ),
  );
}

class _Playground extends StatelessWidget {
  const _Playground({
    required this.modularConfig,
  });

  final ModularAppConfiguration modularConfig;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TalkyThemeData.lightTheme,
      localizationsDelegates: modularConfig.localizationsDelegates,
      supportedLocales: modularConfig.supportedLocales,
      home: const ChatListPage(),
    );
  }
}

class _Widget extends StatelessWidget {
  const _Widget();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
