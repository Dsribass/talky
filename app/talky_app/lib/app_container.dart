import 'package:core/dependencies.dart';
import 'package:core/utils.dart';

class AppContainer implements ContainerModule {
  AppContainer.setup({
    required this.modules,
  }) : injector = GetIt.instance {
    registerDependencies(injector);
  }

  final Set<ContainerModule> modules;
  final GetIt injector;

  @override
  void registerDependencies(GetIt injector) {
    injector.registerSingleton(FakeAppLogger.new);

    for (final module in modules) {
      module.registerDependencies(injector);
    }
  }
}

// TODO(any): Implement the AppLogger class
class FakeAppLogger implements Logger {
  @override
  void call(String message, {required Object error, StackTrace? stackTrace}) {}
}
