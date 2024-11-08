import 'package:auth/src/domain/use_cases/validate_email.dart';
import 'package:auth/src/presentation/sign_up/email/sign_up_email_models.dart';
import 'package:core/core.dart';

final class SignUpEmailBloc extends Bloc<SignUpEmailEvent, SignUpEmailState>
    with RxEventTransformer {
  SignUpEmailBloc({
    required ValidateEmail validateEmail,
  })  : _validateEmail = validateEmail,
        super(const SignUpEmailState.initial()) {
    on<SignUpEmailEmailChanged>(
      _onEmailChanged,
      transformer: debounce(),
    );
    on<SignUpEmailSubmitted>(_onEmailSubmitted);
  }

  final ValidateEmail _validateEmail;

  Future<void> _onEmailChanged(
    SignUpEmailEmailChanged event,
    Emitter<SignUpEmailState> emit,
  ) async {
    final emailInputStatus = await _validateEmailInput(event.email);

    emit(
      state.copyWith(
        email: event.email,
        emailInputStatus: emailInputStatus,
      ),
    );
  }

  Future<void> _onEmailSubmitted(
    SignUpEmailSubmitted event,
    Emitter<SignUpEmailState> emit,
  ) async {
    final emailInputStatus = await _validateEmailInput(event.email);

    emit(
      state.copyWith(
        emailInputStatus: emailInputStatus,
        shouldProceedToNextStep:
            emailInputStatus == SignUpEmailModelInputStatus.valid,
      ),
    );
  }

  Future<SignUpEmailModelInputStatus> _validateEmailInput(String email) =>
      _validateEmail(
        (email: email),
      ).fold(
        (success) => SignUpEmailModelInputStatus.valid,
        (error) => switch (error) {
          EmptyInputException() => SignUpEmailModelInputStatus.empty,
          InvalidInputException() => SignUpEmailModelInputStatus.invalid,
          _ => SignUpEmailModelInputStatus.invalid,
        },
      );
}
