import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/theme/colors/light_colors.dart';

abstract class TalkyColors extends ThemeExtension<TalkyColors> {
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
  Color get success;
  Color get onSuccess;
  Color get warning;
  Color get onWarning;

  ColorScheme get colorScheme =>
      ColorScheme.fromSeed(seedColor: primary).copyWith(
        primary: primary,
        surface: surface,
        error: error,
        outline: outline,
        primaryContainer: primaryContainer,
        surfaceContainer: surfaceContainer,
        onPrimary: onPrimary,
        onSurface: onSurface,
        onError: onError,
        onSurfaceVariant: onSurfaceVariant,
        onPrimaryContainer: onPrimaryContainer,
        brightness: Brightness.light,
      );

  @override
  ThemeExtension<TalkyColors> copyWith() {
    return this;
  }

  @override
  ThemeExtension<TalkyColors> lerp(
    covariant ThemeExtension<TalkyColors>? other,
    double t,
  ) {
    return this;
  }
}
