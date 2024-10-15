import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/components/button/button_content.dart';
import 'package:talky_ui_kit/src/components/button/talky_button.dart';
import 'package:talky_ui_kit/src/theme/colors/color_extensions.dart';
import 'package:talky_ui_kit/src/theme/talky_text_styles.dart';

class TalkyTextButton extends TalkyButton {
  const TalkyTextButton({
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
    return TextButton.icon(
      style: TalkyTextButtonStyle.text(context.colors),
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

extension TalkyTextButtonStyle on ButtonStyle {
  static ButtonStyle text(ColorScheme colors) {
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
