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

  /// Checks if the email is available for registration.
  /// 
  /// Returns `true` if the email is available, `false` otherwise.
  Future<bool> checkEmailAvailability({
    required String email,
  });
}
