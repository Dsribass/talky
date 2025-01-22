import 'package:chat/l10n/gen/module_localizations.dart';
import 'package:core/modular.dart';
import 'package:flutter/widgets.dart';

class ChatLocalization extends LocalizationModule {
  ChatLocalization()
      : super(
          localizationsDelegates: ModuleLocalizations.localizationsDelegates,
          supportedLocales: ModuleLocalizations.supportedLocales,
        );
}

extension ModuleLocalizationExtension on BuildContext {
  ModuleLocalizations get l10n => ModuleLocalizations.of(this);
}
