import 'package:flutter/widgets.dart';

@immutable
final class SignInState {
  const SignInState({
    required this.email,
    required this.password,
    required this.emailInputStatus,
    required this.passwordInputStatus,
    required this.isLoading,
  });

  const SignInState.initial()
      : this(
          email: '',
          password: '',
          emailInputStatus: SignInModelInputStatus.valid,
          passwordInputStatus: SignInModelInputStatus.valid,
          isLoading: false,
        );

  final String email;
  final String password;
  final SignInModelInputStatus emailInputStatus;
  final SignInModelInputStatus passwordInputStatus;
  final bool isLoading;

  bool get shouldEnableSignInButton =>
      (emailInputStatus == SignInModelInputStatus.valid &&
          passwordInputStatus == SignInModelInputStatus.valid) ||
      emailInputStatus == SignInModelInputStatus.incorrect ||
      passwordInputStatus == SignInModelInputStatus.incorrect;

  SignInState copyWith({
    String? email,
    String? password,
    SignInModelInputStatus? emailInputStatus,
    SignInModelInputStatus? passwordInputStatus,
    bool? isLoading,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      emailInputStatus: emailInputStatus ?? this.emailInputStatus,
      passwordInputStatus: passwordInputStatus ?? this.passwordInputStatus,
      isLoading: isLoading ?? this.isLoading,
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
