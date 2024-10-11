import 'package:auth/l10n/gen/module_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          ...ModuleLocalizations.localizationsDelegates,
        ],
        supportedLocales: const [
          ...ModuleLocalizations.supportedLocales,
        ],
        home: widget,
      ),
    );
  }
}
