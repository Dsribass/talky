import 'package:flutter/material.dart';

enum TKRadius {
  /// 6
  xs(6),
  /// 8
  sm(8),
  /// 16
  md(16),
  /// 24
  lg(24),
  /// 32
  xl(32);

  const TKRadius(this.value);

  final double value;

  BorderRadius get borderRadius => BorderRadius.circular(value);
}
