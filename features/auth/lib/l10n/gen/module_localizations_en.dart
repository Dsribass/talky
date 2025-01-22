import 'module_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class ModuleLocalizationsEn extends ModuleLocalizations {
  ModuleLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get introLogo => 'Talky';

  @override
  String get introSignInButton => 'Sign In';

  @override
  String get introSignUpInfo => 'Don\'t have an account yet?';

  @override
  String get introSignUpButton => 'Register here!';

  @override
  String get signInAppBarTitle => 'Login';

  @override
  String get signInTitle => 'Welcome back!';

  @override
  String get signInEmailFieldLabel => 'Enter your email';

  @override
  String get signInPasswordFieldLabel => 'Enter your password';

  @override
  String get signInIncorrectError => 'Email or password is incorrect';

  @override
  String get signInInvalidError => 'Field is invalid';

  @override
  String get signInEmptyError => 'Field is required';

  @override
  String get signInError => 'Oops! Something went wrong';

  @override
  String get signInButton => 'Sign In';

  @override
  String get signInForgotPassword => 'Forgot password?';

  @override
  String get signUpAppBarTitle => 'Sign Up';

  @override
  String get signUpEmailTitle => 'Enter your email';

  @override
  String get signUpEmailFieldLabel => 'Email';

  @override
  String get signUpEmailInvalidError => 'Invalid email';

  @override
  String get signUpEmailEmptyError => 'Field is required';

  @override
  String get signUpEmailUnavailableError => 'Email is already in use';

  @override
  String get signUpEmailGenericError => 'Oops! Something went wrong';

  @override
  String get signUpPasswordTitle => 'Enter your password';

  @override
  String get signUpPasswordFieldLabel => 'Password';

  @override
  String get signUpPasswordInvalidLengthError => 'Invalid password. Must be at least 8 characters long';

  @override
  String get signUpPasswordInvalidTypeError => 'Invalid password. Must contain at least one number and one letter';

  @override
  String get signUpPasswordEmptyError => 'Field is required';

  @override
  String get signUpPasswordGenericError => 'Oops! Something went wrong';

  @override
  String get signUpPasswordRulesTitle => 'Password must contain';

  @override
  String get signUpPasswordLengthRule => 'Least 8 characters';

  @override
  String get signUpPasswordNumericRule => 'Least one number';

  @override
  String get signUpPasswordLetterRule => 'Least one letter';

  @override
  String get signUpEmailButton => 'Next';

  @override
  String get signUpPasswordButton => 'Finish';
}
