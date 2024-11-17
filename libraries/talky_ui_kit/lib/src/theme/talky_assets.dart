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

  AssetImage image(String name) => AssetImage(
        'assets/images/$name',
        package: 'talky_ui_kit',
      );

  AssetImage splashLogo() => image('splash.png');
}

@immutable
final class SvgConfiguration {
  const SvgConfiguration({
    this.color,
    this.width,
    this.height,
  });

  final Color? color;
  final double? width;
  final double? height;
}

final class TalkyIcons {
  const TalkyIcons._();

  SvgPicture svgIcon(String icon, {SvgConfiguration? config}) {
    config ??= const SvgConfiguration();

    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      package: 'talky_ui_kit',
      colorFilter: config.color != null
          ? ColorFilter.mode(config.color!, BlendMode.srcIn)
          : null,
      width: config.width,
      height: config.height,
    );
  }

  SvgPicture logo({SvgConfiguration? config}) =>
      svgIcon('logo', config: config);

  SvgPicture arrowBack({SvgConfiguration? config}) =>
      svgIcon('arrow-back', config: config);

  SvgPicture splash({SvgConfiguration? config}) =>
      svgIcon('splash', config: config);
}
