import 'package:core/core.dart';

@immutable
final class SignUpEmailState {
  const SignUpEmailState({
    required this.email,
    required this.emailInputStatus,
    required this.shouldProceedToNextStep,
    required this.isLoading,
  });

  const SignUpEmailState.initial()
      : this(
          email: '',
          emailInputStatus: SignUpEmailModelInputStatus.initial,
          shouldProceedToNextStep: false,
          isLoading: false,
        );

  final String email;
  final SignUpEmailModelInputStatus emailInputStatus;
  final bool shouldProceedToNextStep;
  final bool isLoading;

  bool get shouldEnableSignUpButton =>
      emailInputStatus == SignUpEmailModelInputStatus.valid;

  SignUpEmailState copyWith({
    String? email,
    SignUpEmailModelInputStatus? emailInputStatus,
    bool? isLoading,
    bool shouldProceedToNextStep = false,
  }) {
    return SignUpEmailState(
      email: email ?? this.email,
      emailInputStatus: emailInputStatus ?? this.emailInputStatus,
      shouldProceedToNextStep: shouldProceedToNextStep,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

enum SignUpEmailModelInputStatus {
  initial,
  valid,
  empty,
  invalid,
  unavailable,
  error,
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
