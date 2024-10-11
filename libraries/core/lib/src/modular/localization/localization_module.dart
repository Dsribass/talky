import 'package:flutter/widgets.dart';

abstract class LocalizationModule {
  const LocalizationModule({
    required this.localizationsDelegates,
    required this.supportedLocales,
  });

  final List<LocalizationsDelegate<dynamic>> localizationsDelegates;
  final List<Locale> supportedLocales;
}
