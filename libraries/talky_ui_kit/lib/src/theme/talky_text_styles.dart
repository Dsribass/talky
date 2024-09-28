import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
final class TalkyTextStyles {
  const TalkyTextStyles._();

  static TextStyle custom({
    double fontSize = 14,
    Color? color,
    FontWeight fontWeight = FontWeight.w400,
    TextDecoration? decoration,
    double? letterSpacing,
  }) =>
      GoogleFonts.inter(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        decoration: decoration,
        letterSpacing: letterSpacing,
      );

  /// Headline 1
  ///
  /// size: 24
  /// weight: 700
  static TextStyle get headline1 => custom(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      );

  /// Headline 2
  ///
  /// size: 20
  /// weight: 700
  static TextStyle get headline2 => custom(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      );

  /// Headline 3
  ///
  /// size: 16
  /// weight: 700
  static TextStyle get headline3 => custom(
        fontSize: 16,
        fontWeight: FontWeight.w700,
      );

  /// Button
  ///
  /// size: 16
  /// weight: 500
  static TextStyle get button => custom(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  /// Paragraph
  ///
  /// size: 14
  /// weight: 400
  static TextStyle get paragraph => custom();

  /// Caption
  ///
  /// size: 12
  /// weight: 500
  static TextStyle get caption => custom(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );
}

extension TextWeight on TextStyle {
  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);
  TextStyle get semibold => copyWith(fontWeight: FontWeight.w600);
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);
  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
  TextStyle get thin => copyWith(fontWeight: FontWeight.w100);
}
