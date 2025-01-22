import 'package:core/src/utils/validator/input_validator.dart';

abstract interface class InputValidationError {}

/// A contract for input validation logic, to be used with [InputValidator].
///
/// This interface defines a method to validate a specific type of input
/// and return an optional error if validation fails.
///
/// Example:
/// ```dart
/// class NonEmptyStringValidator implements InputValidationHandler<String> {
///   @override
///   InputValidationError? validate({required String input}) {
///     return input.isEmpty ? NonEmptyStringError() : null;
///   }
/// }
/// ```
abstract interface class InputValidationHandler<InputType> {
  /// Validates the given [input].
  ///
  /// Returns:
  /// - An instance of `InputValidationError` if the input fails the validation.
  /// - `null` if the input passes the validation.
  InputValidationError? validate({required InputType input});
}
