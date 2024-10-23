import 'package:auth/src/data/exceptions.dart';
import 'package:auth/src/domain/domain.dart';
import 'package:auth/src/presentation/sign_in/sign_in_models.dart';
import 'package:core/core.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
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
      transformer: _debounce(),
    );
    on<SignInPasswordChanged>(
      _onSignInPasswordChanged,
      transformer: _debounce(),
    );
    on<SignInFormSubmitted>(_onSignInFormSubmitted);
  }

  final ValidateEmail _validateEmail;
  final ValidatePassword _validatePassword;
  final SignIn _signIn;

  EventTransformer<Event> _debounce<Event>() => (events, mapper) => events
      .debounceTime(
        const Duration(milliseconds: 300),
      )
      .flatMap(mapper);

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
      TKInvalidCredentialsException() => SignInModelInputStatus.incorrect,
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
      ),
    );
  }

  Future<SignInModelInputStatus> _validatePasswordInput(String password) =>
      _validatePassword(
        (password: password),
      ).fold(
        (success) => SignInModelInputStatus.valid,
        (error) => switch (error) {
          TKEmptyInputException() => SignInModelInputStatus.empty,
          TKInvalidInputException() => SignInModelInputStatus.invalid,
          _ => SignInModelInputStatus.invalid,
        },
      );

  Future<SignInModelInputStatus> _validateEmailInput(String email) =>
      _validateEmail(
        (email: email),
      ).fold(
        (success) => SignInModelInputStatus.valid,
        (error) => switch (error) {
          TKEmptyInputException() => SignInModelInputStatus.empty,
          TKInvalidInputException() => SignInModelInputStatus.invalid,
          _ => SignInModelInputStatus.invalid,
        },
      );
}
