import 'package:auth/src/domain/use_cases/validate_email.dart';
import 'package:auth/src/domain/use_cases/validate_password.dart';
import 'package:core/core.dart';

final class AuthContainer implements ContainerModule {
  @override
  void registerDependencies(GetIt injector) {
    injector
      ..registerCachedFactory(
        () => ValidateEmail(logger: injector.get()),
      )
      ..registerCachedFactory(
        () => ValidatePassword(logger: injector.get()),
      );
  }
}
