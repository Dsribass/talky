import 'package:auth/src/data/exceptions.dart';
import 'package:auth/src/domain/domain.dart';
import 'package:auth/src/presentation/sign_in/sign_in_models.dart';
import 'package:core/core.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState>
    with RxEventTransformer {
  SignInBloc({
    required ValidateEmail validateEmail,
    required ValidatePassword validatePassword,
    required SignIn signIn,
  })  : _validateEmail = validateEmail,
        _validatePassword = validatePassword,
        _signIn = signIn,
        super(const SignInState.initial()) {
    on<SignInEmailChanged>(
      _onSignInEmailChanged,
      transformer: debounce(),
    );
    on<SignInPasswordChanged>(
      _onSignInPasswordChanged,
      transformer: debounce(),
    );
    on<SignInFormSubmitted>(_onSignInFormSubmitted);

    on<SignInObscurePasswordChanged>(
      (_, emit) => emit(
        state.copyWith(
          isObscurePassword: !state.isObscurePassword,
        ),
      ),
    );
  }

  final ValidateEmail _validateEmail;
  final ValidatePassword _validatePassword;
  final SignIn _signIn;

  Future<void> _onSignInEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
  ) async {
    final validationResult = await _validateEmailInput(event.email);

    emit(
      state.copyWith(
        email: event.email,
        emailInputStatus: validationResult,
      ),
    );
  }

  Future<void> _onSignInPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) async {
    final validationResult = await _validatePasswordInput(event.password);

    emit(
      state.copyWith(
        password: event.password,
        passwordInputStatus: validationResult,
      ),
    );
  }

  Future<void> _onSignInFormSubmitted(
    SignInFormSubmitted event,
    Emitter<SignInState> emit,
  ) async {
    emit(
      state.copyWith(isLoading: true),
    );

    final emailInputStatus = await _validateEmailInput(event.email);
    final passwordInputStatus = await _validatePasswordInput(event.password);
    final inputIsNotValid = emailInputStatus != SignInModelInputStatus.valid ||
        passwordInputStatus != SignInModelInputStatus.valid;

    if (inputIsNotValid) {
      return emit(
        state.copyWith(
          email: event.email,
          password: event.password,
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
        email: event.email,
        password: event.password,
        emailInputStatus: inputStatus,
        passwordInputStatus: inputStatus,
        isLoading: false,
        completeSignIn: signInResult.isSuccess(),
      ),
    );
  }

  Future<SignInModelInputStatus> _validatePasswordInput(String password) =>
      _validatePassword(
        (password: password),
      ).fold(
        (success) => SignInModelInputStatus.valid,
        (error) => switch (error) {
          EmptyInputException() => SignInModelInputStatus.empty,
          InvalidInputException() => SignInModelInputStatus.invalid,
          _ => SignInModelInputStatus.invalid,
        },
      );

  Future<SignInModelInputStatus> _validateEmailInput(String email) =>
      _validateEmail(
        (email: email),
      ).fold(
        (success) => SignInModelInputStatus.valid,
        (error) => switch (error) {
          EmptyInputException() => SignInModelInputStatus.empty,
          InvalidInputException() => SignInModelInputStatus.invalid,
          _ => SignInModelInputStatus.invalid,
        },
      );
}
