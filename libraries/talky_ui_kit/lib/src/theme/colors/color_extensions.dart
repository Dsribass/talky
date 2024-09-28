import 'package:flutter/material.dart';

extension ThemeColorsExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colors => Theme.of(this).colorScheme;
}
