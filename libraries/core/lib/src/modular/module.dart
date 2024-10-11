import 'package:core/src/modular/di/container_module.dart';
import 'package:core/src/modular/localization/localization_module.dart';
import 'package:core/src/modular/router/router_module.dart';

abstract class Module {
  const Module({
    required this.router,
    required this.container,
    required this.localization,
  });

  final RouterModule router;
  final ContainerModule container;
  final LocalizationModule localization;
}
