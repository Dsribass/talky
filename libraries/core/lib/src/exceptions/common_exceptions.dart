import 'package:core/src/exceptions/core_exception.dart';

final class GenericException extends CoreException {
  GenericException({
    required super.message,
    super.originalError,
    super.originalStackTrace,
  });
}

sealed class InputValidationException extends CoreException {
  InputValidationException({required super.message});
}

final class InvalidInputException extends InputValidationException {
  InvalidInputException({required super.message});
}

final class InvalidInputLengthException extends InputValidationException {
  InvalidInputLengthException({required super.message});
}

final class EmptyInputException extends InputValidationException {
  EmptyInputException({required super.message});
}

final class ItemNotFoundException extends CoreException {
  ItemNotFoundException({required super.message});
}

final class UserUnauthorizedException extends CoreException {
  UserUnauthorizedException({required super.message});
}
