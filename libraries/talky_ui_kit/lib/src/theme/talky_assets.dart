import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

@immutable
final class TalkyAssets {
  const TalkyAssets._();

  static TalkyImages get images => const TalkyImages._();
  static TalkyIcons get icons => const TalkyIcons._();
}

final class TalkyImages {
  const TalkyImages._();
}

final class TalkyIcons {
  const TalkyIcons._();

  SvgPicture svgIcon(String icon, {Color? color}) => SvgPicture.asset(
        'assets/icons/$icon.svg',
        package: 'talky_ui_kit',
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );

  SvgPicture logo({Color? color}) => svgIcon('logo', color: color);
}
