import 'package:core/core.dart';

abstract interface class AuthRepository {
  Future<Unit> signIn({
    required String email,
    required String password,
  });
}
