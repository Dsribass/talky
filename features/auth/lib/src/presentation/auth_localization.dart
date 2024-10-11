import 'package:auth/l10n/gen/auth_localizations.dart';
import 'package:core/modular.dart';
import 'package:flutter/widgets.dart';

class AuthLocalization extends LocalizationModule {
  AuthLocalization()
      : super(
          localizationsDelegates: AuthLocalizations.localizationsDelegates,
          supportedLocales: AuthLocalizations.supportedLocales,
        );
}

extension AppLocalizationsX on BuildContext {
  AuthLocalizations get l10n => AuthLocalizations.of(this);
}
