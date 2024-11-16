import 'package:core/core.dart';

final class InvalidCredentialsException extends CoreException {
  InvalidCredentialsException({required super.message});
}

final class ItemAlreadyExistsException extends CoreException {
  ItemAlreadyExistsException({required super.message});
}
