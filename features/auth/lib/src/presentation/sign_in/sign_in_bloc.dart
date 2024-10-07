import 'package:auth/src/presentation/sign_in/sign_in_models.dart';
import 'package:core/core.dart';

// TODO(any): Remove mock data and implement real authentication logic
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState.initial()) {
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

  EventTransformer<Event> _debounce<Event>() => (events, mapper) => events
      .debounceTime(
        const Duration(milliseconds: 300),
      )
      .flatMap(mapper);

  void _onSignInEmailChanged(
    SignInEmailChanged event,
    Emitter<SignInState> emit,
  ) {
    final emailInputStatus = event.email.isEmpty
        ? SignInModelInputStatus.empty
        : _isEmailValid(event.email)
            ? SignInModelInputStatus.valid
            : SignInModelInputStatus.invalid;

    emit(
      state.copyWith(
        email: event.email,
        emailInputStatus: emailInputStatus,
      ),
    );
  }

  void _onSignInPasswordChanged(
    SignInPasswordChanged event,
    Emitter<SignInState> emit,
  ) {
    final passwordInputStatus = event.password.isEmpty
        ? SignInModelInputStatus.empty
        : _isPasswordValid(event.password)
            ? SignInModelInputStatus.valid
            : SignInModelInputStatus.invalid;

    emit(
      state.copyWith(
        password: event.password,
        passwordInputStatus: passwordInputStatus,
      ),
    );
  }

  void _onSignInFormSubmitted(
    SignInFormSubmitted event,
    Emitter<SignInState> emit,
  ) {
    final emailInputStatus = event.email.isEmpty
        ? SignInModelInputStatus.empty
        : _isEmailValid(event.email)
            ? SignInModelInputStatus.valid
            : SignInModelInputStatus.invalid;

    final passwordInputStatus = event.password.isEmpty
        ? SignInModelInputStatus.empty
        : _isPasswordValid(event.password)
            ? SignInModelInputStatus.valid
            : SignInModelInputStatus.invalid;

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

  bool _isEmailValid(String email) {
    return email.isNotEmpty && email.length > 5 && email.contains('@');
  }

  bool _isPasswordValid(String password) {
    return password.isNotEmpty && password.length > 5;
  }
}
