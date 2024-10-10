import 'package:auth/auth.dart';
import 'package:auth/src/presentation/sign_in/sign_in_bloc.dart';
import 'package:auth/src/presentation/sign_in/sign_in_models.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:i18n/l10n/l10n.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final SignInBloc _bloc;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _bloc = SignInBloc(
      validateEmail: inject(),
      validatePassword: inject(),
    );
    super.initState();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _emailFocusNode.unfocus();
        _passwordFocusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(context.l10n.signInAppBarTitle),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TKSpacing.x7),
            child: BlocBuilder<SignInBloc, SignInState>(
              bloc: _bloc,
              builder: (context, state) {
                return Column(
                  children: [
                    const SizedBox(height: TKSpacing.x9),
                    Text(
                      context.l10n.signInTitle,
                      style: TalkyTextStyles.headline1,
                    ),
                    const SizedBox(height: TKSpacing.x8),
                    TextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      style: TalkyTextStyles.paragraph.medium,
                      onEditingComplete: _passwordFocusNode.requestFocus,
                      decoration: InputDecoration(
                        hintText: context.l10n.signInEmailFieldLabel,
                        errorText: _getErrorMessage(
                          context,
                          state.emailInputStatus,
                        ),
                      ),
                      onChanged: (value) => _bloc.add(
                        SignInEmailChanged(value),
                      ),
                    ),
                    const SizedBox(height: TKSpacing.x4),
                    TextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      style: TalkyTextStyles.paragraph.medium,
                      decoration: InputDecoration(
                        hintText: context.l10n.signInPasswordFieldLabel,
                        errorText: _getErrorMessage(
                          context,
                          state.passwordInputStatus,
                        ),
                      ),
                      onChanged: (value) => _bloc.add(
                        SignInPasswordChanged(value),
                      ),
                    ),
                    const SizedBox(height: TKSpacing.x4),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        context.l10n.signInForgotPassword,
                        style: TalkyTextStyles.caption.apply(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () => _bloc.add(
                          SignInFormSubmitted(
                            email: _emailController.text,
                            password: _passwordController.text,
                          ),
                        ),
                        child: Text(context.l10n.signInButton),
                      ),
                    ),
                    const SizedBox(height: TKSpacing.x7),
                    Text(
                      context.l10n.introSignUpInfo,
                      style: TalkyTextStyles.paragraph.medium,
                    ),
                    TextButton(
                      onPressed: () => context.navigateToInternalRoute(
                        route: AuthRoutes.signUpEmailStep,
                      ),
                      child: Text(context.l10n.introSignUpButton),
                    ),
                    const SizedBox(height: TKSpacing.x10),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? _getErrorMessage(
    BuildContext context,
    SignInModelInputStatus status,
  ) =>
      switch (status) {
        SignInModelInputStatus.empty => context.l10n.signInEmptyError,
        SignInModelInputStatus.invalid => context.l10n.signInInvalidError,
        SignInModelInputStatus.incorrect => context.l10n.signInIncorrectError,
        _ => null,
      };
}
