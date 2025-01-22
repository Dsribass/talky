import 'package:auth/src/presentation/sign_up/password/validators/password_validation_error.dart';
import 'package:core/utils.dart';

class PasswordInputValidator extends InputValidator<String> {
  void isValidLength({required int min}) =>
      addHandler(LengthValidation(min: min));

  void containsLetter() => addHandler(AlphabeticValidation());

  void containsNumber() => addHandler(NumericValidation());
}

final class LengthValidation implements InputValidationHandler<String> {
  LengthValidation({required this.min});

  final int min;

  @override
  InputValidationError? validate({required String input}) {
    if (input.length < min) {
      return InvalidPasswordLength();
    }
    return null;
  }
}

final class AlphabeticValidation implements InputValidationHandler<String> {
  @override
  InputValidationError? validate({required String input}) {
    if (!input.contains(RegExp('[a-zA-Z]'))) {
      return NoAlphabeticCharacter();
    }
    return null;
  }
}

final class NumericValidation implements InputValidationHandler<String> {
  @override
  InputValidationError? validate({required String input}) {
    if (!input.contains(RegExp('[0-9]'))) {
      return NoNumericCharacter();
    }
    return null;
  }
}
