import 'package:auth/l10n/gen/auth_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
      localizationsDelegates: const [
        ...AuthLocalizations.localizationsDelegates,
      ],
      supportedLocales: const [
        ...AuthLocalizations.supportedLocales,
      ],
        home: widget,
      ),
    );
  }
}
