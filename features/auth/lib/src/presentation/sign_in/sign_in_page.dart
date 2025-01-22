import 'package:auth/src/presentation/auth_localization.dart';
import 'package:auth/src/presentation/sign_in/sign_in_bloc.dart';
import 'package:auth/src/presentation/sign_in/sign_in_models.dart';
import 'package:auth/src/router/auth_router.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
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
    _bloc = SignInBloc(signIn: inject());
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
            child: BlocConsumer<SignInBloc, SignInState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state.completeSignIn) {
                  // TODO(any): check if user already has configured profile
                  GlobalStateNotifier.I.changeState(
                    GlobalState.waitingForSetupProfile,
                  );
                }
              },
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
                      enabled: !state.isLoading,
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
                    ),
                    const SizedBox(height: TKSpacing.x4),
                    TextFormField(
                      enabled: !state.isLoading,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      style: TalkyTextStyles.paragraph.medium,
                      obscureText: state.isObscurePassword,
                      decoration: InputDecoration(
                        hintText: context.l10n.signInPasswordFieldLabel,
                        errorText: _getErrorMessage(
                          context,
                          state.passwordInputStatus,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            state.isObscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: context.colors.outline,
                          ),
                          onPressed: () => _bloc.add(
                            const SignInObscurePasswordChanged(),
                          ),
                        ),
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
                    TalkyFilledButton(
                      width: double.infinity,
                      isLoading: state.isLoading,
                      onPressed: () => _bloc.add(
                        SignInFormSubmitted(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      ),
                      label: Text(context.l10n.signInButton),
                    ),
                    const SizedBox(height: TKSpacing.x7),
                    Text(
                      context.l10n.introSignUpInfo,
                      style: TalkyTextStyles.paragraph.medium,
                    ),
                    TalkyTextButton(
                      onPressed: !state.isLoading
                          ? () => context.navigateToInternalRoute(
                                route: AuthRoutes.signUpEmailStep,
                              )
                          : null,
                      label: Text(context.l10n.introSignUpButton),
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
        SignInModelInputStatus.error => context.l10n.signInError,
        _ => null,
      };
}
