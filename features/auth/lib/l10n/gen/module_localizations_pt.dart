import 'module_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class ModuleLocalizationsPt extends ModuleLocalizations {
  ModuleLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get introLogo => 'Talky';

  @override
  String get introSignInButton => 'Entrar';

  @override
  String get introSignUpInfo => 'Ainda não possui uma conta?';

  @override
  String get introSignUpButton => 'Registre-se aqui!';

  @override
  String get signInAppBarTitle => 'Login';

  @override
  String get signInTitle => 'Bem-vindo de volta!';

  @override
  String get signInEmailFieldLabel => 'Digite seu email';

  @override
  String get signInPasswordFieldLabel => 'Digite sua senha';

  @override
  String get signInIncorrectError => 'Email ou senha estão incorretos';

  @override
  String get signInInvalidError => 'Campo inválido';

  @override
  String get signInEmptyError => 'Campo obrigatório';

  @override
  String get signInError => 'Oops! Algo deu errado';

  @override
  String get signInButton => 'Entrar';

  @override
  String get signInForgotPassword => 'Esqueceu a senha?';

  @override
  String get signUpAppBarTitle => 'Cadastro';

  @override
  String get signUpEmailTitle => 'Digite seu email';

  @override
  String get signUpEmailFieldLabel => 'Email';

  @override
  String get signUpEmailInvalidError => 'Email inválido';

  @override
  String get signUpEmailEmptyError => 'Campo obrigatório';

  @override
  String get signUpEmailUnavailableError => 'Email já está em uso';

  @override
  String get signUpEmailGenericError => 'Oops! Algo deu errado';

  @override
  String get signUpPasswordTitle => 'Digite sua senha';

  @override
  String get signUpPasswordFieldLabel => 'Senha';

  @override
  String get signUpPasswordInvalidLengthError => 'Senha inválida. Deve conter pelo menos 8 caracteres';

  @override
  String get signUpPasswordInvalidTypeError => 'Senha inválida. Deve conter pelo menos um número e uma letra';

  @override
  String get signUpPasswordEmptyError => 'Campo obrigatório';

  @override
  String get signUpPasswordGenericError => 'Oops! Algo deu errado';

  @override
  String get signUpPasswordRulesTitle => 'A senha deve conter';

  @override
  String get signUpPasswordLengthRule => 'Pelo menos 8 caracteres';

  @override
  String get signUpPasswordNumericRule => 'Pelo menos um número';

  @override
  String get signUpPasswordLetterRule => 'Pelo menos uma letra';

  @override
  String get signUpEmailButton => 'Próximo';

  @override
  String get signUpPasswordButton => 'Finalizar';
}
