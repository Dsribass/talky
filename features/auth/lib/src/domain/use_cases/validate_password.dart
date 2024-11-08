import 'package:core/core.dart';

typedef ValidatePasswordParams = ({String password});

/// A use case for validating passwords.
///
/// This use case checks if the provided password meets certain criteria:
/// - It must not be empty.
/// - It must contain at least one letter and one number.
/// - It must be at least 8 characters long.
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
      throw EmptyInputException(message: 'Password cannot be empty');
    }

    if (password.length < 8) {
      throw InvalidInputLengthException(
        message: 'Password must be at least 8 characters long',
      );
    }

    // Regex to validate password with at least one letter and one number
    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d\W]{8,}$');

    if (!regex.hasMatch(password)) {
      throw InvalidInputException(
        message: 'Password must contain at least one letter and one number',
      );
    }

    return unit;
  }
}
