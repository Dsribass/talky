import 'package:core/core.dart';

abstract interface class AuthRepository {
  Future<Unit> signUp({
    required String email,
    required String password,
  });

  Future<Unit> signIn({
    required String email,
    required String password,
  });
}
