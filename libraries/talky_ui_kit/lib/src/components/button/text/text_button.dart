import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/components/button/button_content.dart';
import 'package:talky_ui_kit/src/components/button/talky_button.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class TalkyTextButton extends TalkyButton {
  const TalkyTextButton({
    required super.label,
    required super.onPressed,
    super.isLoading,
    super.iconAlignment,
    super.icon,
    super.width,
    super.foregroundColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: TalkyTextButtonStyle.text(
        context.colors,
        foregroundColor: foregroundColor,
      ),
      icon: icon,
      iconAlignment: iconAlignment,
      onPressed: isLoading ? null : onPressed,
      label: ButtonContent(
        width: width,
        label: label,
        isLoading: isLoading,
      ),
    );
  }
}

extension TalkyTextButtonStyle on ButtonStyle {
  static ButtonStyle text(
    TalkyColors colors, {
    Color? foregroundColor,
  }) {
    return ButtonStyle(
      overlayColor: WidgetStateProperty.resolveWith((states) {
        final color = foregroundColor ?? colors.primary;
        if (states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.focused) ||
            states.contains(WidgetState.pressed)) {
          return color.withOpacity(0.12);
        }
        return null;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return colors.onSurface.withOpacity(0.38);
        }
        return foregroundColor ?? colors.primary;
      }),
      textStyle: WidgetStateProperty.all<TextStyle>(
        TalkyTextStyles.paragraph.bold,
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}
