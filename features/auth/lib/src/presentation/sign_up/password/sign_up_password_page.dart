import 'package:auth/src/presentation/auth_localization.dart';
import 'package:auth/src/presentation/sign_up/password/sign_up_password_bloc.dart';
import 'package:auth/src/presentation/sign_up/password/sign_up_password_model.dart';
import 'package:auth/src/presentation/utils/validators/password_validation_error.dart';
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
                        errorMaxLines: 2,
                      ),
                      onChanged: (value) => _bloc.add(
                        SignUpPasswordPasswordChanged(password: value),
                      ),
                    ),
                    const SizedBox(height: TKSpacing.x8),
                    ValidationList(
                      title: context.l10n.signUpPasswordRulesTitle,
                      items: [
                        ValidationItem(
                          state: _getValidationState<InvalidPasswordLength>(
                            state.errors,
                          ),
                          text: context.l10n.signUpPasswordLengthRule,
                        ),
                        ValidationItem(
                          state: _getValidationState<NoAlphabeticCharacter>(
                            state.errors,
                          ),
                          text: context.l10n.signUpPasswordLetterRule,
                        ),
                        ValidationItem(
                          state: _getValidationState<NoNumericCharacter>(
                            state.errors,
                          ),
                          text: context.l10n.signUpPasswordNumericRule,
                        ),
                      ],
                    ),
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

  ValidationItemState _getValidationState<T extends InputValidationError>(
    List<InputValidationError>? errors,
  ) =>
      errors == null
          ? ValidationItemState.idle
          : errors.whereType<T>().isEmpty
              ? ValidationItemState.valid
              : ValidationItemState.invalid;
}
