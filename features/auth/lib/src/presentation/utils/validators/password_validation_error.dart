import 'package:core/utils.dart';

sealed class PasswordInputValidationError implements InputValidationError {}

class InvalidPasswordLength extends PasswordInputValidationError {}

class NoAlphabeticCharacter extends PasswordInputValidationError {}

class NoNumericCharacter extends PasswordInputValidationError {}

class EmptyPassword extends PasswordInputValidationError {}
