import 'package:auth/src/presentation/intro/intro.dart';
import 'package:auth/src/presentation/sign_in/sign_in.dart';
import 'package:auth/src/presentation/sign_up/sign_up.dart';
import 'package:core/core.dart';

enum AuthRouteParameters implements RouteParameter {
  email;

  @override
  String get name => toString().split('.').last;
}

enum AuthRoutes implements InternalRoutes {
  signIn('sign-in'),
  signUpEmailStep('sign-up/email'),
  signUpPasswordStep('sign-up/password');

  const AuthRoutes(this.path);

  @override
  final String path;

  @override
  String get name => toString().split('.').last;
}

final class AuthRouter implements RouterModule {
  @override
  List<GoRoute> get configuration => [
        GoRoute(
          name: GlobalRoutes.root.name,
          path: GlobalRoutes.root.path,
          builder: (_, __) => const IntroPage(),
          routes: [
            GoRoute(
              name: AuthRoutes.signIn.name,
              path: AuthRoutes.signIn.path,
              builder: (_, __) => const SignInPage(),
            ),
            GoRoute(
              name: AuthRoutes.signUpEmailStep.name,
              path: AuthRoutes.signUpEmailStep.path,
              builder: (_, __) => const SignUpEmailPage(),
              routes: [
                GoRoute(
                  name: AuthRoutes.signUpPasswordStep.name,
                  path: AuthRoutes.signUpPasswordStep.pathWithParameters(
                    [AuthRouteParameters.email],
                  ),
                  builder: (_, state) {
                    final emailParameter = AuthRouteParameters.email.name;
                    return SignUpPasswordPage(
                      email: state.pathParameters[emailParameter]!,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ];
}
