import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

extension ThemeColorsExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ThemeExtension<TalkyColors> get _colorThemeExtension =>
      Theme.of(this).extension<TalkyColors>()!;

  TalkyColors get colors => _colorThemeExtension as TalkyColors;
}
