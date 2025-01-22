import 'package:core/src/exceptions/core_exception.dart';

final class GenericException extends CoreException {
  GenericException({
    required super.message,
    super.originalError,
    super.originalStackTrace,
  });
}

final class EmptyInputException extends CoreException {
  EmptyInputException({required super.message});
}

final class ItemNotFoundException extends CoreException {
  ItemNotFoundException({required super.message});
}

final class UserUnauthorizedException extends CoreException {
  UserUnauthorizedException({required super.message});
}
