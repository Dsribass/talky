import 'package:core/core.dart';

@immutable
final class SignUpPasswordState {
  const SignUpPasswordState({
    required this.password,
    required this.passwordInputStatus,
  });

  const SignUpPasswordState.initial()
      : this(
          password: '',
          passwordInputStatus: SignUpPasswordModelInputStatus.initial,
        );

  final String password;
  final SignUpPasswordModelInputStatus passwordInputStatus;

  bool get shouldEnableSignUpButton =>
      passwordInputStatus == SignUpPasswordModelInputStatus.valid;

  SignUpPasswordState copyWith({
    String? password,
    SignUpPasswordModelInputStatus? passwordInputStatus,
  }) {
    return SignUpPasswordState(
      password: password ?? this.password,
      passwordInputStatus: passwordInputStatus ?? this.passwordInputStatus,
    );
  }
}

enum SignUpPasswordModelInputStatus {
  initial,
  valid,
  invalidLength,
  invalid,
  empty,
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
