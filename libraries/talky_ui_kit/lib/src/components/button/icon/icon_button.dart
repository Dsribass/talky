import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/theme/theme.dart';

class TalkyIconButton extends StatelessWidget {
  const TalkyIconButton({
    required this.icon,
    this.onPressed,
    this.size = 24,
    super.key,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      color: context.colors.onPrimary,
      iconSize: size,
      constraints: BoxConstraints.tightFor(
        width: size * 1.5,
        height: size * 1.5,
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return context.colors.disabled;
          }
          return context.colors.primary;
        }),
        foregroundColor: WidgetStateColor.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return context.colors.onDisabled;
          }
          return context.colors.onPrimary;
        }),
        padding: const WidgetStatePropertyAll(EdgeInsets.zero),
      ),
    );
  }
}
