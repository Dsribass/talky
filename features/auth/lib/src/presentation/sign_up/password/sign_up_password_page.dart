import 'package:auth/src/presentation/auth_localization.dart';
import 'package:auth/src/presentation/sign_up/password/sign_up_password_bloc.dart';
import 'package:auth/src/presentation/sign_up/password/sign_up_password_model.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:talky_ui_kit/talky_ui_kit.dart';

class SignUpPasswordPage extends StatefulWidget {
  const SignUpPasswordPage({
    required this.email,
    super.key,
  });

  final String email;

  @override
  State<SignUpPasswordPage> createState() => _SignUpPasswordPageState();
}

class _SignUpPasswordPageState extends State<SignUpPasswordPage> {
  late final SignUpPasswordBloc _bloc;
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _bloc = SignUpPasswordBloc(
      validatePassword: inject(),
      signUp: inject(),
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
      onTap: _focusNode.unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.signUpAppBarTitle),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: TKSpacing.x7),
            child: BlocConsumer<SignUpPasswordBloc, SignUpPasswordState>(
              bloc: _bloc,
              listener: (_, state) {
                if (state.completeSignUp) {
                  GlobalStateNotifier.I.changeState(
                    GlobalState.waitingForSetupProfile,
                  );
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: TKSpacing.x9),
                    Text(
                      context.l10n.signUpPasswordTitle,
                      style: TalkyTextStyles.headline1,
                    ),
                    const SizedBox(height: TKSpacing.x8),
                    TextFormField(
                      controller: _controller,
                      focusNode: _focusNode,
                      style: TalkyTextStyles.paragraph.medium,
                      decoration: InputDecoration(
                        hintText: context.l10n.signUpPasswordFieldLabel,
                        errorText: switch (state.passwordInputStatus) {
                          SignUpPasswordModelInputStatus.empty =>
                            context.l10n.signUpPasswordEmptyError,
                          SignUpPasswordModelInputStatus.invalid =>
                            context.l10n.signUpPasswordInvalidTypeError,
                          SignUpPasswordModelInputStatus.invalidLength =>
                            context.l10n.signUpPasswordInvalidLengthError,
                          _ => null,
                        },
                        errorMaxLines: 2,
                      ),
                      onChanged: (value) => _bloc.add(
                        SignUpPasswordPasswordChanged(password: value),
                      ),
                    ),
                    const SizedBox(height: TKSpacing.x8),
                    const _PasswordRules(),
                    const Spacer(),
                    TalkyFilledButton(
                      width: double.infinity,
                      onPressed: state.shouldEnableSignUpButton
                          ? () => _bloc.add(
                                SignUpFormSubmitted(
                                  email: widget.email,
                                  password: state.password,
                                ),
                              )
                          : null,
                      label: Text(context.l10n.signUpPasswordButton),
                    ),
                    const SizedBox(height: TKSpacing.x8),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _PasswordRules extends StatelessWidget {
  const _PasswordRules();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.signUpPasswordRulesTitle,
          style: TalkyTextStyles.paragraph,
        ),
        const SizedBox(height: TKSpacing.x2),
        Padding(
          padding: const EdgeInsets.only(left: TKSpacing.x2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.signUpPasswordRule1,
                style: TalkyTextStyles.paragraph,
              ),
              Text(
                context.l10n.signUpPasswordRule2,
                style: TalkyTextStyles.paragraph,
              ),
              Text(
                context.l10n.signUpPasswordRule3,
                style: TalkyTextStyles.paragraph,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
