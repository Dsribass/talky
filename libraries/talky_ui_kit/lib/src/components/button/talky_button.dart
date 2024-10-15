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
    super.key,
  });

  final Widget label;
  final bool isLoading;
  final IconAlignment iconAlignment;
  final VoidCallback? onPressed;
  final Icon? icon;
  final double? width;
}
