import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/theme/theme.dart';
import 'package:talky_ui_kit/src/tokens/tokens.dart';

extension TalkyButton on ButtonStyle {
  static ButtonStyle filled(TalkyColors colors) {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.onSurface.withOpacity(0.12);
        }
        return colors.primary;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.onSurface.withOpacity(0.38);
        }
        return colors.onPrimary;
      }),
      textStyle: WidgetStateProperty.all<TextStyle>(TalkyTextStyles.button),
      fixedSize: WidgetStateProperty.all(const Size.fromHeight(54)),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: TKRadius.sm.borderRadius),
      ),
    );
  }

  static ButtonStyle text(TalkyColors colors) {
    return ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.onSurface.withOpacity(0.38);
        }
        return colors.primary;
      }),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TalkyTextStyles.paragraph.bold,
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
