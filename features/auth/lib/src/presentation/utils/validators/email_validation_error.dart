import 'package:core/utils.dart';

sealed class EmailInputValidationError implements InputValidationError {}

class InvalidEmail extends EmailInputValidationError {}

class EmptyEmail extends EmailInputValidationError {}
