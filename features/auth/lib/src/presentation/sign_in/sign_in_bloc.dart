import 'package:auth/src/domain/domain.dart';
import 'package:auth/src/presentation/sign_in/sign_in_models.dart';
import 'package:core/core.dart';

// TODO(any): Remove mock data and implement real authentication logic
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required ValidateEmail validateEmail,
    required ValidatePassword validatePassword,
  })  : _validateEmail = validateEmail,
        _validatePassword = validatePassword,
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
    final emailInputStatus = await _validateEmailInput(event.email);
    final passwordInputStatus = await _validatePasswordInput(event.password);

    if (emailInputStatus != SignInModelInputStatus.valid ||
        passwordInputStatus != SignInModelInputStatus.valid) {
      return emit(
        state.copyWith(
          email: event.email,
          password: event.password,
          emailInputStatus: emailInputStatus,
          passwordInputStatus: passwordInputStatus,
        ),
      );
    }

    const fakeEmail = 'lorem_ipsum@email.com';
    const fakePassword = '12345678';

    final isEmailCorrect = fakeEmail == event.email;
    final isPasswordCorrect = fakePassword == event.password;

    emit(
      state.copyWith(
        email: event.email,
        password: event.password,
        emailInputStatus: isEmailCorrect
            ? SignInModelInputStatus.valid
            : SignInModelInputStatus.incorrect,
        passwordInputStatus: isPasswordCorrect
            ? SignInModelInputStatus.valid
            : SignInModelInputStatus.incorrect,
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
