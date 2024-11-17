import 'dart:developer';

import 'package:core/dependencies.dart';
import 'package:core/modular.dart';
import 'package:core/utils.dart';

final class AppContainer extends InjectionContainer {
  @override
  void registerMainDependencies(GetIt injector) {
    injector
      ..registerSingleton<Logger>(AppLogger())
      ..registerSingleton<GlobalStateNotifier>(GlobalStateNotifier());
  }
}

class AppLogger implements Logger {
  @override
  void call(String message, {required Object error, StackTrace? stackTrace}) {
    log(message, error: error, stackTrace: stackTrace);
  }
}
