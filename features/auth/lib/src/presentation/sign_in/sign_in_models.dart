import 'package:flutter/widgets.dart';

@immutable
final class SignInState {
  const SignInState({
    required this.emailInputStatus,
    required this.passwordInputStatus,
    required this.isLoading,
    required this.isObscurePassword,
    required this.completeSignIn,
  });

  const SignInState.initial()
      : this(
          emailInputStatus: SignInModelInputStatus.valid,
          passwordInputStatus: SignInModelInputStatus.valid,
          isLoading: false,
          isObscurePassword: true,
          completeSignIn: false,
        );

  final SignInModelInputStatus emailInputStatus;
  final SignInModelInputStatus passwordInputStatus;
  final bool isLoading;
  final bool isObscurePassword;
  final bool completeSignIn;

  bool get shouldEnableSignInButton =>
      (emailInputStatus == SignInModelInputStatus.valid &&
          passwordInputStatus == SignInModelInputStatus.valid) ||
      emailInputStatus == SignInModelInputStatus.incorrect ||
      passwordInputStatus == SignInModelInputStatus.incorrect;

  SignInState copyWith({
    SignInModelInputStatus? emailInputStatus,
    SignInModelInputStatus? passwordInputStatus,
    bool? isLoading,
    bool? isObscurePassword,
    bool completeSignIn = false,
  }) {
    return SignInState(
      emailInputStatus: emailInputStatus ?? this.emailInputStatus,
      passwordInputStatus: passwordInputStatus ?? this.passwordInputStatus,
      isLoading: isLoading ?? this.isLoading,
      isObscurePassword: isObscurePassword ?? this.isObscurePassword,
      completeSignIn: completeSignIn,
    );
  }
}

sealed class SignInEvent {
  const SignInEvent();
}

@immutable
final class SignInFormSubmitted extends SignInEvent {
  const SignInFormSubmitted({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;
}

enum SignInModelInputStatus {
  valid,
  invalid,
  incorrect,
  empty,
  error,
}

@immutable
final class SignInEmailChanged extends SignInEvent {
  const SignInEmailChanged(this.email);

  final String email;
}

@immutable
final class SignInPasswordChanged extends SignInEvent {
  const SignInPasswordChanged(this.password);

  final String password;
}

@immutable
final class SignInObscurePasswordChanged extends SignInEvent {
  const SignInObscurePasswordChanged();
}
