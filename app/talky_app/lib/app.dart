import 'package:flutter/material.dart';
import 'package:talky_app/counter/counter.dart';
import 'package:talky_app/l10n/l10n.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TalkyThemeData.lightTheme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const CounterPage(),
    );
  }
}
