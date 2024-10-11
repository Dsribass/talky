import 'package:auth/src/di/auth_container.dart';
import 'package:auth/src/presentation/auth_localization.dart';
import 'package:auth/src/router/auth_router.dart';
import 'package:core/core.dart';

final class AuthModule extends Module {
  AuthModule() : super(
    router: AuthRouter(),
    container: AuthContainer(),
    localization: AuthLocalization(),
  );
}
