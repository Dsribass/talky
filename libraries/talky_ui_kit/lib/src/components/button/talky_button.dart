import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@internal
abstract class TalkyButton extends StatelessWidget {
  const TalkyButton({
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.iconAlignment = IconAlignment.start,
    this.icon,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
    super.key,
  });

  final Widget label;
  final bool isLoading;
  final IconAlignment iconAlignment;
  final VoidCallback? onPressed;
  final Icon? icon;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;
}
