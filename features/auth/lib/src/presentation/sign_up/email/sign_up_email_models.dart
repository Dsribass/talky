import 'package:core/core.dart';

@immutable
final class SignUpEmailState {
  const SignUpEmailState({
    required this.email,
    required this.emailInputStatus,
    required this.shouldProceedToNextStep,
  });

  const SignUpEmailState.initial()
      : this(
          email: '',
          emailInputStatus: SignUpEmailModelInputStatus.initial,
          shouldProceedToNextStep: false,
        );

  final String email;
  final SignUpEmailModelInputStatus emailInputStatus;
  final bool shouldProceedToNextStep;

  bool get shouldEnableSignUpButton =>
      emailInputStatus == SignUpEmailModelInputStatus.valid;

  SignUpEmailState copyWith({
    String? email,
    SignUpEmailModelInputStatus? emailInputStatus,
    bool? shouldProceedToNextStep,
  }) {
    return SignUpEmailState(
      email: email ?? this.email,
      emailInputStatus: emailInputStatus ?? this.emailInputStatus,
      shouldProceedToNextStep:
          shouldProceedToNextStep ?? this.shouldProceedToNextStep,
    );
  }
}

enum SignUpEmailModelInputStatus {
  initial,
  valid,
  empty,
  invalid,
}

sealed class SignUpEmailEvent {
  const SignUpEmailEvent();
}

@immutable
final class SignUpEmailEmailChanged extends SignUpEmailEvent {
  const SignUpEmailEmailChanged({
    required this.email,
  });

  final String email;
}

@immutable
final class SignUpEmailSubmitted extends SignUpEmailEvent {
  const SignUpEmailSubmitted({
    required this.email,
  });

  final String email;
}
