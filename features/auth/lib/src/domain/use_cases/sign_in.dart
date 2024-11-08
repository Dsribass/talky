import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';

typedef SignInParams = ({String email, String password});

final class SignIn extends UseCase<Unit, SignInParams> {
  const SignIn({
    required this.authRepository,
    required super.logger,
  });

  final AuthRepository authRepository;

  @override
  Future<Unit> execute(SignInParams params) {
    final email = params.email;
    final password = params.password;

    if (email.isEmpty) {
      throw EmptyInputException(message: 'Email cannot be empty');
    }

    if (password.isEmpty) {
      throw EmptyInputException(message: 'Password cannot be empty');
    }

    return authRepository.signIn(email: email, password: password);
  }
}
