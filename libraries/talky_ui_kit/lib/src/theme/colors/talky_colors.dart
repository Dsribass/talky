import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/theme/colors/light_colors.dart';

abstract class TalkyColors {
  const TalkyColors();

  factory TalkyColors.light() => TalkyLightColors();

  Color get primary;
  Color get onPrimary;
  Color get primaryContainer;
  Color get onPrimaryContainer;
  Color get surface;
  Color get onSurface;
  Color get surfaceContainer;
  Color get onSurfaceVariant;
  Color get error;
  Color get onError;
  Color get outline;

  ColorScheme get colorScheme =>
      ColorScheme.fromSeed(seedColor: primary).copyWith(
        primary: primary,
        secondary: primary,
        surface: surface,
        error: error,
        outline: outline,
        primaryContainer: primaryContainer,
        surfaceContainer: surfaceContainer,
        onPrimary: onPrimary,
        onSecondary: onPrimary,
        onSurface: onSurface,
        onError: onError,
        onSurfaceVariant: onSurfaceVariant,
        onPrimaryContainer: onPrimaryContainer,
        brightness: Brightness.light,
      );
}
