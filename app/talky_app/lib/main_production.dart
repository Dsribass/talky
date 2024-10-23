import 'package:core/env.dart';
import 'package:core/modular.dart';
import 'package:talky_app/app.dart';
import 'package:talky_app/app_container.dart';
import 'package:talky_app/bootstrap.dart';

void main() async {
  await Environment.init(
    FlavorEnv.prod,
  );

  return bootstrap(
    (modules) => ModularApp(
      modules: modules,
      builder: (context, configuration) => App(configuration: configuration),
      container: AppContainer(),
    ),
  );
}
