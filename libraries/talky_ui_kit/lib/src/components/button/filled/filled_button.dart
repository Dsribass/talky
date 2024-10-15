import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/components/button/button_content.dart';
import 'package:talky_ui_kit/src/components/button/talky_button.dart';
import 'package:talky_ui_kit/src/theme/theme.dart';
import 'package:talky_ui_kit/src/tokens/tokens.dart';

class TalkyFilledButton extends TalkyButton {
  const TalkyFilledButton({
    required super.label,
    required super.onPressed,
    super.isLoading,
    super.iconAlignment,
    super.icon,
    super.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      style: TalkyFilledButtonStyle.filled(context.colors),
      icon: icon,
      iconAlignment: iconAlignment,
      onPressed: onPressed,
      label: ButtonContent(
        width: width,
        label: label,
        isLoading: isLoading,
      ),
    );
  }
}

extension TalkyFilledButtonStyle on ButtonStyle {
  static ButtonStyle filled(ColorScheme colors) {
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
}
