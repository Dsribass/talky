import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';

typedef SignUpParams = ({
  String email,
  String password,
});

final class SignUp extends UseCase<Unit, SignUpParams> {
  SignUp({
    required this.repository,
    required super.logger,
  });

  final AuthRepository repository;

  @override
  Future<Unit> execute(SignUpParams params) async {
    return unit;
  }
}
