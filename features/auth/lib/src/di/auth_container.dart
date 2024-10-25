import 'package:auth/src/data/data_sources/local/impl/secure_token_local_data_source.dart';
import 'package:auth/src/data/data_sources/local/token_local_data_source.dart';
import 'package:auth/src/data/data_sources/remote/auth_remote_data_source.dart';
import 'package:auth/src/data/data_sources/remote/impl/default_auth_remote_data_source.dart';
import 'package:auth/src/data/repositories/default_auth_repository.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:auth/src/domain/use_cases/use_cases.dart';
import 'package:core/core.dart';

final class AuthContainer implements ContainerModule {
  @override
  void registerDependencies(GetIt injector) {
    _registerCoreDependencies(injector);
    _registerDataDependencies(injector);
    _registerDomainDependencies(injector);
  }

  void _registerCoreDependencies(GetIt injector) {
    injector
      ..registerSingleton(
        ChatHttpClient(options: HttpOptions(baseUrl: env.chatApiBaseUrl)),
      )
      ..registerSingleton(
        const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
            preferencesKeyPrefix: 'talky_',
          ),
          iOptions: IOSOptions(
            accountName: 'talky',
          ),
        ),
      );
  }

  void _registerDataDependencies(GetIt injector) {
    injector
      ..registerCachedFactory<TokenLocalDataSource>(
        () => SecureTokenLocalDataSource(injector.get()),
      )
      ..registerCachedFactory<AuthRemoteDataSource>(
        () => DefaultAuthRemoteDataSource(injector.get<ChatHttpClient>()),
      )
      ..registerCachedFactory<AuthRepository>(
        () => DefaultAuthRepository(
          authRemoteDataSource: injector.get(),
          tokenLocalDataSource: injector.get(),
        ),
      );
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
      )
      ..registerCachedFactory(
        () => SignUp(logger: injector.get(), repository: injector.get()),
      );
  }
}
