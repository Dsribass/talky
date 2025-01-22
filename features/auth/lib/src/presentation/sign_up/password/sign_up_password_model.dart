import 'package:auth/src/presentation/utils/validators/password_validation_error.dart';
import 'package:core/core.dart';

@immutable
final class SignUpPasswordState {
  const SignUpPasswordState({
    required this.password,
    required this.errors,
    required this.isLoading,
    required this.showError,
    this.completeSignUp = false,
  });

  const SignUpPasswordState.initial()
      : password = '',
        errors = null,
        isLoading = false,
        showError = false,
        completeSignUp = false;

  final String password;
  final List<PasswordInputValidationError>? errors;
  final bool showError;
  final bool completeSignUp;
  final bool isLoading;

  bool get shouldEnableSignUpButton =>
      errors == null || errors!.isEmpty && password.isNotEmpty;

  SignUpPasswordState copyWith({
    String? password,
    List<PasswordInputValidationError>? errors,
    bool? isLoading,
    bool showError = false,
    bool completeSignUp = false,
  }) {
    return SignUpPasswordState(
      password: password ?? this.password,
      errors: errors ?? this.errors,
      isLoading: isLoading ?? this.isLoading,
      showError: showError,
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
