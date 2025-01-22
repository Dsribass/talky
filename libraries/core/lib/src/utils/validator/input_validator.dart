import 'package:core/src/utils/validator/input_validation_handler.dart';

/// A generic class that validates input values using a list of
/// [InputValidationHandler]s.
///
/// This class allows you to chain multiple validation handlers to validate
/// an input value against various rules. It collects validation errors
/// from all handlers.
///
/// Type parameter:
/// - [InputType]: The type of input value to be validated.
///
/// Example usage:
/// ```dart
/// final validator = InputValidator<String>()
///   ..addHandler(SomeValidator())
///   ..addHandler(AnotherValidator());
/// 
/// final errors = validator.validate('some input');
/// if (errors != null) {
///   // Handle validation errors
/// }
/// ```
/// 
/// Also you can create a more specific validator by extending this class:
/// ```dart
/// class EmailInputValidator extends InputValidator<String> {
///   void isValidEmail() => addHandler(EmailValidator());
/// }
/// ```
///
/// Methods:
/// - [validate]: Validates the input value using all added handlers and
///   returns a list of errors, or null if there are no errors.
/// - [addHandler]: Adds a new validation handler to the list of handlers.
class InputValidator<InputType> {
  final List<InputValidationHandler<InputType>> _handlers = [];

  List<InputValidationError>? validate(InputType value) {
    final errors = _handlers
        .map((handler) => handler.validate(input: value))
        .nonNulls
        .toList();

    return errors.isEmpty ? null : errors;
  }

  void addHandler(InputValidationHandler<InputType> handler) {
    _handlers.add(handler);
  }
}
