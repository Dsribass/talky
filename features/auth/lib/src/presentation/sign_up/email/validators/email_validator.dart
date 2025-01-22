import 'package:auth/src/presentation/sign_up/email/validators/email_validation_error.dart';
import 'package:core/utils.dart';

class EmailInputValidator extends InputValidator<String> {
  void isValidEmail() => addHandler(EmailValidation());
}

class EmailValidation implements InputValidationHandler<String> {
  @override
  InputValidationError? validate({required String input}) {
    if (input.isEmpty) {
      return EmptyEmail();
    }

    final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&\'*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!emailRegex.hasMatch(input)) {
      return InvalidEmail();
    }

    return null;
  }
}
