import 'package:auth/src/presentation/sign_up/email/sign_up_email_models.dart';
import 'package:auth/src/presentation/sign_up/email/validators/email_validation_error.dart';
import 'package:auth/src/presentation/sign_up/email/validators/email_validator.dart';
import 'package:core/core.dart';

final class SignUpEmailBloc extends Bloc<SignUpEmailEvent, SignUpEmailState>
    with RxEventTransformer {
  SignUpEmailBloc() : super(const SignUpEmailState.initial()) {
    on<SignUpEmailEmailChanged>(
      _onEmailChanged,
      transformer: debounce(),
    );
    on<SignUpEmailSubmitted>(_onEmailSubmitted);
  }

  Future<void> _onEmailChanged(
    SignUpEmailEmailChanged event,
    Emitter<SignUpEmailState> emit,
  ) async {
    final emailInputStatus = _validateEmailInput(event.email);

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
    final emailInputStatus = _validateEmailInput(event.email);

    emit(
      state.copyWith(
        emailInputStatus: emailInputStatus,
        shouldProceedToNextStep:
            emailInputStatus == SignUpEmailModelInputStatus.valid,
      ),
    );
  }

  SignUpEmailModelInputStatus _validateEmailInput(String email) {
    final emailValidator = EmailInputValidator()..isValidEmail();

    final error = emailValidator.validate(email).firstOrNull;

    if (error != null) {
      return switch (error) {
        EmptyEmail() => SignUpEmailModelInputStatus.empty,
        InvalidEmail() => SignUpEmailModelInputStatus.invalid,
        _ => SignUpEmailModelInputStatus.invalid,
      };
    }

    return SignUpEmailModelInputStatus.valid;
  }
}
