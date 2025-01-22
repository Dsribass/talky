import 'package:auth/src/domain/use_cases/sign_up.dart';
import 'package:auth/src/presentation/sign_up/password/sign_up_password_model.dart';
import 'package:auth/src/presentation/utils/validators/password_validation_error.dart';
import 'package:auth/src/presentation/utils/validators/password_validator.dart';
import 'package:core/core.dart';

final class SignUpPasswordBloc
    extends Bloc<SignUpPasswordEvent, SignUpPasswordState>
    with RxEventTransformer {
  SignUpPasswordBloc({
    required SignUp signUp,
  })  : _signUp = signUp,
        super(const SignUpPasswordState.initial()) {
    on<SignUpPasswordPasswordChanged>(
      _onPasswordChanged,
      // transformer: debounce(),
    );
    on<SignUpFormSubmitted>(_onPasswordSubmitted);
  }

  final SignUp _signUp;

  Future<void> _onPasswordChanged(
    SignUpPasswordPasswordChanged event,
    Emitter<SignUpPasswordState> emit,
  ) async =>
      emit(
        state.copyWith(
          password: event.password,
          errors: _validatePasswordInput(event.password),
        ),
      );

  Future<void> _onPasswordSubmitted(
    SignUpFormSubmitted event,
    Emitter<SignUpPasswordState> emit,
  ) async {
    final errors = _validatePasswordInput(event.password);

    if (errors != null) {
      emit(state.copyWith(errors: errors));
    }

    await _signUp(
      (email: event.email, password: event.password),
    ).onSuccess(
      (_) => emit(
        state.copyWith(completeSignUp: true),
      ),
    );
  }

  List<PasswordInputValidationError>? _validatePasswordInput(
    String password,
  ) {
    final passwordValidator = PasswordInputValidator()
      ..isValidLength(min: 8)
      ..containsLetter()
      ..containsNumber();

    return passwordValidator
        .validate(password)
        .whereType<PasswordInputValidationError>()
        .toList();
  }
}
