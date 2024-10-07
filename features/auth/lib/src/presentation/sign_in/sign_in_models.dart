import 'package:flutter/widgets.dart';

@immutable
final class SignInState {
  const SignInState({
    required this.email,
    required this.password,
    required this.emailInputStatus,
    required this.passwordInputStatus,
  });

  const SignInState.initial()
      : this(
          email: '',
          password: '',
          emailInputStatus: SignInModelInputStatus.valid,
          passwordInputStatus: SignInModelInputStatus.valid,
        );

  final String email;
  final String password;
  final SignInModelInputStatus emailInputStatus;
  final SignInModelInputStatus passwordInputStatus;

  SignInState copyWith({
    String? email,
    String? password,
    SignInModelInputStatus? emailInputStatus,
    SignInModelInputStatus? passwordInputStatus,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailInputStatus: emailInputStatus ?? this.emailInputStatus,
      passwordInputStatus: passwordInputStatus ?? this.passwordInputStatus,
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
