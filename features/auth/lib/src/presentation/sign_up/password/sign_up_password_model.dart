import 'package:auth/src/presentation/utils/validators/password_validation_error.dart';
import 'package:core/core.dart';

@immutable
final class SignUpPasswordState {
  const SignUpPasswordState({
    required this.password,
    required this.errors,
    this.completeSignUp = false,
  });

  const SignUpPasswordState.initial()
      : password = '',
        errors = null,
        completeSignUp = false;

  final String password;
  final List<PasswordInputValidationError>? errors;
  final bool completeSignUp;

  bool get shouldEnableSignUpButton =>
      errors == null || errors!.isEmpty && password.isNotEmpty;

  SignUpPasswordState copyWith({
    String? password,
    List<PasswordInputValidationError>? errors,
    bool completeSignUp = false,
  }) {
    return SignUpPasswordState(
      password: password ?? this.password,
      errors: errors ?? this.errors,
      completeSignUp: completeSignUp,
    );
  }
}

sealed class SignUpPasswordEvent {
  const SignUpPasswordEvent();
}

@immutable
final class SignUpPasswordPasswordChanged extends SignUpPasswordEvent {
  const SignUpPasswordPasswordChanged({
    required this.password,
  });

  final String password;
}

@immutable
final class SignUpFormSubmitted extends SignUpPasswordEvent {
  const SignUpFormSubmitted({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}
