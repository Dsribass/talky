import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

extension TalkyInputDecorationTheme on InputDecorationTheme {
  static InputDecorationTheme getTheme(TalkyColors colors) => InputDecorationTheme(
        hintStyle: TalkyTextStyles.paragraph.medium,
        labelStyle: TalkyTextStyles.paragraph.medium,
        errorStyle: TalkyTextStyles.caption.semibold.copyWith(
          color: colors.error,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.onSurface.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.outline),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.error),
        ),
      );
}
