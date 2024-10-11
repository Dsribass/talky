import 'package:core/dependencies.dart';
import 'package:core/modular.dart';
import 'package:core/utils.dart';

final class AppContainer extends InjectionContainer {
  @override
  void registerMainDependencies(GetIt injector) {
    injector.registerSingleton<Logger>(FakeAppLogger());
  }
}

// TODO(any): Implement the AppLogger class
class FakeAppLogger implements Logger {
  @override
  void call(String message, {required Object error, StackTrace? stackTrace}) {}
}
