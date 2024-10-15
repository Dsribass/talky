import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:talky_ui_kit/src/theme/colors/color_extensions.dart';

@internal
class ButtonContent extends StatelessWidget {
  const ButtonContent({
    required this.label,
    required this.isLoading,
    this.width,
    super.key,
  });

  final Widget label;
  final bool isLoading;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: !isLoading,
            maintainState: true,
            maintainSize: true,
            maintainAnimation: true,
            child: label,
          ),
          Visibility(
            visible: isLoading,
            child: ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: 24,
                height: 24,
              ),
              child: CircularProgressIndicator(
                backgroundColor: context.colors.onPrimary.withAlpha(25),
                color: context.colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
