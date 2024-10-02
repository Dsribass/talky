import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talky_ui_kit/src/components/button/talky_button.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

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
      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (context) => TalkyAssets.icons.arrowBack(
          config: const SvgConfiguration(height: 14),
        ),
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colors.surface,
        titleTextStyle: TalkyTextStyles.headline3.apply(
          color: colors.onSurface,
        ),
        foregroundColor: colors.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TalkyTextStyles.paragraph.medium,
        labelStyle: TalkyTextStyles.paragraph.medium,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.onSurface.withOpacity(0.12)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.outline),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: TKRadius.sm.borderRadius,
          borderSide: BorderSide(color: colors.error),
        ),
      ),
    );
  }
}
