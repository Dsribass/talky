import 'package:auth/src/data/exceptions.dart';
import 'package:auth/src/domain/domain.dart';
import 'package:auth/src/presentation/sign_in/sign_in_models.dart';
import 'package:auth/src/presentation/utils/validators/validators.dart';
import 'package:core/core.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>
    with RxEventTransformer {
  SignInBloc({required SignIn signIn})
      : _signIn = signIn,
        super(const SignInState.initial()) {
    on<SignInFormSubmitted>(_onSignInFormSubmitted);

    on<SignInObscurePasswordChanged>(
      (_, emit) => emit(
        state.copyWith(
          isObscurePassword: !state.isObscurePassword,
        ),
      ),
    );
  }

  final SignIn _signIn;

  Future<void> _onSignInFormSubmitted(
    SignInFormSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final emailInputStatus = _validateEmailInput(event.email);
    final passwordInputStatus = _validatePasswordInput(event.password);
    final inputIsNotValid = emailInputStatus != SignInModelInputStatus.valid ||
        passwordInputStatus != SignInModelInputStatus.valid;

    if (inputIsNotValid) {
      return emit(
        state.copyWith(
          emailInputStatus: emailInputStatus,
          passwordInputStatus: passwordInputStatus,
          isLoading: false,
        ),
      );
    }

    final signInResult = await _signIn(
      (email: event.email, password: event.password),
    );

    final inputStatus = switch (signInResult.exceptionOrNull()) {
      InvalidCredentialsException() => SignInModelInputStatus.incorrect,
      Exception() => SignInModelInputStatus.error,
      _ => SignInModelInputStatus.valid,
    };

    emit(
      state.copyWith(
        emailInputStatus: inputStatus,
        passwordInputStatus: inputStatus,
        isLoading: false,
        completeSignIn: signInResult.isSuccess(),
      ),
    );
  }

  SignInModelInputStatus _validatePasswordInput(String password) {
    final passwordValidator = PasswordInputValidator()
      ..isEmpty()
      ..isValidLength()
      ..containsLetter()
      ..containsNumber();

    final error = passwordValidator.validate(password).firstOrNull;

    if (error != null) {
      return switch (error) {
        EmptyPassword() => SignInModelInputStatus.empty,
        _ => SignInModelInputStatus.invalid,
      };
    }

    return SignInModelInputStatus.valid;
  }

  SignInModelInputStatus _validateEmailInput(String email) {
    final emailValidator = EmailInputValidator()..isValidEmail();

    final error = emailValidator.validate(email).firstOrNull;

    if (error != null) {
      return switch (error) {
        EmptyEmail() => SignInModelInputStatus.empty,
        InvalidEmail() => SignInModelInputStatus.invalid,
        _ => SignInModelInputStatus.invalid,
      };
    }

    return SignInModelInputStatus.valid;
  }
}
