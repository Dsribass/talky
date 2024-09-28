import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talky_ui_kit/src/components/button/talky_button.dart';
import 'package:talky_ui_kit/src/theme/colors/talky_colors.dart';

extension TalkyThemeData on ThemeData {
  static ThemeData get lightTheme {
    final colors = TalkyColors.light();
    return ThemeData(
      useMaterial3: true,
      colorScheme: colors.colorScheme,
      canvasColor: colors.surface,
      scaffoldBackgroundColor: colors.surface,
      textTheme: GoogleFonts.interTextTheme(),
      fontFamily: GoogleFonts.inter().fontFamily,
      filledButtonTheme: FilledButtonThemeData(
        style: TalkyButton.filled(colors),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TalkyButton.text(colors),
      ),
    );
  }
}
