import 'package:flutter/material.dart';
import 'package:talky_ui_kit/src/theme/colors/talky_colors.dart';

const blue = Color(0xFF377DFF);
const blueSoft = Color(0xFFE5F1FF);
const green = Color(0xFF2DCA8C);
const greenSoft = Color(0xFFEAFAF3);
const red = Color(0xFFFF715B);
const redSoft = Color(0xFFFFE3DE);
const yellow = Color(0xFFFFBE3D);
const yellowSoft = Color(0xFFFFF2D8);
const black = Colors.black;
const black1 = Color(0xFF243443);
const black2 = Color(0xFF58616A);
const black3 = Color(0xFFAAB0B7);
const white = Colors.white;
const grey1 = Color(0xFFF0F0F0);
const grey2 = Color(0xFFF7F7F9);

class TalkyLightColors extends TalkyColors {
  @override
  Color get primary => blue;

  @override
  Color get onPrimary => white;

  @override
  Color get surface => white;

  @override
  Color get onSurface => black1;

  @override
  Color get error => red;

  @override
  Color get onError => white;

  @override
  Color get outline => black3;

  @override
  Color get onPrimaryContainer => white;

  @override
  Color get onSurfaceVariant => black2;

  @override
  Color get primaryContainer => blue;

  @override
  Color get surfaceContainer => grey2;

  @override
  Color get success => green;

  @override
  Color get onSuccess => greenSoft;

  @override
  Color get warning => yellow;

  @override
  Color get onWarning => yellowSoft;
}
