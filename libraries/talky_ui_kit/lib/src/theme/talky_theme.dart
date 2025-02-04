import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:talky_ui_kit/src/components/button/button.dart';
import 'package:talky_ui_kit/src/components/input/input.dart';
import 'package:talky_ui_kit/src/theme/theme.dart';
import 'package:talky_ui_kit/src/tokens/tokens.dart';

extension TalkyThemeData on ThemeData {
  static ThemeData get lightTheme {
    final colors = TalkyColors.light();
    return ThemeData(
      extensions: [colors],
      useMaterial3: true,
      colorScheme: colors.colorScheme,
      canvasColor: colors.surface,
      scaffoldBackgroundColor: colors.surface,
      textTheme: GoogleFonts.interTextTheme(),
      fontFamily: GoogleFonts.inter().fontFamily,
      filledButtonTheme: FilledButtonThemeData(
        style: TalkyFilledButtonStyle.filled(colors),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TalkyTextButtonStyle.text(colors),
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
      inputDecorationTheme: TalkyInputDecorationTheme.getTheme(colors),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        titleTextStyle: TalkyTextStyles.headline2.semibold.apply(
          color: colors.onSurface,
        ),
        contentTextStyle: TalkyTextStyles.paragraph.apply(
          color: colors.onSurfaceVariant,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: TKRadius.sm.borderRadius,
        ),
        actionsPadding: const EdgeInsets.symmetric(
          horizontal: TKSpacing.x4,
          vertical: TKSpacing.x6,
        ),
      ),
      listTileTheme: ListTileThemeData(
        titleTextStyle: TalkyTextStyles.headline3.semibold.apply(
          color: colors.onSurface,
        ),
        subtitleTextStyle: TalkyTextStyles.paragraph.apply(
          color: colors.onSurfaceVariant,
        ),
        leadingAndTrailingTextStyle: TalkyTextStyles.caption.apply(
          color: colors.onSurfaceVariant,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: TKSpacing.x7,
          vertical: TKSpacing.x2,
        ),
      ),
    );
  }
}
