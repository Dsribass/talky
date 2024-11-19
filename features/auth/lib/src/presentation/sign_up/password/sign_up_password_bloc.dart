import 'package:auth/src/domain/use_cases/sign_up.dart';
import 'package:auth/src/domain/use_cases/validate_password.dart';
import 'package:auth/src/presentation/sign_up/password/sign_up_password_model.dart';
import 'package:core/core.dart';

final class SignUpPasswordBloc
    extends Bloc<SignUpPasswordEvent, SignUpPasswordState>
    with RxEventTransformer {
  SignUpPasswordBloc({
    required ValidatePassword validatePassword,
    required SignUp signUp,
  })  : _validatePassword = validatePassword,
        _signUp = signUp,
        super(const SignUpPasswordState.initial()) {
    on<SignUpPasswordPasswordChanged>(
      _onPasswordChanged,
      transformer: debounce(),
    );
    on<SignUpFormSubmitted>(_onPasswordSubmitted);
  }

  final ValidatePassword _validatePassword;
  final SignUp _signUp;

  Future<void> _onPasswordChanged(
    SignUpPasswordPasswordChanged event,
    Emitter<SignUpPasswordState> emit,
  ) async {
    final passwordInputStatus = await _validatePasswordInput(event.password);

    emit(
      state.copyWith(
        password: event.password,
        passwordInputStatus: passwordInputStatus,
      ),
    );
  }

  Future<void> _onPasswordSubmitted(
    SignUpFormSubmitted event,
    Emitter<SignUpPasswordState> emit,
  ) async {
    final passwordInputStatus = await _validatePasswordInput(event.password);

    if (passwordInputStatus != SignUpPasswordModelInputStatus.valid) {
      emit(
        state.copyWith(
          passwordInputStatus: passwordInputStatus,
        ),
      );
    }

    await _signUp(
      (email: event.email, password: event.password),
    ).onSuccess(
      (_) => emit(
        state.copyWith(completeSignUp: true),
      ),
    );
  }

  Future<SignUpPasswordModelInputStatus> _validatePasswordInput(
    String password,
  ) =>
      _validatePassword(
        (password: password),
      ).fold(
        (success) => SignUpPasswordModelInputStatus.valid,
        (error) => switch (error) {
          EmptyInputException() => SignUpPasswordModelInputStatus.empty,
          InvalidInputException() => SignUpPasswordModelInputStatus.invalid,
          InvalidInputLengthException() =>
            SignUpPasswordModelInputStatus.invalidLength,
          _ => SignUpPasswordModelInputStatus.invalid,
        },
      );
}
