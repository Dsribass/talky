import 'package:auth/src/data/exceptions.dart';
import 'package:auth/src/domain/repositories/auth_repository.dart';
import 'package:core/core.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<Unit> signIn({
    required String email,
    required String password,
  }) async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));

    const fakeEmail = 'lorem_ipsum@email.com';
    const fakePassword = '12345678D';

    final isEmailCorrect = fakeEmail == email;
    final isPasswordCorrect = fakePassword == password;

    if (isEmailCorrect && isPasswordCorrect) {
      return unit;
    } else {
      throw TKInvalidCredentialsException(message: 'Invalid email or password');
    }
  }

  @override
  Future<Unit> signUp({required String email, required String password}) async {
    await Future<dynamic>.delayed(const Duration(seconds: 1));

    return unit;
  }
}
