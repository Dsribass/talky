import 'package:auth/src/data/repositories/mock_auth_repository.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:auth/src/domain/use_cases/use_cases.dart';
import 'package:core/core.dart';

final class AuthContainer implements ContainerModule {
  @override
  void registerDependencies(GetIt injector) {
    _registerDataDependencies(injector);
    _registerDomainDependencies(injector);
  }

  void _registerDataDependencies(GetIt injector) {
    injector.registerCachedFactory<AuthRepository>(MockAuthRepository.new);
  }

  void _registerDomainDependencies(GetIt injector) {
    injector
      ..registerCachedFactory(
        () => ValidateEmail(logger: injector.get()),
      )
      ..registerCachedFactory(
        () => ValidatePassword(logger: injector.get()),
      )
      ..registerCachedFactory(
        () => SignIn(logger: injector.get(), authRepository: injector.get()),
      );
  }
}
