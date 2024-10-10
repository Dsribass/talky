import 'package:auth/auth.dart';
import 'package:auth/l10n/gen/auth_localizations.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: TalkyThemeData.lightTheme,
      localizationsDelegates: const [
        ...AuthLocalizations.localizationsDelegates,
      ],
      supportedLocales: const [
        ...AuthLocalizations.supportedLocales,
      ],
      routerConfig: TKRouterConfig.createRouter([
        AuthRouterModule(),
      ]),
    );
  }
}
