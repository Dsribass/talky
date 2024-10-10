import 'package:core/core.dart';

typedef ValidatePasswordParams = ({String password});

/// A use case for validating passwords.
///
/// This use case checks if the provided password meets certain criteria:
/// - It must not be empty.
/// - It must contain at least one letter and one number.
/// - It must be at least 6 characters long.
///
/// Throws:
/// - `TKEmptyInputException` if the password is empty.
/// - `TKInvalidInputException` if the password does not meet the criteria.
final class ValidatePassword extends UseCase<Unit, ValidatePasswordParams> {
  ValidatePassword({required super.logger});

  @override
  Future<Unit> execute(ValidatePasswordParams params) async {
    final password = params.password;

    if (password.isEmpty) {
      throw TKEmptyInputException(message: 'Password cannot be empty');
    }

    // Regex to validate password with at least one letter and one number
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');

    if (!regex.hasMatch(password)) {
      throw TKInvalidInputException(
        message: 'Password must contain at least one letter and one number',
      );
    }

    return unit;
  }
}
