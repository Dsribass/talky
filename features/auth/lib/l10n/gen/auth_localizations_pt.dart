import 'auth_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AuthLocalizationsPt extends AuthLocalizations {
  AuthLocalizationsPt([String locale = 'pt']) : super(locale);

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
  String get signUpPasswordTitle => 'Digite sua senha';

  @override
  String get signUpPasswordFieldLabel => 'Senha';

  @override
  String get signUpEmailButton => 'Próximo';

  @override
  String get signUpPasswordButton => 'Finalizar';
}
